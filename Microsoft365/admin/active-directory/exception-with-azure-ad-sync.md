---
title: Exception has been thrown by the target of an invocation in Azure AD Sync tool
description: Describes an issue that triggers an 'Exception has been thrown by the target of an invocation" error. Occurs when you run the Azure Active Directory Sync tool Configuration Wizard on a Windows Server 2012 Essentials or Windows Server 2012 R2 Essentials server.
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
- Azure Active Directory
- Office 365 Identity Management
- Windows Server 2012 Essentials
---

# "Exception has been thrown by the target of an invocation" with Directory Sync Configuration Wizard

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

You run the Azure Active Directory Sync tool Configuration Wizard after you install the Azure Active Directory Sync tool on a Windows Server 2012 Essentials server or a Windows Server 2012 R2 Essentials server. In this situation, you receive the following error message:

**Exception has been thrown by the target of an invocation**

Additionally, an event ID 0 that contains the following description is logged to the Application log in Event Viewer:

**Resetting password for SERVERNAME\MSO_\<nnnnnnnnnnn>**

## Cause 

This issue occurs if Office 365 is integrated with a Windows Server 2012 Essentials server or with Windows Server 2012 R2 Essentials. In this scenario, a password filter is attached to the Local Security Authentication server (Lsass.exe) that enforces the following domain password policy:

- Passwords must contain 8–16 characters.   
- Passwords cannot contain a space or a Microsoft Online Services account name.   

Because of the password policy restrictions, the Azure Active Directory Sync tool Configuration Wizard cannot reset the password for the MSO_<**nnnnnnnnnnn**> service account. 

> [!NOTE]
> The Azure Active Directory Sync tool is not supported in Windows Server Essentials.

## Solution 

Use the Windows Server Essentials Dashboard to manage Office 365. We also recommend that you uninstall the Azure Active Directory Sync tool from the server. 

If, for any reason, you can't remove the Azure Active Directory Sync tool from the computer, disable Office 365 integration on the Windows Server Essentials Dashboard, and then restart the server. Doing this removes the password policy restrictions. 

## More information

For more info about Windows Server Essentials and Office 365, see the following resources:

- [Manage Office 365 in Windows Server Essentials](/previous-versions/windows/it-pro/windows-server-essentials-sbs/jj593240(v=ws.11))   
- [How to create a service integration add-in for Windows Server Essentials Experience](/archive/blogs/sbs/how-to-create-a-service-integration-add-in-for-windows-server-essentials-experience)   
- [Manage online accounts for Windows Server Essentials users](/previous-versions/windows/it-pro/windows-server-essentials-sbs/dn737016(v=ws.11))   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.