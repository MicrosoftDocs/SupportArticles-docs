---
title: You cannot remove the initial domain when removing a domain
description: Fixes an issue in which the Remove domain link is unavailable or you receive a You cannot remove the initial domain created for you in Microsoft 365 error message when you try to remove a domain from Microsoft 365.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# The "Remove" link is unavailable when removing a domain from Microsoft 365

## PROBLEM

When you try to remove a domain from Microsoft 365, you experience one of the following symptoms:

- The Remove link is unavailable.
- When you try to remove the domain by using Windows PowerShell, you receive the following error message:
  
  ```output
  Remove-MsolDomain : You cannot remove the initial domain created for you in Office 365.
  At line:1 char:18
  + Remove-MsolDomain <<<< -DomainName <DomainName>
  + CategoryInfo : OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException
  + FullyQualifiedErrorId : Microsoft.Online.Administration.Automation.InitialDomainDeletionException,Microsoft.Online.Administration.Automation.RemoveDomain
  ```

## CAUSE

This issue occurs if the domain is the Microsoft Online routing domain. The Microsoft Online routing domain is the domain that's issued to you by Microsoft 365 (for example, `contoso.onmicrosoft.com`). This domain can't be deleted. Therefore, the Remove link is unavailable.

## MORE INFORMATION

For more information, see [You get an error message when you try to remove a domain from Microsoft 365](https://support.microsoft.com/help/2284755).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).