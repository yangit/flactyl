# Flactyl
## Features

- Thumb cluster with 6 keys, easy to use in combos, so ~12 combinations depending on how you setup combos
- 12g springs to make same finger combos super easy
- Thumb cluster keys are designed to be poked with thumb nail/nose, not pressed with soft area, allows for easy access to all 6 keys with no wrist movement
- Low distance between pinky and the table, allows to rest palms directly on the table without floating them, or using wrist rests.
- Heavy tenting at 60 degrees
- Choc hotswap
- Rotary encoder
- Ergogen for PCB with some custom scripts to generate .bom .pos files for jlcpcb.com SMT assembly service, and output outlines for easier 3d case designing
- zmk with custom nodejs script to make layer declaration easier and more readable
- Nice!Nano positioned right under the keys, hiding itself, without need for manual wiring (because of that PCBs are non reversible)
- Can fit huge batteries
- Magnetic stripe to securely fasten to the table
- The tentable table seen on the photos is from HumanScale

### Links

- Youtube video with detailed review is [here](https://www.youtube.com/watch?v=Pdhb9uNnzU0)
- You can find zmk-config for this board [here](https://github.com/yangit/zmk-config/)
- It took me two years to finish this project, thanks to [KBD.news](https://kbd.news/) for inspiration!

## Structure of this repo

### case
Contains Fusion 360 file and also exported `.stl` for 3d printing using JLCPCB.com

### pcb

#### ergogen
Under `ergogen` folder there is modified fork of [ergogen](https://github.com/ergogen/ergogen)
To run it make sure you have npm/nodejs installed:
```
cd ./pcb/ergogen
npm install
./input/bulid.sh
```

This will produce files in the `./output` folder and they can be used for JLCPCB.com printing, that includes `.pos` and `.bom` files for SMT assembly, that you only need to solder hotswap connectors for choc switches, and headers for Nice!Nano.
If you are looking to make any changes, go under `./ergogen/input` folder and change config files there.

#### kikad
This folder contains different versions of kicad files I have already sent to JLCPCB.

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
