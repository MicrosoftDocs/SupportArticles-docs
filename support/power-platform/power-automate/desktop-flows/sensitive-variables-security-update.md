---
title: Security update for sensitive variables
description: Provides security updates for the sensitive variables feature in Microsoft Power Automate for desktop.
ms.reviewer: nimoutzo, iopanag
ms.date: 04/14/2026
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Security update for sensitive variables in Microsoft Power Automate for desktop

## Summary

A potential security vulnerability is identified in the [sensitive variables](power-automate/desktop-flows/manage-variables#sensitive-variables) feature in Power Automate for desktop versions 2.62 to 2.66.

When marking variables as **sensitive** in a Power Automate Desktop flow, these variable's values are not shown in flow execution logs on the Power Automate portal. However, due to a vulnerability, these values may appear on the execution logs when **global sensitive** variables are used in **local subflows**. Microsoft has issued a [CVE for this issue](https://msrc.microsoft.com/update-guide/advisory/CVE-2025-21187).

> [!IMPORTANT]
> The issue affects only flows that use the **global sensitive variables** in **local subflows**.

## Mitigation

To mitigate the issue, update your Power Automate for desktop to the following patched versions as soon as possible.

- [2.46.185.25043](https://go.microsoft.com/fwlink/?linkid=2300767)
- [2.47.127.25043](https://go.microsoft.com/fwlink/?linkid=2300573)
- [2.48.165.25043](https://go.microsoft.com/fwlink/?linkid=2300574)
- [2.49.183.25043](https://go.microsoft.com/fwlink/?linkid=2300662)
- [2.50.140.25043](https://go.microsoft.com/fwlink/?linkid=2300768)
- [2.51.367.25043](https://go.microsoft.com/fwlink/?linkid=2300789)
- [2.52.66.25042](https://go.microsoft.com/fwlink/?linkid=2304734)

> [!NOTE]
> Starting with release 2.52.66.25042, all future versions will include the security fix.