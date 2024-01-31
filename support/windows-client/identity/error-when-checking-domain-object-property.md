---
title: Error when checking domain object property
description: Describes an issue in which ADAC fails on the domain object property. A workaround is provided.
ms.date: 09/24/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, rolandw, uspand, amaltsev
ms.custom: sap:schema-update-known-issues-best-practices-workflow-review, csstroubleshoot
ms.subservice: active-directory
---
# Error when you check domain object properties by using RSAT in Windows 10: msDS-ExpirePasswordsOnSmartCardOnlyAccounts not exist

This article provides a solution to an error that occurs when you check domain object properties by using RSAT in Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 3214525

## Symptoms

You have a Windows 10, version 1809-based client that joins a domain with a Windows Server 2012 R2 controller. Additionally, the [Remote Server Administration Tools (RSAT) for Windows 10](https://www.microsoft.com/download/details.aspx?id=45520) is installed on the client. When you right-click the properties of a domain object in Active Directory Administrative Center (ADAC) in this situation, you receive the following error message:

> Failed to retrieve the object 'DC=CONTOSO,DC=COM' due to the following error:  
The specified directory service attribute or value does not exist Parameter name: msDS-ExpirePasswordsOnSmartCardOnlyAccounts

## Cause

This issue occurs when the schema version of the domain has not yet been updated.

## Workaround

To work around this issue, use one of the following tools to obtain the properties of a domain object:  

- DSA.msc
- Ldifde.exe
- Ldp.exe
- ADSI Edit (adsiedit.msc)
- Get-ADObject cmdlets
