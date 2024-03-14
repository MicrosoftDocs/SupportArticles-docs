---
title: Connect-MsolService Exception of type was thrown
description: Describes an issue in which you can't connect to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune. Occurs when you use the connect-MSOLService cmdlet in the Azure Active Directory module for Windows PowerShell.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.author: luche
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# "Connect-MsolService: Exception of type was thrown" when you use the connect-MSOLService to connect to Microsoft 365, Azure, or Intune

## Problem

When you try to use the connect-MSOLService cmdlet in the Microsoft Azure Active Directory module for Windows PowerShell to connect to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune, your attempt is unsuccessful. You may also receive the following error message:

```output
Connect-MsolService: Exception of type 'Microsoft.Online.Administration.Automation.MicrosoftOnlineException' was thrown.
```

## Cause

This issue may occur for one or more of the following reasons:

- The Azure Active Directory module for Windows PowerShell rich client can't connect to the service. This is frequently the result of client computer readiness issues.    
- The user ID that's used to authenticate is single sign-on (SSO)-enabled, and a client computer problem is preventing SSO communication with Active Directory Federation Services (AD FS), with the Microsoft Entra authentication system, or with both.   

## Solution

To resolve this issue, follow these steps:

1. Troubleshoot Microsoft 365 rich client connectivity. For more information, see [How to troubleshoot non-browser apps that can't sign in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2637629).     
2. Troubleshoot common client configuration issues that limit SSO authentication. For more information, see [Signing in to Microsoft 365, Azure, or Intune by using single sign-on doesn't work from some devices](https://support.microsoft.com/help/2530713).    

## More information

For more information about Azure Active Directory module for Windows PowerShell, see [Microsoft Entra Cmdlets](/previous-versions/azure/jj151815(v=azure.100)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
