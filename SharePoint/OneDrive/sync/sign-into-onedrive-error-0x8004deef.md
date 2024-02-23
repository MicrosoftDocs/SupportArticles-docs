---
title: Error 0x8004deef when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004deef.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 168842
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---
# Error 0x8004deef when signing in to OneDrive

## Symptoms

When you try to sign in to Microsoft OneDrive, you can't sign in, and you receive the following error message:  

> You don't have access to this service. For help, contact your IT department. (Error code: 0x8004deef)

## Cause

This issue might occur if your OneDrive account has a problem, such as a missing license or a credential mismatch.

## Resolution  

To resolve this issue, try the following methods.  

### Method 1: Make sure that the account has a valid license assigned

Depending on how your organization purchased OneDrive for users, you might no longer have a OneDrive license assigned, or the license might be expired.

**Note:** The following steps must be completed by a Microsoft 365 administrator in your organization.  

1. In the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home#/users), select **Users** > **Active users**.  
1. Select the user who is experiencing the issue.  
1. In the user pane, select **Licenses and apps**.  
1. Expand the **Licenses** section, and make sure that a OneDrive license is assigned to the user.  

> [!NOTE]
> If multiple users experience the issue, it means that the subscription might be expired. To check the subscription status, open the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home#/subscriptions), and then select **Billing** > **Your products**.  

### Method 2: Remove the cached account identities

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
2. Remove all subfolders in the following folders：

    - *%localappdata%/Microsoft/OneAuth*
    - *%localappdata%/Microsoft/IdentityCache*
