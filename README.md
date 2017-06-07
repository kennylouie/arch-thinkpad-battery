# arch_thinkpad_battery
bash scripts to manage the discharging and charging behaviour of class thinkpads with dual batteries

## background

I had a T61 thinkpad with an ultrabay battery. I wanted to change the batteries' discharging behaviour. The default setting is to discharge the smaller ultrabay battery first before draining the main larger battery. Furthermore, the main battery is charged first while the ultrabay battery (after being completely drained) will recharge afterwards. This results in increased wear of the ultrabay battery, which has been documented on other forums.

My goal is to always drain the main battery first and reserve the ultrabay battery as a backup to maintain charge while swapping out the main battery. This is similar to more current thinkpad battery bridge system behaviour. Therefore, I wrote a script and systemd unit to achieve this goal. I am writing this post to 1) share my script so that other people may benefit from it; and 2) to see if anyone more experienced can improve or even suggest a better way to achieve the same outcome.

This script was tested on a T61 running linux 4.4.5-1 kernel and tp_smapi 0.41-81. The script is based on using tp_smapi's forced discharge setting to force the main battery to discharge.

### the scripts
#### 1. Custom script to check battery status and regulate its actions
Place the regulator.sh in the /usr/local/sbin/ directory.
#### 2. The regulator.sh will be activated by a systemd service.
Place the arch_bat_management.service in the /etc/systemd/system/ directory.
#### 3. Activate the service using usual systemd commands.

## discussion

My only gripe with this setup is that it consumes ~1-2W (powertop estimate) as it is continuously running the script every 30 seconds. I originally intended to use a .path unit instead by checking tp_smapi's /sys/devices/platform/smapi/ac_connected file. I thought that a PathModified .path file would be able to check for this file to determine AC connection, and if changed will invoke the .service file which in turns activates the bash script.

If anyone has any suggestions on improving or providing a much better approach, I would really appreciate it. I note that there is a script written on the thinkwiki page on how to use ultrabay batteries, but I would rather not use both batteries continuously.
Anyways, thanks for reading and I really appreciate this forum for all the insights and things I borrowed thus far.
