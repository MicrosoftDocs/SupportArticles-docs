---
title: Service Activity Not Visible and Missing Book Button
description: Solves an issue where the Book button isn't available for service activities and service activities don't appear under Unscheduled Service Activities in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/24/2025
ms.custom: sap:Core Service Scheduling, DFM
---
# Book button isn't available for service activity and Unscheduled Service Activities doesn't show service activities

This article provides guidance on resolving the issue where the **Book** button isn't available for service activities, and service activities don't appear under the **Unscheduled Service Activities** view in the schedule board in Dynamics 365 Customer Service.

## Symptoms

You might encounter the following issues in Dynamics 365 Customer Service:

- The **Book** button is missing for [service activities](/dynamics365/customer-service/use/schedule-service-activity-csh).
- Service activities aren't visible under the **Unscheduled Service Activities** view in the [schedule board](/dynamics365/customer-service/use/use-schedule-board-configure-service-activity).

## Cause

This issue might occur due to one of the following reasons:

- The entity isn't enabled in the **Resource Scheduling** settings.
- Post-import code fails to execute properly for service scheduling upon import. This code is essential for scheduling and establishing relationships.

## Resolution

To resolve the issue:

1. Open the **Resource Scheduling** app in Dynamics 365.
2. Select **Settings** in the navigation area.
3. Select **Administration** from the site map.
4. Select **Enable Resource Scheduling for Entities**.
5. Verify if the relevant [entity](/dynamics365/customer-service/administer/scheduling.entities#understand-scheduling-entities) is enabled. If it isn't enabled, enable the entity and publish the changes.

The issue might persist because post-import code fails to execute properly. To solve this issue:

1. Check for available updates for the Dynamics 365 Service Scheduling solution.
2. Apply the updates as per the instructions provided. For more information, see [Manage Dynamics 365 apps that run on Microsoft Dataverse](/power-platform/admin/manage-apps).
