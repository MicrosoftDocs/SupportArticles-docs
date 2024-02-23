---
title: Cannot open calendar with Free/Busy permission
description: Describes an issue in which a user can't open your Calendar to view your Free/Busy info in Outlook for Mac. Instead, the user receives an error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 10/30/2023
---
# User with Free/Busy permission can't open another calendar in Outlook for Mac

_Original KB number:_ &nbsp; 2876443

## Symptoms

A user grants you Free/Busy permission to their calendar, but when you try to open that user's calendar in Microsoft Outlook 2016 for Mac or Outlook for Mac 2011, you receive the following error message:

> Outlook cannot open the folder. You do not have permission to open this folder. Contact <user_name> for permission.

## Cause

Outlook for Mac cannot open another user's calendar when the user's Calendar folder permission level is set to Free/Busy. This feature is available only in Outlook 2010 and Outlook 2013 for Windows.

For more information, see [Calendar permissions differences in Outlook 2007, Outlook 2010 and Outlook 2013](https://support.microsoft.com/help/2816258).

## Resolution

To open a shared calendar in Outlook for Mac, the user must grant you permissions of Reviewer or higher. Or, you can view the user's Free/Busy information by creating a new meeting request and then adding that user in the Scheduling Assistant.
