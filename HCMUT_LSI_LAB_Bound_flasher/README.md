<img align="left" width="80" height="80" src="https://github.com/vy-nguyenlethao0510/HCMUT_CSE_POS_2.0/blob/hai/SoftwareReport/R/REPORT/Logo-BK.png">

# HCMUT-VLSI-Lab: Bound flasher 

## Team member:
This project is proudly done by:
* [Le Nguyen Tan Loc](https://github.com/leloc0609)
* [Nguyen Van Quang](https://github.com/quangnguyen310)
* [Vu Hoang Hai](https://github.com/DaTha7)
* [Nguyen Le Thao Vy](https://github.com/vy-nguyenlethao0510)
* [Nguyen Ly Dang Khoa](https://github.com/Khoabk) <br />
## System specification:
  **Expected outcome:** A 16-bit LEDs system that functions accurately as specified below.<br /><br />
   The system operates based on three input signals and produces one output signal:
* Input - Clock (clk): Clock signal controls the timing of the system and is used as
the main synchronizing event (state transitions happen at positive / rising edge of
clock signal).
* Input - Reset (rst_n): An ACTIVE-LOW asynchronous input signal used to restart
the system to the initial state.
* Input - Flick (flick): An input signal used in controlling state transitions.
* Output - 16-bit LEDs (led): A signal representing the state of 16 lamps of the bound
flasher.
* Typical workflow: At the initial state, all lamps are OFF. If flick signal is ACTIVE (set 1),
the flasher will function according to the following steps:
    - The lamps are turned ON gradually from lamp[0] to lamp[5].
    - The lamps are turned OFF gradually from lamp[5] (max) to lamp[0] (min).
    - The lamps are turned ON gradually from lamp[0] to lamp[10].
    - The lamps are turned OFF gradually from lamp[10] (max) to lamp[5] (min).
    - The lamps are turned ON gradually from lamp[5] to lamp[15].
    - Finally, the lamps are turned OFF gradually from lamp[15] to lamp[0], return to initial state.
    
* **Additional condition:** At each kickback point (lamp[5] and lamp[10]), if flick signal is ACTIVE, the lamps will turn OFF gradually again to the min lamp of the previous state, then continue operation as above description. For simplicity, kickback point is considered only when the lamps are turned ON gradually, except the first state. <br /><br />

For illustrating purpose, images of typical workflow are attached below:

<img src="https://github.com/leloc0609/HCMUT_Lab_LSI_Bound_flasher/blob/master/img/workflow_1.png"> <br />
<img src="https://github.com/leloc0609/HCMUT_Lab_LSI_Bound_flasher/blob/master/img/workflow_2.png"> <br />

## Internal implementation:

### Overall

<img src="https://github.com/leloc0609/HCMUT_Lab_LSI_Bound_flasher/blob/master/img/block_diagram.png"> 
<br />
<br />

**Data path of Block diagram description:** <br />
| Signal       |Width          |Type  | Description|
| :-------------:|:-------------:| :-----:|:-----|
| CLK |1 |Input |Used to trigger the sequential blocks.|
| RST |1 |Input |Used to reset the system.
| FLICK |1 |Input | If the signal is high when the last turned on LED is at the kick back point the module returns to it’s previous state.|
| LED |16 |Output |Output signal will be connected to LED.|
|STATE |3 |Reg |Used to keep track of the current state of the module.|
|NEXT_STATE |3| Reg |Used to keep track of the next state.|
|N |32| Integer| Used to turn on or off LED, also involves in deciding the next state of the module.|
|Operation| 2 |Reg| Deciding whether to increment or decrement N or keep it unchanged in the next clock cycle.|
<br />
<br />

**Components of Block diagram description:** <br />

|Block| Description|
|:----:|:----------|
|Change_state|The block has three input signals NEXT_STATE, CLK, RST. It simply transfers the NEXT_STATE input signal to the current state when CLK goes high, If RST is low the output is assigned to INIT.|
|Logic| This block’s output is the operation signal, which is determined by the flick signal, the current state and the value of N.|
|Operation on N| This block performs either increment, decrement or to keep the value of N unchanged over clock cycle based on the value of operation input signal.|
|FSM |This block decides the next state of the machine, it relies on three input signals such as FLICK, STATE and OPERATION to make the decision|
|Decoder |This block’s work is to convert the value of N into appropriate output LED display|

### State machine
<img src="https://github.com/leloc0609/HCMUT_Lab_LSI_Bound_flasher/blob/master/img/fsm.png"> 


