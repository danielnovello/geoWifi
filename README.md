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
  Example in Repo
