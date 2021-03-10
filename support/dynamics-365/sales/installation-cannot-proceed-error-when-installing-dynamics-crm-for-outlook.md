---
title: Installation cannot proceed when installing CRM for Outlook
description: Installation cannot proceed this error may occur when installing Microsoft Dynamics CRM for Microsoft Office Outlook. Provides a resolution.
ms.reviewer: v-anlang, ehagen, mmaasjo
ms.topic: troubleshooting
ms.date: 
---
# "Installation cannot proceed" error when installing Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a resolution for the error **Installation cannot proceed** that may occur when installing Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2004114

## Symptoms

You receive the following error when you install Microsoft Dynamics CRM for Microsoft Office Outlook:

> Installation cannot proceed: Setup cannot continue because a pending restart is required. Restart the computer and then try running Setup again.

## Cause

The `RunOnce` registry key exists.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756/).

Check the crm40setup.log to identify the registry key that causes the issue. The crm40setup.log is located in %appdata%\Microsoft\MSCRM\Logs. Once you have found the registry key, you can delete the registry key with the following steps:

1. Select **Start**, select **Run** and type *regedit*, and then select **OK**.
2. Locate the registry key listed in the Setup Log. For example, the registry key is `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce`.
3. Right-click **RunOnce**, and select **Delete**.

## More information

Other common registry keys that cause this error:

- HKEY_CURRENT_USER\Software\Microsoft\Windwos\CurrentVersion\RunOnce
- HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce
