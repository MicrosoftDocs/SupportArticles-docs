---
title: Requirements not scheduled in Resource Scheduling Optimization
description: Provides a resolution to solve the issues with unscheduled requirements.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 10/19/2023
---
# Requirements not scheduled in Resource Scheduling Optimization

This article helps administrators troubleshoot issues with unscheduled requirements based on the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

After a [schedule optimization job](/dynamics365/field-service/rso-schedule-optimization) runs, requirements aren't scheduled.

## Resolution

There are various reasons why requirements might not be booked. Try the following options before opening a support ticket:

- As a quick validation, select one of the resource requirements that aren't scheduled and use the Schedule Assistant to see if it finds results. The Resource Scheduling Optimization add-in and the Schedule Assistant evaluate bookings based on similar criteria.

  There are some scenarios where the Schedule Assistant may find results and the Resource Scheduling Optimization doesn't:

  - If resources found as potential matches don't have **Optimize Schedule** set to **Yes**, Resource Scheduling Optimization won't consider them.
  - If your date windows on the requirement are outside the scope of your Resource Scheduling Optimization run.
  - If your territory for the requirement doesn't match the resource's territory.

- Scheduling method: Make sure the **Scheduling Method** of the requirement is set to **Optimize**. By default, this field is set to **Don't Optimize**. You need to set it manually or [configure the booking setup metadata](/dynamics365/field-service/rso-configuration#make-data-changes-to-prepare-for-optimizations) accordingly.

- Territories: The Resource Scheduling Optimization scope doesn't necessarily depend on the territory, but the Resource Scheduling Optimization run still does a territory match between the requirement and resource:

  - If a requirement is assigned to a territory, then the resource must also be assigned to that territory for the requirement to be scheduled.
  - If a requirement isn't assigned to a territory, then only resources that don't belong to any territory are eligible for that requirement.

- Characteristics: Requirements might have characteristics specified for resources to match. Make sure matching resources have available working hours.

- Restricted resources: Requirements may be excluded from being assigned to a resource because that resource is marked as restricted. This behavior only applies if the **Restricted Resources** constraint is enabled.

- Date/time parameters: The **From Date** and **To Date** windows must fall inside the scope of the optimization run.
- Capacity: Resources need sufficient capacity to pick up all the work in your scope.
- Geolocation: If the **Work Location** for the requirement is set to **Onsite**, the resource requirement needs a valid latitude and longitude, and the resource needs time available to get to the location from its start location.
- Duration: The resource requirement needs duration values greater than zero, and the duration needs to fit into the resource's shift. Splitting a requirement into multiple bookings isn't supported.
- Status: The **Status** of the resource requirement needs to be **Active**.
- Related bookings: If a requirement already has a related booking record, the related booking status **Scheduling Method** needs to be set to **Ignore**.
- Optimization engine effort level: Larger optimization requests require more time to optimize. Consider increasing the engine's effort level to give it more time to find a suitable assignment.
