---
title: An OLE registration error occurred message
description: Describes an issue in which you receive an Outlook Object Model Run-time error when you try to access an InfoPath Forms folder in Outlook 2016, Outlook 2019 or Outlook for Microsoft 365.
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
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# An OLE registration error occurred message when you access an InfoPath Forms folder in Outlook

_Original KB number:_ &nbsp; 3095452

## Symptoms

When you try to access an InfoPath Forms folder in your mailbox in Microsoft Outlook 2016, Outlook 2019, or Outlook for Microsoft 365, you receive the following error message in Outlook:

> Cannot display the folder. An OLE registration error occurred. The program is not correctly installed. Run Setup again for the program.

If you have a programmatic solution that uses the Outlook Object Model to access the InfoPath Forms folder, you receive the following Microsoft Visual Basic run-time error message:

> Run-time error '-2147221164 (80040154)':  
An OLE registration error occurred. The problem is not correctly installed. Run Setup again for the program.

## Cause

Office 2016, Office 2019, and Outlook for Microsoft 365 do not include InfoPath desktop client. InfoPath 2013 is the last release of the desktop client.

## Workaround

If you are not actively using InfoPath forms in Outlook, you can prevent the errors in the Symptoms section by deleting the InfoPath Forms folder from the Outlook folder list. Before deleting the folder, use an earlier version of Outlook to view and back up the contents.
