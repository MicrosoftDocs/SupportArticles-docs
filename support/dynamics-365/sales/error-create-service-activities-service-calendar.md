---
title: Error when you create Service Activities from Service Calendar
description: This article provides a resolution for the problem that occurs when you create a Service Activity from the Service Calendar.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Error creating Service Activities from the Service Calendar in Microsoft Dynamics CRM 2015

This article helps you resolve the problem that occurs when you create a Service Activity from the Service Calendar.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3074562

## Symptoms

Users may receive an error while creating a Service Activity from the Service Calendar, however the user can create the Service Activity from Activities in CRM Online.

An error has occurred. Try this action again. If the problem continues, check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally, you can contact Microsoft support

## Cause

When creating a Service Activity directly from the Service Calendar, it is required to have the Scheduled Start, Scheduled End, and Scheduled Duration fields on the Service Activity form.

## Resolution

To fix this issue, follow these steps:

1. Login to the CRM online organization.
1. Navigate to **Settings** > **Customizations** > **Customize the System**.
1. Expand Entities and go to Service Activity.
1. Open the Main Form of Service activity and verify each one of them is present on the Form: Scheduled Start, Scheduled End, and Scheduled Duration.
1. Save the changes and Publish the customizations.
