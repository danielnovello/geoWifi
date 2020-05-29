//
//  main.swift
//  geoWifi
//
//  Created by Daniel Novello on 2020/05/28.
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
    print("No arguments are passed.")
    _ = CommandLine.arguments[0]
    //print(mywifi)
} else {
    print("Arguments are passed.")
    _ = CommandLine.arguments
}

if let discovery = Discovery() {
    //print(discovery.networks)
    for network in discovery.networks {
        //print(network.ssid!)
        if network.ssid == CommandLine.arguments[1] {
            let alert: NSAlert = NSAlert()
            alert.icon = NSImage (named: NSImage.cautionName)
            alert.messageText = "Wifi Trigger"
            alert.informativeText = "You have entered the Wifi area that has triggered an event"
            alert.alertStyle = NSAlert.Style.informational
            alert.addButton(withTitle: "OK")
            //alert.runModal()
            shell("/usr/local/bin/jamf policy -trigger wifitrigger")
        } else {
            print("Your Wifi SSID is not found")
        }
    }
}
