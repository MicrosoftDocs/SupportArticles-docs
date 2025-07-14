---
title: Upload a file to a library using the new experience version
description: This article describes an issue where you aren't prompted for required information when you upload a file to a SharePoint Online library using the new experience version, and provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Files and Documents\Upload
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# You aren't prompted for required information when you upload a file to a SharePoint Online library using the new experience version

## Problem

Consider the following scenario:

- You're using the new experience version for document libraries in SharePoint Online.

- You have a column where the **Require that this column contains information** setting is set to ***Yes***.

In this scenario, when you upload a file to the library, you're not prompted to enter a value for the required column. In addition, the file isn't checked out by default when you view it in the classic document library experience.

## Solution

To resolve this issue, use the classic view for the affected library. For more information, see [Switch the default experience for lists or document libraries from new or classic](https://support.office.com/article/66dac24b-4177-4775-bf50-3d267318caa9).

## More information

This issue occurs when you upload files to a SharePoint Online library that uses the new document library experience.

After you upload a file that's missing the required information, when you open the file in a Microsoft Office application, you may be prompted with one of the following messages: 

- REQUIRED PROPERTIES To save to the server, correct the invalid or missing required properties.

- This file cannot be saved because some properties are missing or invalid.

In the Microsoft Office application message, click **Edit Properties** or **Go to Document Properties**. Then type a value for the required column so that you're able to save any changes.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
