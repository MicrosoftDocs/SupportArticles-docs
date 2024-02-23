---
title: SharePoint 2013 workflow HTTP Unauthorized in SharePoint Online
description: Describes an issue in which you receive SharePoint 2013 workflow HTTP Unauthorized error occurs in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "SharePoint 2013 workflow HTTP Unauthorized" error occurs

## Problem

When you try to run a Microsoft SharePoint 2013 workflow in Microsoft SharePoint Online, you receive an error message that resembles the following:

**Retrying last request. Next attempt scheduled after Date/Time. Details of last request: HTTP Unauthorized to SharePointSiteCollectionURL ...Correlation Id: CorrelationId Instance Id: InstanceId.**

## Cause

Currently, the SharePoint 2013 Workflow Service does not provide Trusted Network policy support, such as for IP address restrictions. When the Workflow 2013 makes a call to the Azure Workflow Service, the response is returned to SharePoint Online from a different IP address. This behavior triggers an access request restriction and causes the "unauthorized" error message that is mentioned in the "Symptoms" section.

## Solution

To resolve this issue, follow these steps:

1. Go to your tenant administration:

   https://DomainAdmin.sharepoint.com

2. Locate **Access Control**.

3. Under the **Control access based on network location** setting, clear the **Only allow access from specific IP address locations** check box.

> [!NOTE]
> Currently, there are no persistent lists of the Microsoft 365 Azure Workflow Service endpoints to add to the Allow list.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
