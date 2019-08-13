import Cocoa
import Foundation

// Enumerate valid states for our computer: "locked" and "unlocked"
enum State: String {
  case locked
  case unlocked
}

var sync = Sync()

func logAndSync(notification: Notification, state: State) {
  NSLog("Event: \(notification.name.rawValue)")
  sync.initializeSync(state: state)
}

let dnc = DistributedNotificationCenter.default()

dnc.addObserver(forName: .init("com.apple.screenIsLocked"), object: nil, queue: .main) { notification in
  logAndSync(notification: notification, state: State.locked)
}

dnc.addObserver(forName: .init("com.apple.screenIsUnlocked"), object: nil, queue: .main) { notification in
  logAndSync(notification: notification, state: State.unlocked)
}

// Let's do this thing!
NSLog("Process: started")
RunLoop.main.run()
