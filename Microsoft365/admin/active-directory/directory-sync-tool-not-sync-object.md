---
title: Directory Synchronization tool stops syncing objects
description: Describes an issue in which the Microsoft Online Services Directory Synchronization tool no longer syncs objects from your local Active Directory to Office 365, Azure, or Microsoft Intune.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-maqiu
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# Microsoft Online Services Directory Synchronization tool stops syncing objects and triggers a Directory Synchronization error

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

You notice that synchronization of objects from your local Active Directory Domain Services to Microsoft cloud services has stopped. (These services may include Office 365, Microsoft Azure, and Microsoft Intune.)

Additionally, the following event is logged in Event Viewer:

```
Event ID: 0 or Event ID: 109

Source: Directory Synchronization

Description: This version of the Microsoft Online Services Directory Sync tool is no longer supported. Uninstall this version, and then download and install the latest version from your Admin Portal page.
```

## Cause

This issue occurs if you're using a deprecated version of the Microsoft Online Services Directory Synchronization tool. We no longer accept connections to Azure Active Directory (Azure AD) if you're using a deprecated version of the Microsoft Online Services Directory Synchronization tool.

## Solution

Upgrade to the latest version of the synchronization tool. This is now called the Azure AD Connect tool and it must be installed on a 64-bit edition of Windows Server. To find the ways you can upgrade from DirSync, go to [Azure AD Connect: Upgrade from DirSync](/azure/active-directory/hybrid/how-to-dirsync-upgrade-get-started).

## More information

To learn about hybrid identity with Azure Active Directory, see [Prepare for directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity).

To understand what are the system and software requirements for Azure AD Connect, visit [Prerequisites for Azure AD Connect](/azure/active-directory/hybrid/how-to-connect-install-prerequisites).

For a list of attributes that are synchronized by Azure AD Connect, see the following article: [Azure AD Connect sync: Attributes synchronized to Azure Active Directory](/azure/active-directory/hybrid/reference-connect-sync-attributes-synchronized)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
