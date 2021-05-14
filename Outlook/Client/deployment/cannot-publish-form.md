---
title: Unable to publish a form via Outlook
description: Fixes an issue in which you can't publish a form through Outlook to any Forms Library.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro 
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CI 148498
- CSSTroubleshoot
ms.reviewer: kebloom
appliesto:
- Outlook 2013
- Outlook 2016
- Outlook 2019
- Outlook for Office 365
search.appverid: MET150
---
# Can't publish a form to any Forms Library through Outlook

## Symptoms

When you publish a form through Outlook to any Forms Library (such as the Organizational Forms Library in public folders, a user's mailbox, or any other location), you receive the following error message:

> Cannot publish the form. The operation failed.

:::image type="content" source="media/cannot-publish-form/publish-form-error.png" alt-text="Screenshot of the error when publishing a form via Outlook." border="false":::

## Cause

This issue may occur if an anti-virus software or an Outlook add-in interferes with Outlook to publish the form.  

## Resolution

To resolve this issue, we recommend that you configure anti-virus exclusions as detailed in [Virus prevention](../Installation/plan-outlook-2016-deployment.md#virus-prevention). If the issue persists, disable Outlook add-ins by following these steps:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

1. Open the Registry Editor as administrator by running RegEdit.exe.
1. Navigate to each of the following registry subkeys, and then change the `loadbehavior` value to **0** for all non-Microsoft add-ins:

    - `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\AddIns`
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\AddIns`
    - `HKEY_LOCAL_MACHINE\Software\WOW6432node`
    - `HKEY_CURRENT_USER\Software\Policies\Microsoft`
    - `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft`

1. Restart Outlook and publish the form again.

If the issue isn't resolved, collect the following information and contact [Microsoft Support](https://support.microsoft.com/contactus) to identify which process is locking Outlook.

- Collect minifilter drivers

    Open a command prompt as administrator and run `FLTMC` to list the file system drivers (minifilter). Here is an example of the output:

    :::image type="content" source="media/cannot-publish-form/fltmc-output.png" alt-text="Screenshot of the output example when running FLTMC.":::

- Capture a Procmon for the process

    1. Download [Process Monitor](/sysinternals/downloads/procmon).
    1. Save the tool locally and extract files.
    1. Double-click Procmon.exe to start Process Monitor.
    1. Reproduce the issue quickly, switch to the Process Monitor window, and then select the magnifying glass icon in the toolbar to stop the log capture.
    1. On the **File** menu, select **Save** > **All Events**, and then save the Process Monitor log in PML format.
    1. Share the PML file with Microsoft Support for analysis.
