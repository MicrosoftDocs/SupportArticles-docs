---
title: Browser Automation Security Update
description: Provides security updates for the browser automation component in Microsoft Power Automate for desktop.
ms.reviewer: nimoutzo, iopanag
ms.date: 02/26/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Security update for the browser automation component in Microsoft Power Automate for desktop

## Summary

A potential security vulnerability is identified in the [browser automation](/power-automate/desktop-flows/actions-reference/webautomation) component in Power Automate for desktop versions 2.51 and earlier.

The **Launch automation browser** option in the [Launch new Internet Explorer](/power-automate/desktop-flows/actions-reference/webautomation#launchinternetexplorerbase) action might navigate to a potentially malicious URL or compromised website, thus allowing an attacker to execute arbitrary code on the affected system. Microsoft has issued a [CVE for this issue](https://msrc.microsoft.com/update-guide/advisory/CVE-2025-21187).

> [!IMPORTANT]
> The issue affects only flows that use the **Launch automation browser** option in the **Launch new Internet Explorer** action.
>
> Flows that use the **Launch automation browser** option for public or untrusted websites are most vulnerable to this issue.

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

## Impact of the patch

In the updated versions, when browser automation attempts to navigate to a potentially malicious URL, it will display a warning dialog with relevant details. The user can choose to continue or stop the navigation.

If this dialog disrupts a flow and the navigation is considered legitimate, you can mitigate the issue by disabling the warning dialog for specific categories of URLs by adding their protocols to the allowlist in the [UI Automation configuration file](~/power-platform/power-automate/desktop-flows/ui-automation/desktop-application-crashes-ui-automation.md#how-to-create-the-configuration-file). The key to add in this case is `AutomationBrowser.ProtocolAllowList`, and the value is the protocols that you want to allow, separated by commas. For example:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <appSettings>
        <!-- Other configurations -->

        <add key="AutomationBrowser.ProtocolAllowList" value="http,https" />
    </appSettings>
</configuration>
```

With this configuration, if navigating to a URL causes the dialog to appear and the URL uses the `http` or `https` protocol, the dialog will be suppressed.
