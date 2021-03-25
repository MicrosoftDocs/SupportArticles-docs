---
title: There is problem with website security certificate error when federated user signs out
description: Describes an issue in which a federated user receives an error message when the user signs out of Office 365, Microsoft Intune, or Azure. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.reviewer: willfid
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# "There is a problem with this website's security certificate" error when a federated user signs out of Office 365, Intune, or Azure

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When a federated user signs out of a Microsoft cloud service such as Office 365, Microsoft Intune, or Microsoft Azure, the user receives the following error message on login.microsoftonline.com:

> There is a problem with this website's security certificate

## Cause

This issue occurs when an HTTP URL is used for the logout URL, but the logout process uses HTTPS to access the URL. If the URL can't accept HTTPS connections, the user receives the error message. 

For example, this issue occurs if the logout URL is `https://idp.contoso.edu/idp/logout.htm` and the logout process tries to access it by using `https://idp.contoso.edu/idp/logout.htm`.

## Solution

To protect the confidentiality of personally identifiable information (PII) that's contained in the Security Assertions Markup Language (SAML) logout request, a secure (HTTPS) connection is required. Review your security token service (STS) documentation to determine what the logout URL should be. 

To resolve this issue, try Method 1. If Method 1 doesn't resolve the issue, use Method 2. 
### Method 1: Make sure that the logout URL can accept HTTPS requests
Update the logout URL so that it can accept HTTPS requests. To do this, open the Azure Active Directory Module for Windows PowerShell, and then run the following cmdlet:
```PowerShell
Set-MsolDomainFederationSettings -DomainName user.contoso.com -LogOffUri <LogOffUri> -PreferredAuthenticationProtocol SAMLP 
```
**Note** In this command, <LogOffUri> represents your logout URL. 

### Method 2: Remove the HTTP URL that's specified in the LogOffUri parameter
Azure Active Directory (Azure AD) will automatically display a message to notify the user to close the browser when the user logs off if a logout URL isn't specified.

To remove the HTTP URL that's specified in the LogOffUri parameter, open the Azure Active Directory Module for Windows PowerShell, and then run the following cmdlet:
```PowerShell
Set-MsolDomainFederationSettings -DomainName contoso.com -LogOffUri " " –PreferredAuthenticationProtocol SAMLP 
```
**Important** Make sure that there's a space between the quotation marks (" ") in the command line. 

## More Information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.