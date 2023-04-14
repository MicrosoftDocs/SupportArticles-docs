---
title: Troubleshoot remote session disconnected using non-persistent VDI with per-user licensing
description: Troubleshooting the "Remote Desktop License Servers unavailable" error when trying to connect to a remote session using non-persistent VDI.
ms.date: 04/14/2023
author: Heidilohr
ms.author: helohr
manager: femila
audience: itpro
ms.prod: windows-server
ms.topic: troubleshooting
localization_priority: medium
ms.technology: windows-server-rds
---

# Remote session disconnected when using non-persistent VDI with per-user licensing

If you're running a non-persistent Remote Desktop Services (RDS) Virtual Desktop Infrastructure (VDI) with per-user licensing, you may see an error message appear the first time you try to connect to a virtual machine (VM). This error message says **The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license**, and it can appear even if you do already have a license. This article will explain why this error happens, as well as steps you can take to mitigate it.

To understand why this happens, let's first look at the difference between *persistent VDI* and *non-persistent VDI*.

- *Persistent VDI* is when changes made to a virtual machine persist after you shut down or restart your VM. Persistent VDI behaves like a physical machine.

- *Non-persistent VDI* is when the VM doesn't keep the changes you make to it after you shut down or restart it. Instead, every time you end your session, the VM reverts to its original state and loses any changes. VMs on non-persistent VDI typically use a shared custom image.

## Symptoms

This issue appears when you're running a non-persistent VDI deployment Windows virtual machines (VMs) that are licensed with a Remote Desktop Services licensing server. This issue usually happens when you're using per-user licensing mode and your VMs haven't connected to the licensing server within the 120 day grace period after creation.

When the VM first connects, the VM queries the licensing server for the X509 certificate. Usually, this process takes several seconds. However, the issue happens when the connection suddenly stops. After the disconnection, an error message that says **The remote session disconnected because there are no Remote Desktop License Servers available** appears.

## Cause

In a persistent VM, the user or admin could get an X509 certificate and permanently solve the problem. However, for non-persistent VMs, the VM is reset every time it's deactivated.

Basically, because non-persistent VMs can't save changes between sessions, every time a user connects, it's like they're connecting to the licensing server for the first time.

## Resolution

In order for the non-persistent VMs to connect, they must have the X509 certificate. However, since the VMs themselves don't persist between sessions, you must patch the correct certificate directly into the custom image all the non-persistent VMs are based on.

There are two ways you can patch the custom image:

- The first method is to add the correct certificate by turning it on, downloading the certificate, then shutting it down. The one drawback to this method is that now the custom image itself is subject to the 120 day grace period for RDS licenses. As a result, the issue will reappear after the grace period expires.
- The second method is to build a new custom image with the correct certificate every 120 days. You can make a new image manually or with an automated tool, such as Microsoft Development Toolkit.

Microsoft doesn't support non-persistent RDS deployments. If you need more information about how to patch your custom image, contact your third-party virtualization provider.
