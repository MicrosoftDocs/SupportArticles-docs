---
title: You receive an error message after you put the page file on another drive other than the drive C in a guest operating system
description: Describes a problem in which you receive an error message after you move the page file to another drive other than drive C in a guest operating system.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, danma
ms.custom:
- sap:virtualization and hyper-v\storage configuration
- pcy:WinComm Storage High Avail
---
# You receive an error message after you put the page file on another drive other than the drive C in a guest operating system

This article helps to fix an error occurs after you move the page file to another drive other than drive C in a guest operating system.

_Original KB number:_ &nbsp; 979386

## Symptoms

You encounter problems when you put the paging file on another drive other than the drive C in a guest operating system on a computer that is running Windows Server 2008 R2. When you restart the guest operating system, you receive the following error message:  
>Windows created a temporary paging file on your computer because of a problem that occurred with your paging file configuration when you started your computer. The total paging file size for all disk drives may be somewhat larger than the size you specified.

## Cause

This problem occurs if you have two virtual hard disk (VHD) drives for a virtual machine and the second disk is connected by using a virtual SCSI controller.

The SCSI controller is a virtual SCSI controller. Therefore, it is not loaded when you try to create the page file.

## Resolution

To resolve this problem, configure the paging file to be saved on the VHD that is connected by using a virtual IDE controller.
