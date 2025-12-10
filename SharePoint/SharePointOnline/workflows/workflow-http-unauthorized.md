---
title: SharePoint 2013 workflow HTTP Unauthorized in SharePoint Online
description: Describes an issue in which you receive SharePoint 2013 workflow HTTP Unauthorized error occurs in SharePoint Online.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/02/2025
---

# "SharePoint 2013 workflow HTTP Unauthorized" error occurs

> [!IMPORTANT]
> SharePoint 2013 workflow has been turned off on all newly created tenants since April 2, 2024. It will be removed from all existing tenants on April 2, 2026. See [SharePoint 2013 workflow retirement](https://support.microsoft.com/office/sharepoint-2013-workflow-retirement-4613d9cf-69aa-40f7-b6bf-6e7831c9691e) for more information.

## Problem

When you try to run a Microsoft SharePoint 2013 workflow in Microsoft SharePoint Online, you receive an error message that resembles the following example:

> Retrying last request. Next attempt scheduled after Date/Time. Details of last request: HTTP Unauthorized to SharePointSiteCollectionURL ...Correlation Id: CorrelationId Instance Id: InstanceId.

## Cause

Currently, the SharePoint 2013 Workflow Service doesn't provide Trusted Network policy support, such as for IP address restrictions. When the Workflow 2013 makes a call to the Azure Workflow Service, the response is returned to SharePoint Online from a different IP address. This behavior triggers an access request restriction and causes the "unauthorized" error message that is mentioned in the "Symptoms" section.

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
