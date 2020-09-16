---
title: Receive from the serial port by using MScomm32.ocx in Visual FoxPro
description: This article describes two methods to use in Visual FoxPro to receive data from the serial port by using the Mscomm32.ocx control.
ms.date: 09/07/2020
ms.prod-support-area-path:
ms.topic: how-to
ms.prod: visual-studio-family
---
# Receive from the serial port by using MScomm32.ocx in Visual FoxPro

This article describes two methods to use in Visual FoxPro to receive data from the serial port by using the Mscomm32.ocx control.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 140525

## Summary

This article gives you two techniques you can use to receive data from the serial port using the Mscomm32.ocx control. The first uses an event-driven method and does not require you to poll the serial port to check for the presence of received characters. This technique allows the most flexibility and does not require extensive coding to prevent buffer over-runs. The second technique requires you to poll the input buffer periodically to check for the presence of received characters. This article describes these two techniques and provides examples for each.

## More information

Set the following properties regardless of which technique you use:

- `CommPort` property: Set this numeric property to the desired communications port. Valid values are 1, 2, 3, or 4 depending on the serial ports available and the configuration of the individual computer. These values correspond to Com1, Com2, Com3, and Com4 respectively.

- `Settings` property: Set this character property to the baud rate, Parity, Data Bits, and Stop Bits required by the device connected to the serial port. This property is a character, comma-delimited list. For example, to set the serial port to 14,400 baud, Even Parity, 7 Data Bits, and 1 Stop Bit, set the string to: `14400,E,7,1`.

- `PortOpen` property: Set this logical property to true to open communications to the serial port. You can also check this property to determine if the port opened correctly.

## Technique one: Event-driven receive

The event Driven technique generates an `OnComm` event when there are characters waiting in the input buffer. Also, the CommEvent property will contain a numeric 2. For the `OnComm` event to be triggered, you must set the `Rthreshold` property to a value other than zero (its default). The most common setting for the `Rthreshold` property is 1, meaning that the `OnComm` event is triggered if a minimum of one character is waiting in the input buffer.

For example, you can place the following code in the `OnComm` event to append received data to a property of a form called `mybuffer`:

```console
Procedure MyCom.OnComm
    IF This.CommEvent = 2
        ThisForm.mybuffer = ThisForm.mybuffer + This.Input
    ENDIF
ENDPROC
```

## Technique two: Polling the input buffer

Polling the input buffer requires that the program periodically stop what it is doing and check to see if there are characters waiting in the input buffer. When using this technique, leave the `Rthreshold` property at **0** (its default value), and check the `InBufferCount` property to see if it is greater than zero, which indicates that there are characters waiting in the buffer.

> [!NOTE]
> Using a technique such as checking the length of the Input property results in lost characters because as soon as the Input property is accessed, the Input buffer is emptied. Use the InBufferCount property instead.

Assuming the Mscomm control is on the form and has the name `MyCom` and that there is a form property named `mybuffer`, the following code illustrates how to poll for waiting characters:

```console
Procedure myform.myproc
    IF Thisform.MyCom.InBufferCount > 0
        Thisform.mybuffer = Thisform.mybuffer + Thisform.MyCom.Input
    ENDIF
ENDPROC
```

The procedure code could be called in a timer method to facilitate checking for characters at semi-regular intervals. However, if large amounts of data are expected to be received from the serial port, Technique One will reduce the chance of over-running the input buffer.
