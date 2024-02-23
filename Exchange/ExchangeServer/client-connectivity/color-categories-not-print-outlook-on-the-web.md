---
title: Color categories in a calendar aren't print in Outlook on the web
description: Resolves an issue that occurs when you use Outlook on the web to connect to your mailbox in Exchange Server 2016, Exchange Server 2013, or Microsoft 365 and then assign color categories to calendar appointments.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: yumatsum, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Color categories in a calendar don't print in Outlook on the web

_Original KB number:_ &nbsp;2882885

## Symptoms

Consider the following scenario:

- You use Outlook on the web (formally known as Outlook Web App) to connect to your mailbox in Microsoft Exchange Server 2016, Microsoft Exchange Server 2013, or Microsoft 365.
- You assign color categories to calendar appointments.
- You click **Print** to print the calendar.

In this scenario, the color categories don't print.

## Resolution

To resolve this issue, follow these steps, depending on the version of Internet Explorer that you're using.

### Internet Explorer 10 and Internet Explorer 9

1. Click the **Tools**  icon, or press Alt+X.
1. Select **Print**, and then click **Page setup**.
1. Select the **Print Background Colors and Images** option, and then click **OK**.

### Internet Explorer 8

1. Click **Tools**, and then click **Internet Options**.
1. On **Advanced** tab, select the **Print background colors and images** option, and then click **OK**.
