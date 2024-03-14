---
title: Domain removal fails in Microsoft 365
description: This article provides troubleshooting steps for situations in which you receive a An Error Occurred message when using PowerShell to remove a domain from Microsoft 365.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.author: luche
appliesto: 
  - Azure Active Directory Directories, Domains, and Objects
ms.date: 03/31/2022
---

# "An Error Occurred" error and domain removal fails in Microsoft 365

## Symptoms

When you use the **Remove-MsolDomain -domain name domain.com** PowerShell cmdlet to remove a domain from Microsoft 365, you receive the following error message:

"An Error Occurred"

## More information

This error occurs when a Microsoft Entra application uses IdentifierURIs to refer to the domain that is being removed.
You can retrieve a list of applications that refer to the domain by running the following cmdlet.

> [!IMPORTANT]
> The cmdlet requires that you install[Azure Active Directory PowerShell for Graph](/powershell/azure/active-directory/install-adv2).

```pwoershell
Get-AzureADApplication | Where-Object -Property identifieruris -Match '<domain to remove>' 
```

**Note** In this command, replace \<domain to remove> with the domain to be removed.

## Solution

To resolve the issue, update the **identifierURIs** attribute to refer to the .onmicrosoft.com domain of the tenant. Do this in each of the Microsoft Entra applications that refer to the domain.

To make the replacement, use the following cmdlets:

```powershell
$apps=Get-AzureADApplication | Where-Object -Property identifieruris -Match '<domain to remove>'

$apps | foreach {$newid=$_.IdentifierUris -replace "<domain to remove>","<tenant name>.onmicrosoft.com";Set-AzureADApplication -ObjectId $_.objectid -IdentifierUris $newid}
```

> [!IMPORTANT]
> In this command, replace \<domain to remove> with the domain to be removed and \<tenant name> with the .onmicrosoft.com domain for the tenant.
