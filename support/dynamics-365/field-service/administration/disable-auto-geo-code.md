---
title: Can't create or save records due to address geocoding mapping service degradation
description: Provides a workaround to resolve issues with saving records during service degradation of the Geo Code API in Dynamics 365 Field Service.
author: anilmur
ms.author: anilmur
ms.reviewer: mhart
ms.date: 06/18/2024
ms.custom: sap:Administration
---
# Can't create or save records due to service degradation of the address geocoding mapping service

This article provides a workaround for users or administrators to solve issues with saving records in Microsoft Dynamics 365 Field Service in rare cases where the mapping provider faces service degradation.

## Symptoms

Users can't save records, such as work orders, accounts, contacts, or system users with updated address information.

## Cause

The issue originates from a service degradation in the location APIs that the [Universal Resource Scheduling](/dynamics365/field-service/universal-resource-scheduling-for-field-service) solution uses to get the latitude and longitude information for addresses.

## Workaround

As a user, try saving the record again to ensure it's not a temporary issue.

As an administrator:

- To unblock operations like creating or updating records in case of a consistent failure, you can temporarily disable the [Auto Geo Code Addresses](/dynamics365/field-service/turn-on-auto-geocoding) setting in **Field Service Settings**. After re-enabling the setting, users need to manually geocode records that were updated during the outage.

  > [!CAUTION]
  >
  > Disabling automatic geocoding doesn't update the geocoded information for records with updated addresses. Records might have no location information or outdated latitude and longitude values, which might affect scheduling activities that rely on location coordinates. We recommend tracking the updated records while the setting is disabled to address data gaps retroactively.

- If your organization uses custom apps that call the location APIs directly from any of their processes, adjust the processes to stop calling them until the service degradation is resolved.

## More information

[Enable location and map settings](/dynamics365/field-service/field-service-maps-address-locations)
