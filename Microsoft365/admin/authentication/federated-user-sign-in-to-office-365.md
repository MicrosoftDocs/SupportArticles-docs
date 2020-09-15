---
title: Sorry, but we're having trouble signing you in error and 8004789A error
description: Describes an issue in which authentication fails for single sign-on (SSO) users when they try to sign in to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune after you update the relying party trust with Azure AD in AD FS 2.0.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: Office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# "Sorry, but we're having trouble signing you in" and "8004789A" error when a federated user sign in to Office 365, Azure, or Intune

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

Consider the following scenario. You update the relying party trust with Microsoft Azure Active Directory (Azure AD) in Active Directory Federation Services (AD FS) 2.0 by using the procedures that are described in one of the following resources: 
 
- [Limiting Access to Office 365 Services Based on the Location of the Client](https://technet.microsoft.com/library/hh526961%28ws.10%29.aspx)    
- ["Federation service identifier specified in the AD FS 2.0 server is already in use." error when you try to set up another federated domain in Office 365, Azure, or Intune ](https://support.microsoft.com/help/2618887)

However, after you do this, authentication fails for federated users when they try to sign in to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune from a sign-in webpage whose URL starts with `https://login.microsoftonline.com/login`. After the user clicks Sign in at \<DomainName> on the webpage, the user gets the following error message:

```adoc
Sorry, but we're having trouble signing you in

Please try again in a few minutes. If this doesn't work, you might want to contact your admin and report the following error:

8004789A
```

## Solution

To resolve this issue, install Update Rollup 1 for AD FS 2.0 on all AD FS 2.0 Federation Service farm nodes. For more info about how to download and install Update Rollup 1 for AD FS 2.0, see [Description of Update Rollup 1 for Active Directory Federation Services (AD FS) 2.0](https://support.microsoft.com/help/2607496).  

> [!NOTE]
> This update requires a restart of the computer.

## More information 

To use multiple top level domains or client access policies, you must install Update Rollup 1 for Active Directory Federation Services (AD FS) 2.0.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
