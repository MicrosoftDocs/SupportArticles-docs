---
title: Lync users can't communicate with external contacts
description: Describes an issue in which you can't send messages to or connect to external contacts that you added to a Windows Live EASI domain. A resolution is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
- Lync 2013
- Lync 2010
---

# Lync users can't communicate with external contacts who have Microsoft accounts that have a custom (EASI) domain

## Problem

Consider the following scenario: 

- You add an external contact that uses a Microsoft account to a Skype for Business Online (formerly Lync Online) user's contact list.    
- The external contact uses a custom domain or an "email as sign in" (EASI) ID domain instead of a default @outlook.com address.    
- You add the contact to Lync by using the contact's email address. For example, you use the email address joe@live-contoso.com.    

In this scenario, you may experience the following issues: 

- Presence is unavailable, and the status is displayed as **Presence Unknown**.   
- Instant messages can't be delivered or sent.   

> [!NOTE]
> In the following sections, the following placeholders are used as examples of domains:
> - Skype for Business Online domain: contoso.com   
> - Windows Live EASI domain: live-contoso.com   

## Solution

To resolve this issue, use one of the following methods.

### Microsoft Lync 2013

The best method to add external contacts in Lync 2013 is to use the **Add Contact** icon. For more info about how to add contacts through search or the add contact wizard, go to the following Microsoft website:

[Add a contact in Lync](https://office.microsoft.com/redir/ha102828922.aspx)

### Microsoft Lync 2010

Use the Microsoft account together with Public Internet Connectivity (PIC) when you add a user to your Lync contact list. To do this, you must make a change in the search field. A Skype for Business Online user who wants to add the Microsoft account that uses a custom domain, such as <**username**>@live-contoso.com, must add an address that resembles the following to the search field: 

**JoeAndreshak(live-contoso.com)\@msn.com**

This method allows for a quick resolution if Skype for Business Online users are going to add only a few PIC contacts.

### Alternative resolution by using DNS

The Skype for Business Online administrator must add the correct Service (SRV) Federation records to the Domain Name System (DNS) host for the Skype for Business Online environment. The domain owner for the external contact's custom domain must also add an SRV record that resembles the following example:

> sipfederationtls._tcp.live-contoso.com  
> port = 5061  
> server hostname = federation.messenger.msn.com

Administrators can let Skype for Business Online users add contacts without having to use the special format that was discussed in the "Microsoft Lync 2010" section. To do this, administrators must add an SRV Federation record that Skype for Business Online users can access to add contacts to the Windows Live EASI domain.

## More Information 

PIC in Skype for Business Online supports connectivity with Microsoft accounts (msn.com, live.com and outlook.com). However, when you add PIC contacts that use a Windows Live EASI domain such as live-contoso.com, Skype for Business Online can't resolve the Instant Messaging (IM) Federation server based on the domain suffix. 

If you directly add a PIC contact by using the contact's EASI ID (for example, you use JoeAndreshak.@live-contoso.com), a specific SRV record is required in the DNS for live-contoso.com. This SRV record is required because the Skype for Business Online server uses the domain suffix in the user's EASI ID to determine how to route messages. In this example, the Skype for Business Online server tries to use the live-contoso.com domain suffix. 

For more info about how to troubleshoot Skype for Business Online federated contacts, see [Skype for Business Online users can't communicate with external contacts ](../online-im-presence/cannot-communicate-with-external-contacts.md).

> [!NOTE]
> This scenario also applies to contacts that are logging in to Skype by using their Microsoft accounts.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).