---
title: Error (Unknown error (0x80005000)) message when you run the Azure Active Directory Sync Tool Configuration Wizard
description: Describes an issue where you receive an error message when you run the Azure Active Directory Sync Tool Configuration Wizard. Provides a resolution.
ms.date: 06/08/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Error when you run the Azure Active Directory Sync Tool Configuration Wizard: Unknown error (0x80005000)

This article provides a resolution to resolve an issue where you receive an error message when you run the Azure Active Directory Sync Tool Configuration Wizard.

_Original product version:_ &nbsp; Office 365 Identity Management, Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup  
_Original KB number:_ &nbsp; 3003331

## Symptoms

When you run the Azure Active Directory Sync Tool Configuration Wizard, the tool fails, and you receive the following error message:

> Error  
Unknown error (0x80005000)

## Cause

This problem occurs if the Azure Active Directory Sync Tool Configuration Wizard cannot configure the domain.

## Resolution

To resolve this problem, make sure that all domain controllers are running in a healthy state. To determine which domain or domain controller is causing the problem, follow these steps:

1. On the server on which the Azure Active Directory Sync Tool is installed, start Windows PowerShell.
2. Run the following commands:

    ```powershell
    $Forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().domains
    ```

    ```powershell
    $Forest
    ```

3. Examine the information in the output.

    In the following example, the `dev.contoso.com` domain is unreachable. You can determine this because information about the domain is missing in the output, as in the following example.

    ```
    Forest : contoso.com
    DomainControllers : {ContosoDC01.contoso.com}
    Children : {dev.contoso.com}
    DomainMode : Windows2008R2Domain
    Parent :
    PdcRoleOwner : ContosoDC01.contoso.com
    RidRoleOwner : ContosoDC01.contoso.com
    InfrastructureRoleOwner : ContosoDC01.contoso.com
    Name : contoso.com

    Forest :
    DomainControllers :
    Children :
    DomainMode :
    Parent :
    PdcRoleOwner :
    RidRoleOwner :
    InfrastructureRoleOwner :
    Name : dev.contoso.com
    ```

4. Investigate and resolve the problem. Most likely, the domain controller that's hosting the domain is not running or is not in the network.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
