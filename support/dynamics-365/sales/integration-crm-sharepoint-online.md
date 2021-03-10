---
title: Integrate CRM with SharePoint Online
description: Integration of MS Dynamics CRM 2011 with SharePoint Online 2007 (BPOS).
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Integration between Microsoft Dynamics CRM Online and SharePoint Online

This article describes how to integrate Microsoft SharePoint Online with Microsoft Dynamics CRM Online 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2517202

## Symptoms

How to integrate Microsoft SharePoint Online with Microsoft Dynamics CRM Online 2011.

## Cause

Integration between SharePoint Online Subscription to work with Microsoft Dynamics CRM 2011 Online.

## Resolution

A working SharePoint Subscription and Workplace should be created for 2007 (BPOS) or 2010 (O365). Follow the below steps in the CRM application to complete the integration steps with SharePoint

1. In Microsoft Dynamics CRM, select **Settings** in the navigation pane.
1. Select **Document Management**
1. Select **New**.
1. Select **Sharepoint Sites**.
1. Enter the Display Name and the Description.
1. Under **URL Options**, select **Absolute URL**.
1. Enter the Absolute URL (Example: `https:// orgname.sharepoint.microsoftonline.com`).
1. Select **Save** & **Close**.
1. Under **Document Management**, select **SharePoint Document Locations**.
1. Enter the Display name and description of the location.
1. Under the **URL Options**, select **Absolute URL**.  
1. Enter the Absolute URL. (It has to be the location of the folder in your SharePoint site, if you aren't sure, navigate to your SharePoint site, select the folder, and copy the location in the address bar)
1. Select **Save** & **Close**.
1. Under **Document Management**, select **Document Management Settings**.
1. Select the entity that would use SharePoint to store docs. (Keep the URL Box Empty).

## More information

To confirm point to WorkPlace, select **Accounts**, and select an Account (assuming the Accounts entity is chosen to use SharePoint in the Document Management Settings wizard). Select **Documents** and the interface would prompt for sign-in credentials. Use the SharePoint Online credentials. Once Authenticated, the user would have access to the SharePoint Site.
