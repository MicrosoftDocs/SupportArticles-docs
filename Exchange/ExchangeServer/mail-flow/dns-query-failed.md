---
title: 451 4.4.0 DNS query failed Exchange Server error in message queue
description: Describes an issue in which you receive an Exchange Server error when you send email to remote domains. Provides a workaround and a resolution.
author: simonxjx
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition

---

# 451 4.4.0 DNS query failed Exchange Server error in message queue

## Error occurs when you send email to specific remote domains 

This problem may occur because the remote DNS servers ignore the AAAA query or return an unexpected response. 

To work around this issue, create send connectors for the affected remote domains. (Create a send connector for each domain). Then, configure the send connectors to use the mail server in the remote domain as a smart host. To do this, follow these steps:

1. Check the IP address of the MX record (mail server) for the affected remote domain. To do this, use nslookup or [MX Record lookup tool](https://www.bing.com/search?q=mx+lookup+tool&form=awre).    
2. Create a new send connector for this domain. Make sure that you configure the following settings:
  1. In the **Address space** section, add the affected remote domain such as contoso.com.

   ![Address space](https://support.microsoft.com/Library/Images/3059027.jpg)   
  2. In the **Network setting** section, select **Route mail through the following smart hosts**. Add the IP address of the MX record that you checked in step 1.

   ![Network setting](https://support.microsoft.com/Library/Images/3059028.png)   
  3. Set **Smart host authentication settings** to **None**.

   ![The screenshot for step C ](https://support.microsoft.com/Library/Images/3060536.jpg)

   For other settings, you can use the default value. For more information, see [Configure a Dedicated Send Connector for a Specific Domain](https://technet.microsoft.com/library/jj657457%28v=exchg.160%29.aspx).   

When Exchange Server sends email to this remote domain, it will now bypass the DNS query and connect the mail server in the remote domain by using the IP address directly. 

## Error occurs when you send email to all remote domains

This problem may occur because the DNS server that Microsoft Exchange Server uses is not working. By default, Exchange Server uses network adapter DNS settings for outgoing remote mail routing. 

To resolve this issue, fix the issues in your local DNS server, or configure the external DNS server for remote mail routing. To configure the external DNS server for remote mail routing, follow these steps:

1. Open the Proprieties page of the Exchange server that hosts the send connector, and then add the IP address of [public DNS servers](https://www.bing.com/search?q=public+dns+server&go=submit+query&qs=bs&form=qbre) in the **External DNS Lookups** setting.

   ![The screenshot for step 1 ](https://support.microsoft.com/Library/Images/3060537.png)   
2. Select the **Use the external DNS lookup settings on servers with the transport roles** option in the send connector that is responsible for remote mail routing.

   ![The screenshot for step 2 ](https://support.microsoft.com/Library/Images/3060538.png)