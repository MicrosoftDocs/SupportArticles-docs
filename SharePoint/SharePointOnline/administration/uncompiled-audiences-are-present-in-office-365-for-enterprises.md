---
title: Uncompiled audiences are present in SharePoint Online in Microsoft 365 for enterprises
description: Describes an issue in which uncompiled audiences are present in SharePoint Online in Microsoft 365 for enterprises.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Pages\Audience Targeting
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Uncompiled audiences are present in SharePoint Online

## Problem

When you view the Manage User Profiles section of the SharePoint Online admin center in Microsoft 365 for enterprises, you find that uncompiled audiences are present.

:::image type="content" source="media/uncompiled-audiences-are-present-in-office-365-for-enterprises/uncompiled-audiences.png" alt-text="Screenshot of the Uncompiled Audiences item listed in the Manage User Profiles section.":::

## Solution

To resolve this issue, wait for audience compilation to be completed. If more than seven full days have passed since the last audience compilation, contact Microsoft 365 technical support.

Note Audience targeting won't function correctly on SharePoint Online sites until audience compilation is completed. Additionally, if a user was added or removed for an audience, compilation must be completed before the changes are made to the audience.

## More information

This behavior occurs because audiences are compiled weekly in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
