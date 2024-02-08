---
title: RemoteFX-enabled VMs don't start
description: Fixes an issue in which new and existing RemoteFX-enabled virtual machines cannot run on a domain server that is running the Remote Desktop Virtualization Host service in Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 SP1.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rkiran, jarrettr, sabinn
ms.custom: sap:performance-audio-and-video-and-remotefx, csstroubleshoot
---
# New and existing RemoteFX-enabled VMs do not start on a DC that is running the Remote Desktop Virtualization Host service on Windows Server

This article provides a solution to an issue where which new and existing RemoteFX-enabled virtual machines cannot run on a domain server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2506417

## Symptoms

You have a server that is running the Remote Desktop Virtualization Host service on Windows Server. When you configure Active Directory Domain Services (AD DS) on the server to add the server as a domain controller, you experience the following symptoms:

- All existing RemoteFX-enabled virtual machines (VMs) do not start.
- An administrator cannot create a RemoteFX-enabled VM.

## Resolution

To resolve the issue, use one of the following methods.

### Method 1

Remove the RemoteFX 3D video adapter from the VM. To do this, follow these steps:

1. Open Hyper-V Manager. To do this, click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.
2. In the details pane, under **Virtual Machines**, select the VM that you want to configure. The VM must be off for you to be able to change its settings.
3. In the **Action** pane, click **Settings** under the virtual machine name.
4. In the navigation pane, click **RemoteFX 3D Video Adapter**.
5. Click **Remove**, and then click **OK**.

### Method 2

Reconfigure AD DS so that the server that is running the Remote Desktop Virtualization Host service is not a domain controller. Instead, make the server a member server or a member of a workgroup.

## Status

This behavior is by design. Running AD DS on a server that is also running a RemoteFX-enabled VM is not a supported configuration.
