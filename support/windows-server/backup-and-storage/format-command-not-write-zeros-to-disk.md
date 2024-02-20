---
title: Change in the behavior of the format command in Windows Vista and later versions
description: Discusses a change in the behavior of the format command in Windows Vista and later Windows versions.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
---
# Change in the behavior of the format command in Windows Vista and later versions

This article discusses a change in the behavior of the format command in Windows Vista and later Windows versions.

_Applies to:_ &nbsp; Windows Server 2012 R2, Window 10 – all editions  
_Original KB number:_ &nbsp; 941961

## Introduction

The behavior of the format command changed in Windows Vista and later Windows versions. By default in Windows Vista and later versions, the format command writes zeros to the whole disk when a full format is performed. In Windows XP and earlier versions of Windows, the format command doesn't write zeros to the whole disk when a full format is performed.

The new format behavior may cause problems for the on-demand allocation modes that a volume storage provider, such as a Storage Area Network (SAN), supports. Problems may occur because the new format behavior prematurely triggers allocation of the backing space.

In the on-demand scenario, zeros don't have to be written to the whole disk because the volume storage provider initializes the on-demand-allocated data. To avoid causing unnecessary on-demand-allocation, you must use the quick format option.

## Quick format option

You can use four methods to format a volume in Windows Vista and later versions. You can use the quick format option for these four methods:

- Command line: Use the `format /q` command.

- Diskpart: Use the format command together with the *quick*  parameter.  

- Windows Explorer: Click to select the **Perform a quick format** check box.

- Disk Management (Diskmgmt.msc): Click to select the **Perform a quick format** check box.
