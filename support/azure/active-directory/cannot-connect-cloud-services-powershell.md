---
title: You can't connect to Office 365, Azure, or Intune by using the Azure Active Directory module for Windows PowerShell
description: Describes an issue in which you can't connect to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune by using the connect-MSOLService cmdlet. A resolution is provided.
ms.date: 05/11/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Can't connect to Office 365, Azure, or Intune using the Azure Active Directory module for Windows PowerShell

This article describes an issue in which you can't connect to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune by using the `Connect-MSOLService` cmdlet.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2494043

## Symptoms

When you try to use the `Connect-MSOLService` cmdlet in the Microsoft Azure Active Directory module for Windows PowerShell to connect to a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune, your attempt is unsuccessful. Instead, you receive one of the following error messages:

> Connect-MsolService : Exception of type 'Microsoft.Online.Administration.Automation.MicrosoftOnlineException' was thrown.

> Connect-MsolService : Access Denied. You do not have permissions to call this cmdlet.
  
> Connect-MsolService : The user name or password is incorrect. Verify your user name, and then type your password again.`

## Resolution

To resolve this issue, refer one of the following articles, as appropriate for your situation:

- ["Connect-MsolService: Exception of type was thrown" error](https://support.microsoft.com/help/2887306)
- ["Access Denied" error](https://support.microsoft.com/help/2887685)
- ["The user name or password is incorrect" error](https://support.microsoft.com/help/2887705)

## More information

For more information about Azure Active Directory module for Windows PowerShell, see [Manage Microsoft Entra ID using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
