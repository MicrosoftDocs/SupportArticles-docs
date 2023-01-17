---
title: Advanced troubleshooting for Windows start-up issues
description: Learn advanced options for how to troubleshoot common Windows start-up issues, like system crashes and freezes.
ms.date: 10/20/2022
ms.prod: windows-client
ms.topic: troubleshooting
author: dansimp
ms.author: dansimp
audience: itpro
localization_priority: medium
manager: dcscontentpm
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
ms.technology: windows-client-performance
---

# Advanced troubleshooting for Windows start-up issues

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806273" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Windows boot issues</span>

In these articles, you'll learn how to troubleshoot common problems that are related to Windows startup.

## How it works

When Microsoft Windows experiences a condition that compromises safe system operation, the system halts. These Windows startup problems are categorized in the following groups:

- Bug check: Also commonly known as a system crash, a kernel error, or a Stop error.
- No boot: The system may not produce a bug check but is unable to start up into Windows.
- Freeze: Also known as "system hang".
  
## Best practices

To understand the underlying cause of Windows startup problems, it's important that the system be configured correctly. Here are some best practices for configuration:

### Page file settings

- [Introduction of page file](introduction-to-the-page-file.md)
- [How to determine the appropriate page file size for 64-bit versions of Windows](how-to-determine-the-appropriate-page-file-size-for-64-bit-versions-of-windows.md)

### Memory dump settings

- [Configure system failure and recovery options in Windows](configure-system-failure-and-recovery-options.md)
- [Generate a kernel or complete crash dump](generate-a-kernel-or-complete-crash-dump.md)

## Troubleshooting  

These articles will walk you through the resources you need to troubleshoot Windows startup issues:

- [Advanced troubleshooting for Windows boot problems](./windows-boot-issues-troubleshooting.md)
- [Advanced troubleshooting for Stop error or blue screen error](./stop-error-or-blue-screen-error-troubleshooting.md)
- [Advanced troubleshooting for Windows-based computer freeze issues](./windows-based-computer-freeze-troubleshooting.md)
- [Stop error occurs when you update the in-box Broadcom network adapter driver](stop-error-broadcom-network-driver-update.md)
