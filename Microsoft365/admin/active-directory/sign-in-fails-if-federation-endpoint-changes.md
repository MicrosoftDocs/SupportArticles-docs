---
title: Sign in to Office 365, Azure, or Intune fails after you change the federation service endpoint
description: Describes an issue that occurs when AD FS service endpoints are inappropriately configured. Provides resolutions.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.reviewer: v-jocomf
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

# Sign in to Office 365, Azure, or Intune fails after you change the federation service endpoint

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem 

After you change Active Directory Federation Services (AD FS) service endpoint settings in the AD FS Management Console, single sign-on (SSO) authentication to a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune fails, and you experience one of the following symptoms: 
 
- Federated users can't sign-in to Office 365, Azure, or Intune by using rich client applications.    
- Browser applications repeatedly prompt users for credentials when they try to authenticate to AD FS during SSO authentication.    
  

## Cause

This issue may occur if one of the following conditions is true:

- The AD FS service endpoints are inappropriately configured.   
- Kerberos authentication on the AD FS server is broken.   


## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Resolution 1: Restore the default AD FS service endpoint configuration
 To restore AD FS default service endpoint settings, follow these steps on the primary AD FS server: 
 
1. Open the AD FS Management Console, and in the left navigation pane, browse to **AD FS**, then **Service**, and then **Endpoints**.

   ![ADFS Endpoints](./media/sign-in-fails-if-federation-endpoint-changes/adfs-endpoints.png)
2. Examine the endpoints list, and make sure that the entries in this list are enabled as indicated (at a minimum):

   |URL Path|Enabled|Proxy enabled |
   |--|--|--|
   |/adfs/ls/|True|True |
   |/adfs/services/trust/2005/windowstransport|True|False |
   |/adfs/services/trust/2005/certificatemixed|True|True |
   |/adfs/services/trust/2005/certificatetransport|True|True |
   |/adfs/services/trust/2005/usernamemixed|True|True |
   |/adfs/services/trust/2005/kerberosmixed|True|False |
   |/adfs/services/trust/2005/issuedtokenmixedasymmetricbasic256|True|True |
   |/adfs/services/trust/2005/issuedtokenmixedsymmetricbasic256|True|True |
   |/adfs/services/trust/13/kerberosmixed|True|False |
   |/adfs/services/trust/13/certificatemixed|True|True |
   |/adfs/services/trust/13/usernamemixed|True|True |
   |/adfs/services/trust/13/issuedtokenmixedasymmetricbasic256|True|True |
   |/adfs/services/trust/13/issuedtokenmixedsymmetricbasic256|True|True |
   |/adfs/services/trusttcp/windows|True|False |
   |/adfs/services/trust/mex|True|True |
   |/FederationMetadata/2007-06/FederationMetadata.xml|True|True |
   |/adfs/ls/federationserverservice.asmx|True|False |

3. If an item in the list doesn't match the default settings in the previous table, right-click the entry, and then select **Enable** or **Enable on Proxy** as necessary.

   **Note**   
   WS-Trust Windows endpoints (/adfs/services/trust/2005/windowstransport and/adfs/services/trust/13/windowstransport) are meant only to be intranet facing endpoints that use WIA binding on HTTPS.

   These endpoints should always be kept disabled on the proxy (i.e. disabled from extranet) to protect AD account lockouts.         
 
### Resolution 2: Troubleshoot Kerberos authentication issues
 For more info about how to troubleshoot Kerberos authentication issues, see the following Microsoft Knowledge Base article:

 [2461628](https://support.microsoft.com/help/2461628) A federated user is repeatedly prompted for credentials during sign-in to Office 365, Azure, or Intune   

## More Information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
