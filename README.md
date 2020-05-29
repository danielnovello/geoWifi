# geoWifi

Scan for available SSID's and if your SSID is found, trigger a policy in Jamf

<b>Usage:</b>
  <code>sudo ./geoWifi "SSID"</code>
  
If SSID found
 
<img src="https://github.com/djquazzi/djquazzi.github.io/blob/master/images/Alert.png" width="400">
  
  
<b>Create a Persistant LaunchDaemon</b>

- Copy the geoWifi app from Testing to your chosen location <b>(/PATHTOAPP)</b>

- Create a script (make it executable) and copy it your chosen location
  
  <code>
  #!/bin/bash
  /PATHTOAPP "SSID"
  </code>

- Create a LaunchDaemon Plist and copy to /Library/LaunchDaemons (Ammend with the location of your script)
  Example in Repo
    Fix the Permissions:
      
      <code>sudo chown root /Library/LaunchDaemons/com.djquazzi.geowifi.plist</code>
      
      <code>sudo chgrp wheel /Library/LaunchDaemons/com.djquazzi.geowifi.plist</code>

- Run the LaunchDaemon

  <code>sudo launchctl load -w /Library/LaunchDaemons/com.djquazzi.geowifi.plist</code>
