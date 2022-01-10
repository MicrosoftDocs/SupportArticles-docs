---
title: Dynamics 365 Marketing problem with the deployment
description: Problem with the deployment for Microsoft Dynamics 365 Marketing application. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: d365-marketing-marketing
---
# Problem with the deployment for Microsoft Dynamics 365 Marketing application

This article provides a resolution for the **problem with deployment** error that occurs when deploying Microsoft Dynamics 365 Marketing application.

_Applies to:_ &nbsp; Microsoft Dynamics 365 for Marketing  
_Original KB number:_ &nbsp; 4558059

## Symptoms

**There was a problem with deployment. Restart the setup process to try again** error message occurs in First Run Experience for deploying Microsoft Dynamics 365 Marketing application.

## Cause

One of the reasons why First Run Experience for deploying Microsoft Dynamics 365 Marketing application could lead to the error is when change tracking is not enabled for some required for logical entity name(s) on your Microsoft Dynamics CRM organization where you are deploying the Marketing application.

## Resolution

If you are a system customizer or admin, then you can find the setting to enable **Change tracking** by doing the following:

1. Open the **Settings** menu at the top of the page and select **Advanced settings**. The advanced-settings area then opens in a new browser tab. Note that this area uses a horizontal navigator at the top of the page instead of a side navigator.
2. Navigate to **Settings** > **Customization** > **Customization**.
3. Select **Customize the system** (or select **Solutions** and open a solution if your entity is part of a solution).
4. Find and select the entity you want to sync.
5. On the **General** tab for the entity, select the **Change tracking** check box.
6. Save and publish the change.

Retry the deployment from first run experience URL after **Change tracking** is enabled for all the required entities.
