---
title: Run programs on non-Microsoft hardware virtualization software
description: Describes the type of support that Microsoft provides for programs that are run in a virtual environment.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Virtualization and Hyper-V\Installation and configuration of Hyper-V, csstroubleshoot
---
# Support policy for Microsoft software that runs on non-Microsoft hardware virtualization software

This article describes the type of support that Microsoft provides for programs that are run in a virtual environment.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008  
_Original KB number:_ &nbsp; 897615

## Summary

Hardware virtualization software lets you run multiple operating system instances at the same time on a single computer. Microsoft has multiple software offerings that provide this functionality. For a list of products that are currently in life cycle, see [Microsoft Support Lifecycle](/lifecycle/).

Some third-party companies also have software that provides this functionality. This article describes the support that Microsoft provides for its software when you run it with non-Microsoft hardware virtualization software.

## More information

Except as described in this article, Microsoft does not test or support Microsoft software that's run in conjunction with non-Microsoft hardware virtualization software.

For Microsoft customers who have Premier-level support and who run non-Microsoft hardware virtualization software from vendors with which Microsoft does not have an established support relationship that covers virtualization solutions: Microsoft will investigate potential issues with Microsoft software that's run in conjunction with non-Microsoft hardware virtualization software.

As part of the investigation, Microsoft may require the issue to be reproduced by the customer independently from the non-Microsoft hardware virtualization software. This can be done on Windows Server 2012 R2 or later versions of the Windows Server operating system product with the Hyper-V role installed, the actual hardware platform with the Windows operating system installed directly upon it, or on both. Where issues are confirmed to be unrelated to the non-Microsoft hardware virtualization software, Microsoft will support its software in a manner that is consistent with support provided on a server that has passed Microsoft's *Designed for* or *Certified for* testing criteria. For more information about *Designed for* or *Certified for* hardware, see [this website](https://www.windowsservercatalog.com/content.aspx?ctf=logo.htm).

Additionally, for vendors with whom Microsoft has established a support relationship that covers virtualization solutions, or for vendors who have Server Virtualization Validation Program (SVVP) validated solutions, which may also have been awarded an Additional Qualification (AQ) for other functionality, Microsoft will support Windows Server operating systems subject to the Microsoft Support Lifecycle policy for its customers who have support agreements when the operating system runs virtualized on non-Microsoft hardware virtualization software. This support will include coordinating with the vendor to jointly investigate support issues. As part of the investigation, Microsoft may still require the issue to be reproduced independently from the non-Microsoft hardware virtualization software.

Issues related to software-based functionality that are not standard in server hardware, such as memory over-commitment, moving virtual machines from one host system to another, any feature similar to Virtualization Based Security provided by Microsoft Windows, and so on, are not supported by Microsoft under SVVP. The SVVP vendor is responsible for support of such features and functions.

Where issues are confirmed to be unrelated to the non-Microsoft hardware virtualization software, Microsoft will support its software in a manner that is consistent with support provided when that software is not running together with non-Microsoft hardware virtualization software.

## Reference

For more information about the support policy for running Microsoft server software in supported virtualization environments, see [Microsoft server software and supported virtualization environments](microsoft-server-software-support-policy.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

For more information about third-party vendors who will support virtualization software, see [Support partners for non-Microsoft hardware virtualization software](non-microsoft-hardware-virtualization-software.md).
