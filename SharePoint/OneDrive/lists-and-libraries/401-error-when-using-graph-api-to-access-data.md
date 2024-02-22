---
title: 401 error when you use Graph API to access OneDrive data with location-based policy enabled
description: Describes an issue in which you receive 401 Unauthorized error message when you use Microsoft Graph API to query OneDrive resources.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - OneDrive
ms.date: 12/17/2023
---

# 401 error when you use Graph API to access OneDrive data with location-based policy enabled

## Symptoms

An application calls the [Microsoft Graph API](/graph/use-the-api) to query OneDrive resources. If a location-based policy is enabled, requests to the Graph API return a 401 "Unauthorized" error message. This issue occurs even if the user is within the trusted boundary.

## Cause

The issue occurs because the Graph API doesn't pass the user's IP address to SharePoint. Therefore, SharePoint can't determine whether the user is within the trusted boundary. The only apps that currently support location-based policies are Viva Engage and Exchange. It means that all other apps are blocked, even when these apps are hosted within the trusted network boundary.

For more information about this issue, see [Control access to SharePoint Online and OneDrive data based on defined network locations](https://support.office.com/article/Control-access-to-SharePoint-Online-and-OneDrive-data-based-on-defined-network-locations-b5a5f1f1-1174-4c6b-91d0-9273a6b6971f).

## Workaround

To work around this issue, [set conditional access in Microsoft Entra ID](/azure/active-directory/active-directory-conditional-access-azure-portal).

## Status

Microsoft is aware of this issue and is developing a solution.
