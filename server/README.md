# Server Hardware ( Olimex A20-OLinuXino-LIME2-e16Gs16M )
The server is an extremely low powered SBC from Olimex featuring the following specs:

```
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

# OS ( Armbian Trixie Minimal )
Initial [Armbian](https://armbian.com/boards/lime2) installation was [Debian 13 Trixie Minimal(CLI)](https://dl.armbian.com/lime2/Trixie_current_minimal) running the **6.18.29** kernel.

OS has been installed and is running on the 16GB eMMC device for max reliability and low power cosumption.
