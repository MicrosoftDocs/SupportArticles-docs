---
title: Can't delete a directory through the Azure Management Portal
description: Fixes an issue in which you can't delete a directory from the Microsoft Entra extension.
ms.date: 05/22/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: domain-services
ms.custom: has-azure-ad-ps-ref
---
# Can't delete a directory through the Azure Management Portal

This article can help you fix an issue in which you can't delete a directory from the Microsoft Entra extension in Azure portal.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 2967860

## Symptoms

You can't delete a directory from the Microsoft Entra extension through the Azure Management Portal. Additionally, you receive one of the following messages:

> You are signed in as a user for whom \<Your Company Name> is the home directory.
  
> Delete all users except yourself.  

> Directory has one or more subscriptions to Microsoft Online Services.

> Directory has one or more Azure subscriptions.  

> Directory has one or more applications.  

> Directory has one or more Multi-Factor Authentication providers.  

> Directory is a "Partner" directory.  

> Directory contains one or more applications that were added by a user or administrator.  

## You are signed in as a user for whom \<Your Company Name> is the home directory

Make sure that your directory has no home users, and then delete the directory. The user who deletes this directory must be a guest user, must be homed in another directory, and must be a global admin of the directory that is being deleted.

For example, your directory has the domains `contoso.onmicrosoft.com` and `contoso.com`. There must be no users who have these domains in your directory. The guest user may be a Microsoft account or may be homed from another directory such as `fabrikam.onmicrosoft.com`.

To learn more about how to add a guest user, see [Create or edit users](/previous-versions/azure/hh967632(v=azure.100)). When you create this user in your directory, select one of the following:

- A user who has an existing Microsoft account
- A user in another Microsoft Entra directory

This user must also be an admin of your Azure subscription.

## Delete all users except yourself

Do what the message tells you to do. That is, delete all users except yourself.

## Directory has one or more subscriptions to Microsoft Online Services

Do you have one of the following subscriptions?

- Office 365
- Intune
- Dynamics
- Microsoft Azure Information Protection (previously known as Microsoft Azure Rights Management)
- Microsoft Entra ID P1 or P2

If you have one of these subscriptions, contact [billing and subscriptions support](https://support.office.com/).

Do you have one of the following subscriptions?

- Microsoft Enterprise Mobility + Security
- Microsoft Entra Basic

If you have one of these subscriptions, contact your Volume Licensing partner to cancel the subscription.

## Directory has one or more Azure subscriptions

If you have an Azure subscription, make sure that your Azure subscription is not linked to another directory. To do this, follow these steps:

1. In the navigation pane, select **Settings**, and select **Subscriptions**.
2. Notice the following information:

    - Subscription
    - Account administrator
    - Directory
3. If the directory that you are trying to delete is listed under any of the subscriptions, the account administrator has to sign in and change the directory that is associated with the subscription. To do this, the account administrator should follow these steps:

    1. On this screen, select **Edit Directory**.
    2. In the Edit Directory window, select the Directory list, and then change the directory.

  > [!NOTE]
  > If no other directory is available as an option, the account administrator must be a global admin of another directory or must create a new directory. You will see the Edit Directory option if the account is a Microsoft account. Organizational accounts can't change the directory. Therefore, the directory can't be deleted.

## Directory has one or more applications

To learn how to remove applications from your directory, read [Adding, updating, and removing an application](/azure/active-directory/develop/quickstart-register-app)

You may also have to remove additional service principals. Use Azure Active Directory module for Windows PowerShell to remove all service principals. To do this, follow these steps:

1. Open Azure Active Directory module for Windows PowerShell.
2. Connect to the Microsoft Online Service.
3. Run the following command:

    ```powershell
    Get-MsolServicePrincipal | Remove-MsolServicePrincipal
    ```

    > [!NOTE]
    > You may receive an error when you remove some service principals. These principals can't be removed. However, this does not prevent you from deleting your directory. The error that you receive may resemble the following:
    >
    > Remove-MsolServicePrincipal : Invalid value for parameter. Parameter Name: appPrincipalId.

## Directory has one or more Multi-Factor Authentication providers

Remove Azure multi-factor authentication providers for your directory. For information about how do this, see [Plan an Azure Multi-Factor Authentication deployment](/azure/active-directory/authentication/howto-mfa-getstarted).

## Directory is a 'Partner' directory

Contact Microsoft Partner Support at [Microsoft Partner Site](https://partner.microsoft.com).

## Directory contains one or more applications that were added by a user or administrator

To fix this issue, follow the steps in ["Cannot delete" error when you try to delete a B2C directory in Microsoft Entra ID](https://support.microsoft.com/help/3112170).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
