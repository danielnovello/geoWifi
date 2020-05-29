# geoWifi

Scan for available SSID's and if specified SSID is found, trigger a policy in Jamf (Potentailly anything you want to happen)

<i>(Poor mans iBeacons)</i>

Note: Does not need to be connected to any Wifi to function. It scans available Wifi SSID's


 <b>Manual usage:</b>
 
 <code>sudo ./geoWifi "SSID"</code>
  
  If SSID found
 
<img src="https://github.com/djquazzi/djquazzi.github.io/blob/master/images/Alert.png" width="400">
  
  Example Alert script in Jamf
  
    <code>#!/bin/bash</code>
    <code>/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -title "Jamf Security" -windowType hud -description "Jamf Security" -description "You are entering a probibited Area" &</code>
  
  
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
  
  All logs in <i>/private/var/log/geowifi.log</i>
