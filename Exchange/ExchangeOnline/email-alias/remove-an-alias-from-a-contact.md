---
title: Troubleshoot Remove an alias from a contact
ms.author: kwekua
author: kwekua
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
f1_keywords:
- 'O365P_AdminMailContact_TSAlias'
- 'O365E_AdminMailContact_TSAlias'
- 'AdminMailContact_TSAlias'
ms.service: o365-administration
localization_priority: None
ms.collection: Adm_O365
search.appverid:
- BCS160
- MET150
- MOE150
ms.assetid: 0baf335d-ea9b-428c-9573-d0878126f014
description: Learn how to remove an email alias from a contact using Exchange Online PowerShell.
---

# Troubleshoot: Remove an alias from a contact

Did you get this error when you were creating a new user? "This email address is already being used as an alias for the contact \<contact name>." This article will show you how to remove the email alias from the contact.
  
> [!CAUTION]
> It is unusual for a contact to have an alias because it has to be added using Exchange Online PowerShell. You'll have to remove it using Exchange Online PowerShell. <br><br> If you're new to PowerShell, you can do this! The Exchange Online PowerShell commands used in this article will only remove an alias from a contact. 
  
## Remove the email alias from the contact using Exchange Online PowerShell

Before you can do this procedure, you need the following:
  
- [Connect to Exchange Online PowerShell](https://go.microsoft.com/fwlink/p/?linkid=396554 )
    
- The display name of the contact
    
- The email address that you want to remove
    
1. In Exchange Online PowerShell, replace the contact name and email address with your values, and run the following command: 
     
   ```
   Set-MailContact -Identity "Contact name" -Alias @{remove="alias@contoso.com"}
   ```

2. It may take a few minutes, but when the command has completed, the command prompt will return. You'll only get a message if there was an error.
    
3. Close the connection to Exchange Online PowerShell by running the following command:
     
   ```
   Remove-PSSession $Session
   ```



