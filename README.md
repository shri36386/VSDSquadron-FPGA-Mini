# VSDSQUADRON FPGA MINI
<details>
  <summary><h2>Introduction to the VSDSQUADRON FPGA MINI Board</h2> </summary>

What is VSDSQUADRON FPGA MINI Board?

* The VSDSQUADRON FPGA MINI is a compact and cost-effective FPGA development board designed for learning and prototyping digital design concepts. 
  
* It is an ideal platform for students and engineers who want to explore FPGA programming, hardware description languages (HDLs), and digital system design.

Key Features of the VSDSQUADRON FPGA MINI Board 

* FPGA chip - Lattice iCE40 series FPGA

   + The Lattice iCE40 series is a family of low-power, small-footprint FPGAs designed for embedded applications. It is known for its energy efficiency, fast startup time, and compatibility with open-source tools.
   + Logic Elements (LEs): Ranges from 384 to 7680 logic elements, depending on the model.
   + SRAM-based FPGA: Uses volatile SRAM for configuration, requiring an external configuration memory.
   + Power Efficient: Operates at low power, making it suitable for battery-powered devices.

* Built-in Oscillator
   
   + An FPGA usually requires an external crystal oscillator to generate clock signals. However, the VSDSQUADRON FPGA MINI comes with an internal oscillator.
   + This feature is very useful as it- Eliminates the need for additional components, Provides a stable clock signal for timing operations, and Enables real-time frequency generation and PWM control for applications like LED dimming and motor control.

* RGB LED

   + The board contains a set of multi-color RGB LED, which allows users to test digital logic by displaying different colors.
   + Red, Green, and Blue LEDs are controlled separately via Verilog.
   + Pulse Width Modulation (PWM) can be used to control brightness and create color variations.

* GPIO Pins (General-Purpose Input/Output)

  + GPIOs are programmable input/output pins that allow the FPGA to communicate with external hardware.
  + Can be configured as input or output.
  + Used to connect with sensors, switches, displays, communication modules (SPI, I2C, UART), and other peripherals.

* Open-Source Friendly FPGA Toolchains

  + Unlike many FPGA vendors that require expensive proprietary tools, the iCE40 series supports open-source FPGA toolchains, making development more accessible.

  </details>

<details>
  <summary><h2>TASK 1 - VSDSquadron FPGA Mini: Verilog and PCF Task Guide</h2> </summary>

STEP 1 - Analyzing the Verilog Code

The provided Verilog code is designed to control an RGB LED using an internal oscillator. Below is a breakdown of its components and functionality:

1. Introduction

- This project involves the design and implementation of an RGB LED controller using Verilog. The design is based on a Lattice iCE40 FPGA, utilizing an internal oscillator and frequency division logic to control the RGB LED's color output. The project focuses on the following key components:

- Internal Oscillator (SB_HFOSC) for clock generation

- Frequency Counter for generating different LED pulse signals

- RGB LED Driver (SB_RGBA_DRV) for controlling LED intensity

2. Module and Ports Description

The Verilog module (top.v) consists of input and output ports that interact with the FPGA hardware components:

Inputs:

- hw_clk: External hardware clock input (not utilized in this implementation as the internal oscillator is used).

Outputs:

- led_red: Controls the red component of the RGB LED.

- led_blue: Controls the blue component of the RGB LED.

- led_green: Controls the green component of the RGB LED.

- testwire: A test signal derived from the internal frequency counter.

3. Internal Oscillator (SB_HFOSC)

- The SB_HFOSC module is an internal high-frequency oscillator provided in the iCE40 FPGA. It operates at a nominal frequency of 48 MHz with programmable dividers (1, 2, 4, or 8). The oscillator is configured as follows:

- Enabled by setting CLKHFPU = 1 (Power-up) and CLKHFEN = 1 (Enable).

- The output CLKHF is used as the main clock source.

4. Frequency Counter Logic

- A 28-bit register (frequency_counter_i) is implemented as a simple counter that increments on every rising edge of the oscillator clock. 

- A specific bit (frequency_counter_i[5]) is extracted to create a lower-frequency test signal for debugging.

5. RGB LED Driver (SB_RGBA_DRV)

The SB_RGBA_DRV module is a current-controlled driver for the RGB LED. The configuration parameters set the current for each color channel and enable the driver. The LED brightness and color switching are controlled by connecting the PWM inputs to different bits of the frequency counter:

- RGB0PWM (Red) = frequency_counter_i[22]

- RGB1PWM (Green) = frequency_counter_i[22]

- RGB2PWM (Blue) = frequency_counter_i[22]

Since all color components use the same frequency counter bit, the LED cycles through different colors based on the oscillator frequency.

6. Functional Behavior

The RGB LED blinks at a frequency derived from frequency_counter_i[22], resulting in visible color transitions. The testwire output provides a signal for monitoring internal behavior.

STEP - 2 - Creating the PCF File

The Physical Constraints File (PCF) is used in FPGA design to specify pin assignments, mapping logical signals in the Verilog code to the actual FPGA package pins. Below is the detailed breakdown for the VSDSquadron FPGA Mini board based on the provided PCF file.

1. The pin assignments
![image](https://github.com/user-attachments/assets/9739dc83-85f0-421e-ba9b-20a7bd76b2bb)

2. Significance of Each Connection
LED Control Pins (led_red, led_blue, led_green)

- These are connected to the RGB LED on the FPGA board.

- The SB_RGBA_DRV module in the Verilog code drives these LEDs.

- The brightness and color are determined by the frequency counter in the code.

Hardware Clock (hw_clk)

- Pin 20 is assigned to receive the hardware oscillator clock.

- In the provided Verilog code, however, an internal oscillator (SB_HFOSC) is used instead of an external clock.

- This means hw_clk is currently not used, but it can be modified to use an external clock if required.

Test Signal (testwire)

- Connected to Pin 17, testwire is assigned bit 5 of the frequency counter (frequency_counter_i[5]).

- This signal allows for observing a divided-down clock for debugging or external monitoring.

Conclusion
The PCF file ensures that logical signals in Verilog are correctly mapped to the hardware pins of the VSDSquadron FPGA Mini board. These mappings are crucial for correct LED operation and debugging.

STEP 3 - Itegating with VSDSquadron FPGA Mini Board
This section describes the process of integrating the Verilog design and PCF file with the VSDSquadron FPGA Mini board and programming the FPGA to observe the RGB LED behavior.

1. Understanding the VSDSquadron FPGA Mini Board

The VSDSquadron FPGA Mini board is an iCE40-based FPGA development board designed for low-power applications. To successfully integrate our Verilog design, we need to:

- Understand the FPGA’s features and pin layout using its datasheet.

- Ensure the physical board connections match the PCF file.

- Use USB-C and FTDI for communication and programming.

2. Understand the FPGA’s features and pin layout using its datasheet and Ensure the physical board connections match the PCF file.

We cross-check the PCF file (VSDSquadronFM.pcf) with the board’s datasheet to ensure the pin mappings align correctly.
![image](https://github.com/user-attachments/assets/9739dc83-85f0-421e-ba9b-20a7bd76b2bb)

Verification:

- Checked board schematics to confirm LED pins are correctly assigned.

- testwire was verified as a debugging signal output.

- hw_clk was mapped but not used, since the Verilog code uses an internal oscillator.

3. Connecting the Board to the Computer
Required Setup:

- USB-C cable for power and communication.

- FTDI drivers installed (for USB-to-serial communication).

- Development tools installed, including yosys, nextpnr, icestorm, and make.

Steps to Connect:

- Plug in the board using a USB-C cable.

- Ensure the system recognizes the FPGA using: lsusb

4. Building and Flashing the Verilog Code

The provided Makefile automates the synthesis and programming process.

Steps to Compile and Program the FPGA:

- Clean previous builds: make clean

This removes old build files.

- Build the project: make build
This runs Yosys (synthesis), nextpnr (place & route), and generates the bitstream file.

- Flash the FPGA: sudo make flash
This uploads the bitstream to the FPGA board.

5. Observing the RGB LED Behavior

After flashing, the RGB LED should exhibit blinking behavior based on the internal oscillator and frequency counter.

Expected Observations:

- The LED changes colors periodically as dictated by frequency_counter_i[22].

- The testwire signal (Pin 17) toggles at a lower frequency, observable on an oscilloscope.

Implementation in Openlane -
The Implementation of the code is shown in the below ideo -


   </details>

<details>
  <summary><h2>TASK 2 - Implement a UART loopback mechanism </h2> </summary>

UART and UART loophole mechanism -

UART (Universal Asynchronous Receiver-Transmitter)
  
  - It is a hardware communication protocol used for serial communication between devices.

  - It enables data transmission without requiring a shared clock signal, making it an asynchronous method.

  - UART consists of a transmitter (TX) and a receiver (RX), which communicate using a predetermined baud rate, typically including start and stop bits for synchronization.

  - This protocol is widely used in embedded systems, microcontrollers, and communication modules like Bluetooth and GPS due to its simplicity and reliability.

UART Loophole Mechanism 

- It refers to potential vulnerabilities or unintended behaviors in UART communication that can be exploited for debugging, accessing restricted system functionalities, or even security breaches. 

- These loopholes often arise from improperly secured UART interfaces, allowing attackers to gain low-level access to a device’s firmware, bootloader, or shell.

- Exploiting UART loopholes can lead to unauthorized modifications, data extraction, or system control, making it crucial for developers to implement security measures such as disabling exposed UART ports, requiring authentication, or encrypting transmitted data.

Objective of this task: Implement a UART loopback mechanism where transmitted data is immediately received back, facilitating testing of UART functionality.

<details>
  <summary><h3>STEP 1 - Analysis of Existing Code</h3> </summary>

Port Analysis

The module defines six ports:

RGB LED Outputs - 

- led_red, led_blue, led_green → Three PWM-driven LED outputs.

UART Communication Pins

   + uarttx → UART Transmit pin (data sent out).

   + uartrx → UART Receive pin (data received).

System Clock Input - 

 - hw_clk → External system clock input.

Internal Component Analysis

1. Internal Oscillator (SB_HFOSC)

- Generates an internal clock signal (int_osc).

- Uses CLKHF_DIV = "0b10" to divide frequency.

- Provides a stable clock source for timing operations.

2. Frequency Counter

- 28-bit counter (frequency_counter_i).

- Increments on every positive clock edge.

- Used for timing signal generation.

3. UART Loopback

- Direct connection between uartrx (input) and uarttx (output).

- Echoes back any received UART data immediately.

- Enables real-time verification of UART communication.

4. RGB LED Driver (SB_RGBA_DRV)

- Controls three independent RGB channels.

- Uses PWM (Pulse Width Modulation) for brightness adjustment.

- Current limiting set to minimum (0b000001) to avoid excessive power consumption.

- Maps UART input to LED intensity, making the LEDs visually reflect incoming UART data.

Operation Analysis

1. UART Input Processing

- Receives UART data via uartrx pin.

- Immediately loops the data back through uarttx.

- Same data also drives RGB LEDs, causing them to react to incoming serial data.

2. LED Control

- RGB LED driver converts UART signal into PWM output.

- All LEDs respond identically to UART input.

- Brightness changes dynamically based on received data values.

3. Timing Generation

- Internal oscillator provides clock reference for stable operation.

- Frequency counter (frequency_counter_i) generates timing signals.

- Used for LED PWM control and UART data synchronization.

</details>



</details>
