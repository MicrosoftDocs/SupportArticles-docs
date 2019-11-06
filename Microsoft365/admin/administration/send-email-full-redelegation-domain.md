---
title: Can't send email messages from a domain that's set up for full redelegation
description: Describes an issue in which you can't send email messages from an Office 365 Small Business environment for a domain that's set up for full redelegation. Provides a resolution.
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
ms.reviewer: willfid
appliesto:
- Office 365 User and Domain Management
---

# You can't send email messages in Office 365 Small Business from a domain that's set up for full redelegation

## Problem

When you try to send email messages in Office 365 Small Business from a domain that's set up for full redelegation, some messages aren't sent. Additionally, you may receive a nondelivery report (NDR) that resembles the following:

"smtp;550 SPF MAIL FROM check failed (PermError)"

**Note** A domain that is set up for full redelegation is a domain in which the name server (NS) resource records point to Office 365. Full domain redelegation is available only for Office 365 Small Business subscriptions and Office 365 for small businesses subscriptions.  

## Solution

To fix this issue, follow these steps:

1. Use the Nslookup tool to check whether the NS resource records point to Office 365. To do this, follow these steps:
   1. Click **Start**, and then, in the search box, type command prompt.    
   2. In the list of results, right-click **Command Prompt**, and then click **Run as administrator**.   
   3. At the command prompt, type nslookup, and then press Enter.   
   4. Type set type=ns, and then press Enter.   
   5. Type your domain name (for example, type contoso.com), and then press Enter.

   The NS resource records should point to two of the following: 
    - ns1.bdm.microsoftonline.com   
    - ns2.bdm.microsoftonline.com   
    - ns3.bdm.microsoftonline.com   
    - ns4.bdm.microsoftonline.com      
   
2. If the domain was recently set up for full domain redelegation, wait 72 hours.    
3. Use the Nslookup tool to perform a DNS lookup on the TXT (SPF) record. To do this, follow these steps:
   1. Click **Start**, and then, in the search box, type command prompt.    
   2. In the list of results, right-click **Command Prompt**, and then click **Run as administrator**.   
   3. At the command prompt, type nslookup, and then press Enter.   
   4. Type set type=txt, and then press Enter.   
   5. Type your domain name (for example, type contoso.com), and then press Enter.

     The TXT (SPF) record should resemble the following: 
     
     "v=spf1 include:outlook.com ~all"   

## More information

For more information about the Nslookup tool, see [Nslookup](https://support.microsoft.com/help/200525).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
