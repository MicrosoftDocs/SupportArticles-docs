---
title: Cannot sign in after PIC or External Communications is enabled
description: Describes an issue in which users can't sign in to Skype by using their Microsoft account after PIC or External Communications is enabled in Skype for Business Online. This issue occurs if Microsoft 365 uses the same domain as the user's Microsoft account. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Users can't sign in to Skype by using their Microsoft account after Public IM Connectivity (PIC) or External Communications is enabled in Skype for Business Online

## Problem 

Consider the following scenario:

- Users use an "email as sign in" (EASI) account or a custom domain as their Microsoft account to sign in to Microsoft services. For example, they use **username**@contoso.com.
- The domain in the users' Microsoft account is the same as the domain that Microsoft 365 uses.

In this scenario, the users try to sign in to Skype. However, they can't use their current Microsoft account to sign in to Skype. Instead, the users are forced to change their Microsoft account so that it uses a different domain.

## Solution 

To resolve this issue, use one of the following methods: 

- Method 1: For Microsoft 365 Enterprise organizations, disable PIC in the Skype for Business (formerly Lync Online) Admin Center. To do so, follow the steps in [Let Skype for Business Online users communicate with external Lync or Skype contacts](https://support.microsoft.com/office/9e15aceb-8d92-4fe0-ab76-2657bd4ef804).
- Method 2: For Microsoft 365 Business organizations, disable External Communications on the Microsoft 365 Service Settings page. To do so, follow the steps in [Let Skype for Business Online users communicate outside your organization](https://support.office.com/en-us/article/let-skype-for-business-online-users-communicate-outside-your-organization-89d9cbeb-c35d-42be-8a95-92c14444eac8).
- Method 3: Use a different domain for your Microsoft account, or use a different domain in Microsoft 365.
  
## More information

This issue occurs if the following conditions are true: 

- The users' Microsoft account uses the same domain name as Microsoft 365.
- Public IM connectivity (PIC) is enabled in Skype for Business Online for Microsoft 365 Enterprise organizations.
- External Communications is enabled in Skype for Business Online for Microsoft 365 Business organizations.

In this scenario, when the users sign in to Skype, they are forced to change their Microsoft account to use a domain that isn't in conflict with Microsoft 365.

This issue occurs because of the way that the session initiation protocol (SIP) services are advertised. The Microsoft 365 and Skype environments can coexist if PIC or External Communications is disabled for the Microsoft 365 domain. However, if PIC or External Communications is enabled for the Microsoft 365 domain, the Microsoft 365 domain becomes the authoritative SIP domain and hosts the service. Therefore, when users try to sign in to Skype, the Microsoft account service recognizes that Microsoft 365 controls the domain namespace and requires the users to change their Microsoft account to use a different domain.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
