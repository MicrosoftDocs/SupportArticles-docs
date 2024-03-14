---
title: Can't send email messages from a domain that's set up for full redelegation
description: Describes an issue in which you can't send email messages from a Microsoft 365 Small Business environment for a domain that's set up for full redelegation. Provides a resolution.
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
ms.reviewer: willfid
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# You can't send email messages in Microsoft 365 from a domain that's set up for full redelegation

## Problem

When you try to send email messages in Microsoft 365 for business from a domain that's set up for full redelegation, some messages aren't sent. Additionally, you may receive a nondelivery report (NDR) that resembles the following:

"smtp; 550 SPF MAIL FROM check failed (PermError)"

> [!NOTE]
> A domain that is set up for full redelegation is a domain in which the name server (NS) resource records point to Microsoft 365. Full domain redelegation is available only for Microsoft 365 for business subscriptions.  

## Solution

To fix this issue, follow these steps:

1. Use the NsLookup tool to check whether the NS resource records point to Microsoft 365. To do this, follow these steps:
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
3. Use the NsLookup tool to perform a DNS lookup on the TXT (SPF) record. To do this, follow these steps:
   1. Click **Start**, and then, in the search box, type command prompt.    
   2. In the list of results, right-click **Command Prompt**, and then click **Run as administrator**.   
   3. At the command prompt, type nslookup, and then press Enter.   
   4. Type set type=txt, and then press Enter.   
   5. Type your domain name (for example, type contoso.com), and then press Enter.

     The TXT (SPF) record should resemble the following: 
     
     "v=spf1 include:outlook.com ~all"   

## More information

For more information about the NsLookup tool, see [NsLookup](https://support.microsoft.com/help/200525).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
