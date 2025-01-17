---
title: Browser Automation Security Updates
description: Provides security updates for the Browser automation component in Microsoft Power Automate for desktop.
ms.reviewer: nimoutzo, iopanag
ms.date: 01/16/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Security updates for the Browser automation component in Microsoft Power Automate for desktop

## Summary

A potential security vulnerability is identified in the [Browser automation](/power-automate/desktop-flows/actions-reference/webautomation) component in Power Automate for desktop.

Using the **Launch Automation Browser** option in the [Launch new Internet Explorer](/power-automate/desktop-flows/actions-reference/webautomation#launchinternetexplorerbase) action could allow an attacker to execute arbitrary code on the affected system when the **Launch Automation Browser** navigates to a malicious URL or a compromised website. Microsoft has issued a [CVE for this issue](https://msrc.microsoft.com/update-guide/advisory/CVE-2025-21187).

> [!IMPORTANT]
> The issue only affects flows that use the **Launch Automation Browser** option in the **Launch new Internet Explorer** action.
>
> Flows that use the **Launch Automation Browser** option with public or untrusted websites are the most vulnerable to this issue.

## Mitigation

To mitigate the issue, update your Power Automate for desktop to the following patched versions as soon as possible.

- [2.46.184.25013](https://go.microsoft.com/fwlink/?linkid=2300767)
- [2.47.126.25010](https://go.microsoft.com/fwlink/?linkid=2300573)
- [2.48.164.25010](https://go.microsoft.com/fwlink/?linkid=2300574)
- [2.49.182.25010](https://go.microsoft.com/fwlink/?linkid=2300662)
- [2.50.139.25010](https://go.microsoft.com/fwlink/?linkid=2300768)
- [2.51.349.24355](https://go.microsoft.com/fwlink/?linkid=2300789)

> [!NOTE]
> Starting with release 2.52, all future versions will include the security fix.

## Impact of the patch

In the updated versions, when the Browser automation attempts to navigate to a potentially malicious URL, it will display a warning prompt with relevant details. The user can choose to continue or stop the navigation.

If a flow is disrupted by this dialog and a navigation is considered legitimate, the URL can be added to the allow list in the Power Automate UI Automation settings file to avoid showing the dialog for that URL.
