# Raycast

Raycast will be a simple application that combines [sunburst](/sunburst/) aggregate data and selected server power stats for display on the static website.

It also polls a TBD weather service for sky forcast for Today / Tomorrow / Day After Tomorrow and 

| Data Point | Source | Format |
|------------|:------:|-------:|
| Local time | A20-OLinuXino-LIME2 | 24-Hr w/ TZ |
| Uptime     | A20-OLinuXino-LIME2 | weeks, days, hours, minutes |
| Power Usage | A20-OLinuXino-LIME2 | Watts (calculated) |
| Current Draw | A20-OLinuXino-LIME2 | A / mA |
| Voltage    | A20-OLinuXino-LIME2 | V |
| CPU Temp   | A20-OLinuXino-LIME2 | °C |
| CPU Load Avg | A20-OLinuXino-LIME2 | % |
| Solar Active | [sunburst](/sunburst/) / Solar Charge Controller | bool |
| Battery Capacity | [sunburst](/sunburst/) / Solar Charge Controller | % |

Target poll frequency: **1 minute**

See [lowtechmag/materialserver](https://github.com/lowtechmag/materialserver) for ideas
