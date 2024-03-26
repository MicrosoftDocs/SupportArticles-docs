---
title: Password Synchronization has not been activated error.
description: Describes an issue in Microsoft 365, Microsoft Intune, or Azure in which user passwords fail to sync, and an event ID 6900 error is logged in Event Viewer. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: v-chblod
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 10/20/2023
---

# User passwords aren't synced, and "Password Synchronization has not been activated for this company" error is logged in Event Viewer

## Problem 

After you discover that some users can't sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Intune, or Microsoft Azure, you notice that user passwords aren't being synced from your local Active Directory Domain Services (AD DS) environment to Microsoft Entra ID. When you view the Application login Event Viewer, you see that the following event ID 6900 error is logged:

> The server encountered an unexpected error while processing a password change notification:  
"An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company

This issue may occur if password synchronization was disabled after it was set up in the Azure Active Directory Sync appliance.

## Solution 

To resolve this issue, enable password synchronization. To do so, take one of the following actions, as appropriate to the Azure Active Directory Sync appliance that you're running.

### If you're running the Azure Active Directory Sync tool

Run the Azure Active Directory Sync Configuration Wizard, and then, on the Password Synchronization page, select the **Enable Password Synchronization** check box. Doing this finishes the password synchronization setup and starts a full sync. 
<a name='if-youre-running-azure-active-directory-connect'></a>

### If you're running Microsoft Entra Connect

1. Open Windows PowerShell.   
2. Run the following commands:

   ```powershell
   Import-Module ADSync    
   $aadcon = Get-ADSyncConnector | Where {$_.Type -eq "Extensible2"}    
   Set-ADSyncAADPasswordSyncState -ConnectorName $aadcon. Name -Enable $True
   ```
   
## More Information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
