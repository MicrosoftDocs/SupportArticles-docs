---
title: Information about Event ID 51
description: This article describes the information about Event ID 51 that occurs when you write information to the physical disk.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:storage-hardware, csstroubleshoot
---
# Information about Event ID 51

  Event ID 51 may occur when you write information to the physical disk. This article describes how to decode the data section of an Event ID 51 event message.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 244780

## Summary

When you write information to the physical disk, the following event message may be logged in the System log:

```output
Event ID: 51  
Event Type: Warning  
Event Source: Disk  
Description: An error was detected on device \Device\Harddisk3\DR3 during a paging operation.  
Data:  
0000: 04 00 22 00 01 00 72 00  
0008: 00 00 00 00 33 00 04 80  
0010: 2d 01 00 00 00 00 00 00  
0018: 00 00 00 00 00 00 00 00  
0020: 00 52 ea 04 15 00 00 00  
0028: 01 00 00 00 04 00 00 00  
0030: 03 00 00 00 2a 00 00 00  
0038: 02 84 00 00 00 29 06 00  
0040: 2a 60 0a 82 75 29 00 00  
0048: 80 00
```

> [!NOTE]
> The device in the description and the specific hexadecimal data may vary.

## More information

If a generic error occurs when your computer pages information to or from the disk, an Event ID 51 event message is logged. In a paging operation, the operating system either swaps a page of memory from memory to disk, or retrieves a page of memory from disk to memory. It's part of the memory management of Windows.

However, the computer may log this event message when it loads images from a storage device, reads, and writes to locally mapped files or to any file (as long as it's buffered I/O). The computer doesn't log this event message when it performs nonbuffered I/O. You can troubleshoot an Event ID 51 event message exactly like you troubleshoot Event ID 9 or Event ID 11 event messages.

Under certain circumstances, the system logs the following Event ID 51 event message:

```output
An error was detected on device \Device\DeviceName during a paging operation
```

In this case, no harmful effects are experienced. For example, Event ID 51 is logged when blank media such as CDR, CDRW, DVDR, is inserted into a writable drive while a USB device is plugged in. The system logs the event even though the disc is writable, and the USB device is still usable. In these particular cases, you can safely ignore the log entries. No action is required.

> [!NOTE]
> On Windows XP and Windows Server 2003, the DeviceName may be truncated because of the size limitation of the event log entry. As a result, the displayed hard disk number, or the device object name itself may be incorrect. Because a large amount of information is stored in the data section, the space that's available for the DeviceName is reduced. In this case, you can find the appropriate device by looking at the destination disk data that's stored in the data section. For more information, see [Decode the data section of an Event ID 51 event message](#decode-the-data-section-of-an-event-id-51-event-message).

On Windows Vista and later versions, the event log entry size has been increased, and DeviceName isn't truncated.

You can use the binary data associated with any DISK error (Event ID 7, 9, 11, 51, and other Event IDs) to help you identify the problem by decoding the data section.

An Event ID 51 has an extra Command Descriptor Block (CDB) box. Consider the following information when you review the data section of an Event ID 51 event message.

## Decode the data section of an Event ID 51 event message

When you decode the data section of the example in the [Summary](#summary) section, you can see that an attempt to perform a write operation to LUN 3 starting at sector 0x2975820a for 0x0080 sectors fails because the bus was reset but the request will be retried. Later, this article lists the specific steps to decode this example.

The following tables describe what each offset represents:

|Offset|Length|Values|
|---|---|---|
|0x00|1|Type of operation: 0x03 = Read, 0x04 = Write, 0x0F = IOCTL|
|0x01|1|Number of retries remaining|
|0x02|2|Dump Data Size 0x0068|
|0x04|2|Number of Strings 0x0001|
|0x06|2|Offset to the device name|
|0x08|2|Unused|
|0x0a|2|Padding bytes|
|0x0c|4|NTSTATUS Error Code|
|0x10|4|Unique Error Value|
|0x14|4|NTSTATUS Final Status 0x00000000 = the request will be retried|
|0x18|4|Sequence Number - Unused|
|0x1c|4|Io Control Code (doesn't apply to this event)|
|0x20|8|Byte offset to bad sector, if any|
|0x28|8|Tick count when the error occurred|
|0x30|4|Port number - Unused|
|0x34|1|Error Flags|
|0x35|3|Unused|
|0x38|88|SCSI request block structure|
|0x90|18|Sense data structure|
  
## Key sections to decode

Here are key sections to decode.

### The error code

In the example that is in the [Summary](#summary) section, the error code is listed in the second line. That line starts with **0008:** and includes the last 4 bytes in the line.

> 0008: 00 00 00 00 33 00 04 80

ErrorCode = 0x80040033

This code is the code for error 51. This code is the same for all Event ID 51 event messages:

> IO_WARNING_PAGING_FAILURE

> [!NOTE]
> When you interpret the hexadecimal data in the Event ID to the status code, remember that the values are represented in the little endian format.

### The final status code

In the example in the [Summary](#summary) section, the final status code is listed at **0x14** (in the third line) that starts with **0010:** and includes the last four octets in this line.

> 0010: 2d 01 00 00 00 00 00 00

FinalStatus = 0x00000000

It maps to `STATUS_SUCCESS` and implies that the request will be retried.

> [!NOTE]
> When you interpret the hexadecimal data in the Event ID to the status code, remember that the values are represented in the little endian format.

### The destination disk

You can use this data to help determine on what disk the problem occurred:

> 0028: 01 00 00 00 04 00 00 00

Path ID = 0x0000001, Target ID = 0x0000004

> 0030: 03 00 00 00 2a 00 00 00

LUN = 0x0000003

It may be easier to identify the volume by using the symbolic link listed to the drive in the description of the Event ID. For example, `\Device\Harddisk3\DR3`.

> [!NOTE]
> The destination disk information is how it appears to the operating system. Storage virtualization and multipath I/O software may mask what is presented to the operating system. This information may not directly correspond to the physical mappings.

### The SCSI Request Block (SRB) parameters

In the example in the [Summary](#summary) section, the ScsiStatus is **0x02** (first byte in line **0038**), and SrbStatus is **0x84** (second byte in line **0038**). It provides the following information:

> 0038: 02 84 00 00 00 29 06 00

ScsiStatus of 0x02:  
`SCSISTAT_CHECK_CONDITION`

SCSI status codes: (from SCSI.H)

```cpp
0x00 = SCSISTAT_GOOD
0x02 = SCSISTAT_CHECK_CONDITION
0x04 = SCSISTAT_CONDITION_MET
0x08 = SCSISTAT_BUSY
0x10 = SCSISTAT_INTERMEDIATE
0x14 = SCSISTAT_INTERMEDIATE_COND_MET
0x18 = SCSISTAT_RESERVATION_CONFLICT
0x22 = SCSISTAT_COMMAND_TERMINATED
0x28 = SCSISTAT_QUEUE_FULL
```

SrbStatus of 0x84:  
`SRB_STATUS_AUTOSENSE_VALID | SRB_STATUS_ERROR`

```cpp
0x00 = SRB_STATUS_PENDING
0x01 = SRB_STATUS_SUCCESS
0x02 = SRB_STATUS_ABORTED
0x03 = SRB_STATUS_ABORT_FAILED
0x04 = SRB_STATUS_ERROR
0x05 = SRB_STATUS_BUSY
0x06 = SRB_STATUS_INVALID_REQUEST
0x07 = SRB_STATUS_INVALID_PATH_ID
0x08 = SRB_STATUS_NO_DEVICE
0x09 = SRB_STATUS_TIMEOUT
0x0A = SRB_STATUS_SELECTION_TIMEOUT
0x0B = SRB_STATUS_COMMAND_TIMEOUT
0x0D = SRB_STATUS_MESSAGE_REJECTED
0x0E = SRB_STATUS_BUS_RESET
0x0F = SRB_STATUS_PARITY_ERROR
0x10 = SRB_STATUS_REQUEST_SENSE_FAILED
0x11 = SRB_STATUS_NO_HBA
0x12 = SRB_STATUS_DATA_OVERRUN
0x13 = SRB_STATUS_UNEXPECTED_BUS_FREE
0x14 = SRB_STATUS_PHASE_SEQUENCE_FAILURE
0x15 = SRB_STATUS_BAD_SRB_BLOCK_LENGTH
0x16 = SRB_STATUS_REQUEST_FLUSHED
0x20 = SRB_STATUS_INVALID_LUN
0x21 = SRB_STATUS_INVALID_TARGET_ID
0x22 = SRB_STATUS_BAD_FUNCTION
0x23 = SRB_STATUS_ERROR_RECOVERY
0x24 = SRB_STATUS_NOT_POWERED
0x30 = SRB_STATUS_INTERNAL_ERROR
(used by the port driver to indicate that a non-scsi-related error occurred)
0x38 - 0x3f = Srb status values reserved for internal port driver use.
```

SRB status masks:

```cpp
0x80 = SRB_STATUS_AUTOSENSE_VALID
0x40 = SRB_STATUS_QUEUE_FROZEN
```

You must break down SRB status masks because they are a substatus. They are combined with the SRB status codes.

In the earlier **0x84** example, **0x8_** is a status mask. Therefore, `SRB_STATUS_AUTOSENSE_VALID` and **0x04** is the SRB status code. It means `SRB_STATUS_ERROR`.

### The sense code

If the SRB status is that the autosense is valid, the sense codes provide more information. In the example in the [Summary](#summary) section, the sense code is **0x06** (seventh byte in line **0038**), and the additional sense code is **0x29** (sixth octet in line **0038**). It provides the following information:

> 0038: 02 84 00 00 00 29 06 00

The sense key of **0x06**:

The byte at offset 003e is the sense key. It maps to:

```cpp
0x06 = SCSI_SENSE_UNIT_ATTENTION
```

Sense codes: (from SCSI.H)

```cpp
0x00 = SCSI_SENSE_NO_SENSE
0x01 = SCSI_SENSE_RECOVERED_ERROR
0x02 = SCSI_SENSE_NOT_READY
0x03 = SCSI_SENSE_MEDIUM_ERROR
0x04 = SCSI_SENSE_HARDWARE_ERROR
0x05 = SCSI_SENSE_ILLEGAL_REQUEST
0x06 = SCSI_SENSE_UNIT_ATTENTION
0x07 = SCSI_SENSE_DATA_PROTECT
0x08 = SCSI_SENSE_BLANK_CHECK
0x09 = SCSI_SENSE_UNIQUE
0x0A = SCSI_SENSE_COPY_ABORTED
0x0B = SCSI_SENSE_ABORTED_COMMAND
0x0C = SCSI_SENSE_EQUAL
0x0D = SCSI_SENSE_VOL_OVERFLOW
0x0E = SCSI_SENSE_MISCOMPARE
0x0F = SCSI_SENSE_RESERVED
```

Additional sense code (ASC) of 0x29:

The ASC is located in the sixth byte in line 0038 at offset 003d, and has a value of 29. For the specified sense key, it maps to:

```cpp
0x29 = SCSI_ADSENSE_BUS_RESET
```

Additional sense codes: (from SCSI.H)

```cpp
0x00 = SCSI_ADSENSE_NO_SENSE
0x02 = SCSI_ADSENSE_NO_SEEK_COMPLETE
0x04 = SCSI_ADSENSE_LUN_NOT_READY
0x0C = SCSI_ADSENSE_WRITE_ERROR
0x14 = SCSI_ADSENSE_TRACK_ERROR
0x15 = SCSI_ADSENSE_SEEK_ERROR
0x17 = SCSI_ADSENSE_REC_DATA_NOECC
0x18 = SCSI_ADSENSE_REC_DATA_ECC
0x20 = SCSI_ADSENSE_ILLEGAL_COMMAND
0x21 = SCSI_ADSENSE_ILLEGAL_BLOCK
0x24 = SCSI_ADSENSE_INVALID_CDB
0x25 = SCSI_ADSENSE_INVALID_LUN
0x27 = SCSI_ADSENSE_WRITE_PROTECT
0x28 = SCSI_ADSENSE_MEDIUM_CHANGED
0x29 = SCSI_ADSENSE_BUS_RESET
0x2E = SCSI_ADSENSE_INSUFFICIENT_TIME_FOR_OPERATION
0x30 = SCSI_ADSENSE_INVALID_MEDIA
0x3a = SCSI_ADSENSE_NO_MEDIA_IN_DEVICE
0x3b = SCSI_ADSENSE_POSITION_ERROR
0x5a = SCSI_ADSENSE_OPERATOR_REQUEST
0x5d = SCSI_ADSENSE_FAILURE_PREDICTION_THRESHOLD_EXCEEDED
0x64 = SCSI_ADSENSE_ILLEGAL_MODE_FOR_THIS_TRACK
0x6f = SCSI_ADSENSE_COPY_PROTECTION_FAILURE
0x73 = SCSI_ADSENSE_POWER_CALIBRATION_ERROR
0x80 = SCSI_ADSENSE_VENDOR_UNIQUE
0xA0 = SCSI_ADSENSE_MUSIC_AREA
0xA1 = SCSI_ADSENSE_DATA_AREA
0xA7 = SCSI_ADSENSE_VOLUME_OVERFLOW
```

Additional sense code qualifier (ASCQ) of 0x00:

The ASCQ is located in the fifth byte in line **0038** at offset 003C, and has a value of **00**. It's **00** in this example, so it doesn't apply for the specified ASC. This list of ASCQ for each sense code is too large to include in this article. View SCSI.H in the DDK for more information.

> [!NOTE]
> All ASC and ASCQ values above **0x80** are vendor specific and are not documented in the SCSI specification or Microsoft DDK. Refer to the hardware vendor.

### The Command Descriptor Block (CDB) parameters

The CDB starts at the line with an offset of **0040**:

> 0040: 2a 60 0a 82 75 29 00 00  
> 0048: 80 00

The bytes at offset 0x40 represent the CDB code. The bytes from offset 0x43 to 0x46 represent the starting sector, and offset 0x47 to 0x49 represent the number of sectors involved in the operation.

> [!NOTE]
> The CDB data section isn't in the little-endian format. So the bytes shouldn't be flipped. Be careful when you decode this section, because the format is different from earlier sections.

```cpp
0x2a = Write request
0x0a827529 = The starting sector
0x0080 = The number of sectors
```

SCSI CDB codes: (from SCSI.H)

```cpp
0x00 = SCSIOP_TEST_UNIT_READY
0x01 = SCSIOP_REZERO_UNIT
0x01 = SCSIOP_REWIND
0x02 = SCSIOP_REQUEST_BLOCK_ADDR
0x03 = SCSIOP_REQUEST_SENSE
0x04 = SCSIOP_FORMAT_UNIT
0x05 = SCSIOP_READ_BLOCK_LIMITS
0x07 = SCSIOP_REASSIGN_BLOCKS
0x07 = SCSIOP_INIT_ELEMENT_STATUS
0x08 = SCSIOP_READ6
0x08 = SCSIOP_RECEIVE
0x0A = SCSIOP_WRITE6
0x0A = SCSIOP_PRINT
0x0A = SCSIOP_SEND
0x0B = SCSIOP_SEEK6
0x0B = SCSIOP_TRACK_SELECT
0x0B = SCSIOP_SLEW_PRINT
0x0C = SCSIOP_SEEK_BLOCK
0x0D = SCSIOP_PARTITION
0x0F = SCSIOP_READ_REVERSE
0x10 = SCSIOP_WRITE_FILEMARKS
0x10 = SCSIOP_FLUSH_BUFFER
0x11 = SCSIOP_SPACE
0x12 = SCSIOP_INQUIRY
0x13 = SCSIOP_VERIFY6
0x14 = SCSIOP_RECOVER_BUF_DATA
0x15 = SCSIOP_MODE_SELECT
0x16 = SCSIOP_RESERVE_UNIT
0x17 = SCSIOP_RELEASE_UNIT
0x18 = SCSIOP_COPY
0x19 = SCSIOP_ERASE
0x1A = SCSIOP_MODE_SENSE
0x1B = SCSIOP_START_STOP_UNIT
0x1B = SCSIOP_STOP_PRINT
0x1B = SCSIOP_LOAD_UNLOAD
0x1C = SCSIOP_RECEIVE_DIAGNOSTIC
0x1D = SCSIOP_SEND_DIAGNOSTIC
0x1E = SCSIOP_MEDIUM_REMOVAL
0x23 = SCSIOP_READ_FORMATTED_CAPACITY
0x25 = SCSIOP_READ_CAPACITY
0x28 = SCSIOP_READ
0x2A = SCSIOP_WRITE
0x2B = SCSIOP_SEEK
0x2B = SCSIOP_LOCATE
0x2B = SCSIOP_POSITION_TO_ELEMENT
0x2E = SCSIOP_WRITE_VERIFY
0x2F = SCSIOP_VERIFY
0x30 = SCSIOP_SEARCH_DATA_HIGH
0x31 = SCSIOP_SEARCH_DATA_EQUAL
0x32 = SCSIOP_SEARCH_DATA_LOW
0x33 = SCSIOP_SET_LIMITS
0x34 = SCSIOP_READ_POSITION
0x35 = SCSIOP_SYNCHRONIZE_CACHE
0x39 = SCSIOP_COMPARE
0x3A = SCSIOP_COPY_COMPARE
0x3B = SCSIOP_WRITE_DATA_BUFF
0x3C = SCSIOP_READ_DATA_BUFF
0x40 = SCSIOP_CHANGE_DEFINITION
0x42 = SCSIOP_READ_SUB_CHANNEL
0x43 = SCSIOP_READ_TOC
0x44 = SCSIOP_READ_HEADER
0x45 = SCSIOP_PLAY_AUDIO
0x46 = SCSIOP_GET_CONFIGURATION
0x47 = SCSIOP_PLAY_AUDIO_MSF
0x48 = SCSIOP_PLAY_TRACK_INDEX
0x49 = SCSIOP_PLAY_TRACK_RELATIVE
0x4A = SCSIOP_GET_EVENT_STATUS
0x4B = SCSIOP_PAUSE_RESUME
0x4C = SCSIOP_LOG_SELECT
0x4D = SCSIOP_LOG_SENSE
0x4E = SCSIOP_STOP_PLAY_SCAN
0x51 = SCSIOP_READ_DISK_INFORMATION
0x52 = SCSIOP_READ_TRACK_INFORMATION
0x53 = SCSIOP_RESERVE_TRACK_RZONE
0x54 = SCSIOP_SEND_OPC_INFORMATION
0x55 = SCSIOP_MODE_SELECT10
0x5A = SCSIOP_MODE_SENSE10
0x5B = SCSIOP_CLOSE_TRACK_SESSION
0x5C = SCSIOP_READ_BUFFER_CAPACITY
0x5D = SCSIOP_SEND_CUE_SHEET
0x5E = SCSIOP_PERSISTENT_RESERVE_IN
0x5F = SCSIOP_PERSISTENT_RESERVE_OUT
0xA0 = SCSIOP_REPORT_LUNS
0xA1 = SCSIOP_BLANK
0xA3 = SCSIOP_SEND_KEY
0xA4 = SCSIOP_REPORT_KEY
0xA5 = SCSIOP_MOVE_MEDIUM
0xA6 = SCSIOP_LOAD_UNLOAD_SLOT
0xA6 = SCSIOP_EXCHANGE_MEDIUM
0xA7 = SCSIOP_SET_READ_AHEAD
0xAD = SCSIOP_READ_DVD_STRUCTURE
0xB5 = SCSIOP_REQUEST_VOL_ELEMENT
0xB6 = SCSIOP_SEND_VOLUME_TAG
0xB8 = SCSIOP_READ_ELEMENT_STATUS
0xB9 = SCSIOP_READ_CD_MSF
0xBA = SCSIOP_SCAN_CD
0xBB = SCSIOP_SET_CD_SPEED
0xBC = SCSIOP_PLAY_CD
0xBD = SCSIOP_MECHANISM_STATUS
0xBE = SCSIOP_READ_CD
0xBF = SCSIOP_SEND_DVD_STRUCTURE
0xE7 = SCSIOP_INIT_ELEMENT_RANGE
```
