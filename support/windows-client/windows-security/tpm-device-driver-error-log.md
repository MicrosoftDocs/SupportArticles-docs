---
title: Error log of Trusted Platform Module (TPM) device driver
description: The TPM device driver is recorded in the system log when it encounters an unrecoverable error.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ksharma, kaushika
ms.custom: sap:tpm, csstroubleshoot
---
# Event ID 14, 17 log for TPM command failure or non-recoverable error

This article describes an issue in which the TPM device driver is recorded in the system log when it experiences an unrecoverable error.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4562894

## Symptoms

On a TPM device, you experience issues with BitLocker, logging to applications using Modern Authentication or Next Generation Credentials. These messages are logged in the event logs:  

- The Trusted Platform Module (TPM) hardware failed to execute a TPM command.
- The device driver for the Trusted Platform Module (TPM) encountered a non-recoverable error in the TPM hardware, which prevents TPM services (such as data encryption) from being used.

See the following log examples for detailed information:

### Event ID 14

> Log Name:      System  
Source:        TPM  
Date:  
Event ID:      14  
Task Category: None  
Level:         Error  
Keywords:  
User:          SYSTEM  
Computer:      `WIN10PC.CONTOSO.COM`  
Description:  
The device driver for the Trusted Platform Module (TPM) encountered a non-recoverable error in the TPM hardware, which prevents TPM services (such as data encryption) from being used. For further help, please contact the computer manufacturer.  
Event Xml:  
\<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`">  
  \<System>  
    \<Provider Name="TPM">  
    \<EventID>14\</EventID>  
    \<Version>0\</Version>  
    \<Level>2\</Level>  
    \<Task>0\</Task>  
    \<Opcode>0\</Opcode>  
    \<Keywords>0x8000000000000000\</Keywords>  
    \<EventRecordID>55474\</EventRecordID>  
    \<Correlation />  
    \<Execution ProcessID="4" ThreadID="284" />  
    \<Channel>System</Channel>  
    \<Computer>WIN10PC.CONTOSO.COM\</Computer>  
    \<Security UserID="S-1-5-18" />  
  \</System>  
  \<EventData>  
    \<Data Name="locationCode">0x2c000230\</Data>  
    \<Data Name="Data">255\</Data>  
  \</EventData>  
\</Event>  

### Event ID 17

> Log Name:      System  
Source:        TPM  
Date:  
Event ID:      17  
Task Category: None  
Level:         Information  
Keywords:  
User:          SYSTEM  
Computer:      `WIN10PC.CONTOSO.COM`  
Description:  
The Trusted Platform Module (TPM) hardware failed to execute a TPM command.  
Event Xml:  
\<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`">  
  \<System>  
    \<Provider Name="TPM">  
    \<EventID>17\</EventID>  
    \<Version>0\</Version>  
    \<Level>4\</Level>  
    \<Task>0\</Task>  
    \<Opcode>0\</Opcode>  
    \<Keywords>0x8000000000000000\</Keywords>  
    \<EventRecordID>55475\</EventRecordID>  
    \<Correlation />  
    \<Execution ProcessID="4" ThreadID="284" />  
    \<Channel>System\</Channel>  
    \<Computer>WIN10PC.CONTOSO.COM\</Computer>  
    \<Security UserID="S-1-5-18" />  
  \</System>  
  \<EventData>  
    \<Data Name="locationCode">0x1e000354\</Data>  
    \<Data Name="TpmCommandOrdinal">378\</Data>  
    \<Data Name="TpmResponseCode">3221225860\</Data>  
  \</EventData>  
\</Event>  

## Cause

This problem occurs because of an issue with the TPM device. It prevents Windows from communicating and using the TPM device for the functionalities that reply on TPM, such as:

- BitLocker
- Modern Authentication
- Next Generation Credentials

## Workaround

Make sure the following updates are installed:  

- [Latest Servicing Stack Update (SSU)](https://portal.msrc.microsoft.com/security-guidance/advisory/ADV990001) and [monthly Cumulative Update (CU) in Windows](https://www.catalog.update.microsoft.com/Search.aspx?q=windows%2010%20cumulative%20update)  
- Available update of the BIOS Firmware or TPM Device Firmware on manufacturer's support websites.

If the issue persists, contact the hardware vendor or the device manufacturer to diagnose your TPM device. For more information, see [TPM Recommendations](/windows/security/information-protection/tpm/tpm-recommendations).
