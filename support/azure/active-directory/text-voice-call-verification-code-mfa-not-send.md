---
title: You don't receive a text or voice call that contains the verification code for Azure Active Directory Multi-Factor Authentication
description: Discusses an issue in which an Office 365 admin who has Azure Active Directory (Azure AD) Multi-Factor Authentication enabled doesn't receive a text or voice call that contains the verification code. Therefore, the admin can't sign in to a work or school account.
ms.date: 07/06/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# You don't receive a text or voice call that contains the verification code for Azure AD Multi-Factor Authentication

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2834956

## Symptoms

Consider the following scenario:

- You're a global admin who has Microsoft Azure AD Multi-Factor Authentication (MFA) enabled
- You don't receive the text message or voice call that contains your verification code.

In this scenario, you can't sign in to your work or school account, such as Office 365, Azure, or Microsoft Intune.

## Resolution

To fix this problem, follow these steps:

1. If you have set up other options for security verification, select **Other verification options**, and then try again by selecting a different option. Also, make sure that your phone numbers are correct in your user account settings.
2. Ask another global admin to confirm whether your phone numbers are set correctly in your user settings. If steps 1 and 2 don't resolve the problem, your user account may be blocked from using Azure AD MFA. To check whether your user account is blocked, ask a global admin for your Microsoft cloud service to perform the following steps:

If you have an Azure AD MFA or Azure Active Directory Premium subscription

1. Go to the [Azure portal](https://portal.azure.com), and then open **Azure Active Directory** .
2. If you want to change the default active directory, click **Manage tenants**, choose the active directory, and then click **Switch**.
3. Choose **Users**, open the profile of the user that has the problem.
4. Check whether the **Block sign in** is enabled. If yes, disable the option.

If you have Office 365 and don't have an Azure AD MFA or Azure Active Directory Premium subscription, contact Office 365 Support.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
