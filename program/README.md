# `amiunlocked` Program

A macOS CLI program that listens for screen un/locks and notifies a cloud-based key/value store.

- [Installation](#installation)
  - [Download latest release](#download-latest-release)
  - [Build from source](#build-from-source)
- [Setup key/value store](#setup-keyvalue-store)
- [Configure program](#configure-program)
- [Set program as background service](#set-program-as-background-service)

NOTE: the directions included in rest of the README assume you have cloned the repo and navigated to the `program` directory.

<details><summary>Clone Instructions</summary>
<div>

```sh
git clone <url>
cd amiunlocked/program
```

</div>
</details>

## Installation

You can install `amiunlocked` by downloading the latest release or building the binary from source.

### Download latest release

Navigate to the repo [releases page](https://github.com/raygesualdo/amiunlocked/releases) and download the latest release wherever you prefer on your computer.

### Build from source

Building from source requires having the latest Xcode with Swift 5+ installed on your computer. In the `program` directory, run the following commands:

```shell
swift package update
swift package generate-xcodeproj
swift build -c release
```

The program binary is located at `./.build/release/amiunlocked`. You can leave it there or copy it to another location on your computer.

## Setup key/value store

`amiunlocked` persists your computer's locked/unlocked state using a [kvdb.io](https://kvdb.io/) store called a "bucket". Using the provided `scripts/setupDb.sh` script, take the following steps to create your own bucket:

1. Open `scripts/setupDb.sh`
2. Generate two random strings for each of the following variables and enter them in the script:
   - `secretKey`
   - `writeKey`
3. Save and run `scripts/setupDb.sh`
4. Copy/paste the output to a safe location. This information cannot be recovered if lost.

## Configure program

Running `amiunlocked` requires two configuration settings: the url to your kvdb bucket (including the "key" of the key/value pair) and the `writeKey` to give `amiunlocked` write-access to the bucket. This configuration is kept in a `config.json` file adjacent to the `amiunlocked` binary. You can use `config.json.example` as an example configuration file to get started.

1. Run the following command to create an empty `config.json` file:

   ```sh
   cp ./config.json.example /directory/container/program/config.json
   ```

2. Open `config.json`
3. Fill in `url` with your kvdb bucket URL and the key you will store computer state at. For example, if your kvdb URL is "https://kvdb.io/abcdefg123456" and you are going to use the key "computer-state", the value for `url` would be "https://kvdb.io/abcdefg123456/computer-state".
4. Fill in `writeKey` with the value generated for the [Setup key/value store](#setup-keyvalue-store) step
5. Save and close the file

## Set program as background service

`amiunlocked` can be configured using LaunchAgents. Take the following steps to set it up:

```shell
cd scripts
./createPlistFile.sh
# Provide the amiunlocked binary path to the script
./installPlistFile.sh
```

That's it. You can verify the process was installed as a LaunchAgent using the following command:

```shell
tail -f /tmp/com.amiunlocked.startup.stderr
# [2019-08-14 09:37:54.734 amiunlocked[3241:22125] Process: started
```
