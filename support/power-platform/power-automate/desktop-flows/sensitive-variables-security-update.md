---
title: Resolve sensitive variable vulnerability in Desktop Flows
description: Power Automate for desktop security update fixes a sensitive variables vulnerability that exposes values in flow execution logs.
ms.reviewer: nimoutzo, iopanag, v-shaywood
ms.date: 05/01/2026
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Security update for sensitive variables

## Summary

This article describes a security update for the [sensitive variables](/power-automate/desktop-flows/manage-variables#sensitive-variables) feature in Microsoft Power Automate for desktop. A potential vulnerability that can expose sensitive values in flow execution logs affects Power Automate for desktop versions *2.62* through *2.66*.

> [!IMPORTANT]
> The issue affects only flows that use *global sensitive variables* in *local subflows*.

## Symptoms

When you mark a variable as *sensitive* in a desktop flow, its value is usually hidden from flow execution logs on the Power Automate portal. Because of this vulnerability, the value can appear in the logs if a [global sensitive variable](/power-automate/desktop-flows/scoped-variables#variable-scope) is used in a [local subflow](/power-automate/desktop-flows/scoped-variables#create-local-subflows-and-variables).

## Solution

To fix the issue, update Power Automate for desktop to an updated version as soon as possible. Install the latest version of [Power Automate for desktop](https://go.microsoft.com/fwlink/?linkid=2102613).

If you need an update for an earlier release, get one of the following downloads:

- [2.66.166.26105](https://download.microsoft.com/download/dd82ff1c-b050-4c01-a5a5-e85118d3d191/Setup.Microsoft.PowerAutomate.exe)
- [2.65.152.26105](https://download.microsoft.com/download/50845c1a-5f2d-40d8-8cc8-f9b1e35e6a06/Setup.Microsoft.PowerAutomate.exe)
- [2.64.110.26105](https://download.microsoft.com/download/e993dec1-4be7-4c69-90b7-a221f696e1d6/Setup.Microsoft.PowerAutomate.exe)
- [2.63.165.26105](https://download.microsoft.com/download/7fc65b64-ffa4-480b-a800-9962b3f9f884/Setup.Microsoft.PowerAutomate.exe)
- [2.62.189.26106](https://download.microsoft.com/download/40fe38ea-36ad-4f96-bb73-3a75a7a3ec0d/Setup.Microsoft.PowerAutomate.exe)

> [!NOTE]
> Release 2.67.143.26090 and all later versions include this security fix.

## Related content

- [Variable data types in Power Automate for desktop](/power-automate/desktop-flows/variable-data-types)
- [Set up subflows in the Power Automate for desktop flow designer](/power-automate/desktop-flows/designer-workspace)
