---
title: Cannot save templates in My Templates
description: Describes an issue in which Microsoft 365 users are unable to save templates in the My Templates App in Outlook Web App.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Template is too large to save or template couldn't be saved error in the My Templates app in Outlook Web App

_Original KB number:_ &nbsp; 3006968

## Symptoms

When Microsoft 365 users try to save a template in the My Templates app in Outlook Web App, they receive an error message that resembles one of the following:

> This template is too large to save. Please make it smaller, then try to save it again.

> Your template couldn't be saved. Please try again later.

## Cause

This problem occurs if the total size of all templates in the My Templates app is more than 32 kilobytes (KB). The My Templates app has a total size limit of 32 KB for all templates.

## Resolution

Reduce the amount of content so that the combined size of all templates is less than 32 KB.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
