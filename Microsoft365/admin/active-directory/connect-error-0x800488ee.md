---
title: Unable to connect to Office 365, Azure, or Intune
description: Describes an issue in which you receive an error message that contains a 0x800488EE error code after your admin account is disabled for Multi-Factor Authentication.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 User and Domain Management
---

# 0x800488EE when connecting to Office 365, Azure, or Intune in the Azure AD Module for PowerShell

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

Assume that Azure Multi-Factor Authentication was disabled for your admin account because you want to use the Azure Active Directory Module for Windows PowerShell. (Admins who are enabled for Azure Multi-Factor Authentication can't use the Azure Active Directory Module for Windows PowerShell.)

When you open the Azure Active Directory Module for Windows PowerShell and then run the **Connect-MsolService** cmdlet to try to connect to Microsoft Office 365, Azure, or Microsoft Intune, the cmdlet does not run as expected. Instead, you receive the following error message:

```asciidoc
Connect-MsolService : Exception of type
'Microsoft.Online.Administration.Automation.MicrosoftOnlineException' was thrown.
At line:1 char:1
+ Connect-MsolService
+ ~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : OperationStopped: (:) [Connect-MsolService], Mic
rosoftOnlineException
+ FullyQualifiedErrorId : 0x800488EE,Microsoft.Online.Administration.Automation.ConnectMsolService
```

> [!NOTE]
> This article applies only if the hexadecimal error code in the error message is 0x800488EE, as in this example.

## SOLUTION

Restart the Online Services Sign-In Assistant service. To do this, follow these steps:

1. Open Control Panel, click **Administrative Tools**, and then click **Services**.
2. In the list of services, right-click **Microsoft Online Services Sign-In Assistant**, and then click **Restart**.

## MORE INFORMATION

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread)website.