---
title: Sorry, but we're having trouble signing you in error and 8004789A error
description: Describes an issue in which authentication fails for single sign-on (SSO) users when they try to sign in to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune after you update the relying party trust with Microsoft Entra ID in AD FS 2.0.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# "Sorry, but we're having trouble signing you in" and "8004789A" error when a federated user sign in to Microsoft 365, Azure, or Intune

## Problem

Consider the following scenario. You update the relying party trust with Microsoft Entra ID in Active Directory Federation Services (AD FS) 2.0 by using the procedures that are described in one of the following resources: 
 
- [Limiting Access to Microsoft 365 Services Based on the Location of the Client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh526961(v=ws.10))    
- ["Federation service identifier specified in the AD FS 2.0 server is already in use." error when you try to set up another federated domain in Microsoft 365, Azure, or Intune ](https://support.microsoft.com/help/2618887)

However, after you do this, authentication fails for federated users when they try to sign in to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune from a sign-in webpage whose URL starts with `https://login.microsoftonline.com/login`. After the user clicks Sign in at \<DomainName> on the webpage, the user gets the following error message:

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

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
