---
title: Security update for sensitive variables
description: Provides security updates for the sensitive variables feature in Microsoft Power Automate for desktop.
ms.reviewer: nimoutzo, iopanag
ms.date: 04/14/2026
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Security update for sensitive variables in Microsoft Power Automate for desktop

## Summary

A potential security vulnerability is identified in the sensitive variables feature in Power Automate for desktop versions 2.62 to 2.66.

When marking variables as **sensitive** in a Power Automate Desktop flow, these variable's values aren't shown in flow execution logs on the Power Automate portal. However, due to a vulnerability, these values may appear on the execution logs when **global sensitive** variables are used in **local subflows**.

> [!IMPORTANT]
> The issue affects only flows that use the **global sensitive variables** in **local subflows**.

## Mitigation

To mitigate the issue, update your Power Automate for desktop to the patched version as soon as possible. You can download the latest version of Power Automate for desktop from [this link](https://go.microsoft.com/fwlink/?linkid=2102613). If you need a patched version for a prior version, you can download from the list bellow.

- [2.66.166.26105](https://download.microsoft.com/download/dd82ff1c-b050-4c01-a5a5-e85118d3d191/Setup.Microsoft.PowerAutomate.exe)
- [2.65.152.26105](https://download.microsoft.com/download/50845c1a-5f2d-40d8-8cc8-f9b1e35e6a06/Setup.Microsoft.PowerAutomate.exe)
- [2.64.110.26105](https://download.microsoft.com/download/e993dec1-4be7-4c69-90b7-a221f696e1d6/Setup.Microsoft.PowerAutomate.exe)
- [2.63.165.26105](https://download.microsoft.com/download/7fc65b64-ffa4-480b-a800-9962b3f9f884/Setup.Microsoft.PowerAutomate.exe)
- [2.62.189.26106](https://download.microsoft.com/download/40fe38ea-36ad-4f96-bb73-3a75a7a3ec0d/Setup.Microsoft.PowerAutomate.exe)

> [!NOTE]
> Starting with release 2.67.143.26090, all future versions will include the security fix.