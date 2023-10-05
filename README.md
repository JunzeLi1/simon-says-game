# Simon Says Game

## Objective
The Simon Says Game project aims to recreate the classic memory game using hardware description languages. The primary objective is to challenge players to remember and replicate a progressively longer sequence of lights and buttons.

## Project Description
This project is an implementation of the classic "Simon Says" game using SystemVerilog. The game involves a sequence of lights and buttons, where the player must repeat the sequence shown. As the player progresses, the sequence becomes longer and more challenging to remember.

## Features
- **Memory Challenge**: The game tests and trains the player's memory by presenting an ever-increasing sequence of lights.
- **Multiple Game States**: The game has various states such as READY, PLAY, FAIL, PASS, and WIN to guide the player through different stages.
- **7-Segment Display**: The game uses a 7-segment display to show the current state and other relevant information.
- **Button Input**: Players interact with the game using buttons to replicate the sequence of lights.

## Code Structure
1. **[clkdiv.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/clkdiv.sv)**: Handles clock division.
2. **[freerun.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/freerun.sv)**: Provides a free-running counter.
3. **[mem.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/mem.sv)**: Represents the game's memory.
4. **[scankey.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/scankey.sv)**: Manages key/button scanning.
5. **[shiftdown.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/shiftdown.sv)**: Shifts down the output.
6. **[ssdec.sv](https://github.com/jzllll/simon-says-game/blob/master/ps1/ssdec.sv)**: Decodes input for 7-segment display.
7. **[controller.sv](https://github.com/jzllll/simon-says-game/blob/master/ps2/controller.sv)**: Main game controller.
8. **[simonsays.sv](https://github.com/jzllll/simon-says-game/blob/master/ps3/simonsays.sv)**: Core game module.
9. **[ice40hx8k.sv](https://github.com/jzllll/simon-says-game/blob/master/ps3/ice40hx8k.sv)**: Top-level module.
10. **[top.sv](https://github.com/jzllll/simon-says-game/blob/master/ps3/top.sv)**: Integrates the core game with other components.

## Core Concepts and Algorithms
The game operates based on a finite state machine (FSM) with states like READY, PLAY, FAIL, PASS, and WIN. The game logic checks the sequence entered by the player against the expected sequence. The sequence is stored in memory and is loaded from the "press.mem" file. The game uses various modules to manage the display, input scanning, and game progression.

## Technologies and Tools Used
- **Language**: SystemVerilog
- **Platform**: FPGA (Field-Programmable Gate Array)

## Problem Statement
The challenge was to recreate the classic "Simon Says" game using hardware description languages, ensuring that the game logic, user input, and display work seamlessly together.

## Usage
To use the project, clone the repository and load the project files into an FPGA development environment. Compile and deploy the design to an FPGA board. Interact with the game using the board's buttons and observe the game states on the 7-segment display.

## Challenges & Solutions
- **Memory Management**: Storing and retrieving the sequence of lights was a challenge. This was addressed by creating a dedicated memory module that loads sequences from a file and provides outputs based on the game's current state.
- **User Input**: Scanning and interpreting button presses in real-time was crucial. The scankey module was developed to handle this aspect efficiently.
- **Game Progression**: Managing the game's progression and states was a complex task. The controller module was designed to handle the game's various states and transitions.

## Optimization & Efficiency
The game has been optimized for efficient memory usage and real-time performance. Modules like clkdiv and freerun ensure that the game runs smoothly without any lags or glitches.
