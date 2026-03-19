---
title: 'Fix: Power Automate desktop Windows credential dialog issues'
description: 'Power Automate for desktop: fix broken Windows credential dialog automation caused by January 2026 security updates by using these step-by-step workarounds.'
ms.date: 03/18/2026
ms.reviewer: iomavrid, adanas, v-shaywood
ms.custom: sap:Desktop flows\UI or browser automation
---

# Can't automate websites and apps that require Windows credentials

_Applies to:_ &nbsp; Power Automate

## Summary

After you install Windows security updates that were released on or after January 13, 2026, [Power Automate for desktop](/power-automate/desktop-flows/introduction) can't interact correctly with dialogs that prompt for Windows credentials. This article describes the cause of the issue, and provides workarounds to restore automated authentication workflows in Power Automate for desktop.

## Symptoms

Power Automate for desktop stops interacting correctly with the Windows security dialog. This limitation includes both capturing [UI elements](/power-automate/desktop-flows/ui-elements) and interacting with the windows (for example, by selecting a button). Examples of these dialogs include:

- A web page that requests Windows credentials

  :::image type="content" source="media/windows-credentials-dialog-issues/windows-credentials-dialog-website.png" alt-text="Screenshot that shows a web page requesting Windows credentials.":::

- A desktop application that requests Windows credentials

  :::image type="content" source="media/windows-credentials-dialog-issues/windows-credentials-dialog-app.png" alt-text="Screenshot that shows a desktop application requesting Windows credentials.":::

## Cause

A security fix for _CredentialUIBroker.exe_ that was initially released on January 13, 2026, and causes automated authentication workflows to fail. Browsers and UI applications such as Remote Desktop Connection use this executable so that users can sign in by using their Windows credentials. Because Windows enforces this change, Power Automate for desktop can't bypass the restriction.

The following table lists the Windows security updates that introduced this change.

| KB article                                              | Release date      | Target OS                                                                               |
| ------------------------------------------------------- | ----------------- | --------------------------------------------------------------------------------------- |
| [KB5074109](https://support.microsoft.com/help/5074109) | January 13, 2026  | Windows 11, version 25H2 and 24H2 (OS Builds 26200.7623 and 26100.7623)                 |
| [KB5073455](https://support.microsoft.com/help/5073455) | January 13, 2026  | Windows 11, version 23H2 (OS Build 22631.6491)                                          |
| [KB5073724](https://support.microsoft.com/help/5073724) | January 13, 2026  | Windows 10, version 22H2 and Enterprise LTSC 2021 (OS Builds 19045.6809 and 19044.6809) |
| [KB5073723](https://support.microsoft.com/help/5073723) | January 13, 2026  | Windows 10 Enterprise LTSC 2019 and Windows Server 2019 (OS Build 17763.8276)           |
| [KB5073379](https://support.microsoft.com/help/5073379) | January 13, 2026  | Windows Server 2025 (OS Build 26100.32230)                                              |
| [KB5073457](https://support.microsoft.com/help/5073457) | January 13, 2026  | Windows Server 2022 (OS Build 20348.4648)                                               |
| [KB5075999](https://support.microsoft.com/help/5075999) | February 10, 2026 | Windows Server 2016 (OS Build 14393.8868)                                               |

After you install any of these updates, Power Automate for desktop can't automate Windows credential dialogs correctly. For more information, see [New behavior restricting certain applications to autofill credentials introduced by the Windows January 2026 security update](https://support.microsoft.com/en-us/help/5080542).

## Workarounds

Until a fix is available, use the following workarounds, as appropriate:

- For web automation problems, use an alternative browser. Currently, only Microsoft Edge is affected. Therefore, use Firefox or Chrome instead, if possible.

   > [!NOTE]
   > When you use Chrome, you might have to use the UI element inspector tool and enable [Microsoft Active Accessibility (MSAA)](/windows/win32/winauto/microsoft-active-accessibility) mode.

- [Run Power Automate for desktop as an administrator](/power-automate/desktop-flows/setup#run-power-automate-with-elevated-rights) for local attended (console) runs. This option isn't available for cloud runs (unattended or attended).

## Related content

- [Automate desktop applications](/power-automate/desktop-flows/desktop-automation)
- [UI automation actions](/power-automate/desktop-flows/actions-reference/uiautomation)
- [Troubleshoot desktop flows runtime](/power-automate/desktop-flows/troubleshoot)
