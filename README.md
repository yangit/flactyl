# Flactyl

## Contacts

If you need help building this keyboard or have any questions you can drop me a line at [yan@yan.my](mailto:yan@yan.my)

I'd be happy to help!

## Features

- Thumb cluster with 6 keys, easy to use in combos, so ~12 combinations depending on how you setup combos
- 15g SPRiT springs to make same finger combos super easy
- Thumb cluster keys are designed to be poked with thumb nail/nose, not pressed with soft area, allows for easy access to all 6 keys with no wrist movement
- Multiple cases including the `clay` case to easily prototype your thumb cluster location
- Low distance between pinky and the table, allows to rest palms directly on the table without floating them, or using wrist rests.
- Heavy tenting at 60 degrees
- Choc hotswap
- Rotary encoder
- Ergogen for PCB with some custom scripts to generate `.bom` `.pos` files for jlcpcb.com SMT assembly service, and output outlines for easier 3d case designing
- zmk with custom nodejs script to make layer declaration easier and more readable
- Nice!Nano positioned right under the keys, hiding itself, without need for manual wiring (because of that PCBs are non reversible)
- Can fit huge batteries
- Magnetic stripe to securely fasten to the table
- The tentable table seen on the photos is from HumanScale

## Videos and links

- Youtube video with detailed review is [here](https://www.youtube.com/watch?v=Pdhb9uNnzU0)
- Short typing video [here](https://www.youtube.com/watch?v=eU5eg4PKMlQ)
- Reddit [thread](https://www.reddit.com/r/ErgoMechKeyboards/comments/13qep4y/after_4_year_lurking_and_2_years_building_my_own/)
- You can find zmk-config for this board [here](https://github.com/yangit/zmk-config/)
- It took me two years to finish this project, thanks to [KBD.news](https://kbd.news/) for inspiration!

## Cases

There are 3 cases available:
Clay, Iceberg, Hitam.

**Clay** consist of two pieces, you are supposed to put clay/play dough in it and see what position is best for you. It is pretty usable already.

**Iceberg** consists of single hollow box, switches are exposed on the sides.

**Hitam** (COMING SOON) pretty involved shape to cover all the keys from the sides as well. Great for transportability.

## Build

High-level build steps looks like so:

- Select which case you want to print
- Order case and PCB from JLCPCB or any other pcb/3d printing vendor
- Order parts online from various vendors according to the parts list
- Solder everything up
- Assemble everything down
- Flash it with ZMK firmware (or any other you want)

(COMING SOON) Video on how to order PCB and case from jlcpcb.com

## Parts list

You going to need some assorment of items to get done:

- 2 x EC11 Rotary encoder with a knob (ALP-ENC-TCT-001 or any similar will do)
- 42 x Kailh Low Profile Choc switches (highly recommend getting 20g (pink) for thumb cluster to make multi key combos easier)
- 42 x 1u Blank MBK Choc Low Profile Keycaps
- 2 x Pitch 2.54mm 1 * 40 Pin Sets of headers for Nice!Nanos
- 2 x Nice!Nano microcontrollers
- 32 x Hot swap connectors (two buttons are soldered directly on each half)
- 2 x Case
- 4 x Pcb (two for each half and two for thumb clusters)
- 12 x M2 x 10mm Screws
- 12 x M2x3x3x1.8 square nuts
- 12 x Spring washers (I recommend getting hex head screws, they are easier to tighten)
- 2 x JST SH 1.0mm x 2 wireConnector for battery (only if you want to go wireless)
- 2 x Battery (only if you want to go wireless)
- 2 x JST SH 1.0mm x 5 wire cable for thumb cluster

You will also need

- Screw driver
- Soldering iron with flux and solder

## Customize

You can customize thumb cluster location reasonably easy using
`./scad/` folder. Try to play around with it, you need OpenScad free software.

## ZMK-config

You can take a base config for this shield [here](https://github.com/yangit/zmk-config-flactyl/)

## Structure of this repo

### `./production`
You can grab `.zip` and `.stl` here, and send them to JLCPCB.com, they will print case, and PCB, it also includes BOM and POS files so that JLCPCB can solder connectors, diodes, reset button and power switch on the board for you.

(COMING SOON) Look at the how to order video.

### `./ergogen`

Here is modified fork of [ergogen](https://github.com/ergogen/ergogen)
To run it make sure you have npm/nodejs installed:

```
cd ./ergogen
npm install
./input/bulid.sh
```

This will produce files in the `./output` folder and they can be used for JLCPCB.com printing, that includes `.pos` and `.bom` files for SMT assembly.
If you are looking to make any changes, go under `./ergogen/input` folder and change config files there.



## Photos

![Photo1](./photos/1.jpeg)
![Photo4](./photos/4.jpeg)
![Photo6](./photos/6.jpeg)
![Photo7](./photos/7.jpeg)
![Photo8](./photos/8.jpeg)
![Photo9](./photos/9.jpeg)
![Photo10](./photos/10.jpeg)
![Photo11](./photos/11.jpeg)
![Photo12](./photos/12.jpeg)

## License

MIT
