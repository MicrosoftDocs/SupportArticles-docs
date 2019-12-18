---
title: Unable to sign in to Office 365, Azure, or Intune
description: Describes an issue in which you can't sign in to Office 365, Azure, or Microsoft Intune. Provides troubleshooting information.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 User and Domain Management
- Office 365 Identity Management
---

# You can't sign in to Office 365, Azure, or Intune

## Symptoms

> [!NOTE]
> Don't use this article if you use a [Microsoft account](https://support.microsoft.com/search?query=what%20is%20a%20microsoft%20account%3F) to sign in.   

You can't sign in to Microsoft Office 365, Microsoft Azure, or Microsoft Intune. You might be trying to sign in by using a portal such as [https://login.microsoftonline.com](https://login.microsoftonline.com/). Or, you might be trying to sign in by using a non-browser–based app, such as one of the following: 

- Office apps, such as Outlook, Word, Excel, and PowerPoint    
- Office apps on mobile devices, such as Office Mobile, Teams, and Microsoft OneDrive for Business (formerly Microsoft SkyDrive Pro)
- Azure Active Directory Sync    
- Azure Active Directory Module for Windows PowerShell    
- Dynamics CRM    
  
## Cause

The following conditions might cause this issue: 
 
- Your subscription has expired.    
- Your user account is not enabled.    
- You're locked out from your user account.    
- You tried to sign in with the wrong user name and password.    
- The password you tried to sign in with is temporary and expired. (This might happen if your user account is new or your password was recently reset.)    
- Your password has expired.    
- You're blocked from signing in.    
- If you're a federated user, single sign-on is not working.    

## Resolution

To resolve this issue, follow these steps. 

### Step 1: Sign in to the portal

- If you're using Office 365 or CRM Online, go to [https://portal.office.com](https://portal.office.com/).    
- If you're using Azure, go to [https://manage.windowsazure.com/?whr=azure.com](https://manage.windowsazure.com/?whr=azure.com).    
- If you're using Intune, go to [https://manage.microsoft.com](https://manage.microsoft.com).    
 
### Step 2: Use the solution that's appropriate for your sign-in experience
  
#### You can sign in to the portal

If you can sign in to the portal, but you can't sign in to a non-browser–based app, such as an Office app or an app on your mobile device to check email, follow these steps: 
 
1. Work with your admin to make sure that you have the correct licenses applied to your account.    
2. If you're enabled for multi-factor authentication, make sure that you have set up app passwords. For more information about multi-factor authentication, see [Manage your settings for two-step verification](https://docs.microsoft.com/azure/active-directory/user-help/multi-factor-authentication-end-user-manage-settings).    
3. If you use a mail app such as Outlook, and if you're a federated user, see [Federated users can't connect to an Exchange Online mailbox](https://support.microsoft.com/help/2466333).      
4. For more information about how to troubleshoot sign-in issues that use non-browser–based apps, see [How to troubleshoot non-browser apps that can’t sign in to Office 365, Azure, or Intune](https://support.office.com/article/how-to-troubleshoot-non-browser-apps-that-can-t-sign-in-to-office-365-azure-or-intune-3ba1b268-66f6-462c-b0e5-070f5c2603c1).      
  
#### You can't sign in to the portal

If you can't sign in to the portal, use one of the solutions in the following table, as appropriate for your situation.  

|Error or description| Solution |
|------|-----|
|We don't recognize this user ID or password. Make sure you typed the user ID assigned to you by your organization. It usually looks like **someone**@**example**.com or **someone**@**example**.onmicrosoft.com. And check to make sure you typed the correct password.  |   To resolve this issue, see ["We don't recognize this user ID or password" error when a user tries to sign in to the Office 365 portal ](https://support.microsoft.com/help/2853347).  |
| You've tried to sign in too many times with an incorrect user ID or password.|After 10 unsuccessful sign-in attempts (wrong password), the user is locked out for one minute. Subsequent incorrect sign-in attempts will lock out the user for increasing durations. To resolve this issue, do one of these methods: 1. Try again. You will have to enter a random set of letters and number as part of the sign-in process. 2. Update your password on all devices that connect to your account. 3. Reset your password. |
|It looks like your account has been blocked. Please contact your admin to unblock it.|To resolve this issue, see ["It looks like your account has been blocked" error when a user tries to sign in to Office 365](https://support.microsoft.com/help/2742372). If the issue still occurs, use one of these methods: 1. Wait 15 minutes, and then try again. 2. Have your admin reset the password. This unlocks the account.|
|Sorry, that didn't work. This doesn't look like a valid user ID. Make sure you typed the user ID assigned to you by your organization. It usually looks like **someone**@**example**.com or **someone**@**example**.onmicrosoft.com.|To resolve this issue, see ["This doesn't look like a valid user ID" error when a user tries to sign in to Office 365](https://support.microsoft.com/help/2844931).   |
|You're automatically signed in as a different user.|If you're using more than one user account in a web browser, try one of these methods: 1. Sign out of the portal. 2. Clear the cache in the web browser, delete Internet cookies, and then try to sign in again.|
|You see a correlation ID that resembles "Correlation ID:ac5d279c-cf72-5073-278e-a5b2b0c8a4bc"|Contact [Microsoft Technical Support](https://support.microsoft.com/contactus). |
|You're asked to change your password.|Your password may be temporary or your password has expired. If you're prompted, change your password. |
| Sorry, but we're having trouble signing you in. Please try again in a few minutes. If this doesn't work, you might want to contact your admin and report the error: \<error code>|To resolve this, see ["This doesn't look like a valid user ID" error when a user tries to sign in to Office 365](https://support.microsoft.com/help/2844931/this-doesn-t-look-like-a-valid-user-id-error-when-a-user-tries-to-sign).  |
|You don't see any of the previous error messages, and the website address doesn't start with [https://login.microsoftonline.com](https://login.microsoftonline.com/).|You may be a federated user. Work with your company admin, and see [How to use Remote Connectivity Analyzer to troubleshoot single sign-on issues for Office 365, Azure, or Intune](https://support.microsoft.com/help/2650717) and [A federated user is prompted unexpectedly to enter their work or school account credentials](https://support.microsoft.com/help/2535227).    |
| Sorry! We can’t process your request. Your session is invalid or expired. There was an error processing your request because your session is invalid or expired. Please try again.|To resolve this issue, see ["Sorry! We can’t process your request” error when you try to set up security verification settings for Azure Multi-Factor Authentication ](https://support.microsoft.com/help/2909939). |
| We did not receive the expected response. Please try again.|To resolve this issue, see [ "We did not receive the expected response" error message when you try to sign in by using Azure Multi-Factor Authentication](https://support.microsoft.com/help/2834968). |
| We didn't receive a response. Please try again.|To resolve this issue, see ["We didn't receive a response" error message when you try to sign in by using Azure Multi-Factor Authentication](https://support.microsoft.com/help/2834965). |
| Sorry, our account verification system is having trouble. This could be temporary, but if you see it again, you might want to contact your admin.|To resolve this issue, see ["Account verification system is having trouble" error message when you try to sign in by using a work or school account](https://support.microsoft.com/help/2834966).  |

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
