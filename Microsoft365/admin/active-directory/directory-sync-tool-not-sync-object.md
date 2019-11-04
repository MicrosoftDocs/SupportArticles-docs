---
title: Directory Synchronization tool stops syncing objects
description: Describes an issue in which the 32-bit version of the Microsoft Online Services Directory Synchronization tool no longer syncs objects from your local Active Directory to Office 365, Azure, or Microsoft Intune. Also, event ID 0 is logged.
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
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# Microsoft Online Services Directory Synchronization tool stops syncing objects and triggers event ID 0

## Problem

You notice that synchronization of objects from your local Active Directory Domain Services to Microsoft cloud services has stopped. (These services may include Office 365, Microsoft Azure, and Microsoft Intune.)

Additionally, the following event is logged in Event Viewer:

```adoc
Event ID: 0

Source: Directory Synchronization

Description: This version of the Microsoft Online Services Directory Sync tool is no longer supported. Uninstall this version, and then download and install the latest version from your Admin Portal page.
```

## Cause

This issue occurs if you're using the 32-bit version of the Microsoft Online Services Directory Synchronization tool. We no longer accept connections to Azure Active Directory (Azure AD) if you’re using a 32-bit version of the Microsoft Online Services Directory Synchronization tool. 

## Solution

Upgrade to the latest version of the Directory Sync tool. This is now called the Azure Active Directory Synchronization tool, and it must be installed on a 64-bit edition of Windows Server. To download the latest version of the Directory Sync tool, go to [What is hybrid identity with Azure Active Directory?](https://technet.microsoft.com/library/jj151800.aspx).

## More information

To learn about the system and software requirements for the Directory Sync tool, see [Prepare for directory synchronization](https://technet.microsoft.com/library/jj151831.aspx). 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
