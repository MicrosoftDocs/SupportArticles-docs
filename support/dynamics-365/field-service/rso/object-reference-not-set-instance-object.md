---
title: Object reference not set to an instance of an object error
description: Resolves issues related to an error message in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.reviewer: anclear, v-wendysmith, v-shaywood
ms.date: 05/04/2026
ms.custom: sap:Resource Scheduling Optimization
---
# "Object reference not set to an instance of an object" error in Resource Scheduling Optimization

## Summary

This article helps administrators resolve issues related to an error message in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization request](/dynamics365/field-service/rso-schedule-optimization#review-optimization-requests) fails, and you receive the following error message:

> Object reference not set to an instance of an object.

## Solution

Typically, this issue occurs when a custom plug-in runs into an unhandled null value. It can occur because of:

- A custom plug-in that triggers synchronously when you create a booking.
- A work order update.
- A booking-related record.
- A record that the results of an optimization run could impact.

System customizers can use the [plug-in trace log](/power-apps/developer/data-platform/debug-plug-in#use-tracing) capability to identify which plug-in fails and fix the problem.

> [!CAUTION]
> After debugging, disable the plug-in trace logging as soon as possible to avoid overloading the organization's database.
