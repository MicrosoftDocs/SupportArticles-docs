---
title: A user with this name could not be found when resetting a password
description: Describes an issue that occurs when you try to reset a password for a user in Microsoft 365. A resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "A user with this name could not be found" when resetting a password for a user in Microsoft 365

## Problem

When you try to reset a password for a user in Microsoft 365, you receive the following message:

**A user with this name could not be found. They may have been deleted.**

## Solution

To resolve this issue, use Microsoft Azure Active Directory module for Windows PowerShell to set the user principal name (UPN) to the default domain. Then, change the user principal name back to use the vanity domain. To do this, follow these steps:

1. Start Azure Active Directory module for Windows PowerShell, and connect to Microsoft Entra ID.

   > [!NOTE]
   > For more info about Azure Active Directory module for Windows PowerShell, go to the following Microsoft website: [Microsoft Entra Cmdlets](/previous-versions/azure/jj151815(v=azure.100)).

1. Change the UPN of the user to the default domain. To do this, run the following command:

   ```powershell
   Set-MsolUserPrincipalName -UserPrincipalName [ExistingUPN] -NewUserPrincipalName [NewUPN]
   ```

   For example, use this command:

   ```powershell
   Set-MsolUserPrincipalName -UserPrincipalName johnsmith@contoso.com -NewUserPrincipalName johnsmith@contoso.onmicrosoft.com
   ```

1. Change the UPN of the user back to the original domain. To do this, run the following command: 

   ```powershell
   Set-MsolUserPrincipalName -UserPrincipalName [ExistingUPN] -NewUserPrincipalName [NewUPN]
   ```

   For example, use this command:

   ```powershell
   Set-MsolUserPrincipalName -UserPrincipalName johnsmith@contoso.onmicrosoft.com -NewUserPrincipalName johnsmith@contoso.com
   ```
1. Reset the password again.

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
