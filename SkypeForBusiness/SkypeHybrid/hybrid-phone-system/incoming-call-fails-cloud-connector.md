---
title: Incoming call fails when you use Skype for Business Cloud Connector Edition
description: Describes an issue that triggers a We're sorry, we cannot complete your call at this time error when you use Skype for Business Cloud Connector Edition. Provides a solution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 03/31/2022
---

# Incoming call fails when you use Skype for Business Cloud Connector Edition

## Problem 

Consider the following scenario:

- Your Microsoft 365 user account is configured to use Cloud PBX.   
- You're using Skype for Business on Windows to receive calls, and the voice for calls uses Skype for Business Cloud Connector Edition.   
- People report that they can't call you.
- Your Skype for Business administrator has confirmed that your account is configured correctly to receive calls.   
- The **InternetDNSIPAddress** property is configured by using the correct public DNS server IP address in the CloudConnector.ini file.   

In this scenario, an incoming call fails and you receive either a fast busy signal or a recording whose content resembles the following:
 We're sorry, we cannot complete your call at this time.

## Solution 

Use one of the following methods, as appropriate for your situation.

### Method 1
 
Configure the external network interface on the Cloud Connector Edge server to use a public DNS server.

Note Make sure that you modify the Advanced settings on this interface to remove the **Register this connection's addresses in DNS** option.

### Method 2
 
For Cloud Connector Edition 1.4.1, modify the Cloud Connector DNS server to use pinpoint zones, or add the missing public DNS record (or records) for Cloud Connector to the internal DNS zone. 

## More information

The Cloud Connector Edition Edge Server cannot resolve the **sipfederationtls** DNS SRV record for the user's SIP domain (or domains). A Skype for Business Server logging trace on the Edge server shows the following errors:

- **SIP/2.0 504 Server time-out error**   
- **ms-diagnostics error 1008 "Unable to resolve DNS SRV record"**   
 
For Cloud Connector Edition 1.4.1, the Edge Server is configured to use the internal Cloud Connector Edition DNS server, and this server has an authoritative zone configured for the SIP domain.

For Cloud Connector Edition 1.4.2, the Edge Server is not automatically configured by using the DNS IP that's defined in the Cloud Connector configuration file.For more information, see the following Microsoft websites:

- [Plan for Skype for Business Cloud Connector Edition](/skypeforbusiness/skype-for-business-hybrid-solutions/plan-your-phone-system-cloud-pbx-solution/plan-skype-for-business-cloud-connector-edition)   
- [Advanced DNS planning for Skype for Business Server 2015](/previous-versions/office/communications/mt346420(v=ocs.16))   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
