---
title: Workflow can't send email to group
description: SPD workflow cannot send email to SharePoint group(s) collected from Initiation Form.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\SharePoint Designer
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# SPD Workflow cannot send email to group(s) from initiation form

## Symptoms

Customer develops SharePoint Designer workflow, set Initiation Form to collect parameter of type Person or Group. Workflow steps include "Send an Email" action with "To" as look up to the Person or Group parameter collected from Initiation Form.

Run the workflow, after execute all steps, workflow status shows "completed" but no email is sent and workflow history displays error "Coercion warning: user or group does not have a valid e-mail address.".

## Cause

Workflow action - Send an Email can resolve lookup of Person or Group field collected by Initiation Form only when "Return field as" is either "Login Name" or "Login Names, Semicolon Delimited".

## Resolution

When configure workflow action - Send an Email on workflow canvas in SharePoint Designer, if Data source is Person or Group from Initiation Form, set "Return field as" to either "Login Name" or "Login Names, Semicolon Delimited" depending on if you allow multiple groups.

## More Information

Repro steps:

1. Create an SPD 2010 List Workflow. 
2. Create an Initiation Form Parameter value with following settings:
   1. Information Type: Person or Group
   1. Collect from parameter during: Association
   1. Show Field: Account
   1. Allow Selection of "People and Groups"
   1. Choose From: All Users
3. Configure the workflow with one Activity: Send email to user.
   1. Configure to send email to the Initiation Form Parameter (from above)
   1. In the "Lookup for Person or Group" dialog, select any option from the "Return field as" (for example Email Addresses, Semicolon Delimited).
4. Publish the workflow and associate with a list.  During association, enter use a SharePoint Group for the value.
5. Start the workflow and choose a SharePoint Group in Initiation Form.
6. Error in workflow history shows "Coercion warning: user or group does not have a valid e-mail address." even though workflow status is completed.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
