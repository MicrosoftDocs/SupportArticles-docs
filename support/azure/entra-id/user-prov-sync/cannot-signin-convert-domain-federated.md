---
title: Users can no longer sign in after you run the Convert-MSOLDomaintoFederated command to convert an existing domain
description: Describes an issue in which users can no longer access Office 365, Azure, or Microsoft Intune after you run the Convert-MSOLDomaintoFederated command to convert an existing domain from standard authentication to federated authentication. Provides resolutions.
ms.date: 07/06/2020
ms.reviewer: dahans
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom: has-azure-ad-ps-ref
---
# Users can no longer sign in after you run the Convert-MSOLDomaintoFederated command to convert an existing domain

This article provides information about troubleshooting an issue in which users can no longer access Office 365, Azure, or Microsoft Intune after running the `Convert-MSOLDomaintoFederated` command to convert an existing domain from standard authentication to federated authentication.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2662960

## Symptoms

During setup of single sign-on (SSO) in a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune, you run the `Convert-MSOLDomaintoFederated` command to convert an existing domain from standard authentication to federated authentication. However, after you do this, users who are associated with that domain can no longer access the cloud service.

## Cause

This issue occurs if SSO isn't set up correctly or if the setup isn't completed.

> [!WARNING]
> It's a Microsoft best practice to always have at least one administrator user ID that's associated with the default domain so that administrative access to the organization isn't lost if SSO is compromised.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1: Troubleshoot SSO setup

Use this method only if all the following conditions are true:

- The problem isn't caused by a service outage.
- Immediately restoring user access isn't required.

To diagnose and troubleshoot SSO setup, see [Troubleshoot single sign-on setup issues in Office 365, Intune, or Azure](https://support.microsoft.com/help/2530569).

### Method 2: Revert the domain federation back to standard authentication if the AD FS server isn't available

Use this method only if all the following conditions are true:

- The problem is caused by a service outage that requires immediately restoring user access.
- The AD FS server is unavailable.

If these conditions are true, reset the authentication setting for the domain and for each user account to use standard authentication. To do this, follow these steps:

1. Start the Azure Active Directory module for Windows PowerShell. To do this, select **Start**, select **All** Programs, select **Windows Azure Active Directory**, right-click **Windows Azure Active Directory module for Windows PowerShell**, and then select **Run as administrator**.
2. To convert the domain, run the following commands in the order in which they are presented. Press Enter after you type each command.

    ```powershell
    $cred = Get-Credential
    ```  

    When you're prompted, enter cloud service administrator credentials that are not SSO-enabled.

    ```powershell
    Connect-MsolService -credential $cred
    ```  

    ```powershell
    Set-MSOLDomainAuthentication -Authentication Managed -DomainName <federated domain name>
    ```

    > [!NOTE]
    > In this command, the placeholder \<federated domain name> represents the name of the domain for which SSO isn't working.
3. For each user who has a user principal name (UPN) suffix that's associated with the domain, run the following command:

    ```powershell
    Convert-MSOLFederatedUser -UserPrincipalName <string>
    ```

    > [!NOTE]
    > In this command, the placeholder \<string> represents the value of the UPN for the user who is being converted.

## More information

> [!IMPORTANT]
> In scenarios in which the last Microsoft cloud services organization administrator is assigned the domain suffix of a federated domain and in which that administrator becomes SSO-enabled, subsequent AD FS failures will limit running the connect-MSOLService command and may prevent the remediation of SSO problems. It's a best practice recommendation that Microsoft cloud services organization administrators always keep at least one global administrator account that isn't SSO-enabled to allow for troubleshooting SSO problems by using the Azure Active Directory module for Windows PowerShell.

If this problem occurs, contact Microsoft Support to have the domain federation reversed temporarily so that the administrator (who is no longer SSO-enabled) can regain access to troubleshoot SSO-related problems.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
