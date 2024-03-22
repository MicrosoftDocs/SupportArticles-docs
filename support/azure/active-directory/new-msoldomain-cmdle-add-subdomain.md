---
title: Unable to use the New-MSOLDomain command to add a subdomain to an existing domain
description: Discusses an error message that you receive in Office 365, Microsoft Intune, or Azure when you try to use the New-MSOLDomain command to add a subdomain to an existing domain that's set up for federated authentication. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: users
ms.custom: has-azure-ad-ps-ref
---
# Error when you try to use the New-MSOLDomain command to add a subdomain to an existing domain: New-MsolDomain: Unable to add this domain

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2666578

## Symptoms

You try to add a subdomain to an existing domain in a Microsoft cloud service such as Office 365, Microsoft Intune, or Microsoft Azure by using the New-MSOLDomain command. However, you receive the following error message:

> New-MsolDomain: Unable to add this domain. It is a subdomain and its authentication type is different from the authentication type of the root domain.

## Cause

This issue occurs if you try to use the New-MSOLDomain command to add a subdomain to an existing domain that's set up for federated authentication. The New-MSOLDomain command tries to add the subdomain as a standard authentication domain.

## Resolution

To add a subdomain to a domain that's set up for federated authentication, follow these steps:

1. Connect to Microsoft Entra ID by using Windows PowerShell. For more information, see [Connect to Microsoft Entra ID Using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN#bkmk_connect).
2. Use the New-MSOLFederatedDomain command.

    The syntax to add a subdomain is as follows, where \<subdomain> is the name of the subdomain that you want to add:

     ```powershell
     New-MSOLFederatedDomain -DomainName:<subdomain>
     ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
