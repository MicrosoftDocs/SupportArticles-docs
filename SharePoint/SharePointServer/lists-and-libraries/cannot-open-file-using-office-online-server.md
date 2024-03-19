---
title: Can't open a file using OW or Office Online Server
description: Provides a workaround for an issue in which you receive an error message when you use an Office Web App to open a file on a SharePoint Server 2013 site.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Files and Documents
  - CSSTroubleshoot
ms.reviewer: nsimons
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Something went wrong when you open a file by using an Office Web App or Office Online Server

_Original KB number:_ &nbsp; 2761265

## Symptoms

When you try to open a file by using an Office Web App or Office Online Server, you receive the following error message:

> Error
>
> Sorry, something went wrong
>
> An error has occurred on the server.
>
> Technical Details
>
> Troubleshoot issues with Microsoft SharePoint Foundation.
>
> Correlation ID: <*Correlation ID*>

## Cause

This issue occurs when you log on to the SharePoint Server by using a system account. Office Online requires the SharePoint server to pass a user token on every request. However, SharePoint Server cannot create a user token for a system account.

## Workaround

To work around this issue, don't use a system account when you log on to a SharePoint Server site.
