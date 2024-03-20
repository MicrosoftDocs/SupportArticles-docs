---
title: Cannot create new user without Exchange Online license
description: Discusses an issue in Microsoft 365 in which you receive an error message when you create a new user without an Exchange Online license. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.reviewer: tasitae, v-six
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# To assign a license that contains Outlook Customer Manager error when creating a new user

> [!NOTE]
> Outlook Customer Manager has been retired in June 2020. You won't be able to use Outlook Customer Manager after June 2020, but you'll be able to export or delete your data.).

_Original KB number:_ &nbsp; 3209493

## Symptoms

In Microsoft 365, when you try to create a new user without an Exchange Online license, you receive the following error message:

> To assign a license that contains Outlook Customer Manager, you must also assign one of the following service plans: Exchange Online (Plan 2), Exchange Online (Plan 1).

## Cause

This issue occurs because Outlook Customer Manager is enabled for the new user. However, Outlook Customer Manager is dependent on the user also having an Exchange Online license.

## Workaround

To work around this issue, disable Outlook Customer Manager and Exchange Online for the Microsoft 365 account. To do this, follow these steps.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../Exchange/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).
2. Run the following command to retrieve the Microsoft 365 AccountSkuID:

    ```powershell
    Get-MsolAccountSku
    ```

3. Run the following command, where *<SKU_ID>* is the AccountSkuID that you obtained in step 2:

    ```powershell
    $LO = New-MsolLicenseOptions -AccountSkuId <SKU_ID> -DisabledPlans "EXCHANGE_S_STANDARD", "O365_SB_Relationship_Management"
    ```

4. Run the following command, where *<TARGET_USER_ADDRESS>* is the email address of the user.

    ```powershell
     Set-MsolUserLicense -UserPrincipalName <TARGET_USER_ADDRESS> -LicenseOptions $LO
    ```

 Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
