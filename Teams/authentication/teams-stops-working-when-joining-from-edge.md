---
title: Can't join Teams when using IE or Edge
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Describes a resolution where you're unable to sign in using Internet Explorer or Edge.
---

# Teams stops working when joining from Edge or Internet Explorer 

## Symptoms

When trying to join Microsoft Teams using Edge or Internet Explorer, Teams will loop, stop working, or fail to sign in.

## Cause

Your organization utilizes Trusted Sites in Internet Explorer. The Teams web-based application will not correctly sign in if Teams are not allowed as a trusted site.

## Resolution

Make the following changes to IE or Edge settings from the Control Panel, either with Administrator rights or a Group Policy Object:

1. Under **Internet Options** > **Privacy** > **Advanced**, accept **First-Party and Third-Party cookies**, and check the box for **Always allow session cookies**.
2. Select **Internet Options** > **Security** > **Trusted Sites** > **Sites**, and add the following URLs:
   - https://login.microsoftonline.com
   - https://*.teams.microsoft.com

> [!NOTE]
> Always validate and allow all trusted URLs for Teams and the requirements from the following document: [Microsoft 365 URLs and IP address ranges.](/office365/enterprise/urls-and-ip-address-ranges)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).