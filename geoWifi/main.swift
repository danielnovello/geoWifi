//
//  main.swift
//  geoWifi
//
//  Created by Daniel Novello on 2020/05/29.
//  Copyright © 2020 Daniel Novello. All rights reserved.
//

import Foundation
import CoreWLAN
import AppKit

class Discovery {

    var currentInterface: CWInterface
    var interfacesNames: [String] = []
    var networks: Set<CWNetwork> = []

    // Failable init using default interface
    init?() {
        if let defaultInterface = CWWiFiClient.shared().interface(),
            let name = defaultInterface.interfaceName {
            self.currentInterface = defaultInterface
            self.interfacesNames.append(name)
            self.findNetworks()
        } else {
            return nil
        }
    }

    // Init with the literal interface name, like "en1"
    init(interfaceWithName name: String) {
        self.currentInterface = CWWiFiClient.shared().interface()!
        self.interfacesNames.append(name)
        self.findNetworks()
    }

    // Fetch detectable WIFI networks
   func findNetworks() {
        do {
            self.networks = try currentInterface.scanForNetworks(withSSID: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }

}

func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}

if CommandLine.argc < 2 {
    //print("No arguments are passed.")
    _ = CommandLine.arguments[0]
    //print(mywifi)
} else {
    //print("Arguments are passed.")
    _ = CommandLine.arguments
}

var count = CommandLine.argc
//print("Number of arguments is \(count)")

if count == 1  {
        print("Missing arguments. Example: geoWifi SSID JAMFTRIGGER")
    }
else if count == 2 {
    print("Missing arguments. Example: geoWifi SSID JAMFTRIGGER")
}
else {
        if let discovery = Discovery() {
            for network in discovery.networks {
                print("Found SSID: \(network.ssid!)")
                if network.ssid == CommandLine.arguments[1] {
                    shell("/usr/local/bin/jamf policy -trigger \(CommandLine.arguments[2])")
                } else {
                    print("Found another SSID, but not the one specified")
                }
            }
        }

    }

