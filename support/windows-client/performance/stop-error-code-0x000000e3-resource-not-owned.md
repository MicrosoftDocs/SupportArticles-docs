---
title: 
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# "Stop error code 0x000000E3 (RESOURCE_NOT_OWNED)" error message

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 281317

## Symptoms

You may receive the following error message on a blue screen when the NTFS file system is stressed:

Stop 0x000000e3 (0x81d534c8, 0x8210fc20, 0x00000000, 0x00000002)
RESOURCE_NOT_OWNED
> [!NOTE]
> : The four parameters may differ significantly from the parameters in this error message, but the stop code is 0xE3.

## Cause

This problem can occur because there is a timing problem with the Ntfs.sys file, which may cause a resource to be released even though you did not acquire it.

## Resolution

To resolve this problem, obtain the latest service pack for Windows 2000. For additional information, click the following article number to view the article in the Microsoft Knowledge Base:
 [260910](/EN-US/help/260910) How to Obtain the Latest Windows 2000 Service Pack  

The English-language version of this fix should have the following file attributes or later:

```

Date Time Version Size File name Platform
 ---------------------------------------------------------------
 12/14/2000 04:39p 5.0.2195.2800 512,240 Ntfs.sys Intel

```  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows 2000 Service Pack 2.
