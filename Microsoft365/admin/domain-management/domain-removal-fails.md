---
title: Domain removal fails in Office 365
description: This article provides troubleshooting steps for situations in which you recieve a An Error Occured message when using PowerShell to remove a domain Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Azure Active Directory Directories, Domains, and Objects
---

# “An Error Occurred” error and domain removal fails in Office 365

## Symptoms

When you use the **Remove-MsolDomain -domainname domain.com** PowerShell cmdlet to remove a domain from Office 365, you receive the following error message: 

"An Error Occurred"

## More information

This error occurs when an Azure Active Directory application uses IdentifierURIs to refer to the domain that is being removed. 
You can retrieve a list of applications that refer to the domain by running the following cmdlet.

> [!IMPORTANT]
> The cmdlet requires that you install[Azure Active Directory PowerShell for Graph](https://docs.microsoft.com/powershell/azure/active-directory/install-adv2?view=azureadps-2.0).     

```pwoershell
Get-AzureADApplication | Where-Object -Property identifieruris -Match '<domain to remove>' 
```

**Note** In this command, replace \<domain to remove> with the domain to be removed 

## Solution

To resolve the issue, update the **identifierURIs** attribute to refer to the .onmicrosoft.com domain of the tenant. Do this in each of the AzureAD applications that refer to the domain.
 
To make the replacement, use the following cmdlets:

```powershell 
$apps=Get-AzureADApplication | Where-Object -Property identifieruris -Match '<domain to remove>'

$apps | foreach {$newid=$_.IdentifierUris -replace "<domain to remove>","<tenant name>.onmicrosoft.com";Set-AzureADApplication -ObjectId $_.objectid -IdentifierUris $newid}
```

> [!IMPORTANT]
> In this command, replace \<domain to remove> with the domain to be removed and \<tenant name> with the .onmicrosoft.com domain for the tenant.
