---
title: Third-party storage solutions support policy
description: Explains the Microsoft third-party storage software solutions support policy that works in conjunction with Microsoft server products.
ms.date: 04/07/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# Overview of the Microsoft third-party storage software solutions support policy

This article outlines the Microsoft third-party storage software solutions support policy that works in conjunction with Microsoft server products.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 841696

## Introduction

If you're using third-party storage solutions that run in conjunction with Microsoft server products such as Microsoft Exchange Server and Microsoft SQL Server, you may find occasions where you require support for the configuration. You can contact Microsoft Product Support Services (PSS) if you require help, although depending on your configuration, PSS may provide support directly, or may instruct you to contact the storage vendor if you require help.

## More information

### The Designed for Windows Logo program, Exchange, and SQL Server

Exchange, SQL Server, and other Microsoft software products that run on Windows do not have separate Hardware Compatibility Tests for qualifying hardware to be used in conjunction with them. They rely on the Designed for Windows Logo program for hardware devices to qualify storage hardware and other hardware components for use with various Windows desktop and server operating systems. A block storage hardware target (such as small computer system interface [SCSI], Fibre Channel, or iSCSI) that receives the Designed for Windows (DFW) logo is qualified to receive support for Exchange, SQL Server, SharePoint Portal Server, and other Microsoft programs that run on Windows.

### Third-party software that is running on Designed for Windows targets

Many storage vendors offer software solutions for backup, replication, mirroring, and snapshots that are for use with their storage products. Some Microsoft customers have used these products. They're frequently well integrated as part of an overall hardware solution. If you run these third-party products on a Windows system that is attached to a storage target device (such as SCSI, Fibre Channel, or iSCSI) that qualifies under the Designed for Windows Logo program, you don't void the basic support for the device. However, if a problem exists with the program or the hardware product directly, you must contact the product manufacturer or vendor for support. If it's appropriate, Microsoft may work in conjunction with the third-party vendor to resolve the issue after you make initial contact with the third-party vendor or manufacturer.

> [!NOTE]
> For third-party software programs that install drivers, this policy applies only if all the included drivers are signed. This includes filter drivers, system drivers, and others.

When you use a third-party program on qualified hardware such as block mode devices, you must contact the third-party software vendor for support for that software product. For example, if you use snapshot management software or backup software that configures the storage hardware directly, you must contact the vendor directly for support with the tool. However, when you these third-party programs on a Windows system that is connected to qualified hardware or that is installed with qualified hardware, your overall configuration is still supported by Microsoft. You can still run these programs without invalidating or otherwise compromising the supportability of your configuration.

> [!NOTE]
> For third-party software programs that install drivers, this policy only applies if all the included drivers are signed. This includes filter drivers, system drivers, and others.

Microsoft won't offer direct support for third-party software that is used on qualified hardware, just as Microsoft doesn't offer direct support for other third-party independent programs that run on Windows. If you call Microsoft for support for third-party software that is used in conjunction with qualified hardware, and PSS determines that there's a problem with the third-party software product, PSS will refer you to the software vendor.

### The role of Volume Shadow Copy Service

Volume Shadow Copy Service (VSS) is an infrastructure where multiple third-party storage management programs, business programs, and hardware providers cooperate in the creation and management of shadow copies.

Because VSS is an API that is licensed and built upon by these third parties, Microsoft makes no warranty or recommendation on the performance or reliability of the third-party solution. Microsoft relies on partners to offer VSS-enabled solutions and to provide support for them. We recommend that customers use VSS-enabled backup products.

When designed and implemented correctly, VSS-enabled products help make sure that synchronization occurs between the server program, the backup program, and the Windows storage subsystem. VSS-enabled products help make sure that pending writes are held while the backup is created. VSS-enabled products help make sure that system state information is accurately captured. This is especially true when backing up Exchange, SQL Server, the Microsoft Cluster Service (MSCS), and the Active Directory directory service.

### Role of the Microsoft Certified for Windows program

The Microsoft Certified for Windows program is a logo program for Windows Server software programs. This is a third-party testing process that is conducted by VeriTest for Windows 2000 Server and Windows Server 2003 logos.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.  
 Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

## References

For additional information about how storage solutions are supported for Microsoft Exchange 5.5, Microsoft Exchange Server 2003, Microsoft SQL Server 7.0, and Microsoft SQL Server 2000, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[833770](https://support.microsoft.com/help/833770) Support for SQL Server 2000 on iSCSI technology components  

[304261](https://support.microsoft.com/help/304261) Support for network database files
