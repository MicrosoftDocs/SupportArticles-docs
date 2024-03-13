---
title: The user name or password is incorrect error when running Azure Active Directory Sync tool Configuration Wizard
description: Describes a problem that occurs when you run the Azure Active Directory Sync tool Configuration Wizard, and event ID 611 is logged to the Application log in Event Viewer. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: arrenc, willfid
ms.service: active-directory
ms.subservice: authentication
---
# Error when you run the Azure Active Directory Sync tool Configuration Wizard: The user name or password is incorrect

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2965539

## Symptoms

When you run the Azure Active Directory Sync tool Configuration Wizard, you receive the following error message:

> The user name or password is incorrect.

:::image type="content" source="media/user-name-pwd-incorrect/user-name-pwd-incorrect-error.png" alt-text="Screenshot of the error message in the Windows Azure Directory Sync tool Configuration Wizard." border="false":::

Additionally, event ID 611 is logged to the Application log in Event Viewer:

> Event ID: 611  
> Level: Information  
> Source: Directory Synchronization  
> Description:  
Password synchronization failed for domain: `ChildDomain.Contoso.Com`. Details:
Microsoft.Online.PasswordSynchronization.SynchronizationManagerException: Unable to open connection to domain: `ChildDomain.Contoso.Com`. Error: An exception occurred while attempting to locate a domain controller for domain `ChildDomain.Contoso.Com`. ---> Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsCommunicationException: An exception occurred while attempting to locate a domain controller for domain `ChildDomain.Contoso.Com`. ---> System.Security.Authentication.AuthenticationException: The user name or password is incorrect.  
> ---> System.Runtime.InteropServices.COMException: The user name or password is incorrect.

## Cause

This problem occurs if the enterprise admin account credentials that are specified in the wizard are not unique in the Active Directory forest. Password mismatches between two or more identically named accounts in multi-domain forests can cause the wizard to fail.

Consider the following example scenario:

- Contoso\admin is the enterprise admin account that's specified in the Azure Active Directory Sync tool Configuration Wizard.
- Contoso\admin and Fabrikam\admin are two accounts that have the same name but that exist in different domains.
- Each account has a different password.

In this scenario, the password of Contoso\admin is used for all domains in the Active Directory forest during the configuration process. For example, if the password is "Password1," "Password1" is used for Fabrikam\admin. This causes the wizard to fail.

## Resolution

To resolve this problem, do one of the following:

- Create an enterprise admin account in which the value of the sAMAccountName attribute is unique and does not exist in each domain.
- Update the passwords of all accounts that have identical names so that the password is the same for all those accounts.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
