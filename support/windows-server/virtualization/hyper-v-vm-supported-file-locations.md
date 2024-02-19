---
title: Hyper-V VM supported file locations
description: Discusses supported locations for Hyper-V virtual machine files.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, benarm
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Hyper-V virtual machine supported file locations

This article describes supported locations for Hyper-V virtual machine files.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2928127

## Summary

Hyper-V virtual machines are only in a supported configuration when the virtual machine files are stored in a subfolder. It is not a supported configuration to have virtual machine files stored directly in the base (or root) of a drive or file share.

For example:

D:\\ is not a supported location for storing virtual machine files in Hyper-V.

D:\\VMs is a supported location for storing virtual machine files.

\\\\FILESERVER\\SHARE is not a supported location for storing virtual machine files.

\\\\FILESERVER\\Share\\VMname is a supported location for storing virtual machine files.

## More information

Hyper-V requires that it can control the file access permissions on all files that comprise a virtual machine. This is not possible when a virtual machine is stored in the base of a drive or share.
