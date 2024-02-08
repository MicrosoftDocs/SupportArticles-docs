---
title: Microsoft Entra Administrators can't reset their own password from cloud
description: "Troubleshoot error SSPR_009: You can't reset your own password because password reset isn't turned on for your organization."
ms.date: 02/11/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
keywords:
#Customer intent: As a user with a Microsoft Entra Administrator role, I want to avoid SSPR_009 errors so that I can reset my own password from the cloud.
---
# Troubleshoot error SSPR_009: Synchronized Microsoft Entra Administrator can't reset password from the cloud

This article explains how to troubleshoot a password reset error that occurs when a synchronized user who has a Microsoft Entra Administrator role tries unsuccessfully to reset their password.

This scenario occurs after the user visits the sign-in page at <https://login.microsoftonline.com> and selects **Can't access your account?**, **Forgot my password**, or **reset it now**. Then, the browser redirects the user to the self-service password reset (SSPR) page at <https://passwordreset.microsoftonline.com> to start the SSPR process. This process requires that the user enter a "captcha" code. If the operation is successful, password writeback sends a password reset request for the user to an on-premises Active Directory domain. Simultaneously, SSPR sets the new password in Microsoft Entra ID. If the operation is unsuccessful, an "SSPR_009" error is returned instead. If the error occurs, use this article to fix the problem.

## Symptoms

After a synchronized user tries unsuccessfully to reset a password by entering a captcha code, the browser displays the following error message:

> You can't reset your own password because password reset isn't turned on for your organization.
>
> SSPR_009: Your organization hasn't turned on password reset. If you're an administrator, you can get more information from the ["How to enable password reset"](/azure/active-directory/authentication/tutorial-enable-sspr) article. If you're not an administrator, you can provide this information when you contact your administrator.

> [!NOTE]
> This scenario occurs only for Microsoft Entra users who have a Microsoft Entra Administrator role assigned to them. The password change or reset flow works as expected for standard accounts.

## Cause

SSPR for Administrators isn't enabled on the tenant. SSPR for Administrators (SSPR-A) was the first implementation of SSPR. After SSPR for Users (SSPR-U) was introduced, users could have two separate configurations.

The old SSPR-A implementation is used when a Microsoft Entra account has an admin role, such as Global Administrator or Billing Administrator. However, the SSPR management on the Azure portal is for SSPR-U only. Therefore, SSPR-A might not be enabled on the tenant.

## Solution

Enable SSPR-A on the tenant by running the [Set-MsolCompanySettings](/powershell/module/msonline/set-msolcompanysettings) PowerShell cmdlet, as follows:

```powershell
Set-MsolCompanySettings -SelfServePasswordResetEnabled $true
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
