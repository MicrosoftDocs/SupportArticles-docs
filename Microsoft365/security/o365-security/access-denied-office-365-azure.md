---
title: Access Denied when you connect to Office 365, Azure, or Intune
description: Describes an issue in which you can't connect to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune by using the connect-MSOLService cmdlet in the Azure Active Directory Module for Windows PowerShell.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid:
- SPO160 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 109573
ms.author: v-six
appliesto:
- Cloud Services (Web roles/Worker roles) 
- Azure Active Directory 
- Microsoft Intune 
- Azure Backup 
- Office 365 User and Domain Management
---

# "Access Denied" error when you use the connect-MSOLService cmdlet to connect to Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms 

When you try to use the connect-MSOLService cmdlet in the Microsoft Azure Active Directory Module for Windows PowerShell to connect to a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune, your attempt is unsuccessful. Additionally, you may receive the following error message:

```asciidoc
Connect-MsolService : Access Denied. You do not have permissions to call this cmdlet.
```

## Resolution 

This issue can be resolved by adding the member/user to an administrator role within Azure. For more information, see the article [Add-MsolRoleMember](/powershell/module/msonline/add-msolrolemember?preserve-view=true&view=azureadps-1.0).

## More information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.