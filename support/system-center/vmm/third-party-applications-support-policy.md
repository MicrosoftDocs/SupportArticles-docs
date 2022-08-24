---
title: Support policy for third-party applications running in Server App-V
description: Describes the support policy for third-party applications that are running in a Microsoft Server Application Virtualization (Server App-V) environment
ms.date: 07/17/2020
ms.reviewer: jeffpatt
---
# Support policy for third-party applications running in a Server App-V environment

This article covers the Microsoft support policy for third-party applications that are running in a Microsoft Server Application Virtualization (Server App-V) environment.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2692652

## Summary

Server App-V builds on the technology used with Application Virtualization (App-V) by separating the application configuration and state from the underlying operating system running on computers in a data center environment. Server App-V allows for dynamic composition of application and hardware images that can help significantly reduce the number of images that need to be managed. Server App-V also enables automation of deployment and management scenarios that can improve reliability, availability, and serviceability of datacenter applications.

Not all applications are supported for use with Server App-V. Applications such as antivirus software that require device or kernel driver support are not supported. Server App-V is primarily designed for use with business applications or the business tiers of multi-tiered applications. Consequently some large server applications such as Microsoft Exchange Server, Microsoft SQL Server, and Microsoft SharePoint are not supported. While there is no list of supported applications for use with Server App-V, Server App-V has been optimized to create virtual application packages for applications with the following attributes:

- State persisted to local disk
- Microsoft Windows Services
- Internet Information Services (IIS)
- Registry
- COM+ / DCOM
- Text-based Configuration Files
- WMI Providers
- Microsoft SQL Server Reporting Services
- Local Users and Groups

Microsoft will provide commercially reasonable efforts to investigate issues when you run third-party applications in a Server App-V environment. As part of that investigation, we may require that you reproduce an issue independently from the Server App-V environment. If the issue is determined to be related to the third-party application, you must contact the third-party vendor for more information about how to resolve the issue.

## More information

For more information on Server App-V, see [Server Application Virtualization Overview](/previous-versions/system-center/system-center-2012-R2/gg703262(v=sc.12)?redirectedfrom=MSDN).
