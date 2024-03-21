---
title: You cannot remove a domain that has subdomains
description: Describes an issue in which you receive the Domain has associated subdomains or You cannot remove a domain that has subdomains error. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
appliesto: 
  - User and Domain Management
ms.date: 03/31/2022
---

# "Domain has associated subdomains" when removing a domain from Microsoft 365

## Problem

If you try to remove a domain from Microsoft 365, you experience one or both of the following symptoms:

- When you try to remove the domain through the Microsoft 365 portal, you receive the following error message:

    > Domain has associated subdomains.

- When you try to remove the domain by using Windows PowerShell, you receive the following error message:

    > Remove-MsolDomain : You cannot remove a domain that has subdomains. You must first delete the subdomains before you can remove this domain.  
      At line:1 char:18  
      +Remove-MsolDomain <<<< -DomainName \<DomainName>  
      +CategoryInfo : OperationStopped: (:) [Remove-MsolDomain],  MicrosoftOnlineException  
      +FullyQualifiedErrorId : Microsoft.Online.Administration.Automation.DomainHasChildDomainException,Microsoft.Online.Administration.Automation. RemoveDomain  

This issue occurs if the domain has associated subdomains.

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

## Solution

To fix this issue, remove all subdomains that contain the domain that you're trying to delete.

For example, consider the following scenario:

- You have two domains: `www.contoso.com` and `contoso.com`.
- You want to remove the `contoso.com` domain.

In this scenario, you must also remove the `http://www.contoso.com` subdomain to remove the `contoso.com` domain.

## More information

For more info, see the following Microsoft Knowledge Base article:

[You get an error message when you try to remove a domain from Microsoft 365](https://support.microsoft.com/help/2284755)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).