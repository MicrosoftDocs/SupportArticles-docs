---
title: Queue views perform poorly or fail to load
description: This article provides a resolution for the problem that occurs when you navigate to Queues in the Service module of Microsoft Dynamics CRM 2015.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Queue views perform poorly, or fail to load in Microsoft Dynamics CRM 2015

This article helps you resolve the problem that occurs when you navigate to Queues in the Service module of Microsoft Dynamics CRM 2015.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3092883

## Symptoms

When navigating to Queues in the Service module of Microsoft Dynamics CRM 2015, views take a long time to load, and sometimes fails to load. While loading, the following is displayed:

> Loading Activity Records.

## Cause

Unresolved email addresses are being displayed by the view, which causes the performance issue and occasional failure to load the data.

## Resolution

Remove any field from the view that contains an unresolved email address. To remove fields from the Queue view, follow the steps below:

1. Navigate to **Settings** > **Customizations**, and choose **Customize the System**.
1. Under **Components**, expand **Entities**, and then expand the **Queue** entity.
1. Select **Views**.
1. Double-click the view that needs to be edited.
1. Select the field that contains unresolved email addresses, and click on **remove**.
1. Click **Save** and **Close**.
1. Choose **Publish** to publish customizations.
