# RISC Processor with APB Peripheral System

## Overview

This project implements a custom 16-bit RISC processor integrated into a microcontroller-style system using the AMBA APB protocol.

The design is written in SystemVerilog and includes both processing logic and memory-mapped peripherals.

---

## Architecture

* 16-bit RISC processor (non-pipelined)
* Harvard architecture (separate instruction/data paths)
* Custom instruction set (ALU, jump, load/store)

---

## APB System

* APB Master implemented as FSM (IDLE / SETUP / ACCESS)
* Memory-mapped peripherals using address decoding
* Handshake using `pready`

---

## Peripherals

* Data Memory (APB slave)
* PWM controller
* Button interface
* MEAN module (computes average of 4 values)

---

## MEAN_APB Module

* Receives 4 input values via APB
* Computes average using sequential FSM
* Uses states:

  * IDLE
  * BUSY
  * DONE
* Result available via APB read

---

## Verification

* Testbench developed for full system (`computer_APB_tb`)
* Waveform analysis used to validate:

  * APB transactions
  * FSM behavior
  * Correct data flow

---

## Technologies

* SystemVerilog (RTL design)
* FSM design
* AMBA APB protocol
* Digital system integration

