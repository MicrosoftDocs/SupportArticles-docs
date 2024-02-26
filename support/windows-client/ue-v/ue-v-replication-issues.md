---
title: Troubleshoot UE-V replication issues
description: Describes how to troubleshoot replication issues with Microsoft User Experience Virtualization (UE-V).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, markstan
ms.custom: sap:user-experience-virtualization-ue-v, csstroubleshoot
---
# How to troubleshoot UE-V replication issues

This article provides the steps to troubleshoot replication issues with Microsoft User Experience Virtualization (UE-V).

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2844022

## Summary

Common scenarios include:

- Settings replicate from one machine to the Settings Storage Path but not from a second machine.
- Settings have replicated to the Settings Storage Path in the past, but are no longer either uploading or downloading correctly.
- Settings for some applications replicate, but not for other applications.

In general, it is recommended to test settings on at least two separate client computers and optionally two user accounts (computerA and computer, userA and userB in the example below).  It is also recommended to investigate using a reference application such as Notepad for testing.  Most commonly, issues will fall in to one of 4 broad scenarios:

- If settings replicate for UserA but not from UserB on the same computer, the problem lies with UserB.
- If settings replicate for neither UserA nor UserB on computerA, but do successfully replicate for both users on computerB, the problem is with computerA.
- If settings do not replicate for either user on either computer, the problem most likely resides in the server hosting the Settings Store Path, or in an infrastructure issue
- If settings replicate for UserA for some applications but not others, the problem most likely resides in the configuration of the problem application's template

Depending on the scenario, you are troubleshooting, use the steps below to further investigate the users, computers, or application templates experiencing the issue.

## Isolate problem users, computers, or application templates

The checklist below provides a general framework for isolating problem users, computers, or application templates:

1. Examine the Microsoft-User Experience Virtualization-App Agent/Operational event log located under Event Viewer\Applications and Services Logs\Microsoft\User Experience Virtualization\App Agent. A successful synchronization will record an entry like the following:

    > Log Name: Microsoft-User Experience Virtualization-App Agent/Operational  
    Source: Microsoft-User Experience Virtualization-App Agent  
    Event ID: 2010  
    Task Category: Orchestrator  
    Description: User settings for the settings location template "Microsoft Notepad" have been successfully uploaded to the settings storage location.  

2. Inspect the Microsoft-User Experience Virtualization-App Agent/Operational event log for any errors or warnings pertaining to the synchronization issue you are investigating.

3. Verify that location information is being updated as expected:

    1. Open a PowerShell window and navigate to the appropriate subfolder under %localappdata%\Microsoft\UEV\%computername%. For each monitored template, there will be a folder that corresponds to the application's TemplateID (as reported by the `Get-UEVTemplate` command). Beneath this folder, the most current settings package file will be contained in a folder named *Current*.

    2. Check the date modified information (type `dir` in PowerShell and note the **LastWriteTime** column, or navigate to the folder in Explorer and reference the Date Modified setting). This should roughly correspond to the time of the last modification of the application.

    3. Compare the modified date of the file and the file size with the current package in the user's Settings Storage Path.(Get-UevConfiguration).settingsstoragepath data.

4. Run simultaneous traces on both machines to determine the point of failure. For more information, see [How to enable debug logging in Microsoft User Experience Virtualization (UE-V)](enable-debug-logging.md).

5. If the UE-V synchronization method (`SynMethod`) is set to **OfflineFiles** (the default), verify that Client-Side Caching (also known as Offline Files) is enabled and working properly. See [Managing Files and Folders](/previous-versions/windows/it-pro/windows-xp/bb457104(v=technet.10)) for general information on how to implement and troubleshoot Client-Side Caching.

## General troubleshooting notes

- Packages will only be modified if monitored settings are changed. In order to assess whether a package is being replicated, make one or more changes to the application's settings and wait for replication changes.

- Packages are replicated only when the application is launched or exited. Exceptions to this rule are desktop background, Ease of Access, and Desktop settings ([Planning Which Applications to Synchronize with UE-V 1.0](/microsoft-desktop-optimization-pack/uev-v1/planning-which-applications-to-synchronize-with-ue-v-10)).

- Notepad is recommended as the preferred application for testing application data replication for UE-V because it is installed on all supported operating systems, is a relatively simple application, and familiar to most users. To test replication via Notepad, open Notepad.exe, click on **Format**, then click on **Font...**, modify the size of the font to the next available setting (that is, change **Size** from 11 to 12), then click **OK** to save settings. Exit Notepad to commit the changes. If necessary, repeat these steps on a second computer.
