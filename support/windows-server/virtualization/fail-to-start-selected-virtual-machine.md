---
title: Fail to start selected virtual machine
description: Provides a solution to an error that occurs while you try to  start the selected virtual machine.
ms.date: 08/26/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Virtual machine will not boot
ms.technology: HyperV
---
# An error occurred while attempting to start the selected virtual machine

This article provides a solution to an error that occurs while you try to  start the selected virtual machine.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2000800

## Symptoms

When trying to set the DVD drive for a Guest Machine running on Hyper-V Server to Physical CD/ DVD Drive, the following error is displayed after Clicking Apply:

> Hyper-V Manager  
An error occurred while attempting to start the selected virtual machine(s).
\<Guest Virtual Machine Name> failed to start.  
Microsoft Emulated IDE Controller (Instance ID
{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}): Failed to power on with Error 'The process cannot access the file because it is being used by another process.'
Failed to open attachment '\<Disk Drive> :'. Error 'The process cannot access the file because it is being used by another process.'
>
> Note: " X" represent an alpha/numeric Value

## Cause

The physical CD/DVD drive has already been mapped to another Guest Machine on the Hyper-V server

## Resolution

To resolve this issue,  we must remove physical CD/DVD Drive from an existing Guest Machine by changing the DVD setting to None or point to an ISO file
To accomplish this task perform the following steps:

1. Locate another Guest machine that is configured to use the Physical CD/DVD.
2. From Hyper-V manager, select settings, Click on the DVD drive option under Hardware
3. In the right-hand pane,  Under the Media option, choose either **NONE** or to an **Image File** as per user needs
Or
Open the Guest Machine  click on **Media** under media select **DVD drive** in the submenu select **Uncapture** \<Drive letter for DVD drive>
