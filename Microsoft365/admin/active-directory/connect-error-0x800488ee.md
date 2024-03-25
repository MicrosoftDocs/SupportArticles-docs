---
title: Unable to connect to Microsoft 365, Azure, or Intune
description: Describes an issue in which you receive an error message that contains a 0x800488EE error code after your admin account is disabled for Multi-Factor Authentication.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 10/20/2023
---

# 0x800488EE when connecting to Microsoft 365, Azure, or Intune in the Azure AD module for PowerShell

## PROBLEM

Assume that Azure Multi-Factor Authentication was disabled for your admin account because you want to use the Azure Active Directory module for Windows PowerShell. (Admins who are enabled for Azure Multi-Factor Authentication can't use the Azure Active Directory module for Windows PowerShell.)

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

When you open the Azure Active Directory module for Windows PowerShell and then run the **Connect-MsolService** cmdlet to try to connect to Microsoft 365, Azure, or Microsoft Intune, the cmdlet doesn't run as expected. Instead, you receive the following error message:

```output
Connect-MsolService : Exception of type
'Microsoft.Online.Administration.Automation.MicrosoftOnlineException' was thrown.
At line:1 char:1
+ Connect-MsolService
+ ~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : OperationStopped: (:) [Connect-MsolService], MicrosoftOnlineException
+ FullyQualifiedErrorId : 0x800488EE,Microsoft.Online.Administration.Automation.ConnectMsolService
```

> [!NOTE]
> This article applies only if the hexadecimal error code in the error message is 0x800488EE, as in this example.

## SOLUTION

Restart the Online Services Sign-In Assistant service:

1. Open Control Panel, click **Administrative Tools**, and then click **Services**.
2. In the list of services, right-click **Microsoft Online Services Sign-In Assistant**, and then click **Restart**.

## MORE INFORMATION

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread)website.
