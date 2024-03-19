---
title: Error (This user can't sign in because this account is currently disabled) when syncing settings of Windows 10
description: "Describes an issue in which (Event ID 6065:80070533 This user can't sign in because this account is currently disabled) is logged when Windows 10 settings fail to sync."
ms.date: 06/08/2020
ms.reviewer: cpuckett
ms.service: active-directory
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Error when Windows 10 devices settings fail to sync: This user can't sign in because this account is currently disabled

This article describes an issue in which error "Event ID 6065:80070533 This user can't sign in because this account is currently disabled" is logged when Windows 10 settings fail to sync.

_Original product version:_ &nbsp; Windows 10, version 1803, version 1709, version 1703, version 1511, version 1607, all editions  
_Original KB number:_ &nbsp; 3193791

## Symptoms

You have enabled **Enterprise State Roaming** in the Microsoft Entra admin center and on some Windows 10 clients. Any supported settings for sync, such as the desktop background or the task bar position, do not sync between devices for the same user.

Additionally, Event ID 6065 is logged in the Microsoft-Windows-SettingSync/Debug event log:

> Log Name: Microsoft-Windows-SettingSync/Debug  
Source: Microsoft-Windows-SettingSync  
Date: \<date and time>  
Event ID: 6065  
Task Category: None  
Level: Error  
Keywords: User: \<User SID>  
Computer: WIN10DESKTOP  
Description: shell\roaming\cloudsync\cloudsyncengine\cloudsyncengine.cpp(990)\SettingSyncHost.exe!00007FF701A2A8C2: (caller: 00007FF701A2A3D9) ReturnHr\[PreRelease](17) tid(1060) 80070533 This user can't sign in because this account is currently disabled. CallContext:[\AttemptSyncActivity]

## Cause

The tenant has not been provisioned with the RMSBASIC subscription. This happens automatically when **Enterprise State Roaming** is enabled in the Microsoft Entra admin center and is used to encrypt the synchronized data. If `AllowAdHocSubscriptions` is set to **False** on the tenant, this configuration can prevent the tenant from being provisioned with the RMSBASIC subscription.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Resolution

### Verify RMSBASIC subscription is enabled on the tenant

1. Open PowerShell and sign in to Microsoft Entra ID using your Microsoft Entra credentials. The first line will prompt you for your credentials. The second line connects to Microsoft Entra ID.

    ```powershell
    $msolcred = get-credential connect-msolservice -credential $msolcred
    ```

2. Run the following cmdlet to see all the SKUs that the company owns.

    ```powershell
    Get-MsolAccountSku
    ```

3. If RMSBASIC is listed, as in the example output below, you do not need to proceed with the rest of the steps in this article.

    |AccountSkuId|ActiveUnits|WarningUnits|ConsumedUnits|
    |---|---|---|---|
    |---------------|------------|---------------|-----------------|
    |tenantname:ENTERPRISEPACK|25|0|14|
    |tenantname:INTUNE_A|25|0|23|
    |tenantname:AAD_PREMIUM|100|0|21|
    |tenantname:RIGHTSMANAGEMENT_ADHOC|1000|0|18|
    |tenantname: RMSBASIC|1000|0|18|

4. If RMSBASIC is not present, as in the example output below, proceed with the steps in the next section.

    |AccountSkuId|ActiveUnits|WarningUnits|ConsumedUnits|
    |---|---|---|---|
    |---------------|------------|---------------|-----------------|
    |tenantname:ENTERPRISEPACK|25|0|14|
    |tenantname:INTUNE_A|25|0|23|
    |tenantname:AAD_PREMIUM|100|0|21|
    |tenantname:RIGHTSMANAGEMENT_ADHOC|1000|0|18|

### Verify AllowAdHocSubscriptions is set to "True" on the tenant

The tenant cannot be provisioned with the RMSBASIC subscription if `AllowAdHocSubscriptions` is set to **False** on the tenant. Use these steps to verify the configuration of `AllowAdHocSubscriptions` and temporarily set it to **True** to obtain the RMSBASIC subscription.

1. Open PowerShell and sign in to Microsoft Entra ID using your Microsoft Entra credentials. The first line will prompt you for your credentials. The second line connects to Microsoft Entra ID.

    ```powershell
    $msolcred = get-credential connect-msolservice -credential $msolcred
    ```

2. Run the following cmdlet to determine if your tenant has `AllowAdHocSubscriptions` set to **True** or **False**.

    ```powershell
    Get-MsolCompanyInformation | fl AllowAdHocSubscriptions
    ```

3. If `AllowAdHocSubscriptions` is set to **True**, you do not need to proceed with rest of the steps. If it is False, you can run the following command to enable `AllowAdHocSubscriptions`. You can set it back to **False** in a later step.

    ```powershell
    Set-MsolCompanySettings -AllowAdHocSubscriptions $true
    ```

4. In the Microsoft Entra admin center, disable and re-enable **Enterprise State Roaming**. See the **Verify USERS MAY SYNC SETTINGS AND ENTERPRISE APP DATA is enabled on the tenant** section.
5. Run the `Get-MsolAccountSku` cmdlet to see if the RMSBASIC subscription has been added:

    ```powershell
    Get-MsolAccountSku
    ```

### Verify USERS MAY SYNC SETTINGS AND ENTERPRISE APP DATA is enabled on the tenant

After obtaining a Premium Microsoft Entra subscription, follow these steps to enable **Enterprise State Roaming**:

1. Sign in to the Azure classic portal.
2. On the left side, select **ACTIVE DIRECTORY**, and then select the directory for which you want to enable **Enterprise State Roaming**.
3. Go to the **CONFIGURE** tab.
4. Scroll down the page, look for **USERS MAY SYNC SETTINGS AND ENTERPRISE APP DATA**, and verify that **ALL** or **SELECTED** is selected.
5. If **All** or **SELECTED** is already selected, select None, save, and go back to the previously selected **ALL** or **SELECTED** with the original SG option, and then save again. For a reference with screenshots, see [Enable Enterprise State Roaming in Microsoft Entra ID](/azure/active-directory/devices/enterprise-state-roaming-enable).

### (Optional) Set AllowAdHocSubscriptions to "False" on the tenant

If you want to set AllowAdHocSubscriptions back to False, use this cmdlet after the RMSBASIC subscription has been provisioned on the tenant:

```powershell
Set-MsolCompanySettings -AllowAdHocSubscriptions $false
```

## More information

- [Azure Active Directory PowerShell Module](/powershell/module/MSOnline/?view=azureadps-1.0&redirectedfrom=msdn&preserve-view=true)
- [Get-MsolAccountsku](/powershell/module/msonline/get-msolaccountsku?view=azureadps-1.0&preserve-view=true)
- [Set-MsolCompanySettings](/powershell/module/msonline/set-msolcompanysettings?view=azureadps-1.0&preserve-view=true)
- [How administrators can control the accounts created for RMS for individuals](/azure/information-protection/rms-for-individuals)
- [50,000 seats are assigned to the RIGHTSMANAGEMENT_ADHOC SKU in your Office 365 organization](https://support.microsoft.com/help/2925380)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
