---
title: Incorrect shutdown reason code
description: Provides a resolution for the issue that an incorrect shutdown reason code written to SEL on user initiated shutdown.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:shutdown-is-slow-or-hangs, csstroubleshoot
---
# An incorrect shutdown reason code written to SEL on user initiated shutdown

This article provides a resolution for the issue that an incorrect shutdown reason code written to SEL on user initiated shutdown.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2001061

## Symptoms

After reboot from a manual shutdown (`START`->`Shutdown`), the Windows System Eventlog shows two events 1074. The first entry contains the correct reason code provided by the user, the second looks similar to:  
>Log Name:      System  
Source:        USER32  
Date:          *\<DateTime>*  
Event ID:      1074  
Task Category: None  
Level:         Information  
Keywords:      Classic  
User:         Computername\Administrator  
Computer:      Computername  
Description:  
The process C:\Windows\system32\winlogon.exe \<computername> has initiated the power off of computer \<computername> on behalf of user \<computername>\Administrator for the following reason: No title for this reason could be found  
**Reason Code: 0x500ff**  
Shutdown Type: power off  
Event 0x000500FF (System Failure) is written to the SEL (System Event Log) even if a different shutdown reason was provided by the user who initiated the shutdown.

## Cause

Microsoft has confirmed that this is a problem.

## Resolution

Microsoft will address the problem in future releases.

## Workaround

Use shutdown.exe to initiate the shutdown, run below command (for example) from the elevated command line:

`shutdown.exe /r /d P:4:2`

This will result in an event log and SEL entry with reason code 0x80040002.  
Shutdown reason codes can be found here: [https://msdn.microsoft.com/library/aa376885(VS.85).aspx](https://msdn.microsoft.com/library/aa376885%28VS.85%29.aspx)  

## More information

The SEL (System Event Log) is the database of events in the [baseboard management controller (BMC)](https://msdn.microsoft.com/library/aa384465%28VS.85%29.aspx#winrm.gloss_baseboard_management_controller) hardware.  
The [SEL adapter](https://msdn.microsoft.com/library/aa384465%28VS.85%29.aspx#winrm.gloss_sel_adapter) conveys these events to the operating system.
