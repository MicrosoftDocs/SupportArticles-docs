---
title: Object reference not set to an instance of an object error
description: Resolves issues related to an error message in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:Resource Scheduling Optimization
---
# "Object reference not set to an instance of an object" error in Resource Scheduling Optimization

This article helps administrators resolve issues related to an error message in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization request](/dynamics365/field-service/rso-schedule-optimization#monitoring-optimization-requests) fails, and you receive the following error message:

> Object reference not set to an instance of an object.

## Resolution

Typically, this issue occurs when a custom plug-in runs into an unhandled null value. It can occur because of:

- A custom plug-in that's triggered synchronously on the creation of a booking.
- A work order update.
- A booking-related record.
- A record that could be impacted when the results are returned by an optimization run.

System customizers can use the plug-in trace log capability to identify which plug-in fails and address the issue.

> [!CAUTION]
> After the debugging is completed, disable the plug-in trace logging as soon as possible to avoid overloading the organization's database.
