---
title: Upgrade solutions for a Portals Deployment
description: Describes how to upgrade the solutions for a Microsoft Dynamics CRM Portals Deployment.
ms.reviewer: jbirnbau
ms.topic: how-to
ms.date: 03/31/2021
ms.subservice: d365-sales-connectors
---
# How to upgrade the solutions for a Microsoft Dynamics CRM Portals Deployment

This article describes how to upgrade the solutions for a Microsoft Dynamics CRM Portals Deployment.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3192042

## Summary

On September 28, 2015, Microsoft [announced](https://blogs.microsoft.com/blog/2015/09/28/microsoft-acquires-adxstudio-inc-web-portal-and-application-lifecycle-management-solutions-provider/) the acquisition of Adxstudio Inc., the developers of [Adxstudio Portals](/lifecycle/announcements/legacy-adxstudio-portals-v7-end-of-support). Following the acquisition, Microsoft has continued to develop the portal application, releasing version 8.x as an optional portal add-on for Dynamics CRM Online 2016 Update 1.

With the version 8.x release and beyond, updates are automatically deployed to the portal website itself by Microsoft. However, action must be taken by the respective Office 365 administrator to deploy the corresponding solutions within the Dynamics CRM instance that is associated with the portal.

## Upgrade the portal solutions

To upgrade the portal solutions, the following steps must be completed:

1. Navigate and sign-in to the [Microsoft 365 Admin Center](https://www.office.com/) with administrative privileges, then navigate to the CRM Online Administration page.
2. Select the instance hosting the portal and select the **Solutions** option in the right pane to reach the Manage your solutions page.
3. On this page, select a solution package that was previously deployed and an **Upgrade Available** option will be available within the right pane.
4. Select the **Upgrade** button. The status of the solution will change to **Installation pending**, followed by Installed when the upgrade process is complete.
