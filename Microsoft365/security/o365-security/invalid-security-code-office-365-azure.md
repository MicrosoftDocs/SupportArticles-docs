---
title: Invalid Security Code for Microsoft 365, Intune, or Azure
description: Describes an issue in which you receive an error message when you try to reset your admin password for Microsoft 365, Microsoft Intune, or Azure. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---

# "Invalid Security Code" error when you reset your admin password for Microsoft 365, Intune, or Azure

## Problem 

When you try to reset your password by using the self-service password reset for administrators feature in Microsoft 365, Microsoft Intune, or Microsoft Azure, you receive the following error message: 

```asciidoc
Invalid Security Code

This security code you entered does not match the code we sent, or it has expired. To start a new password reset request, click here.
```

You experience these symptoms when you do the following:

- You click the email link that's sent to your alternative email account.   
- After you enter the security code that's sent to your mobile phone.   

## Solution

Try re-entering the security code again. If it continues to fail, start the self-service password reset process again and complete the process in less than 60 minutes. The process must be performed within 60 minutes of when the email message was sent. Additionally, the whole process must be performed in the same web browser session. 

If you still experience the issue, close all web browsers, and then start the process again.

If the issue persists, contact your company administrator to reset your password. If you are the only administrator in your company, contact Technical Support.

## More information

This issue may occur if one of the following conditions is true:

- The security code isn't valid. That is, the security code doesn't match what was sent through SMS text messaging.   
- You wait too long to click the Reset your password nowin the email message.   
- The security code has expired. 
  > [!NOTE]
  > The security code and the Reset your password nowlink is valid only for 10 minutes.   
- You clicked Reset your password nowfrom a different computer. Or, you opened a new web browser session, which is different from the web browser session in which you started the password reset request.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
