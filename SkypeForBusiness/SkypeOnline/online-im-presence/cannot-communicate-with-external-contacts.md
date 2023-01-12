---
title: Skype for Business Online users can't communicate with external contacts
description: Discusses that users can't communicate with external contacts in Microsoft Skype for Business Online in Microsoft 365. Provides a resolution.
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

# Skype for Business Online users can't communicate with external contacts

## Problem 

You experience one of the following symptoms in Skype for Business Online (formerly Lync Online):

- Instant messages aren't delivered to external contacts. When you try to send an instant message to an external contact in Skype for Business Online, you receive the following error message:

    **This message was not delivered to joe@contoso-federated.combecause the address is outside your organization and is not federated with your company, or the address is incorrect. Please contact your support team with this information.**

    > [!NOTE]
    > In this error message, joe@contoso-federated.com is a placeholder.

    The following error message may also be recorded in the Lync 2010 UCCAPI logs:

    **403 Forbidden: From URI not authorized to communicate with federated partners.**
   
- Presence is unknown for an external contact. When you search for the external contact, or you review an external contact who's already added to your contact list, the presence icon is unavailable (it appears dimmed), and **Presence Unknown** is displayed.   
- External contacts can't join Skype for Business Online meetings. When the external contact receives a Skype for Business Online meeting invitation and then clicks Join Online Meeting, the user receives an error message that states that the person doesn't have permission to join the meeting, and the connection fails.   

## Solution 

The first step to resolve issues that affect Skype for Business Online is to scope the issue appropriately. The following table will help determine what the most likely cause of the issue is, depending on the type and number of contacts that are affected.

|Type and number of external contacts |One external contact |Multiple external contacts |All external contacts |
|-|-|-|-|
|External Lync contact|Permissions issue between contacts|Permissions issue between domains|External Communications disabled or Federation SRV record missing |
|Public IM contact (Microsoft Messenger, Skype)|Permissions issue between contacts|Contacts not added in correct format|External Communications for PIC disabled or Federation SRV record missing|

### Configuring external communications for Skype for Business Online  
 
Microsoft 365 enterprise and academic customers can configure individual access options for the following external contacts on both an organization and user level: 
 
- Other organizations that are using Skype for Business Online, Microsoft Lync Server 2010, Microsoft Lync Server 2013, or Microsoft Office Communications Server 2007 R2    
- Public Instant Messaging (IM) contacts on Skype or Microsoft Messenger    
 
Microsoft 365 professional and business customers can turn external communications on or off only for all external contacts. This includes other Lync or OCS organization and public IM contacts on Skype or Microsoft Messenger. This setting can be configured at the organization or user level.

For help configuring external communications for your organization, go to the following Microsoft website: 
 
- [Guided Walkthrough: Set up Skype for Business Online External Communications](https://support.microsoft.com/help/10041/)

### Resolving permissions issues between individual contacts  
 
Both external contacts have to be added to one another's contact lists, and they must have the appropriate permissions. For more information, go to the following Microsoft websites: 
 
- [Control access to your presence information in Lync 2010](https://office.microsoft.com/redir/ha101850361.aspx)    
- [Control access to your presence information in Lync 2013](https://office.microsoft.com/redir/ha102925421.aspx)    
 
> [!NOTE]
> In Lync, make sure that the setting to block all invites isn't set. Open the Lync **Options** page and then click **Alerts**. Under **Contacts not using Lync**, clear the box labeled **Block all invites and communications**.

Generally for troubleshooting, if two external contacts have problems communicating, they should both completely remove the other contact from their own contact list. Re-add the external contact and then verify that notifications are being sent and accepted by each contact involved.

If you're trying to communicate with Skype users, make sure that the Skype users have upgraded to the latest client on Windows (version 6.3 or a later version).

### Resolving permissions issues between domains  
 
If your Skype for Business Online users can't communicate with all external contacts from a specific domain, this problem might occur for either of the following reasons: 
 
- The external contact's domain isn't set up for federation.    
- The domain isn't included on the allowed domains list in the Lync Control Panel or Lync Admin Center.    
 
If the external contact's organization hasn't been configured for federation with Skype for Business Online, go to the following TechNet website: 

[Configuring Federation Support for a Skype for Business Online Customer](/previous-versions/office/lync-server-2013/lync-server-2013-configuring-federation-support-for-a-lync-online-customer) 
 
After you verify that federation is configured correctly for the external contact's domain, Microsoft 365 for enterprises customers should examine the Lync Control Panel or Lync Admin Center to make sure that the external contact's domain is either on the allowed list of domains or not on the blocked list of domains. For guidance about how to configure external communications with other organizations, view the following Microsoft website: 

[Configure external communications](https://support.microsoft.com/office/9e15aceb-8d92-4fe0-ab76-2657bd4ef804)

### Adding contacts in the correct format  
Contacts that don't use the standard domains for Microsoft Messenger, such as live.com, outlook.com, msn.com or Hotmail.com, must be added to Lync by using a special format. For information about how to add external contacts in this manner, go to the following article in the Microsoft Knowledge Base: 

[2566829](https://support.microsoft.com/help/2566829) Lync users can't communicate with external contacts who have Microsoft accounts that have a custom (EASI) domain

### Verify the Federation SRV record for Skype for Business Online  
 
Federation with external organizations requires an SRV record in DNS that directs external organizations to Skype for Business Online when they try to communicate. If that SRV record is missing or incorrectly configured, all communication with external contacts fails. To verify that the record is configured correctly, go to the following article in the Microsoft Knowledge Base:

[2566790](https://support.microsoft.com/help/2566790) Troubleshooting Skype for Business Online DNS configuration issues in Microsoft 365      

## More information

These issues occur because external communications in Skype for Business Online may be turned off or incorrectly configured. Or, if the external contact is a member of another Lync Server or Office Communications Server organization, external access may also be configured incorrectly. 

Note Federation with Skype isn't supported at this time. However, external contacts who have Microsoft accounts can log on to the Skype client instead of to Microsoft Messenger. Federation with Microsoft accounts is still supported, whether the external contacts use Microsoft Messenger or the Skype client. After an external contact who has a Microsoft account logs into Skype, the user will no longer be able to use video conferencing. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).