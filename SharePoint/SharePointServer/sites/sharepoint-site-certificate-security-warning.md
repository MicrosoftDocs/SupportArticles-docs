---
title: The name on the security certificate is invalid
description: Fixes an issue in which you receive a The name on the security certificate is invalid or does not match the name of the site error message when you start Outlook that has one or more Microsoft SharePoint calendars or lists.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.reviewer: sercast, aruiz
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
search.appverid: MET150
ms.date: 12/17/2023
---
# Certificate security warning for a SharePoint site when you start Outlook

_Original KB number:_ &nbsp; 2121926

## Symptoms

When you configure Microsoft Outlook to have one or more Microsoft SharePoint calendars or lists, and then you start Outlook, you receive the following certificate security warning:

> The name on the security certificate is invalid or does not match the name of the site.

## Cause

This issue occurs because of the **Alternate access mappings** setting on the SharePoint server. When SharePoint servers are on the same network as Outlook, the Intranet Zone mapping in SharePoint takes precedence over the Default mapping. If the intranet URL doesn't match the certificate URL, you receive the security alert that described in the "Symptoms" section.

## Resolution 1

To manage **Alternate access mappings** on the SharePoint server, follow these steps.

1. Click **Start**, click **All Programs**, click **Microsoft Office Server**, and then click **SharePoint 3.0 Central Administration**.
2. On the Central Administration home page, on the top navigation bar, select **Operations**.
3. On the Operations page, in the **Global Configuration** section, select **Alternate access mappings**.
4. Click the URL that's listed as **Intranet**.
5. Update the URL to match the URL that is listed on the certificate. Or, select **Delete** to remove the entry.
6. Click **OK** to save changes.

## Resolution 2

Use a certificate that matches the URL in the **Intranet zone** list on the SharePoint server.
