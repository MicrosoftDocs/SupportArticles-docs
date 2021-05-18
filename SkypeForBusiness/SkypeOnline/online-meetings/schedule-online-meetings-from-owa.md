---
title: Can't schedule meetings, see presence info, or send IMs from Outlook Web App
description: Describes a problem in which online meeting scheduling, presence, and IM services aren't available in Outlook Web App when you use OWA in Office 365.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Can't schedule Skype for Business Online meetings, see presence info, or send IMs from Outlook Web App in Office 365

## Problem 

When you use Outlook Web App in Office 365, you may experience the following issues: 

- You can't schedule Skype for Business Online (formerly Lync Online) meetings in Outlook Web App because the link or button to do this is missing.   
- You can't see presence information for contacts in Outlook Web App.   
- When you try to use the Instant Messaging (IM) feature in Outlook Web App, you receive the following error message:
   
  **Instant Messaging isn't available right now. The Contact List will appear when the services become available.** 

## Solution 

To resolve this issue, make sure that the DNS records for your domain's DNS host are configured correctly. Specifically, the DNS SRV record for federation and the LyncDiscover DNS CNAME record are required for IM and online meeting functionality to work in Outlook Web App. For more information, see
[Troubleshooting Skype for Business Online DNS configuration issues in Office 365](https://support.microsoft.com/help/2566790).

If the DNS record is created correctly but you continue to receive the error message, contact Office 365 technical support for additional assistance. Before you contact support, try to run the Get-Mailbox cmdlet and have the results available for the support tech. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see the following help topic: 
  
   [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
1. Run the **Get-Mailbox** cmdlet on the affected users, and then save the results. For more info about this cmdlet, see the following help topic:

   [Get-Mailbox](http://help.outlook.com/140/dd575549.aspx#mailboxes)

## More Information

This issue occurs if certain DNS records are missing or misconfigured with the DNS host of the custom domain.

Each DNS host is different, and each host may have different ways of adding DNS records. To identify your DNS host and to learn how to add specific DNS records, see the following Office 365 help topic:

[Locate your domain registrar or DNS service provider](https://office.microsoft.com/client/15/help/home?shownav=true&lcid=1033&ns=o365entadmin&ver=15&services=rms_s_enterprise_b_pilot%2coffice_pro_plus_subscription_b_pilot%2clync_s_enterprise_b_pilot%2csharepointwac_b_pilot%2csharepoint_s_enterprise_b_pilot%2cexchange_s_enterprise_b_pilot)

If you're trying to integrate the Exchange Online Outlook Web App with an on-premises Lync Server 2013 deployment or the other way around, go to the following Microsoft Knowledge Base articles:

- [2614614 ](https://support.microsoft.com/help/2614614) How to integrate Exchange Online with Skype for Business Online, Lync Server 2013, or a Lync Server 2013 hybrid deployment   
- [2614242 ](https://support.microsoft.com/help/2614242) How to integrate Exchange Server 2013 with Lync Server 2013, Skype for Business Online, or a Lync Server 2013 hybrid deployment

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).