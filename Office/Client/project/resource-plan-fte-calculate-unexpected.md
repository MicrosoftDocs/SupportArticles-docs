---
title: Resource Plan FTE doesn't calculate as expected when Max Units are 0 or 0%
description: Explanation of how Project Server calculates resource plans using FTE vs. hours of work.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
  - Project Server 2019
  - Project Server 2016
  - Project Server 2013
ms.reviewer: 
ms.date: 05/26/2025
---
# Resource Plan FTE doesn't calculate as expected when Max Units are 0 or 0%

_Original KB number:_ &nbsp; 2506962

## Symptoms

You have setup a resource plan using Full Time Equivalent (FTE) and when you switch between different timescale granularities, the value for a resource with Max Units of zero doesn't calculate the same way as a resource with greater than zero Max Units.

## Cause

This problem only occurs when:

In Server Settings > Additional Server Settings > Resource Plan Work Day is set to use "Resource Base Calendars"
and the Resource's Max Units is set to zero.

The server setting will apply to all resources used within a resource plan. If a resource has zero Max Units that are similar to saying that resource has no availability defined. Project cannot use zero for calculating resource requirements, so it defaults to using seven days a week 8 hours a day when both the above settings are in place.

## Resolution

There are a couple of solutions available.

Workaround 1 - Set the Resource Plan Work Day to "Hours per Day". Then enter the total hours the resource is required within that time period.

Workaround 2 - Set the resource's Max Units to something other than 0 or 0%. (100% is recommended, as it is easiest to work with, i.e. 100% of a resource is equivalent to one FTE. If you set the Max Units to 500% that would be equivalent to five resources of that type. When you go to enter FTE for a time period, you have to calculate what fraction of 5 is required. In this case, 0.2 FTE would equal one individual.

## More information

Overview of Resource Plans.

Resource Plans are a high-level view of resource requirements and used by Resource Managers to plan for resource requirements on projects that are not yet underway or do not have named resources committed to tasks in the future.

Resource plans also feed into Portfolio Analysis for resource requirements as discussed the [white paper Demand Management and Workflow in Project Server 2013](https://www.microsoft.com/download/details.aspx?id=37005).

[Setting up resource constraint analysis (Project Server 2010)](https://technet.microsoft.com/library/gg597668(v=office.14).aspx)

Tips for using Resource Plans.  

When you first enter a resource plan, the date range is set to the current date. Be careful to start the resource plan from the beginning of the plan or the beginning of the Timescale period. For example, if your plan goes over one year, set the date range for the first day of the month or quarter and set the timescale to months or quarters for entering resource requirements. Starting in the middle of the month may give you unexpected results when entering Work Units as FTE rather than Hours.

If you want to change the Max Units for a resource after the Resource Plan has been created, it is best to remove the resource and then rebuild the team and the resource plan to get the best results.

If you are planning to switch between timeframe granularities to review the resource requirements, it is best to enter the data in days making sure to skip weekend dates. That way when you switch to a new granularity the requirement will roll up correctly. If you enter the requirements at the higher granularity, then the values could potentially be spread over the entire timeframe including weekend days.

Use Generic Resource set to 100% Max Units when you are not sure that named resources will eventually be assigned to tasks.

NOTE: Generic Resources are not included in the Portfolio Analysis Resource Requirements availability view, only named resources of the same "role or skill" are counted in this view. This has caused issues for business analysis as they think they need to do additional calculations when running through a Portfolio Resource Analysis
