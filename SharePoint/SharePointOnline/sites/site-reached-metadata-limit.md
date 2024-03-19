---
title: SharePoint site metadata is at or near limit error message
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Storage\Site Storage
  - CI 118775
  - CSSTroubleshoot
ms.reviewer: arkumar
description: How to resolve an issue where you are at or near the metadata limit for your SharePoint site.
---

# SharePoint site is at or near the metadata limit

## Symptom

You see one of the following messages on the **Storage metrics** page of your SharePoint Online site:

> This site is close to the metadata limit

or

> This site has reached the metadata limit

## Cause

Your site is approaching or has exceeded the metadata storage limit set for the site. More information about the limit can be found in the article [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits).

## Resolution

To resolve this issue, create more space by deleting old file versions and duplicate files in [lists](https://support.microsoft.com/office/add-edit-or-delete-list-items-a4b31f53-f044-470e-9823-4526594bacde) and [libraries](https://support.office.com/article/Delete-files-in-a-library-DDA553F9-33C0-4BB1-86C3-EEF703C94629). 

## More information

A SharePoint site contains system-generated information (metadata) about the saved files and lists on your site, such as file size, author, creation date, versions of the file, lists, etc. This information counts against the overall storage limit for your site. Generally, creating multiple versions of the same file and list or creating copies of the same file contributes to an increase in this type of metadata storage. 


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
