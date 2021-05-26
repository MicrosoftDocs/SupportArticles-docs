---
title: Can't send an IM to external contacts from Outlook Web App
description: Describes a problem that prevents you from sending an instant message in Outlook Web App to your external contacts. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: girishg, dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
---

# You can't send an IM to external contacts from Outlook Web App

## Problem

You try to start an instant message (IM) conversation in Outlook Web App with an external contact, also known as a federated contact. You do this from another Lync or Office Communications Server (OCS) organization. However, the message isn't sent, and no error message is generated.

## Solution 

> [!NOTE]
> This solution requires the assistance of an Office 365 administrator.

To resolve this issue, create a Contact object in the Exchange Admin Center, and then add the external contact's IM address to the **Proxy Address** field. Make sure that the IM address contains the **sip:** prefix for the IM address of the external contact.

For more information about how to add the IM address as a proxy address to the external contact, use the instructions at the following Microsoft website, but make sure that you use the "sip:user2@sip-contoso.com" format for the address.

[Add or remove email addresses for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/add-or-remove-email-addresses)

To send an IM to the newly created external contact, type the contact's IM address, and then add **sip:** to the beginning of the IM address. The message should be sent successfully.

## More Information

This issue occurs when the **IM Address** field is populated only with **user2\@sip-contoso.com**. Outlook Web App uses the IM address to look for external contacts in Active Directory Domain Services (AD DS) that have a matching Session Initiation Protocol (SIP) address in the **ProxyAddresses** attribute in AD DS. However, the IM address in the **ProxyAddresses** attribute always includes the **sip:** prefix. If the **IM Address** field is populated only by **user2\@sip-contoso.com**, Outlook Web App won't be able to find the user, and the IM will fail. 

The IM address must also exist as a SMTP proxy address for the user account. Although the IM address doesn't have to be a primary SMTP address, it must exist so that the user and the SIP address can be located. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).