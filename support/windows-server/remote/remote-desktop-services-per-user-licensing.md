---
title: The first connection to a non-persistent VDI session fails when using per-user Remote Desktop licensing
description: Troubleshooting the "Remote Desktop License Servers unavailable" error when trying to connect to a remote session using non-persistent VDI and per-user Remote Desktop licensing.
ms.date: 04/27/2023
author: Heidilohr
ms.author: helohr
manager: femila
audience: itpro
ms.prod: windows-server
ms.topic: troubleshooting
localization_priority: medium
ms.technology: windows-server-rds
---

# The first connection to a non-persistent VDI session fails when using per-user Remote Desktop licensing

If you're running a Virtual Desktop Infrastructure (VDI) environment with non-persistent virtual machines (VMs) that connect to a Remote Desktop license server with per-user licensing, you may see an error message appear the first time a user tries to connect. The error message is **The remote session disconnected because there are no Remote Desktop License Servers available**. This article explains why this error happens and gives you directions for how to mitigate it.

Let's first look at the difference between *persistent VDI* and *non-persistent VDI*:

- *Persistent VDI* is when changes made to a virtual machine are kept after you shut down or restart your VM. Persistent VDI behaves like a physical machine.

- *Non-persistent VDI* is when the VM doesn't keep the changes you make to it after you shut down or restart it. Instead, every time you end your session, the VM reverts to its original state and loses any changes. VMs on non-persistent VDI typically use a shared custom image.

## Symptoms

A user sees the error message **The remote session disconnected because there are no Remote Desktop License Servers available**. This issue happens if a user is the first one to connect to a VM after they turn it on and the following things are true:

- The Windows VM has the *Remote Desktop Session Host* (RDSH) role installed.
- The Remote Desktop licensing server the VM uses is configured in *per-user* mode.
- The [120 day grace licensing period](/windows-server/remote/remote-desktop-services/rds-client-access-license) has expired. No license server is required during this time.
- The VM has never connected to the Remote Desktop licensing server specified.

While this scenario can happen with both persistent and non-persistent VDI, it happens most often with non-persistent VDI, as the VMs for persistent VDI have connected to the Remote Desktop licensing server during the grace period.

This scenario only applies to third-party VDI providers. A Microsoft Remote Desktop Services deployment doesn't natively have the option to use non-persistent VMs.

## Cause

When the first user tries to connect, the VM queries the Remote Desktop licensing server for an X509 certificate. This process can take several seconds, during which connections fail and display the error message **The remote session disconnected because there are no Remote Desktop License Servers available**. Once the VM receives the X509 certificate, subsequent connections succeed. This error happens by design.

With non-persistent VMs, depending on how you serviced the VM, this issue may happen each time someone turns it on because its state always resets. As a result, the VM queries the Remote Desktop licensing server for an X509 certificate.

## Resolution

For users to connect to the non-persistent VMs without the error, the VM must have received an X509 certificate.

Non-persistent VMs are provisioned based on a custom image, where multiple VMs are all based on the same image. The admins don't service non-persistent VMs with things like installing Windows Updates because all changes are lost whenever the VM restarts. Instead, they service the custom image the VMs are based on.

Typically, servicing happens in one of two ways. The following table lists the differences between each approach in this scenario:

| Servicing method | Result |
|--|--|
| Start with the existing custom image, install any updates, and make the same custom image available to be used by the non-persistent VMs. | The error doesn't happen while the custom image is within the grace period. However, once the grace period expires, the error occurs again.<br /><br />Alternatively, you could create a script to simulate the first connection to obtain an X509 certificate. |
| Create a new custom image each time using an automated process with a tool like [Microsoft Deployment Toolkit](/windows/deployment/deploy-windows-mdt/get-started-with-the-microsoft-deployment-toolkit). | If you use this method frequently, the custom image is within the grace period, so the error doesn't occur. You still need to license your deployment correctly. |

> [!NOTE]
> You should contact your VDI provider for recommendations as to the most suitable way to service your deployment.
