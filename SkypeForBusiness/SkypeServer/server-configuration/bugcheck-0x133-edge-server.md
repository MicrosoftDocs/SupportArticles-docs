---
title: Bug Check 0x133 DPC_WATCHDOG_VIOLATION error on Skype for Business Edge server
description: Describes Bug Check 0x133 DPC_WATCHDOG_VIOLATION error.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
  - Skype for Business Server 2015
  - Windows Server 2012 R2 Standard
ms.date: 03/31/2022
---

# Bug Check 0x133 DPC_WATCHDOG_VIOLATION error on Lync/Skype for Business Edge server

## Symptoms

When a Microsoft Lync or Skype for Business (any version) Edge server is running on modern hardware with multiple processor groups enabled, the computer crashes with the following Bug Check 0x133 DPC_WATCHDOG_VIOLATION error:

```AsciiDoc
Time:     6/24/2016 6:28:09 AM 
ID:       1001
Level:    Error
Source: Microsoft-Windows-WER-SystemErrorReporting
Machine:  USIDMLLYC203

Message: The computer has rebooted from a bugcheck. The bugcheck was: 0x00000133 (0x0000000000000000, 0x0000000000000501, 0x0000000000000500, 0x0000000000000000). A dump was saved in: C:\Windows\MEMORY.DMP. Report Id: 062416-18468-01.
```

## Cause

This issue occurs because low-level Edge server code is specifically designed to work with hardware that's configured for only a single processor group. This low-level code resides in the Media Relay driver component on Edge servers. 

## Resolution

To avoid this issue, disable the "processor groups" feature in the Edge server's BIOS.

## More Information

For more information about this error, see [Bug Check 0x133 DPC_WATCHDOG_VIOLATION](/windows-hardware/drivers/debugger/bug-check-0x133-dpc-watchdog-violation). 

To disable multiple processor groups, go to the "Numa Configuration" section in the BIOS. By default, Numa Configuration is set to **Clustered** on some modern systems, which creates multiple processor groups. Set this option to **flat**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).