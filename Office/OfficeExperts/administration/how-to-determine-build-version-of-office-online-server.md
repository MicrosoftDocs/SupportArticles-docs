---
title: Determine the build version of Office Web Apps 2013 or Office Online Server
description: Describes how to determine the build version of Office Web Apps 2013 or Office Online Server.
author: helenclu
ms.author: luche
ms.reviewer: thempel
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# How to determine the build version of Office Online Server

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

This article introduces two ways to determine the build version of your Office Web Apps 2013 or Office Online Server.

## Method 1: Run the "Get-Content" cmdlet in an Admin PowerShell window if you have access to the servers

To get the build version, run the following cmdlet:
```
get-content C:\ProgramData\Microsoft\OfficeWebApps\Data\local\OfficeVersion.inc
```
The build version that begins with 15.0 is Office Web Apps 2013.The build version that begins with 16.0 is Office Online Server.

**Office Web Apps 2013**

:::image type="content" source="media/how-to-determine-build-version-of-office-online-server/office-web-apps-2013.png" alt-text="Screenshot of the cmdlet result for Office Web Apps 2013." border="false":::

**Office Online Server**

:::image type="content" source="media/how-to-determine-build-version-of-office-online-server/office-online-server.png" alt-text="Screenshot of the cmdlet result for Office Online Server." border="false":::

## Method 2: Run a network trace if you don't have access to the servers directly

To get the build version, you can run a network trace while opening a document in a browser and inspect the response header.

There are many network tracing tools that you can use. However, if the SharePoint and Office Web Apps farms are running HTTPS, Fiddler is the easiest tool for the job. You can check the **X-OfficeVersion** in the **Response Headers** to determine the build version.

:::image type="content" source="media/how-to-determine-build-version-of-office-online-server/response-headers.png" alt-text="Screenshot to check the X-OfficeVersion in the Response Headers." border="false":::
