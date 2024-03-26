---
title: We don't recognize this user ID or password
description: Describes an issue in which a user gets a We don't recognize this user ID or password error message when trying to sign in to the Microsoft 365 portal. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: willfid, v-chblod
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Azure Active Directory
  - Microsoft 365
ms.date: 03/31/2022
---

# "We don't recognize this user ID or password" error when a user tries to sign in to the Microsoft 365 portal

## Problem 

When users try to sign in to the Microsoft 365 portal, they receive the following error message:

```output
We don't recognize this user ID or password

Make sure you typed the user ID assigned to you by your organization. It usually looks like someone@example.com or someone@example.onmicrosoft.com. And check to make sure you typed the correct password.This issue occurs if the wrong user ID or password is entered.
```

## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Scenario: Incorrect user ID or password

1. Make sure that the correct user ID is entered.

   **Note** The user ID resembles jsmith@contoso.com or jsmith@contoso.onmicrosoft.com. If you're not sure what your user ID is, contact your administrator.   
2. Make sure that the correct password is entered. 

   **Note** If you're copying and pasting the password, make sure that you don't include spaces before or after the password characters.   

### Scenario: Forgot user ID or password

See [Forgot password to sign in to Microsoft 365, Intune, or Azure](https://support.microsoft.com/help/2606983).

### Scenario: Your organization is using password synchronization together with the Azure Active Directory Sync tool

Perform one of the following actions:

- Have the users change their computer password.
- Reset the computer password for the users. When you reset the users' password, make sure that the **User must change password at next logon** check box isn't selected.

After Active Directory synchronization occurs, the users' computer password in the on-premises Active Directory Domain Services (AD DS) environment is synced to Microsoft Entra ID. The users can then log on to the computer, and sign in to Microsoft 365 by using the same password.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
