import Cocoa
import Just

private func getISOTimestamp() -> String {
  if #available(macOS 10.12, *) {
    let date = Date()
    let dateFormatter = ISO8601DateFormatter()
    return dateFormatter.string(from: date)
  } else {
    fatalError("This process only runs on macOS 10.12+.")
  }
}

class Sync {
  private static let config = Config()

  enum SyncStatus {
    case pending(nextState: State)
    case success
    case failure(retryState: State)
  }

  var syncStatus: SyncStatus = .success
  private var task: DispatchWorkItem?

  func initializeSync(state: State) {
    syncStatus = .pending(nextState: state)
    handleSync()
  }

  private func handleSync() {
    if task != nil { task!.cancel() }

    switch syncStatus {
    case let .pending(nextState):
      sendRequest(state: nextState)
    case .success:
      break
    case let .failure(retryState):
      syncStatus = .pending(nextState: retryState)
      sendRequest(state: retryState)
    }
  }

  private func sendRequest(state: State) {
    let r = Just.post(
      Sync.config.url,
      json: ["state": state.rawValue, "updatedAt": getISOTimestamp()],
      auth: (Sync.config.writeKey, "")
    )
    if r.ok {
      NSLog("Network: request succeeded")
      syncStatus = .success
    } else {
      NSLog("Network: request failed")
      syncStatus = .failure(retryState: state)
      task = DispatchWorkItem { self.handleSync() }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: task!)
    }
  }
}
