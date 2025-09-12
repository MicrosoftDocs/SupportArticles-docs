---
title: Unable to publish a form via Outlook
description: Fixes an issue in which you can't publish a form through Outlook to any Forms Library.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Group Policy
  - Outlook for Windows
  - CI 148498
  - CSSTroubleshoot
ms.reviewer: kebloom
appliesto: 
  - Outlook 2013
  - Outlook 2016
  - Outlook 2019
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't publish a form to any Forms Library through Outlook

## Symptoms

When you publish a form through Outlook to any Forms Library (such as the Organizational Forms Library in public folders or a user's mailbox), you receive the following error message:

> Cannot publish the form. The operation failed.

:::image type="content" source="media/cannot-publish-form/publish-form-error.png" alt-text="Screenshot of the error when publishing a form via Outlook." border="false":::

## Cause

This issue might occur if an antivirus software or a Microsoft Outlook add-in interferes with the Outlook publishing process.  

## Resolution

To resolve this issue, configure antivirus exclusions, as detailed in [Virus prevention](/microsoft-365-apps/outlook/configuration/plan-outlook-deployment#virus-prevention). If the issue persists, disable Outlook add-ins by using the following steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

1. Open Registry Editor as an administrator. To do this, select **Start**, enter _regedit_, right-click **Registry Editor** in the search results, and then select **Run as administrator**.
1. Navigate to each of the following registry subkeys, and then change the `loadbehavior` value to **0** for all non-Microsoft add-ins:

    - `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\AddIns`
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\AddIns`
    - `HKEY_LOCAL_MACHINE\Software\WOW6432node`
    - `HKEY_CURRENT_USER\Software\Policies\Microsoft`
    - `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft`

1. Restart Outlook, and publish the form again.

If the issue isn't resolved, collect the following information, and then contact [Microsoft Support](https://support.microsoft.com/contactus) to identify which process is locking Outlook.

- Collect minifilter drivers

    Open a Command Prompt window as an administrator, and then run `FLTMC` to list the file system drivers (minifilter). Here's an example of the output:

    :::image type="content" source="media/cannot-publish-form/fltmc-output.png" alt-text="Screenshot of the output example when running FLTMC.":::

- Do a Procmon capture for the process:

    1. Download [Process Monitor](/sysinternals/downloads/procmon).
    1. Save the tool locally, and extract the files.
    1. Double-click Procmon.exe to start Process Monitor.
    1. Reproduce the issue, switch to the Process Monitor window, and then select the magnifying glass icon on the toolbar to stop the log capture.
    1. Select **File** > **Save** > **All Events**, and then save the Process Monitor log in PML format.
    1. Share the PML file with Microsoft Support for analysis.
