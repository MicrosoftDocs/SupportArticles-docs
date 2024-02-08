---
title: NMI_HARDWARE_FAILURE error
description: This article discusses a by-design behavior where NMI_HARDWARE_FAILURE error occurs when an NMI is triggered.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# NMI_HARDWARE_FAILURE error when an NMI is triggered on Windows

This article discusses a by-design behavior where the NMI_HARDWARE_FAILURE error occurs when a Non-Maskable Interrupt (NMI) is triggered.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2750146

## Symptoms

On a Windows computer, an NMI may be triggered by a user manually pressing an NMI switch on the computer, or because of a hardware error.

In this event, Windows stops executing and displays a bluescreen, stating "Your PC ran into a problem and needs to restart." It includes the following error code: NMI_HARDWARE_FAILURE.

The computer may then save a memory dump file, and may automatically reboot, depending on the settings specified under "Startup and Recovery" in the "Advanced system settings" under the System control panel.

## Cause

The behavior when an NMI is encountered has changed compared to earlier versions of Windows. In Windows 7, Windows Server 2008 R2, and earlier versions, the response when the system encountered an NMI was dependent on the configuration of the "NMICrashDump" registry value.
For more information about the NMICrashDump registry value and handling of NMIs in earlier Windows versions, click the following article number to view the article in the Microsoft Knowledge Base:  
[927069](https://support.microsoft.com/kb/927069)  How to generate a complete crash dump file or a kernel crash dump file by using an NMI on a Windows-based system

In Windows 8 and Windows Server 2012, this behavior is not configurable. An NMI will always result in a bugcheck 0x80 (NMI_HARDWARE_FAILURE). This is equivalent to the behavior on earlier Windows versions where the "NMICrashDump" registry value was present and set to a value of 1.

## More information

This behavior is by design.
