---
title: Can't use Azure Multi-Factor Authentication to sign in to cloud services after you lose your phone or the phone number changes
description: Describes an issue in which you don't receive the verification code for Azure Multi-Factor Authentication because you lost your phone or your phone number has changed. Therefore, you can't sign in to your cloud services account.
ms.date: 07/06/2020
ms.reviewer: willfid, willfid
ms.service: entra-id
ms.subservice: authentication
---
# Can't use Azure Multi-Factor Authentication to sign in to cloud services after you lose your phone or the phone number changes

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2834954

## Symptoms

Assume that you're a Microsoft cloud services admin who has Microsoft Azure Multi-Factor Authentication enabled. If you lose your phone or your phone number has changed, you can't sign in to your cloud services account (such as Office 365, Azure, or Microsoft Intune) because you didn't receive the text message or voice call from the Multi-Factor Authentication service.

## Resolution

Ask another cloud services admin to reset your Multi-Factor Authentication settings. To do this, the admin should follow these steps:

1. Sign in to the cloud service portal as an admin.
2. Go to [https://account.activedirectory.windowsazure.com/usermanagement/multifactorverification.aspx](https://account.activedirectory.windowsazure.com/usermanagement/multifactorverification.aspx).
3. Select the check box for the admin account whose Multi-Factor Authentication settings you want to reset.
4. Select **Manage user settings**.
5. Select the **Require selected users to provide contact methods again** check box, and then select **Save**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
