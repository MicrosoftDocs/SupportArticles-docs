---
title: Send to the serial port by using Mscomm32.ocx
description: This article describes how to send information to the serial port by using the Mscomm32.ocx control.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: Visual FoxPro
---
# Send to the serial port by using Mscomm32.ocx

This article introduces how to send information to the serial port by using the Mscomm32.ocx control.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 139526

## Summary

This article describes the settings necessary to send data to the serial port by using Mscomm32.ocx. Mscomm32.ocx ships with Microsoft Visual FoxPro Professional Edition. It can be used on computers that are running Microsoft Windows 95 and later versions of Windows.

## More information

The most frequently used properties to send data to the serial port using the mscomm control are as follows:

### CommPort

The `CommPort` property specifies the communications port number. A numeric property that corresponds to the Comm port. By default, this property is set to 1 corresponding to com1. Valid values are 1, 2, 3, or 4 depending on the serial ports installed on the computer and their configuration.

### Settings

The `Settings` property configures the baud rate, parity, data bits, and stop bits for the serial port. The Settings property is a character string that contains individual comma-separated values. By default, the Settings property is as follows: 9600,N,8,1
This property corresponds to 9600 baud, no parity, 8 data bits, and 1 stop bit.

The following baud rate values are valid: 110, 300, 600, 1200, 2400, 4800, 9600 (default), 14400, 19200, 28800, 38400, 56000, 57600, 115200, 128000, 256000.

### PortOpen

The `PortOpen` property specifies a logical value that controls whether or not the serial port is open and active. Once the previous properties are set to begin using the serial port, you can set this property to true.

### Output

The Output property is assigned the string of characters to be sent to the serial port. To output the string "Hello World" to the serial port after the previous properties are set, use the following command:

```sql
 myform.mycomm.output = "Hello World"

```

Other properties that may be also be needed depending on the application are as follows:

### CommEvent

The `CommEvent` property contains a value that represents the most recent communications event or errors.

### Sthreshold

The `Sthreshold` property specifies the minimum number of characters in the output buffer that are sent.

### OutBufferCount

The OutBufferCount control returns the number of characters waiting in the transmit buffer. This should always be zero if the `Sthreshold` property is zero. Setting the `OutBufferCount` property to zero will clear the transmit buffer.

### OutBufferSize

The `OutBufferSize` property specifies the size of the transmit buffer. By default, this buffer is 512 bytes. The larger the transmit buffer, the less memory available to other applications. Slow baud rates and large text strings written to the serial port may mean you need to make this value larger.

Following is a sample that shows how to set up the comm control and dial the phone number 555-1234 by using the standard Hayes Modem commands.

```console
 PUBLIC ComForm
 ComForm = CREATEOBJECT('Form')
 ComForm.AddObject("Testcom","Olecontrol","MSCOMMLib.MSComm")
 ComForm.Testcom.CommPort = 2 && Use Comm2, The second Serial Port.
 ComForm.Testcom.Settings = "14400,N,8,1" && 14.4 Kbaud, No Parity,
 && 8 data Bits, 1 Stop Bit
 ComForm.Testcom.PortOpen = .T.
 ComForm.Testcom.Output = "ATDT555-1234" + chr(13) && Dialing the number
 * The chr(13) is needed to complete the modem command sequence
 ComForm.Testcom.PortOpen = .F.
 ***** End Code *****
```

> [!NOTE]
> If you use this in an application and then distribute the application by using the Visual FoxPro Setup Wizard, you may see the following error when you run the application:

Program Error OLE error code 0x80040112: Appropriate license for this class not found.
