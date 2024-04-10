---
title: Integration with OpsMgr fails with error 10218
description: Fixes an issue where you receive error 10218 when creating the Virtual Machine Manager integration with Operations Manager
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Operations Manager integration with System Center 2012 Virtual Machine Manager fails with error 10218

This article helps you fix an issue where you receive error 10218 when creating the Virtual Machine Manager integration with Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2674625

## Symptoms

When creating the integration from System Center 2012 Virtual Machine Manager (VMM 2012) to Operations Manager, the integration fails with the following error:

> Error (10218)
>
> Setup could not import the System Center Virtual Machine Manager Management Pack into Operations Manager server because one or more required management packs are missing. The VMM Management Packs cannot be deployed unless the following component management packs are present in Operations Manager 2007:  
> Windows Server Internet Information Services 2003,  
> Windows Server 2008 Internet Information Services 7,  
> Windows Server Internet Information Services Library,  
> SQL Server Core Library.

> [!NOTE]
> All required management packs have been imported in Operations Manager.

## Cause

In this scenario, the Virtual Server 2005 R2 Management Pack was imported which imports the Microsoft Virtualization Core Library. The cause of the problem is that VMM 2012 will import a newer version of the Microsoft Virtualization Core Library Management Pack and the old version cannot be present in order for integration to complete successfully.

## Resolution

There are two potential solutions:

- Remove the old version of the Microsoft Virtualization Core Library and the Microsoft Virtual Server 2005 R2 Management Pack.

- Configure a second Operations Management group for the VMM 2012 integration and configure the VMM 2012 server as well as the Hyper-V servers to report to this new management group.  

## More information

The Microsoft Virtualization Core Library is a Hyper-V Management Pack developed by the Hyper-V team. It has been updated to support the latest version of Hyper-V and improve monitoring of the hosts.
