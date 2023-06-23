---
title:  Error message: Requirements not scheduled in the Resource Scheduling Optimization add-in
description: Troubleshoot issues with unscheduled requirements.
ms.author: feifeiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Requirements not scheduled in the Resource Scheduling Optimization add-in

This article helps administrators troubleshoot issues with unscheduled requirements based on the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.

## Symptoms

After the schedule optimization job run, requirements aren't scheduled.

## Resolution

There are various reasons why requirements might not get booked. Try the following options before opening a support ticket:

- As a quick validation, select one of the resource requirements that isn't scheduled and use the Schedule Assistant to see if it finds results. The Resource Scheduling Optimization add-in and the schedule assistant evaluate bookings based on similar criteria.

  There are some scenarios where the Schedule Assistant may find results and the Resource Scheduling Optimization won’t:

  - If resources found as potential matches don't have **Optimize Schedule** set to **Yes**, Resource Scheduling Optimization wouldn't consider them.
  - If your date windows on the requirement are outside of the scope of your Resource Scheduling Optimization run.
  - If your territory for the requirement doesn’t match the resources’ territory.

- Scheduling method: Make sure the **Scheduling Method** of the requirement is set to **Optimize**. By default, this field is set to **Don't Optimize**. You either need to set it manually or [configure the booking setup metadata](/dynamics365/field-service/rso-configuration#make-data-changes-to-prepare-for-optimizations) accordingly.

- Territories: The Resource Scheduling Optimization scope doesn’t necessarily depend on territory, but the Resource Scheduling Optimization run still does a territory match between requirement and resource:
  - If a requirement is assigned to a territory, then the resource must also be assigned to that territory for the requirement to be scheduled.
  - If a requirement isn't assigned to a territory, then only resources that don’t belong to any territory are eligible for that requirement.

- Characteristics: Requirements might have characteristics specified for resources to match. Make sure matching resources have available working hours.

- Restricted resources: Requirement may get excluded from being assigned to a resource because that resource is marked as restricted. This behavior only applies if the **Restricted Resources** constraint is enabled.

- Date/time parameters: The **From Date** and **To Date** window must fall inside the scope of the optimization run’s scope.

- Capacity: Resources need sufficient capacity to pick up all of the work in your scope.

- Geolocation: If the **Work Location** for the requirement is set to **Onsite**, the resource requirement needs to have a valid latitude and longitude and the resource needs time available to get to the location from their start location.

- Duration: The resource requirement needs duration values greater than 0 and the duration needs to fit into a resource's shift. Splitting a requirement into multiple bookings isn't supported.

- Status: The **Status** of the resource requirement needs to be **Active**.

- Related bookings: If a requirement already has a related booking record, the related booking status **Scheduling Method** needs to be set to **Ignore**.

- Optimization engine effort level: Larger optimization requests require more time to optimize. Consider increasing the engine’s effort level to give it more time to find a suitable assignment.
