# Server Hardware ( Olimex A20-OLinuXino-LIME2-e16Gs16M )
The server is the extremely low powered [A20-OLinuXino-LIME2-e16Gs16M SBC from Olimex](https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXino-LIME2/open-source-hardware). 

It is OSHW certified open source hardware and runs open source software.

[**User Manual**](https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXino-LIME2/resources/A20-OLinuXino-LIME2-UM.pdf)
[**Olimage Linux Guide**](https://github.com/OLIMEX/OLINUXINO/blob/master/DOCUMENTS/OLIMAGE/Olimage-guide.pdf) (I am NOT using Olimage Linux. Just for Ref)
[**Schematics & Hardware Source**](https://github.com/OLIMEX/OLINUXINO/tree/master/HARDWARE/A20-OLinuXino-LIME2)
[**Board Dimensions**](https://www.olimex.com/Products/OLinuXino/A10/_resources/Ax0-OLINUXINO-LIME-dimensions.png)

The Hardware running the server features the following specs:

```
- A20-OLinuXino-LIME2-e16Gs16M Rev. L
- Allwinner A20/T2 dual core Cortex-A7 processor, each core typically running at 1GHz and dual-core Mali 400 GPU
- 1GB DDR3 RAM memory
- 16GB eMMC flash memory option (in A20-OLinuXino-LIME2-e4GB or A20-OLinuXino-LIME2-e16GB)
- 16MB SPI flash option (-s16MB suffix)
- Native SATA support with connector and 5V SATA power jack
- Capable of FullHD (1080p) video playback 
- Native HDMI support with connector
- 2 x USB High-speed host with power control and current limiter
- USB-OTG with power control and current limiter
- 1000MBit native Ethernet
- LiPo Battery connector with battery-charging capabilities
- LCD row of pins (0.05'' step)
- 160 GPIOs on four GPIO rows of pins (0.05'' step)
- MicroSD card connector
- DEBUG-UART connector for console debug with USB-SERIAL-CABLE-F
- GPIO LED
- Battery charge status LED
- Power LED
- 2KB EEPROM for MAC address storage and more
- 3 BUTTONS with ANDROID functionality + RESET button
- 4 mount holes
- 5V DC input power supply jack, noise immune design
- PCB dimensions: (84 x 60)mm ~ (3.3 x 2.4)"
```

## OS ( Armbian Trixie Minimal )
Initial [Armbian](https://armbian.com/boards/lime2) installation was [Debian 13 Trixie Minimal(CLI)](https://dl.armbian.com/lime2/Trixie_current_minimal) running the **6.18.29** kernel.

OS has been installed and is running on the 16GB eMMC device for max reliability and low power cosumption.

## Maximum Power Saving Config

### Disable HDMI

Disabling HDMI can see an estimated savings of **~0.15W - 0.4W (~30 mA - 80 mA)**.

To disable see the [/server/config/disable-hdmi.dts] file and follow these steps:

1. Compile this file into a binary device-tree block (.dtb) via:  
`dtc -I dts -O dtb -o disable-hdmi.dtb disable-hdmi.dts`

2. Move the compiled overlay to the user-overlay directory:  
`sudo mv disable-hdmi.dtb /boot/overlay-user/`

3. Modify Armbian environment parameters:  
`sudo nano /boot/armbianEnv.txt`

4. Locate or add the 'user_overlays' property line, then save the file:  
`user_overlays=disable-hdmi`

> [!CAUTION]
> Disabling video will limit you from locally debugging via HDMI should something happen to your headless setup,
> leaving you with the last resort of using UART to debug.

### Disable USB ports

Disabling the 2 USB ports can see an estimated savings of **~0.05W - 0.20W (~10 mA - 40 mA)**.

To disable see [/server/config/power-save-usb.sh](/server/config/power-save-usb.sh) and follow these steps:

1. Make the `power-save-usb.sh` script executable via:  
`sudo chmod +x /usr/local/bin/power-save-usb.sh`

2. Add script as cron boot event:  
`sudo crontab -e`

3. Append the following text:  
`@reboot /usr/local/bin/power-save-usb.sh`

> [!CAUTION]
> Disabling usb port will prevent you from locally debugging via usb keyboard should something happen to your headless setup,
> leaving you with the last resort of using UART to debug.

### Disable Green LED

It is possible to disable the LED1 (**GREEN** :green_circle:). Doing so can see an estimated savings of ~0.05W (~10 mA).

It NOT possible to disable the PWR_LED (**RED** :red_circle:) as it is hardwired to the DC barrel jack.

I am not currently providing any scripts to achieve this.

## Troubleshooting

### UART0

In the event of being unable to reach the A20-OLinuXino-LIME2 via network OR locally via HDMI (due to power savings disable), it is possible to locally connect to the board using it's UART0 Serial header pins.

The board pinout for the UART0 header is:

| PIN | WIRE COLOUR |
| --- | ----------- |
| TX0 | :green_square: GREEN |
| RX0 | :red_square: RED |
| GND | :blue_square: BLUE |

Using Olimex [USB-Serial-F (Part Number: 9000043175)](https://www.olimex.com/Products/USB-Modules/Interfaces/USB-SERIAL-F/) cable or any FTDI cable will work.

Using [tio](https://github.com/tio/tio) as the terminal emulator program is a good choice.

To connect simply run:  
`tio /dev/ttyUSB0`  
Note: your device may vary!
