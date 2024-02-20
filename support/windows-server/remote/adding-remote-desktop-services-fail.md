---
title: Adding Remote Desktop Services role fails
description: Helps solve an issue where adding Remote Desktop Services role fails when Firewall Service is stopped.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robertvi
ms.custom: sap:administration, csstroubleshoot
---
# Adding Remote Desktop Services role may fail when Firewall Service is stopped

This article provides help to solve an issue where adding Remote Desktop Services role fails when Firewall Service is stopped.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2802436

## Symptoms

On a computer that is running Windows Server 2012, when you try to install the Remote Desktop Services role using the "Add Roles and Features" Wizard, the installation may fail. Additionally, during the installation process you may receive one of the following error messages:

> Unable to open remote connections on the RD Connection Broker server
>
> The post installation configuration did not complete.

> [!NOTE]
> After a reboot, the RDS Server may work. If it does not, the following powershell commands will complete the failed action:
>
> ```powershell
> $tss = Get-WmiObject -namespace root\cimv2\terminalservices -class Win32_TerminalServiceSetting  
> $tss.SetAllowTSConnections(1,0)
> ```

## Cause

During the post installation configuration, the wizard attempts to enable necessary firewall exceptions for the RDS Role. When the firewall service is stopped, this operation fails and is reported with the above error.

## Resolution

It is not recommended to run without a Firewall. If you have certain requirements to do so, enable the Firewall Service at least during installation of this Role.
