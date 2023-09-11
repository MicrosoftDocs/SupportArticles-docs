---
title: Directory Synchronization tool stops syncing objects
description: Describes an issue in which the Microsoft Online Services Directory Synchronization tool no longer syncs objects from your local Active Directory to Microsoft 365, Azure, or Microsoft Intune.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft Online Services Directory Synchronization tool stops syncing objects and triggers a Directory Synchronization error

## Problem

You notice that synchronization of objects from your local Active Directory Domain Services to Microsoft cloud services has stopped. (These services may include Microsoft 365, Microsoft Azure, and Microsoft Intune.)

Additionally, Event ID 0, or Event ID 109 is logged in Event Viewer:

```output
Event ID: 0 or Event ID: 109

Source: Directory Synchronization

Description: This version of the Microsoft Online Services Directory Sync tool is no longer supported. Uninstall this version, and then download and install the latest version from your Admin Portal page.
```

## Cause

This issue occurs if you're using a deprecated version of the Microsoft Online Services Directory Synchronization tool. We no longer accept connections to Azure Active Directory (Azure AD) if you're using a deprecated version of the Microsoft Online Services Directory Synchronization tool.

## Solution

Upgrade to Azure AD Connect. This tool must be installed on a 64-bit version of Windows Server. For more information about how to upgrade from DirSync, see [Azure AD Connect: Upgrade from DirSync](/azure/active-directory/hybrid/how-to-dirsync-upgrade-get-started).

## More information

For more information about hybrid identity with Azure Active Directory, see [Prepare for directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity).

For more information about the system and software requirements for Azure AD Connect, see [Prerequisites for Azure AD Connect](/azure/active-directory/hybrid/how-to-connect-install-prerequisites).

For more information about the attributes that are synchronized by Azure AD Connect, see [Azure AD Connect sync: Attributes synchronized to Azure Active Directory](/azure/active-directory/hybrid/reference-connect-sync-attributes-synchronized).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/), or [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread).
