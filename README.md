# geoWifi

Scan for available SSID's and if your SSID is found, trigger a policy in Jamf

<b>Usage:</b>
  <code>sudo ./geoWifi "SSID"</code>
  
If SSID found
 
<img src="https://github.com/djquazzi/djquazzi.github.io/blob/master/images/Alert.png" width="400">
  
  
<b>Create a Persistant LaunchDaemon</b>

- Create a script (make it executable)
  <code>
  #!/bin/bash
  /PATHTOSCRIPT "SSID"
  </code>

- Create a LaunchDaemon Plist
  <code>
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC -//Apple Computer//DTD PLIST 1.0//EN
  http://www.apple.com/DTDs/PropertyList-1.0.dtd>
  <plist version="1.0">
   <dict>
    <key>Label</key>
     <string>com.djquazzi.geowifi</string>
    <key>UserName</key>
     <string>root</string>
    <key>KeepAlive</key>
     <true/>
    <key>ProgramArguments</key>
     <array>
      <string>/Users/daniel/Desktop/geoWifi/Testing/tester.sh</string>
     </array>
    <key>StandardOutPath</key>
     <string>/var/log/geowifi.log</string>
    <key>StandardErrorPath</key>
     <string>/var/log/geowifi.log</string>
    <key>Debug</key>
     <true/>
   </dict>
  </plist>
  <code>
