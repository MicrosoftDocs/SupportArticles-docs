---
title: Troubleshooting issues with Microsoft Skype for Business for Android
description: This article describes how to troubleshoot some common issues that you may encounter when you use the Skype for Business (formerly Lync 2013) for Android.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business for Android
ms.date: 03/31/2022
---

# Troubleshooting issues with Microsoft Skype for Business (formerly Lync 2013) for Android

## Summary

Users can download the [Skype for Business for Android](https://play.google.com/store/apps/details?id=com.microsoft.office.lync15&hl=en) (formerly Lync 2013 for Android) for free from Google Play. Users can use the client to connect to Skype for Business Online (formerly Lync online ) if they're assigned a Skype for Business Online license. This article describes how to troubleshoot some common issues that you may encounter when you use Skype for Business for Android.

### How to install the app

Make sure that you have the latest version of the app installed. The Skype for Business for Android is available for free from Google Play. To install the app, go to [https://play.google.com/store/apps/details?id=com.microsoft.office.lync15](https://play.google.com/store/apps/details?id=com.microsoft.office.lync15). Users should install the app directly to their device and use their user ID to sign in. 

> [!NOTE]
> The current release for Android smartphones isn't supported on Android media tablets or on other non-phone Android form factors (hardware models). For more information, click the following article number to view the article in the Microsoft Knowledge Base:

### Sign-in requirements for Google Android

When users sign in to the Skype for Business for Android, the sign-in information that's required to successfully authenticate depends on the following scenarios:

- Whether a user's Session Initiation Protocol (SIP) address is the same as the user's user principal name (UPN)   
- Whether users are hosted on an on-premises Skype for Business (Lync server) or on Skype for Business Online   

The following table describes the sign-in fields required for Android users: 

|User is hosted by|SIP address and UPN|Required fields|
|-|-|-|
|On-premises Skype for Business Server|SIP address and UPN are the same|**Sign-in address:**SIP address **User name:** Blank **Password:** Password|
|On-premises Skype for Business Server|SIP address and UPN are different|**Sign-in address:** SIP address **User name:**UPN or domain\username **Password:** Password|
|Microsoft 365|SIP address and UPN are the same|**Sign-in address:** SIP address **User Name:** Blank **Password:** Password|
|Microsoft 365|SIP address and UPN are different|**Sign-in address:** SIP address **User name:** UPN **Password:** Password|

If automatic discovery for mobile clients hasn't been configured, users have to enter the following internal and external discovery addresses in addition to the fields that are listed in the table:

- Internal discovery address*: `https://webdir.online.lync.com/Autodiscover/autodiscoverservice.svc/root`
- External discovery address*: `https://webdir.online.lync.com/Autodiscover/autodiscoverservice.svc/root`

*These addresses are valid only for Microsoft 365 users and will be different for On-premises Skype for Business Server deployments.

> [!NOTE]
> The Sign-in address and Password fields are displayed on the sign-in screen. To access the User name, Domain, Internal discovery address, and External discovery addressfields, select Server Settings on the sign-in screen.

### Troubleshoot Auto-Detect

The Skype for Business for Android looks for different DNS records than the Skype for Business desktop client. For the Auto-Detect process to discover the correct Skype for Business Online service, a CNAME record that meets the following criteria must be created for the SIP domain that's being used:

|Alias|Domain|Value|
|-|-|-|
|Lyncdiscover|\<domain> Example: Contoso.com| \<Your web directory location> Example: Webdir.online.lync.com|

To troubleshoot, use one or more of the following methods, as appropriate for your situation:

- Use the nslookup command and a public DNS server to determine whether the DNS CNAME record is configured correctly.   
- If the user has the option, have the user switch between Wi-Fi and 3G to determine whether the issue can be scoped to one kind of connection. If sign in continues to fail on a 3G data connection, although the CNAME DNS records are configured, it may be an issue with the cellular service provider's data connection.   
- The user receives the following error message:
Cannot connect to the server. It might be unavailable. Also please check your network connection, sign-in address and server addresses.

   This error message usually indicates one of the following conditions:

    - A DNS lookup issue exists.   
    - The Auto-Detect CNAME records are configured incorrectly or aren't configured at all.   

- The user receives the following error message when the user tries to sign in:
Can't sign in. Please check your account information and try again.

   This error message indicates one of the following conditions:

   - The Skype for Business for Android  can discover the correct Skype for Business Online server. However, it can't find the sign-in address that was entered by the user.   
   - The password is incorrect.   
   
**Connecting over Wi-Fi through an authenticating proxy**

If the Wi-Fi connection that's used requires authentication before connecting, Skype for Business may not connect because it can't use the credentials to connect through a proxy. To work around this, connect through the mobile carrier's data connection instead of Wi-Fi.

**Contact lists**

The contact list that's displayed in the Skype for Business for Android is read-only and can't be changed from the mobile device. If a user wants to add or remove a contact from the list, the user must use the Skype for Business desktop client or Outlook Web App (OWA) Instant Messaging (IM).

Contact photos are displayed only if they're stored in the global address list (GAL). A contact who specified images through web URLs on the desktop client won't have a photo displayed for the contact.

**Chats tab and conversation history**

The Chats tab on the Lync mobile client for Google Android only keeps track of the conversations that occurred on the mobile device. It won't display chats from desktop clients. Chats on mobile devices aren't displayed in the conversation history folder in the user's Exchange mailbox.

**Security**

The Skype for Business client supports only digest authentication and does not support integrated/ SPNEGO for authenticated proxy.

**Notifications**

Some users may repeatedly see a notification with information that their calls are not set up to ring a mobile device. This is a known issue.

**Sending logs**

When users experience an issue with the Skype for Business for Android, they can send logs by email to the technical support engineer. To do this, follow these steps:

1. On the Android device, after a user is signed in, press the hardware menu button and tap Options in the menu. On the Options screen, check if the Logging option is turned on. If not, turn on the Logging option, sign out, and then sign in again.   
2. Reproduce the issue, return to the Options screen, and then tap Send Log Files.   
3. Select a configured email account.   
4. In the To box, enter the recipient's email address. In the Subject box, enter a subject, and then tap Send. Logs are attached as a .zip file.   

**Issues that arise after an OS update**

Assume that a new operating system update is released for your device. After you install the update, Skype for Business fails. However, before you installed the update, Skype for Business worked as expected. 

> [!NOTE]
> After commercially reasonable troubleshooting steps are taken, Support may inform the customer that in order to continue, engagement of the manufacturer will be necessary to obtain the correct resources to resolve the issue.

## More Information

[We can't sign you in error when you use an Android device to sign in to Lync Mobile](https://support.microsoft.com/help/2973873)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
