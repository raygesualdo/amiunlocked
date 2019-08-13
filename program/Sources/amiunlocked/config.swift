import Configuration

// Start a configuration manager, load configuration from an adjacent
// `config.json` file, cast config values to appropriate types, and
// fail if required config values are not present
struct Config {
  var url: String
  var writeKey: String
  init() {
    let manager = ConfigurationManager()
    manager.load(file: "config.json")
    url = manager["url"] as? String ?? ""
    writeKey = manager["writeKey"] as? String ?? ""

    if url == "" {
      fatalError("The config parameter 'url' is required. Set it in 'config.json' and please try again.")
    }

    if writeKey == "" {
      fatalError("The config parameter 'writeKey' is required. Set it in 'config.json' and please try again.")
    }
  }
}
