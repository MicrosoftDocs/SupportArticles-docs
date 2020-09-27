---
title: Transmit and receive binary data
description: This article describes how to use the MSComm32.ocx control to receive and transmit binary data over an RS-232 cable without modems.
ms.date: 09/07/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: visual-studio-family
---
# Transmit and receive binary data by using the VFP MSComm32 control

This article describes how to use the MSComm32.ocx control to receive and transmit binary data over an RS-232 cable without modems.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 154741

## Summary

This article illustrates some techniques using the Visual FoxPro 3.0 Communications (MSComm) control for receiving and transmitting binary data over RS-232 cable (without having modems).

## More information

The Communications control, MSCOMM32.OCX, provides serial communications for your application by allowing the transmission and reception of data through a serial port where only a string of characters to the transmit buffer is permitted. This feature limits you to transmitting only text-based files.

This article demonstrates how to use the MSComm control to transmit and receive binary data using RS-232 cable. (The techniques in this article will also work with modems.) The binary data must be converted 1 byte at a time to a character and then transmitted. When received, the data must be converted from a character back into binary data 1 byte at a time.

On DBCS-enabled operating systems (running operating system software that uses one of the double-byte character sets), binary data will be corrupted if one of the binary values matches a DBCS lead character. The MSComm control will interpret this byte and the following byte as one double-byte character and return only 1 byte for the equivalent ASCII character. To resolve this problem, you need to convert 1 byte into ASCII size of three characters to preserve the lead character.

### Sample code

The following code illustrates this process.

> [!WARNING]
> USE OF THE SAMPLE CODE PROVIDED IN THIS ARTICLE IS AT YOUR OWN RISK. Microsoft provides this sample code "as is" without warranty of any kind, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose.

```console
* Transmitter Code.

* INIT event of Comm OLE control
* 28800 baud, no parity, 8 data, and 1 stop bit.
* In RS-232, maximum speed of 28800 baud can be used

This.Settings = "28800,N,8,1"
This.InputLen = 1
This.CommPort = 1
This.PortOpen = .T.

* ONCOMM event of Comm OLE Control
* The following code is needed to make sure that next set of characters
* can be transmitted (CommEvent = 2 is triggered from the receiver side)

IF This.CommEvent = 2
This.input
IF gnTop <= gnEnd
gcString = FREAD(gnFileHandle, 1) && Store to memory
q=asc(gcstring)
* change ASCII to character (size of 3) to preserve the lead char
thisform.olecontrol1.output = str(q,3)
gnTop = gnTop + 1
ENDIF
ENDIF

* INIT event of form
PUBLIC gnFileHandle
PUBLIC gnEnd
PUBLIC gnTop
PUBLIC q
* You should replace 'c:\sample.hlp' with your own binary file
STORE FOPEN('c:\sample.hlp') TO gnFileHandle && Open the file
STORE FSEEK(gnFileHandle, 0, 2) TO gnEnd && Move pointer to EOF
STORE FSEEK(gnFileHandle, 0) TO gnTop && Move pointer to BOF
gntop=1
q=""
-----------------------
Property of OleControl1

RThreshold = 1 * triggers when at least one char is on the buffer
SThreshold = 3
----------------------

* Receiver Code.

* INIT event of OleControl1
* 28800 baud, no parity, 8 data, and 1 stop bit.

This.Settings = "28800,N,8,1"
This.InputLen = 3
This.CommPort = 1
This.PortOpen = .T.

* OnComm event

IF This.CommEvent = 2 AND This.InBufferCount > 0
qq=CHR(VAL(This.Input))
=FWRITE(gnFileHandle,qq)
this.output = CHR(26)
ENDIF
* INIT event of form
PUBLIC gnFileHandle
* You should replace 'c:\sample.hlp' with your own file name
IF FILE('c:\sample.hlp') && Does file exist?
gnErrFile = FOPEN('c:\sample.hlp',12) && If so, open read-write
ELSE
gnErrFile = FCREATE('c:\sample.hlp') && If not, create it
ENDIF
= FCLOSE(gnErrFile) && Close the file
STORE FOPEN('c:\sample.hlp',1) TO gnFileHandle && Open the file
* CLICK event of button
*This tells the transmitting side to start sending the file
Thisform.Olecontrol1.output = CHR(26)
-----------------------
Property of OleControl1
RThreshold = 3
-----------------------
```

The event-driven technique generates an OnComm event when there are characters waiting in the input buffer. Also, the `CommEvent` property will contain a numeric 2. For the OnComm event to be triggered, you must set the `Rthreshold` property to a value other than zero (its default). The most common setting for the `RThreshold` property is **1**, meaning that the OnComm event is triggered if a minimum of one character is waiting in the input buffer. In this article, **3** is being used as a value of `RThreshold` property because **three** characters at a time are being sent.
