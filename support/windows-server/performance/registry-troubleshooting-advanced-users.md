---
title: Registry troubleshooting for advanced users
description: Describes how to troubleshoot registry corruption issues.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
ms.technology: windows-server-performance
---
# Registry troubleshooting steps for advanced users

This article describes how to troubleshoot registry corruption issues.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 822705

## Summary

If your computer does not restart, the registry hives may be corrupted. The error messages may vary. They can include any of the following:  

> Windows could not start because the following file is missing or corrupt:\WINNT\SYSTEM32\CONFIG\SYSTEM.ced  

> Windows could not start because the following file is missing or corrupt:\WINNT\SYSTEM32\CONFIG\SYSTEM  

> Windows could not start because the following file is missing or corrupt:\WINNT\SYSTEM32\CONFIG\SOFTWARE  

> System hive error  

> Stop 0xc0000218 (0xe11a30e8, 0x00000000, 0x000000000, 0x00000000)   UNKNOWN_HARD_ERROR  

> Stop: 0xc0000218 {Registry File Failure} The registry cannot load the hive (file):  
\SystemRoot\System32\Config\ **CorruptHive** or its log or alternate. It is corrupt, absent, or not writable.

## More information

There are many reasons why a registry hive may be corrupted. Most likely, the corruption is introduced when the computer is shut down, and you cannot track the cause because the computer is unloading processes and drivers during shutdown. Sometimes, it is difficult to find the cause of registry corruption. The following sections describe three possible causes of the problem and provide steps to troubleshoot the problem.

### Power Failure

A power failure or some other unexpected shutdown event may cause a corrupted registry hive. To determine whether this is the cause of the issue, look for event ID 6008 entries. Event ID 6008 entries indicate that there was an unexpected shutdown. In this case, some process may have been modifying part of the registry hive, and the computer lost power before that change could be completed. This leaves the registry hive in an inconsistent state. On restart, when the operating system tries to load the registry hive, it may find data in that registry hive that it cannot interpret, and you may receive one of the error messages that is included in the "Summary" section.

### File Corruption and Faulty Hardware

Other files may be corrupted. You must determine whether only the registry hives are corrupted or whether other files (system and data) are corrupted. If corruption is not limited to registry hives, the corruption may cause by faulty hardware. This hardware may include anything that is involved in writing to a disk, such as the following:

- The random access memory (RAM)
- The cache
- The processor
- The disk controller

If you suspect faulty hardware, the hardware vendor must thoroughly investigate the condition of all computer components.

### The Registry Is Written to at Shutdown

If one or two registries hives consistently become corrupted for no reason, the problem probably occurs at shutdown and is not discovered until you try to load the registry hive at the next restart. In this scenario, the registry hive is written to disk when you shut down the computer, and this process may stop the computer or a component in the computer before the writing is completed.

### Troubleshoot

To troubleshoot this issue, follow these steps.

1. Restore the computer to a previous state before registry corruption occurred.  
    One tool that you can use to back up registry hives is Recovery Console. For more information about how to back up and restore the registry, click the following article numbers to view the articles in the Microsoft Knowledge Base:

    [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows XP and Windows Vista  

    [307654](https://support.microsoft.com/help/307654) How to install and use the Recovery Console in Windows XP  

2. Check the hardware, the disk, the firmware drivers, and the BIOS. To do this, follow these steps. These steps may require downtime for the computer.
   1. Make sure that the CPU is not being over-clocked.
   2. Make sure that system event logs do not contain event ID 9, event ID 11, or event ID 15 (or any combination of these events). These events may indicate hardware problems that must be addressed.
   3. Run the `chkdsk` command-line command together with the /r switch on the disk that contains the registry hive files. This command helps verify that the area of the disk that contains the registry hive files is not involved in the problem.
   4. Apply the latest firmware revisions to disk controllers, and use the matching driver versions. Make sure that the drivers are signed drivers and that you have the appropriate firmware revisions installed.
   5. Make sure that you apply the latest basic input/output system (BIOS) updates to the computer.
3. After you complete step 2, you may not see any change in behavior. To prevent the corruption, try to close all running processes before you shut down the computer. You may be able to narrow the scope to a single process that is involved. Even if you determine the process, you may be unable to prevent a component from being unloaded before the registry hive is written to. However, if you make sure that you stop the process before shut down, you may be able to prevent registry hive corruption.
4. After you complete step 3, if you do not see any change in behavior, compare the registry hives. Capture a non-corrupted registry hive and a corrupted registry hive and then compare the two by using comparison tools such as Windiff.exe.
5. Determine which registry hive section is growing. If it seems that the problem in the registry hive is growing too large, you may be able to determine which section is growing and to trace this back to a process that is writing to the hive.
