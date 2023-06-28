---
title: "Error message: Object reference not set to an instance of an object"
description: Resolve issues with an error message in in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feifeiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 06/28/2023
---

# Error message: Object reference not set to an instance of an object

This article helps administrators resolve issues with an error message in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.

## Symptoms

An optimization request failed and gave the message “Object reference not set to an instance of an object”.

## Resolution

Typically, a custom plug-in ran into an unhandled null value. It can occur because of a custom plug-in that is triggered synchronously on the creation of a booking, the update of a work order, or other booking-related record, or one of the other records that could be impacted when the results are returned by an optimization run.

System customizers can use the plug-in trace log capability to identify which plug-in is failing and address the issue.

> [!CAUTION]
> Disable plug-in trace logging as soon as you are done with debugging to avoid overloading the organization’s database.
