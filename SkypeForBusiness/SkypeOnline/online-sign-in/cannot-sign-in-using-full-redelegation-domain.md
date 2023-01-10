---
title: Cannot sign in to Skype for Business Online with a full redelegation domain
description: Discusses an issue in which you can't sign in to Skype for Business Online by using a domain that's configured for full redelegation in Microsoft 365 for Small Business. A resolution is provided.
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

# You can't sign in to Skype for Business Online by using a domain that is configured for full redelegation

## Problem 

When you try to sign in to Skype for Business Online (formerly Lync Online) in Microsoft 365 as a Microsoft 365 Business customer who has a custom verified domain, you receive an error message that indicates that the server is temporarily unavailable.

> [!NOTE]
> Microsoft 365 Apps customers who have custom verified domains have those domains fully redelegated to Microsoft 365. "Full domain redelegation" indicates a domain for which the name server (NS) resource records point to Microsoft 365. Therefore, the Domain Name System (DNS) records that are required for Microsoft 365 functionality are managed by Microsoft 365.  

## Solution 

To fix this problem, follow these steps:

1. Make sure that the NS resource records point to Microsoft 365. To do this, use the Nslookup tool to query the name server records for your domain. The NS resource records should point to two of the following fully qualified domain names (FQDNs):
   - ns1.bdm.microsoftonline.com   
   - ns2.bdm.microsoftonline.com   
   - ns3.bdm.microsoftonline.com   
   - ns4.bdm.microsoftonline.com   

    > [!NOTE]
    > If the domain was recently configured for full domain redelegation, you should wait for 72 hours before you run a query.   
2. If you still can't sign in after the NS resource records have been changed, there may be a delay in publishing the Skype for Business Online DNS records. If this occurs, test the DNS records. To do this, follow these steps:
   1. Browse to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/) website.   
   2. Select the **Office 365** tab.   
   3. Select **Skype for Business Online DNS Connectivity Test**.   
   4. Enter the address that you use to try to sign in to Skype for Business Online (for example, darrin@contoso.com), and then start the test.   

    This test examines all four DNS records that are required by Skype for Business Online to determine whether they're correctly configured. The results of the test will resemble the following output.

    :::image type="content" source="./media/cannot-sign-in-using-full-redelegation-domain/test.png" alt-text="Screenshot that shows the result for the Remote Connectivity Analyzer.":::

If the NS records and the Lync Service (SRV) records are correct, perform standard Lync sign-in troubleshooting.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).