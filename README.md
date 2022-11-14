# CNC-AO

All encompassing custom 3-Axis CNC Controller package incorpates a RaspberryPi hosted web-based interface & server [CNC.js](https://github.com/cncjs/cncjs), that sends G-Code instructions through serial communcation to a Arduino UNO microctronller running [GRBL](https://github.com/gnea/grbl) firmware.

### Hardware
- [Raspberry Pi 3](https://www.raspberrypi.com/products/) (Model B, B+, A+)
- [Arduino UNO R3](https://docs.arduino.cc/hardware/uno-rev3)
- v3.51 CNC shield - Many different manufactures, but all gerneally the same. I'm using this one [HERE](https://a.co/d/5g3BnT0)
- (4) A4988 Stepper Driver Modules
- [Geekworm X715](https://wiki.geekworm.com/X715) power management expansion board


---
## Installation & Setup

### Software

#### Raspberry Pi
1. Node.js - Reffer to the [CNC.js documentation](https://github.com/cncjs/cncjs#supported-nodejs-versions) for the latest supported versions.

    1. Add repository for the targeted version of Node.js :
    `curl -fsSL curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -`


    2. Install Node.js: `sudo apt-get install -y nodejs`

    3. Verify installation:

        `node -v` -> should output -> `v12.22.12`

        `npm -v`  -> should output -> `6.14.16`

2. CNC.js
    1. `sudo npm install -g cncjs@latest --unsafe-perm`

3. [PM2](https://github.com/Unitech/pm2) production process manager
    1. `sudo npm install pm2 -g`
    2. `pm2 startup`
    3. Run the instructed command that is returned
    4. Start CNCjs with PM2:  `pm2 start cncjs -- --port 8000 -m /widget:/home/aokopal/CNC-AO/application/control-widget/src/`
    5. Set current running apps to startup: `pm2 save`
    6. Get list of PM2 processes: `pm2 save`

5. Setup Display:
    1. Install necessary packages:
    
    `sudo apt install --no-install-recommends xserver-xorg x11-xserver-utils xinit chromium-browser git python3-pip`

    2. Install Adafruit PiTFT Driver:
        1. `sudo pip3 install --upgrade adafruit-python-shell click`
        2. `git clone https://github.com/adafruit/Raspberry-Pi-Installer-Scripts.git`
        3. `cd Raspberry-Pi-Installer-Scripts`
        4. `sudo python3 adafruit-pitft.py --display=28r --rotation=90 --install-type=fbcp`
        5. REBOOT NOW? `y`
    
    3. Update Xorg permissions:

        `chmod ug+s /usr/lib/xorg/Xorg`

6. X715 Power management board setup
    1. sudo apt install python3-gpiozero