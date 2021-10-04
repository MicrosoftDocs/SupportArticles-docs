---
title: Virtual machine stuck in failed state
description: This article provides steps to resolve issues where the virtual machine (VM) is stuck in a failed state. 
services: virtual-machines
author: mimckitt
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.topic: troubleshooting
ms.date: 10/4/2021
ms.author: mimckitt
---

# Virtual machine stuck in a failed state

This article provides steps to resolve issues where the virtual machine (VM) is stuck in a failed state.

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you will see that the screenshot displays that the operating system (OS) was unresponsive during a boot with the message **Applying Audit Policy Configuration policy**.

  ![The OS booting with the message: “Applying Audit Policy Configuration policy”](./media/vm-unresponsive-applying-audit-configuration-policy/1.png)

  ![The OS booting in Windows Server 2012 with the message: “Applying Audit Policy Configuration policy”](./media/vm-unresponsive-applying-audit-configuration-policy/2.png)

## Cause

There are conflicting locks when the policy attempts to clean up old user profiles.

> [!NOTE]
> This applies only to Windows Server 2012 and Windows Server 2012 R2.

Here’s the problematic policy:
*Computer Configuration\Policies\Administrative Templates\System/User Profiles\Delete user profiles older than a specified number of days on system restart.*

## Solution

Using the [Reapply](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply) REST API, you can push the latest goal state in hopes of fixing some issues of broken/”failed” VMs or inconsistent state. 

1. 