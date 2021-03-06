# geoWifi

![](https://img.shields.io/github/v/release/danielnovello/geoWifi)&nbsp;![](https://img.shields.io/badge/macOS-10.14%2B-success)


https://danielnovello.github.io/geoWifi/


Lightweight CLI application that scans for available SSID's and if specified SSID is found, trigger a policy in Jamf (Potentailly anything you want to happen)

Note: Does not need to be connected to any Wifi to function. It scans available Wifi SSID's


 <b>Manual usage:</b>
 
    sudo ./geoWifi SSID JAMFTRIGGER
  
  If SSID found
 
  <img src="https://novello.co.za/img/Alert.png" width="400">
  
  <i>Example Alert script in Jamf</i>
  
    #!/bin/bash
    /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -title "Jamf Security" -windowType hud -description "Jamf Security" -description "You are entering a probibited Area" &
  
  <hr>

<b>Create a Persistant LaunchDaemon</b>

<i>NOTE: This has not been tested long term. Not sure of the CPU usage over long periods of time.</i>

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
 
   <hr>

   <h3>Why not use built in method and script? (Legacy command)</h3>

       /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s

  The above command using the <i>airport</i> command does work, however testing the <i>airport</i> command and <i>geoWifi</i> along side each other, it is clear that for reliabilty, accuracy and performance <i>geoWifi</i> wins when used with a persistant LaunchDaemon

    <hr>
 
 Built application, example script and launchDaemon in Testing directory
