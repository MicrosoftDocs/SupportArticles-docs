---
title: Invalid Argument error when configuring Dynamics CRM
description: Fixes an issue in which you get the "Invalid Argument" error when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "Invalid Argument" error when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article helps you fix an issue in which you get the "Invalid Argument" error when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3093119

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> "Invalid Argument"

If you click **Details** or **View the log file**, additional details like the following appear:

> context at Microsoft.Crm.Metadata.MetadataCache.GetInstance(IOrganizationContext context)  
 at Microsoft.Crm.Application.ControlDescriptor.get_Metadata()  
 at Microsoft.Crm.Application.FormDescriptor.GetChildColumns()  
 at Microsoft.Crm.Application.FormDescriptor.AddHiddenControls(EntityMetadata entityMetadata)  
> \...

## Cause

A fix is available for an issue that can cause this error to occur when Update 1 is installed on Microsoft Dynamics CRM 2015 for Microsoft Office Outlook. The issue can occur if you have a Lookup field on one of the following entities and that Lookup field is filtered based on another Lookup field that is not on the form.

- Contact
- Account
- Lead
- Incident (Case)
- Contract
- Opportunity

Example Scenario: The Contact field on the Incident (Case) form has the properties configured to use **Related Record Filtering** and **Only show record where** with the field set to **Responsible Contact (Cases)**. If the **Responsible Contact** field is not on the Incident (Case) form, this error can occur.

## Resolution

Install [Microsoft Dynamics CRM 2015 Update 1.2](https://www.microsoft.com/download/details.aspx?id=53311).
