---
title: Images and tables missing in meeting requests
description: Describes an issue that causes images and tables in Outlook meeting requests to go missing. Occurs when a meeting request is sent from Outlook 2016 and is received in Outlook 2013 or Outlook 2010. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Images and tables are missing in Outlook 2013 or 2010 meeting requests received from Outlook 2016

_Original KB number:_ &nbsp; 3182818

## Symptoms

When you receive a meeting request in Microsoft Outlook 2013 or Outlook 2010, you discover that images and table structures are missing from the body of the request. The table content still appears, but it's no longer formatted as a table.

## Cause

This issue occurs if a meeting request that's sent from Outlook 2016 is received in Outlook 2013 or Outlook 2010.

## Resolution

To fix this issue for Outlook 2013, install the December 7, 2016, update for Outlook 2013, and then follow the steps in the Resolution section of KB3128018. For information about this update and the additional steps, see:

- [December 6, 2016, update for Outlook 2013 (KB3127975)](https://support.microsoft.com/help/3127975)
- [Tables, images, and attachments are missing in the received meeting requests in Outlook 2013](https://support.microsoft.com/help/3128018)

## Workaround

If you can't install the update that's mentioned in the Resolution section to fix this issue, or if you're running Outlook 2010, you can work around the issue by using one of the following options:

- You can view the meeting request in Outlook on the Web or in a different version of Outlook, such as Outlook 2016.
- The meeting request sender can use Rich Text Format (RTF) to create the request in Outlook 2016.
