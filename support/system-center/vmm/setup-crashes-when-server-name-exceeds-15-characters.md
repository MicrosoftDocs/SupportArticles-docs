---
title: VMM setup crashes when the server name exceeds 15 characters
description: System Center Virtual Machine Manager 2012 setup crashes when the VMM server name exceeds 15 characters.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt
---
# Setup for System Center 2012 Virtual Machine Manager crashes when the server name exceeds 15 characters

This article helps you fix an issue where System Center 2012 Virtual Machine Manager (VMM) setup crashes when the NetBIOS name for the VMM server exceeds 15 characters.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2685676

## Symptoms

The installation of System Center 2012 Virtual Machine Manager will fail with the following error if the NetBIOS name for the VMM server exceeds 15 characters:

> The Virtual Machine Manager server could not validate user Domain\ComputerName.
>
> Contact your Virtual Machine Manager administrator to verify that there is a two-way trust relationship between the user domain and the domain of the Virtual Machine Manager server.

## Cause

NetBIOS names longer than 15 characters are not allowed (see [Naming conventions in Active Directory for computers, domains, sites, and OUs](https://support.microsoft.com/help/909264)). When a server is deployed and the server's NetBIOS name is longer than 15 characters, AD NetBIOS name changes and truncates the server name. For example, *MyVMMServerName01$* gets changed to *MyVMMServerName$*.

## Resolution

To resolve this issue, rename the VMM server so that the NetBIOS name doesn't exceed 15 characters.
