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
The Implementation of the code is shown in the below PHOTOS-
![image](https://github.com/user-attachments/assets/b20b0139-2ea5-4d56-bfdf-2ac327b72a79)
![image](https://github.com/user-attachments/assets/d449328c-9d81-4fe5-8239-b1f5cbc7b30d)
![image](https://github.com/user-attachments/assets/65f3976c-569e-48ee-ad91-fbddc4ac64aa)
![image](https://github.com/user-attachments/assets/19116d96-2122-44ff-bced-eb110572a8be)

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
  <summary><h3>STEP 1 - ANALYSIS OF EXISTING CODE </h3> </summary>

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

<details>
  <summary><h3>STEP 2 - DESIGN DOCUMENTATION </h3> </summary>
  
Block diagram illustrating the UART loopback architecture

![image](https://github.com/user-attachments/assets/5451994b-31c1-47dc-904e-940379cd1496)

<details>
  <summary><h3>The above diagram depicts the following -</h3> </summary>

1. UART Loopback Mechanism

- The UART receiver (uartrx) captures incoming serial data from an external source (e.g., a PC or microcontroller).

- This data is directly forwarded to the UART transmitter (uarttx), creating a loopback effect where received data is immediately echoed back.

- This setup allows real-time verification of UART communication, ensuring data integrity and debugging capability.

2. Internal Clock Generation & Timing

- A high-frequency oscillator (SB_HFOSC) generates the system clock (int_osc), eliminating the need for an external clock source.

- A 28-bit frequency counter (frequency_counter_i28-bit) increments on each clock cycle, providing internal timing signals.

- These timing signals regulate various system operations, including UART baud rate handling and LED PWM control.

3. RGB LED Control via UART Data

- The RGB Driver (SB_RGBA_DRV) receives UART data and maps it to LED brightness levels using Pulse Width Modulation (PWM).

- All three LEDs (led_red, led_blue, led_green) respond identically, changing brightness based on the received UART values.

- This behavior provides a visual representation of the incoming serial data, making it easier to observe communication activity.

4. Control Signals & Power Management

- The control block (Enable Signals - RGBLEDEN, CURREN) ensures that the RGB LED driver is activated only when needed.

- The current setting (0b000001) is configured to the minimum power level, preventing excessive power consumption while still allowing LED visibility.

- These settings allow efficient operation while maintaining full functionality of the UART-driven LED display.

5. Complete System Integration & Real-Time Testing

- This system combines UART communication, clock generation, LED driving, and control logic into a compact FPGA implementation.

- Testing is straightforward:

Send data through UART (from a PC or another microcontroller).

Verify that the same data is received back (loopback confirmation).

Observe that RGB LEDs respond to the data (visual feedback).

- This integrated design is useful for debugging, UART validation, and real-time embedded system monitoring.

</details>

Circuit diagram showing connections between the FPGA and any peripheral devices used -

![image](https://github.com/user-attachments/assets/d942a45c-94df-46ff-8e2f-4d33277c11f1)

<details>
  <summary><h3>The above diagram depicts the following -</h3> </summary>

- UART Loopback Communication – The UART interface (uartrx / uarttx) receives serial data and immediately transmits it back, enabling real-time verification and debugging. The UART bridge connects external devices for communication.

- Internal Clock & Timing – A high-frequency oscillator (int_osc) generates the system clock, while a 28-bit frequency counter ensures proper timing for UART and LED control.

- RGB LED Control via PWM – The RGB Driver (SB_RGBA_DRV) converts UART data into PWM signals, controlling LED brightness. All LEDs respond based on received UART data.

- Power Supply & Signal Flow – The power supply provides VCC and GND to the FPGA, UART bridge, and RGB LEDs, ensuring stable operation. The PWM control signal modulates LED intensity.

- Efficient & Low-Power Operation – Control signals (RGBLEDEN, CURREN) optimize LED power usage, preventing excessive current draw while maintaining brightness control.

</details>

</details>

<details>
  <summary><h3>STEP 3 - IMPLEMENTATION </h3> </summary>

To transmit the code to the FPGA board

- Create the following files (Makefile, uart_trx - verilog, top module - verilog, pcf file) in a folder under VSDSquadronFM. In this case I have named it uart_loop.

- After doing so, go to the terminal and enter the following commands. Also connect the board to the VM and verify the connection using lsusb. If successful, you will see "Future Technology Devices International" in the output.

      cd

      cd VSDSquadron_FM

      cd uart_loopback

- After this, run the commands "make build", and "sudo make flash". Then, your screen will look like:
![image](https://github.com/user-attachments/assets/13e07c77-159e-4528-b46c-298ecea3114d)


</details>

<details>
  <summary><h3>STEP 4 - VERIFICATION </h3> </summary>

 - To test the UART loopback functionality, we will use Docklight, a specialized serial communication software. This tool allows us to send and receive UART data, verifying whether the FPGA correctly echoes back received messages. 
  
 - First, after downloading and opening Docklight, ensure that your system (not the virtual machine) is connected to the correct communication port (COM port).
 
 - By default, Docklight may select COM1, but you need to verify and change it if necessary. Navigate to Tools > Project Settings, where you can select the appropriate COM port; in this case, it is COM7.
 
 - Additionally, set the baud rate to 9600, as this is the communication speed configured for our FPGA's UART module. This ensures that both Docklight and the FPGA are operating at the same frequency, preventing data mismatches.

- Next, within Docklight, locate the "Send Sequences" section, which allows you to create and send custom UART messages. Double-click on the small blue box under the "Name" column, which will open an editor where you can enter a custom name for your message.

- Select the appropriate format (e.g., ASCII or HEX) and then type the message you wish to send. After entering the message, click "Apply", and verify that your sequence appears in the Send Sequences list.

- This step is essential as it confirms that your message is correctly formatted and ready for transmission. The ability to define and store multiple sequences also makes repeated testing easier, as you can quickly resend predefined messages.

- Finally, to test the loopback functionality, click the arrow beside the message name to send the message through UART. 

- If the FPGA's loopback system is working correctly, you should see the same message appear in the received data log in Docklight. This confirms that data sent from Docklight is successfully received by the FPGA and immediately retransmitted back. 

- If you do not receive the expected message, double-check the COM port settings, baud rate, and UART connections. This method provides a quick and efficient way to verify UART functionality, ensuring that the FPGA correctly processes serial communication.

![image](https://github.com/user-attachments/assets/0869c518-aad6-44cb-9ed8-a3e76e70d582)

</details>

</details>

</details>

<details>
  <summary><h2>TASK 3 - Develop a UART transmitter module </h2> </summary>

INTRODUCTION TO UART TRANSMITTER

- The UART transmitter is responsible for converting parallel data into a serial stream and sending it over a communication line. It follows a standard protocol, beginning with a start bit, followed by data bits, an optional parity bit, and ending with one or more stop bits.

- The transmitter operates at a predefined baud rate, ensuring synchronization with the receiver. When data is available, it is loaded into a shift register, which shifts out the bits sequentially, starting with the least significant bit (LSB). Proper timing and control signals ensure error-free transmission, making UART an efficient and widely used communication protocol in embedded systems.

OBJECTIVE OF TASK - Develop a UART transmitter module capable of sending serial data from the FPGA to an external device.

<details>
  <summary><h3>STEP 1 - STUDY THE EXISTING CODE </h3> </summary>

  - This Verilog module implements an 8N1 UART transmitter, meaning it sends 8 data bits, no parity, and 1 stop bit per frame.
  
  - The module converts an 8-bit parallel data input (txbyte) into a serial output (tx), transmitting it bit by bit at every clock cycle.

MAIN COMPONENTS -

Inputs:

- clk → System clock signal driving the transmission process.

- txbyte[7:0] → The 8-bit data to be transmitted.

- senddata → A trigger signal that starts transmission when high.

Outputs:

- tx → Serial transmit wire, sending the data bit by bit.

- txdone → Indicates when the transmission of a full byte is completed.

Registers & State Variables:

- state → Stores the current state of transmission (Idle, Start, Sending, Done).

- buf_tx → A buffer register that holds the byte being transmitted.

- bits_sent → A counter tracking how many bits have been sent.

- txbit → Holds the current bit value to be transmitted.

Working Process:

1. Idle State (STATE_IDLE)

- The transmitter remains idle (tx stays HIGH).

- When senddata is triggered, it moves to the Start Transmission state.

2. Start Bit (STATE_STARTTX)

- The module sends a Start Bit (LOW = 0) to signal the beginning of data transmission.

- Moves to the transmitting state.

3. Data Transmission (STATE_TXING)

- Sends the 8 data bits one by one, starting from the least significant bit (LSB).

- Uses a shift register (buf_tx >> 1) to shift out each bit on txbit.

- The bits_sent counter increments after each bit transmission.

4. Stop Bit & Completion (STATE_TXDONE)

- After sending all 8 data bits, a Stop Bit (HIGH = 1) is sent.

- The txdone signal is set HIGH, indicating the byte was sent.

- The module then returns to the Idle state, waiting for the next byte.

</details>

<details>
  <summary><h3>STEP 2 - DESIGN DOCUMENT </h3> </summary>

 1. Create a block diagram detailing the UART transmitter module.

![image](https://github.com/user-attachments/assets/23909dc7-65bd-4728-b34a-c19df38bb174)

Data Input and Buffering:

- The Tx byte (8-bit data) is loaded into the buffer (Buf_tx) when the Senddata trigger is received.

- The system operates on a clock signal (Clk), ensuring synchronized data transmission.

State Machine Control and Transmission:

- The state machine manages the transmission by progressing through different states (Idle, Start, Transmit, Stop).

- The Next State Decision block determines transitions based on current state and bit counter.

- The Tx bit (current bit) is sequentially transmitted to the Tx (serial output) line.

Completion and Status Update:

- A bit counter (Bits sent) tracks how many bits have been transmitted.

- Once all bits (including stop bit) are sent, the Transmission Complete Flag is raised, signaling that the UART transmission is finished.


2. Develop a circuit diagram illustrating the FPGA's UART TX pin connection to the receiving device.

![image](https://github.com/user-attachments/assets/5208106d-33bb-4dc8-ac78-661cf7d0cf52)

- UART Transmitter Operation:
The UART transmitter operates at a 3.3V logic level and sends serial data through its TX pin. This pin outputs a digital signal that represents transmitted data bits. However, if the receiving device operates at a different voltage level (e.g., 5V logic), direct connection might cause communication issues or even damage the receiver due to voltage mismatches.

- Signal Conditioning Using Voltage Divider:
To ensure compatibility between the transmitter and receiver, a resistor voltage divider is used. The voltage divider consists of two resistors: R1 (1kΩ) and R2 (2kΩ). These resistors form a passive circuit that reduces the transmitted signal voltage before it reaches the RX pin of the receiving device. The formula for voltage division is:

![image](https://github.com/user-attachments/assets/5decff6a-4492-44fa-9ef8-b228f1997703)


This means that the signal is scaled down to 2.2V, making it safe and readable for the receiving device.

- Receiving Device and Proper Signal Handling:
The adjusted voltage signal is then fed into the RX pin of the receiving device. Since the voltage level is now appropriately scaled down, the receiving device can correctly interpret the transmitted UART data without any risk of voltage damage or miscommunication.

- Common Ground Connection:
A common ground (GND) is essential for proper communication between the UART transmitter and the receiver. Both devices must share the same reference voltage to ensure that logic levels are interpreted correctly. Without a shared ground, the signal could be unstable, leading to errors in communication.

</details>

<details>
  <summary><h3>STEP 3 - IMPLEMENTATION </h3> </summary>

Create the required files inside a folder under VSDSquadron_FM.

Next, open the terminal and navigate to the uart_transmission folder using the following commands:

cd VSDSquadron_FM  
cd uart_transmission  

Once inside the folder, verify the board connection using:

lsusb  

If the board is connected, you will see "Future Technology Devices International" in the output.

Finally, build and flash the code with:

make build  
sudo make flash  

That's it! The code is successfully transmitted.

</details>

<details>
  <summary><h3>STEP 4 - VERIFICATION </h3> </summary>

Install and open PuTTY or you may use docklight.

Verify the correct serial port (e.g., COM7) is connected.

Check the output:

A series of "D" characters should appear.

The RGB LED should be blinking, cycling between red, green, and blue.

If these conditions are met, you have successfully completed the task!

https://drive.google.com/file/d/1C8N5BCpPNtx6H7yrSQd2ao3JO7cgJtFj/view?usp=sharing

</details>
</details>

<details>
  <summary><h2>TASK 4 - Implementing a UART Transmitter that Sends Data Based on Sensor Inputs </h2> </summary>
  
Objective: Implement a UART transmitter that sends data based on sensor inputs, enabling the FPGA to communicate real-time sensor data to an external device.

<details>
  <summary><h3>STEP 1 - STUDY THE EXISTING CODE </h3> </summary>

uart_tx_sense Module Overview
The uart_tx_sense module is a dedicated UART transmitter designed for sensor data transmission. Its architecture consists of three key components:

Data Buffer Management – Stores and synchronizes sensor data.

UART Protocol Controller – Handles framing and transmission sequencing.

Transmission Control Logic – Ensures reliable bit-by-bit data transfer.

Operation Flow
Data Acquisition: Captures valid sensor data in the IDLE state and stores it in a 32-bit buffer.

Transmission Protocol:

START – Sends UART start bit (low).

DATA – Transmits 8 bits sequentially.

STOP – Ensures proper termination with a high bit.

Status Indication:

ready signal indicates readiness for new data.

tx_out provides a continuous UART stream.

Port Analysis
Clock & Reset:

clk – Drives sequential operations.

reset_n – Active-low asynchronous reset.

Data Interface:

data – 32-bit input for sensor readings.

valid – Indicates valid incoming data.

UART Interface:

tx_out – Serial output following UART protocol.

Status Interface:

ready – Signals readiness for new data.

Internal Components
State Machine Controller: Manages protocol states, controls data flow, and ensures correct UART framing.

Data Buffer: Stores and stabilizes incoming sensor data for smooth transmission.

Transmission Controller: Manages bit-by-bit transmission, timing, and start/stop bit generation.  
</details>

<details>
  <summary><h3>STEP 2 - DESIGN DOCUMENTATION </h3> </summary>
BLOCK DIAGRAM

  ![image](https://github.com/user-attachments/assets/34a28a5e-8333-4b33-a242-2078f632c0d0)

CIRCUIT DIAGRAM

![image](https://github.com/user-attachments/assets/1a9dbde0-104f-4c5e-ab6f-236f066bd8fe)

</details>

<details>
  <summary><h3>STEP 3 - IMPLEMENTATION </h3> </summary>
Create the required files inside a folder under VSDSquadron_FM.

Open the terminal and navigate to the uart_tx_sense folder using:

cd VSDSquadron_FM  
cd uart_tx_sense  

Verify the board connection by running:

lsusb  

If connected, you will see "Future Technology Devices International" in the output.

Build and flash the code:

make build  
sudo make flash  

That is it. The code is transmitted.

</details>

<details>
  <summary><h3>STEP 4 - VERIFICATION </h3> </summary>

  Open PuTTY or you may use docklight.

Verify the correct port for serial communication (e.g., COM7).

Check the output:

A series of "D" characters should appear.

The RGB LED should be red.

https://drive.google.com/file/d/1Bb61uY00jVFBbObvupKQVIJ-5vhOMKln/view?usp=sharing

</details>
</details>



<details>
  <summary><h2>TASK 5 - Real-Time Sensor Data Acquisition and Transmission System </h2> </summary>

Objectives:

Conduct comprehensive research on the chosen theme.​

Formulate a detailed project proposal outlining the system's functionality, required components, and implementation strategy.

<details>
  <summary><h2>STEP 1 - Literature review</h2> </summary>

Distance-Based LED Alert System Using HC-SR04 and FPGA

This project is a real-time object detection system built using an FPGA and an ultrasonic distance sensor (HC-SR04). The system continuously monitors the distance to an object. If the object comes closer than 5 centimeters, an LED is triggered to blink (toggle on and off). Otherwise, the system keeps the LED off.

The entire logic of distance measurement and LED control is implemented using Verilog on the FPGA. No microcontroller or analog circuits are used. The project demonstrates how basic digital logic and sensor interfacing can create a complete, working application with real-world relevance.

Objectives
Interface a digital ultrasonic sensor (HC-SR04) with an FPGA

Measure the duration of the echo signal using counters

Calculate the approximate distance using timing information

Compare the distance to a threshold (5 cm)

Trigger an LED to blink when an object is too close (less than 5 cm)

Design a clean, reliable, and repeatable hardware logic using Verilog
</details>

<details>
  <summary><h2>STEP 2 - Define System Requirements</h2> </summary>

1. FPGA Development Board

iCE40UP5K (or similar FPGA development board)

This FPGA board will be used to implement your Verilog design. You'll program the FPGA with the bitstream generated using the tools.

Example:

iCEBreaker FPGA Board (with iCE40UP5K)

Board features: 5k LUTs, 128 I/O pins, integrated USB, etc.

If you use a different FPGA, make sure the pinout and resources align with the configuration in the project.pcf.

2. HC-SR04 Ultrasonic Sensor

The HC-SR04 module is used for measuring the distance by emitting a sound wave and receiving its echo.

VCC pin: Power supply for the module (5V).

GND pin: Ground.

Trig pin: Used to trigger the ultrasonic measurement.

Echo pin: Receives the reflected signal (duration is used to calculate distance).

3. LED

A simple LED to blink based on the distance measurement.

Resistor (typically 220Ω to 330Ω) in series with the LED to limit current and prevent damage.

4. Power Supply

5V power supply to power the HC-SR04 sensor and the FPGA board.

Ensure the FPGA board is powered through USB or an external adapter depending on your setup.

5. Jumper Wires

Used for connecting the pins of the FPGA board to the HC-SR04 sensor and LED.

Pin Connections for the Components

1. HC-SR04 Ultrasonic Sensor to FPGA Board

VCC (HC-SR04) → 5V power supply

GND (HC-SR04) → GND

Trig (HC-SR04) → Pin 2 on FPGA (configured in project.pcf)

Echo (HC-SR04) → Pin 3 on FPGA (configured in project.pcf)

2. LED to FPGA Board

Anode (positive) → Pin 41 on FPGA (configured in project.pcf)

Cathode (negative) → GND

Current-limiting resistor (220Ω or 330Ω) in series with the LED.

3. FPGA Board

Pin 35 → Clock (12 MHz)

</details>

<details>
  <summary><h2>STEP 3 - Design System Architecture </h2> </summary>
Here is the block diagram of the system -

![image](https://github.com/user-attachments/assets/4d1de5ba-b1ea-4a68-9135-563319331d61)

How It Works (with LED Control)

The FPGA sends a short 10-microsecond HIGH pulse to the HC-SR04 sensor every 50 milliseconds. This pulse initiates a distance measurement.

The sensor emits a sound wave and waits for it to bounce back. The Echo pin goes HIGH for a duration that depends on how far the object is from the sensor.

The FPGA uses a counter to measure the duration of the Echo signal.

The FPGA uses the following formula to calculate the distance:

Distance (cm) = (Time in microseconds × 0.0343) / 2

Where:

0.0343 is the speed of sound in cm/us.

The division by 2 accounts for the round trip of the sound wave (out and back).

If the measured distance is less than 5 cm, the FPGA toggles the LED (turning it ON and OFF repeatedly to create a blinking effect).

If the distance is greater than or equal to 5 cm, the FPGA keeps the LED OFF (since it’s active-low).


</details>

<details>
  <summary><h2>STEP 4 - Develop FPGA Modules </h2> </summary>

1. top.v

This is the top-level Verilog module that connects all the sub-modules and controls the overall logic of the project.

Inputs:

clk: Main clock signal (12 MHz). It drives the logic in the design.

rst: Asynchronous reset signal to initialize the system to a known state.

echo: The Echo signal from the HC-SR04 ultrasonic sensor, used to measure distance.

Outputs:

trigger: Trigger signal for the HC-SR04 sensor to initiate distance measurement.

led: Output signal to control the LED based on the measured distance.

What it does:

It uses the trigger_gen module to generate a 10 μs pulse at regular intervals (every 50 ms) to trigger the HC-SR04.

It uses the echo_timer module to measure the time the Echo signal stays high, which corresponds to the distance.

Based on the measured distance, it uses the led_ctrl module to control the blinking of the LED.

2. led_ctrl.v

This module controls the LED behavior based on the measured distance.

Inputs:

clk: Main clock signal to sync the logic.

rst: Reset signal to initialize the module.

duration: The measured duration from the Echo signal (representing the distance).

Outputs:

led_out: The LED output signal, which will control the blinking of the LED on the FPGA.

What it does:

It checks the duration (time taken for the Echo pulse to return).

If the measured distance is below a certain threshold (5 cm), it toggles the LED (turning it ON/OFF).

If the distance is above the threshold, the LED stays OFF.

3. project.pcf

This is the Pin Configuration File that specifies which FPGA pins are connected to the external components. It tells the FPGA toolchain (like NextPNR) how to assign your design's signals to the actual physical pins on the FPGA board.

Pins specified:

clk: Pin 35 (onboard clock at 12 MHz).

trigger: Pin 2 (to trigger the HC-SR04 sensor).

echo: Pin 3 (to receive the Echo signal from the HC-SR04 sensor).

led: Pin 41 (to control the LED, which blinks based on distance).

What it does:

Ensures that the logic in your design is correctly mapped to the appropriate FPGA pins based on your hardware setup.

4. Makefile

This file automates the build process for your FPGA design using various tools like Yosys, NextPNR, and IcePack.

What it does:

Synthesis: It converts your Verilog files into a netlist (.json) format that the FPGA tools can work with.

Place and Route: It runs NextPNR to perform placement and routing, producing a .asc file (bitstream layout).

Bitstream Generation: It uses IcePack to convert the .asc file into a .bin file, which is the final bitstream used to program the FPGA.

Programming: It uses iceprog to upload the generated bitstream to the FPGA.

Clean: It removes the intermediate files to clean up your directory after the build.

The files have been uploaded.
</details>

<details>
  <summary><h2>STEP 4 - VIDEO OF THE PROJECT </h2> </summary>

Verify connections: Ensure the corresponding hardware devices (e.g., sensor, LEDs) are properly connected to the designated pins.

Verification Process:
Compile the design: Ensure the FPGA or microcontroller synthesizes correctly with the pin assignments in the .pcf file.

Run simulation: Check if the system's behavior (triggering, echo responses, LED outputs) matches expectations.

Test in hardware: After programming the device, physically verify the system works by toggling the inputs (e.g., trigger and reset) and checking the outputs (echo response and LED).

https://github.com/user-attachments/assets/42f2e37c-3984-4025-bdcc-a2d768e12ab1

 </details> 
