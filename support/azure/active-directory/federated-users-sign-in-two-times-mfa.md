---
title: Federated users in Azure Active Directory may have to sign in two times before being prompted for MFA
description: Discusses an issue in which federated users in Azure Active Directory must sign in two times before they can run MFA.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# Federated users in Azure Active Directory may have to sign in two times before being prompted for MFA

This article discusses an issue in which federated users in Azure Active Directory must sign in two times before they can run MFA.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4037806

## Symptoms

Consider the following scenario:

- You have an Azure Active Directory (Azure AD) tenant in which users are federated through Active Directory Federated Services (AD FS).
- In this tenant, Azure MFA Server or a third-party MFA provider is deployed in AD FS.

In this scenario, users may be forced to sign in by providing their user name and password two times before they are prompted for multi-factor authentication (MFA) and can complete the logon.

## Cause

If the **MsolDomainFederationSettings -SupportsMFA** value is set to **$true** and the **-PromptLoginBehavior** value is set to **TranslateToFreshPasswordAuth**, Azure AD sends the MFA request to the Identity Provider for step-up authentication. Azure AD also asks for a fresh user login. This is accomplished by sending the following parameters to AD FS:

`wauth=http://schemas.microsoft.com/claims/multipleauthn`  
 `wfresh=0`  

When this occurs, user is prompted a second time for their user name and password regardless of whether they just logged in. Users are prompted for MFA only after they enter their credentials a second time.

## Resolution

To resolve this issue, you must configure Azure AD to let AD FS natively handle this request by changing the **-PromptLoginBehavior** setting to **NativeSupport**. To do this, follow these steps:

> [!IMPORTANT]
> Your AD FS deployment must be running on Windows Server 2016 or Windows Server 2012 R2, and must have the July 2016 update [KB 3172614](https://support.microsoft.com/help/4009451/windows-8-1-windows-server-2012-r2-update-kb3172614) installed.

1. Run the following `Connect` command to sign in to your Azure AD administrator account:

    ```powershell
    Connect-Msolservice
    ```

    > [!NOTE]
    > Run this command every time that you start a new session.

2. Configure Azure AD to run federated user authentication by using the **prompt=login** behavior. This prevents the user from having to begin a new authentication. For example, run a command such as the following that includes your tenant-specific information:

    ```powershell
    Set-MsolDomainFederationSettings -DomainNameyour_domain_name-PreferredAuthenticationProtocol <current auth setting such as WsFed> -SupportsMfa $True -PromptLoginBehavior NativeSupport
    ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
