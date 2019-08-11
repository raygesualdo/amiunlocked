import Cocoa
import Configuration
import Foundation
import Just

// Enumerate valid states for our computer: "locked" and "unlocked"
enum State: String {
  case locked
  case unlocked
}

// Section: Configuration
// Start a configuration manager, load configuration from an adjacent
// `config.json` file, cast config values to appropriate types, and
// fail if required config values are not present
let manager = ConfigurationManager()
manager.load(file: "config.json")
let url = manager["url"] as? String ?? ""
let writeKey = manager["writeKey"] as? String ?? ""

if url == "" {
  fatalError("The config parameter 'url' is required. Set it in 'config.json' and please try again.")
}

if writeKey == "" {
  fatalError("The config parameter 'writeKey' is required. Set it in 'config.json' and please try again.")
}

// Section: Network Requests
// Functions to create UTC timestamps and make network requests
// to the kvdb bucket with a given `State`
func getISOTimestamp() -> String {
  if #available(macOS 10.12, *) {
    let date = Date()
    let dateFormatter = ISO8601DateFormatter()
    return dateFormatter.string(from: date)
  } else {
    fatalError("This process only runs on macOS 10.12+.")
  }
}

func sendRequest(state: State) {
  let r = Just.post(
    url,
    json: ["state": state.rawValue, "updatedAt": getISOTimestamp()],
    auth: (writeKey, "")
  )
  if r.ok {
    NSLog("Network: request succeeded")
  } else {
    NSLog("Network: request failed")
  }
}

// Section: Event Listeners
// The event listeners listening for `screenIsLocked` and `screenIsUnlocked`
// events, and the callback function to log and make a network request in
// response to a triggered event
func logAndSendRequest(notification: Notification, state: State) {
  NSLog("Event: \(notification.name.rawValue)")
  sendRequest(state: state)
}

let dnc = DistributedNotificationCenter.default()

dnc.addObserver(forName: .init("com.apple.screenIsLocked"), object: nil, queue: .main) { notification in
  logAndSendRequest(notification: notification, state: State.locked)
}

dnc.addObserver(forName: .init("com.apple.screenIsUnlocked"), object: nil, queue: .main) { notification in
  logAndSendRequest(notification: notification, state: State.unlocked)
}

// Let's do this thing!
NSLog("Process: started")
RunLoop.main.run()
