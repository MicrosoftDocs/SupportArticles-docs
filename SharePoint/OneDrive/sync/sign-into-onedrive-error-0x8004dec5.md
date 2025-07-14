---
title: Error 0x8004dec5 when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004dec5.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 167247
  - CSSTroubleshoot
ms.reviewer: salarson, prbalusu
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---
# Error 0x8004dec5 when signing in to OneDrive

## Symptoms

You can't sign in to Microsoft OneDrive, and you receive the following error code:
  
> Error Code: 0x8004dec5

## Cause

This is an authentication error that's usually caused by multiple cached identities.

## Resolution

To fix this issue, remove the cached Office account identities from the registry.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.  

1. Start Registry Editor.  
2. Locate the following registry subkey:  

   `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity`

3. Right-click **Identity**, and then select **Delete**.  

> [!NOTE]
> If you have [Shared Computer Activation](/deployoffice/troubleshoot-shared-computer-activation#Enabled) enabled, also remove the following registry subkey:
>
> `HKEY_USERS\<user_SID>\SOFTWARE\Microsoft\Office\16.0\Common\Identity`
>
> To get the SID of the currently signed-in user, run the `whoami /user` command at a command prompt. If the issue persists, go to [Clear prior activation information manually](/office/troubleshoot/activation/reset-office-365-proplus-activation-state#method-clear-prior-activation-information-manually), expand "Section A: Remove Office licenses & cached accounts," and then follow the steps in "Part 1: Remove previous Office activations" and "Part 3: Remove Office credentials stored in Windows Credential Manager."  

If you still experience the issue, follow these steps to remove the folders that contain cached credentials:

1. Sign out of OneDrive.
2. Remove all folders in the following locations:  

    - *%localappdata%/Microsoft/OneAuth*
    - *%localappdata%/Microsoft/IdentityCache*
