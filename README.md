# geoWifi

![](https://img.shields.io/github/v/release/danielnovello/geoWifi)&nbsp;![](https://img.shields.io/badge/macOS-10.14%2B-success)

Scan for available SSID's and if specified SSID is found, trigger a policy in Jamf (Potentailly anything you want to happen)

Note: Does not need to be connected to any Wifi to function. It scans available Wifi SSID's


 <b>Manual usage:</b>
 
    sudo ./geoWifi SSID JAMFTRIGGER
  
  If SSID found
 
  <img src="https://github.com/djquazzi/djquazzi.github.io/blob/master/images/Alert.png" width="400">
  
  Example Alert script in Jamf
  
    #!/bin/bash
    /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -title "Jamf Security" -windowType hud -description "Jamf Security" -description "You are entering a probibited Area" &
  
  
<b>Create a Persistant LaunchDaemon</b>

- Create a script (make it executable) and copy it your chosen location
  
      #!/bin/bash
      /PATHTOAPP SSID JAMFTRIGGER
      
- Create a LaunchDaemon Plist and copy to /Library/LaunchDaemons (Ammend with the location of your script)
  Example in Repo
    Fix the Permissions:
      
      sudo chown root /Library/LaunchDaemons/com.djquazzi.geowifi.plist
      sudo chgrp wheel /Library/LaunchDaemons/com.djquazzi.geowifi.plist

- Run the LaunchDaemon

      sudo launchctl load -w /Library/LaunchDaemons/com.djquazzi.geowifi.plist
  
  All logs in <i>/private/var/log/geowifi.log</i> You might want to scrub the log every now and again.
 
 
 Built application, example script and launchDaemon in Testing directory
