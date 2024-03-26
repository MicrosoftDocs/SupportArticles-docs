---
title: Error (Federation service identifier specified in the AD FS 2.0 server is already in use) when you try to set up another federated domain in Office 365, Azure, or Intune
description: Discusses a scenario in Office 365, Azure, or Microsoft Intune  in which you receive an error message when you try to run the new-MSOLFederatedDomain command or the convert-MSOLDomainToFederated command to set up a second federated domain on an AD FS server. Provides a resolution and a workaround.
ms.date: 06/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Error when you try to set up another federated domain in Office 365, Azure, or Intune: Federation service identifier specified in the AD FS 2.0 server is already in use

This article provides information about resolving an issue in which you receive an error message when running the `New-MSOLFederatedDomain` command or the `Convert-MSOLDomainToFederated` command using Azure Active Directory module for Windows PowerShell.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2618887

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Symptoms

In a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune, you can't set up a second federated domain on an Active Directory Federation Services (AD FS) server. When you use the Azure Active Directory module for Windows PowerShell to run the `New-MSOLFederatedDomain` command or the `Convert-MSOLDomainToFederated` command, you receive the following error message:

> The federation service identifier specified in the Active Directory Federation Services 2.0 server is already in use. Please correct this value in the AD FS 2.0 Management console and run the command again.

## Cause

The Microsoft Entra authentication system requires a unique federation brand uniform resource identifier (URI) for each federated domain. By default, AD FS uses a global value for all federated trusts. When you try to federate a second domain in a scenario where a federated trust already exists, the request fails because the URI is already being used.

## Resolution

To resolve the issue, you must use the `-supportmultipledomain` switch to add or convert every domain that's federated by the cloud service. This includes federated domains that already exist.

### Step 1: Install Update Rollup 1 for AD FS 2.0

On each node of the AD FS 2.0 Federation Service farm, download and install Update Rollup 1 for AD FS 2.0. For more information about how to download and install Update Rollup 1 for AD FS 2.0, see [Description of Update Rollup 1 for Active Directory Federation Services (AD FS) 2.0](https://support.microsoft.com/help/2607496).

> [!NOTE]
> This update requires a restart of the computer. If you do not restart the computer, you will experience the issue ["Sorry, but we're having trouble signing you in" and "8004789A" error when a federated user tries to sign in to Office 365, Azure, or Intune](https://support.microsoft.com/help/2635357).

### Step 2: Check that the `Update-MSOLFederatedDomain` command can be run successfully against the AD FS environment

1. Select **Start** > **All Programs** > **Windows Azure Active Directory**, right-click **Windows Azure Active Directory module for Windows PowerShell** and select **Run As Administrator**.
2. At the command prompt, run the following commands in the order in which they are presented. Press **Enter** after each command.

    ```powershell
    Connect-MSOLService
    ```  

    > [!NOTE]
    > When you are prompted, **enter** your cloud service global administrator credentials.

    ```powershell
    Set-MSOLADFSContext -Computer <AD FS 2.0 server name>
    ```

    > [!NOTE]
    > In this command, \<AD FS 2.0 server name> is the computer name of a node in the AD FS Federation Service farm.

    ```powershell
    Update-MSOLFederatedDomain -DomainName <Federated Domain Name>
    ```

    > [!NOTE]
    > In this command, \<Federated Domain Name> is the name of the domain that's already federated with Microsoft Entra ID for single sign-On (SSO).

3. If the `Update-MSOLFederatedDomain` command is successful and you do not receive error messages, go to step 3 to remove the federated trust from the AD FS server.

### Step 3: Update the federated trust on the AD FS server

> [!WARNING]
> The following steps should be planned carefully. Users for which SSO functionality is enabled in the federated domain will be unable to authenticate between the completion of steps C and D. If the `Update-MSOLFederatedDomain` command test in step 2 was not completed successfully, step D of this procedure will not finish correctly. Federated users will be unable to authenticate until the `Update-MSOLFederatedDomain` command can be run successfully.

1. Log on to the console of the AD FS server, select **Start** > **All Programs** > **Administrative Tools**, and then select A**D FS (2.0) Management**.
2. In the left navigation pane, select **AD FS (2.0)**, select **Trust Relationships**, and then select **Relying Party Trusts**.
3. In the pane on the right side, delete the Microsoft Office 365 Identity Platform entry.
4. Re-create the deleted trust object by using the `-supportmultipledomain` switch. In the PowerShell window that's open from step 1C, run the following command, and then press **Enter**:

    ```powershell
    Update-MSOLFederatedDomain -DomainName <Federated Domain Name> -supportmultipledomain
    ```

> [!NOTE]
> In this command, \<Federated Domain Name> is the name of the domain that's already federated with the cloud service for SSO.

### Step 4: Use the `-supportmultipledomain` switch to add or convert additional federated domains

After you update the existing trust in step 2, use the -supportmultipledomain switch to add or convert additional federated domains. This switch informs the command to use a unique URI namespace for each domain that's federated by the cloud service. To do this, use one of the following command syntaxes:

```powershell
New-MSOLFederatedDomain -domainname <domain name> -supportmultipledomain
```

```powershell
Convert-MSOLDomainToFederated -domainname <domain name> -supportmultipledomain
```

> [!NOTE]
> In this command, \<domain name> represents the name of the domain that you are trying to federate.

## Workaround

Implement an AD FS Federation Service farm to federate every cloud service domain for which SSO features will be used. AD FS implementation guidance for Office 365 can be found at the following article:

Step-by-step implementation guidance: [Plan for and deploy Active Directory Federation Services 2.0 for use with single sign-on](https://onlinehelp.microsoft.com/office365-**enter**prises/ff652539.aspx)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
