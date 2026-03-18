---
title: Application was unable to start correctly error when accessing Microsoft 365 apps
description: Describes an error message that appears when you try to open Microsoft 365 apps, and provides a resolution.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:  
  - sap:Office Suite (Issues that affect all apps)\Errors & Crashing
  - CSSTroubleshoot
  - CI 8557
ms.author: meerak
ms.reviewer: gausin, v-lisalozano
search.appverid: 
  - MET150
appliesto:
  - Microsoft 365 apps
ms.date: 03/19/2026
---

# "Application was unable to start correctly" error when accessing Microsoft 365 apps

## Summary

This article discusses an error message that appears when you try to open Microsoft 365 apps. It explains the cause of the error, and provides a resolution to fix the error.

## Symptoms

You're running Office version 16.0.14827.20220 on your computer, or you've installed Microsoft 365 apps by using an Office Click-to-Run build that uses App-V subsystems. When you open any Microsoft 365 app, the app doesn't start, and you see the following error message:  

"The application was unable to start correctly (0xc0000715)."

You also see the following event logged in the system log or added as an entry in the Click-to-Run log:

"directory_entry::status: The symbolic link cannot be followed because its type is disabled."

## Cause

This error occurs because symbolic link evaluation is disabled on your computer. The Office Click-to-Run service uses symbolic links when it deploys updates and enables streamed application delivery. If symbolic link evaluation is blocked by Group Policy settings or by settings for the [`fsutil` command](/windows-server/administration/windows-commands/fsutil-behavior), Office can't load the required components.

To verify that symbolic link evaluation is disabled, run the following command in Windows PowerShell on your computer:

`fsutil behavior query SymlinkEvaluation`  

You'll see an output that resembles the following example:

`NOTE: SymlinkEvaluation is currently controlled by group policy.

Showing current group policy state:

Local-to-local symbolic link evaluation is: DISABLED  

Local-to-remote symbolic link evaluation is: DISABLED  

Remote-to-local symbolic link evaluation is: DISABLED  

Remote-to-remote symbolic link evaluation is: ENABLED`

This output indicates that symbolic link evaluation is blocked by Group Policy settings. If you don't see the message about Group Policy, then the settings for the `fsutil` command might be set to disable symbolic link evaluation.

## Resolution

Depending on how symbolic link evaluation is controlled, use one of the following options to enable all types of symbolic link evaluation for the file paths on your local computer. Then, restart the Office Click-to-Run service.  

Also, make sure that the antivirus and endpoint protection tools on your computer don't override symbolic link settings.

### Option 1: Update the Group Policy settings

If symbolic link evaluation is disabled by Group Policy, enable it by following these steps:

1. In the Windows Search bar, enter `gpedit.msc` to open the Local Group Policy Editor.

1. Select **Computer Configuration** > **Administrative Templates** > **System** > **Filesystem**.

1. Select **Selectively allow the evaluation of a symbolic link**, and then select **Edit policy setting**.

1. Select **Enabled**, and then select the checkboxes for the options that are not enabled:

   - **Local Link to Local Target**
   - **Local Link to a Remote Target**
   - **Remote Link to Remote Target**
   - **Remote Link to Local Target**

1. Select **Apply**, and then select **OK**.

1. Close the Local Group Policy Editor.

### Option 2: Use the fsutil command

If symbolic link evaluation is controlled by the settings for the `fsutil` command, use these steps to enable it.  

Run the following commands in an elevated Command Prompt window:

- `fsutil behavior set SymlinkEvaluation L2L:1`  
- `fsutil behavior set SymlinkEvaluation L2R:1`  
- `fsutil behavior set SymlinkEvaluation R2L:1`

### Restart the Office Click-to-Run service

After you enable symbolic link evaluation, restart the service.

Run the following commands in an elevated Command Prompt window:

1. `net stop ClickToRunSvc`
1. `net start ClickToRunSvc`
