---
title: Troubleshoot the Event ID 50 error message
description: Describes how to troubleshoot the Event ID 50 error message.
ms.date: 3/15/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna, v-tappelgate
ms.custom: sap:smb, csstroubleshoot
---
# Troubleshoot the Event ID 50 error message

This article helps troubleshoot the Event ID 50 error message.

## Symptoms

When Windows writes information to the physical disk, it might log the following two event messages in the System event log:

> Event ID: 50  
Event Type: Warning  
Event Source: Ftdisk  
Description: {Lost Delayed-Write Data} The system was attempting to transfer file data from buffers to \Device\HarddiskVolume4. The write operation failed, and only some of the data may have been written to the file.  
Data:  
0000: 00 00 04 00 02 00 56 00  
0008: 00 00 00 00 32 00 04 80  
0010: 00 00 00 00 00 00 00 00  
0018: 00 00 00 00 00 00 00 00  
0020: 00 00 00 00 00 00 00 00  
0028: 11 00 00 80  

> Event ID: 26  
Event Type: Information  
Event Source: Application Popup  
Description: Windows - Delayed Write Failed : Windows was unable to save all the data for the file \Device\HarddiskVolume4\Program Files\Microsoft SQL Server\MSSQL$INSTANCETWO\LOG\ERRORLOG. The data has been lost. This error may be caused by a failure of your computer hardware or network connection.  
>  
> Please try to save this file elsewhere.  

These event ID messages mean exactly the same thing and are generated for the same reasons. This article focuses on event ID 50.

> [!NOTE]  
> The device and path in the description and the specific hexadecimal data in these messages vary depending on the exact circumstances that caused the event.

## More information

There are several different sources for an event ID 50 message. For example, an event ID 50 message logged from a MRxSmb source occurs if there's a network connectivity problem that involves the redirector. This article addresses event ID 50 messages that refer to disk write problems. Review the event ID 50 message to confirm that it refers to a disk write problem and that this article applies.

In this context, Windows logs an event ID 50 message if a generic error occurs when Windows tries to write information from the file system Cache Manager (not the hardware-level cache) to the physical disk. This write behavior, known as write-back or delayed-write caching, is part of the memory management function of Windows. Write-back caching improves system performance. However, failures in the delayed-write operations might cause losses of data or volume integrity.

Typically, when an application sends a write request to Windows, Cache Manager caches the write request and reports to the application that the write was successful. Later, Cache Manager writes the data to the physical disk and then clears the cache. If an error occurs during the write operation, the data is lost when Cache Manager clears the cache.

Applications or processes that write non-critical data, such as logging processes, use Cache Manager to improve overall performance. Applications that write critical data, such as SQL Server, do not use Cache Manager. Such applications set a `FILE_FLAG_NO_BUFFERING` flag to guarantee that the transaction is completed directly to disk. Direct-to-disk writes never generate event ID 50 messages.

An event ID 50 message is similar to an event ID 9 or an event ID 11 message. Although the error isn't as serious as the error indicated by the event ID 9 or event ID 11 message, you can use the same troubleshooting techniques for an event ID 50 message as you do for an event ID 9 and an event ID 11 message. However, remember that anything in the stack can cause lost-delay writes, such as filter drivers and mini-port drivers.

### Decoding the example event

The [Symptoms](#symptoms) section of this article provides the following example of an event ID 50 message.

> Event ID: 50  
Event Type: Warning  
Event Source: Ftdisk  
Description: {Lost Delayed-Write Data} The system was attempting to transfer file data from buffers to \Device\HarddiskVolume4. The write operation failed, and only some of the data may have been written to the file.  
Data:  
0000: 00 00 04 00 02 00 56 00  
0008: 00 00 00 00 32 00 04 80  
0010: 00 00 00 00 00 00 00 00  
0018: 00 00 00 00 00 00 00 00  
0020: 00 00 00 00 00 00 00 00  
0028: 11 00 00 80  

#### How to identify the target disk

You can identify the disk that the write was being tried to by using the symbolic link that is listed to the drive in the "Description" section of the event ID message, for example: *\\Device\\HarddiskVolume4*.

#### How to decode the data section

Event ID 50 messages (as well as event ID 9, 11, 51 or similar "DISK" messages) include binary data that you can use to help identify the problem. The message includes the following data section:

> Data:  
0000: 00 00 04 00 02 00 56 00  
0008: 00 00 00 00 32 00 04 80  
0010: 00 00 00 00 00 00 00 00  
0018: 00 00 00 00 00 00 00 00  
0020: 00 00 00 00 00 00 00 00  
0028: 11 00 00 80  

> [!NOTE]  
> When you are converting the hexadecimal data in the event ID message to the status code, remember that the values are represented in the little-endian format.

The following table describes what each offset of this message represents:

|OffsetLengthValues|Length|Values|
|-----------|------------|---------|
|0x00|2|Not Used|
|0x02|2|Dump Data Size = 0x0004|
|0x04|2|Number of Strings = 0x0002|
|0x06|2|Offset to the strings|
|0x08|2|Event Category|
|0x0c|4|NTSTATUS Error Code|
|0x10|8|Not Used|
|0x18|8|Not Used|
|0x20|8|Not Used|
|0x28|4|NT Status error code|

**The NT Status error code**

The final status code is the most important piece of information in an event ID 50 message. This is the error code that's' returned when the write request was made, and it's the key source of information. In the example, the final status code is listed at 0x28, the sixth line of the data set. In starts with "0028:" and includes the four octets in this line:

> 0028: 11 00 00 80

When you are converting the hexadecimal data in the event ID 50 message to the status code, remember that the values are represented in the little-endian format. Because the status code is the only piece of information that you are interested in, it may be easier to view the data in WORDS format instead of BYTES. If you do so, the bytes will be in the correct format and the data may be easier to interpret quickly.

To change your view of the data, select **Words** in the **Event Properties** window. In the **Data Words** view, the data section of the example reads as follows:

```output
() Bytes (.) 
Words 0000: 00040000 00560002 00000000 80040032 0010: 00000000 00000000 00000000 00000000 0020: 00000000 00000000 80000011
```

In this case, the final status code is 0x80000011. This status code maps to `STATUS_DEVICE_BUSY` and implies that the device is currently busy. This was the reason that the write operation failed.

For more information about NT status codes, see [Using NTSTATUS Values](/windows-hardware/drivers/kernel/using-ntstatus-values). The list of codes is also available in the Windows Software Developers Kit (SDK), in the *NTSTATUS.H* file.

**The event category code**

In the example, the event category code (the code that's associated with event ID 50) is listed in the second line. This line starts with "0008:" and it includes the last 4 bytes of the following line:  

> 0008: 00 00 00 00 32 00 04 80  

In this case, the error code is 0x80040032, which corresponds to `IO_LOST_DELAYED_WRITE`. This information appears in the event description as "Lost Delayed-Write Data."
