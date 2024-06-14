---
title: Temporarily disable automatic address geocoding in case of service degradation
description: Provides a workaround to resolve issues with saving records during service degradation of Geo Code API in Dynamics 365 Field Service.
author: anilmur
ms.author: anilmur
ms.reviewer: mhart
ms.date: 06/14/2024
ms.custom: sap:Administration
---
# Temporarily disable automatic address geocoding in case of service degradation

This article provides a workaround for users or an administrator to solve issues with saving records in Microsoft Dynamics 365 Field Service in the rare case that the mapping provider faces a service degradation.

## Symptoms

Users can't save records, such as work orders, accounts, contacts, or system users with updated address information.

## Cause

The issue originates from a service degradation in the location APIs that the [Universal Resource Scheduling](/dynamics365/field-service/universal-resource-scheduling-for-field-service) solution uses to get latitude and longitude information for addresses.

## Workaround

- Try saving the record again to ensure it's not a temporary hiccup.
- To unblock operations like creating or updating records in case of consistent failure, an administrator can temporarily disable the [Auto Geo Code Addresses](/dynamics365/field-service/turn-on-auto-geocoding) setting in the **Field Service Settings**. After reenabling the setting, users need to manually geocode records that were updated during the outage.

> [!CAUTION]
>
> Disabling automatic geocoding won't update the geocoded information for records with updated addresses. Records might have no location information or outdated latitude and longitude values, which might affect scheduling activities that rely on location coordinates. We recommend keeping track of the updated records while the setting was disabled to address data gaps retroactively.

If your organization uses custom apps that call the location APIs directly from any of their processes, adjust the process to stop calling the API until the service degradation is resolved.
