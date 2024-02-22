---
title: The Sent time stamp on email messages is incorrect in Outlook on the web
description: Describes sent time stamp on email messages is incorrect in Outlook on the web
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Outlook on the web
ms.date: 01/24/2024
ms.reviewer: v-six
---

# The "Sent" time stamp on email messages is incorrect in Outlook on the web

## Symptoms

The **Sent** time stamp on email messages may be incorrect when you sign in to Outlook on the web (formally known as Microsoft Outlook Web App or Outlook Web App) in a corporate messaging environment. Additionally, the time on meeting requests may also be incorrect.

## Cause

This issue can occur if all the following conditions are true:

- You are in a region that does not follow daylight saving time (DST).   
- The server that is running Microsoft Exchange Server where the mailbox is hosted is located in a region that follows DST.   

## Resolution

To work around this issue, set the time zone on the Exchange Server to a region that matches the Coordinated Universal Time (UTC) zone of the country/region where the server is located. Make sure that the UTC zone for that country/region doesn't follow DST.

**[Set Regional Settings in Outlook on the web](/previous-versions/exchange-server/exchangeserver-149/dd188698(v=exchsrvcs.149))**

You may also have to set the time zone in Microsoft Outlook Web App or in Outlook Web App. To do this, follow these steps, as appropriate for your situation. 

### Microsoft Exchange Server 2013

1. Log on to Microsoft Outlook Web App.   
2. Click **Settings**.   
3. Click **Options**.   
4. Click **Settings**.   
5. Click **Regional**.   
6. Under **Current time zone**, click the time zone that you want.   

### Microsoft Exchange Server 2010

1. Log on to Microsoft Outlook Web App.   
2. Click **Options**, and then click **See All Options**.   
3. Click **Settings**.   
4. Click **Regional**.   
5. Under **Current time zone**, click the time zone that you want.   

### Microsoft Exchange Server 2007

1. Log on to Microsoft Office Microsoft Outlook Web App.  
2. Click **Options**.   
3. Click **Regional Settings**.   
4. In the **Current time zone** box, click the time zone that you want.   

## More Information

This issue does not occur when you use Microsoft Outlook because Outlook uses the time zone information from the client operating system.
