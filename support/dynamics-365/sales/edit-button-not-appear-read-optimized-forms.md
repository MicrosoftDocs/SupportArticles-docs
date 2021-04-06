---
title: Edit button does not appear in read optimized forms
description: This article provides a resolution for the problem where you notice that the Edit button does not appear for certain entity forms that open in read optimized mode. 
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# When using the iPad browser, the edit button does not appear in Read Optimized forms in Microsoft Dynamics CRM Online

This article helps you resolve the problem where you notice that the **Edit** button does not appear for certain entity forms that open in read optimized mode.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2813511

## Symptoms

When working in the iPad browser experience, users notice that the **Edit** button does not appear for certain entity forms that open in read optimized mode.

## Cause

Mobile Express is disabled on the affected entity.

## Resolution

Enable Mobile Express for the affected entity as follows:

1. Click **Settings**, select **Customizations**, and then click **Customize The System**.
2. Under **Components**, expand **Entities**, and select the entity where the issue occurs
3. In the **General** tab, under **Outlook & Mobile**, place a checkmark in Mobile Express
4. Click **Save** and then click **Publish**.

## More information

The iPad browser experience is available in Microsoft Dynamics CRM Online after applying the latest product update for the December 2012 Service Update.
