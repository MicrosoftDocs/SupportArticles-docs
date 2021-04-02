---
title: List Component is case-sensitive
description: Provides a solution to an error that occurs when you can't configure the Microsoft Dynamics CRM 2011 List Component for Microsoft SharePoint 2013.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics CRM 2011 List Component for Microsoft SharePoint 2013 Configuration is case-sensitive for SharePoint URLs

This article provides a solution to an error that occurs when you can't configure the Microsoft Dynamics CRM 2011 List Component for Microsoft SharePoint 2013.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2867688

## Symptoms

You can't configure the Microsoft Dynamics CRM 2011 List Component for Microsoft SharePoint 2013 and receive an error that resembles the following example:

> Document Management Settings
>
> `https://mysharepointwebsite.sharepoint.com/sites/crm` is a valid URL
>
> Warning:
>
> Microsoft Dynamics CRM List Component is not installed.
Install the List Component to enable MIcrosoft SharePoint to automatically create a hierarchical folder structure on Microsoft SharePoint for Microsoft Dynamics CRM records. The List Component also enables you to get the appearance and behavior of a Microsoft Dynamics CRM List.

## Cause

The Microsoft Dynamics CRM 2011 List Component for Microsoft SharePoint 2013 requires that the URL for the Microsoft SharePoint 2013 website is entered in a case-sensitive manner.

*Scenario:*  
If the URL for your SharePoint 2013 website is `https://mysharepointwebsite.sharepoint.com/sites/CRM`, then the website URL must be input exactly as `https://mysharepointwebsite.sharepoint.com/sites/CRM`.

If you enter the following URL, you'll receive the error listed in the [Symptoms](#symptoms) section:  
`https://mysharepointwebsite.sharepoint.com/sites/crm`

## Resolution

When configuring the Microsoft Dynamics CRM 2011 List Component against a Microsoft SharePoint 2013 website, ensure that the URL for the SharePoint 2013 website is entered in a case-sensitive manner.

## More information

This issue will occur for SharePoint Online and SharePoint 2013 On-Premise where use of the CRM 2011 List Component for SharePoint 2013 applies.

This issue will only affect the initial configuration of the list component.
