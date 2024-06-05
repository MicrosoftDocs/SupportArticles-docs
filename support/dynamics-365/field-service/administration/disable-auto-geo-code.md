---
title: Temporarily disable automatic address geocoding in case of service degradation
description: Provides a resolution to resolve issues with saving records during service degradation of Geo Code API.
author: anilmur
ms.author: anilmur
ms.reviewer: mhart
ms.date: 06/04/2024
ms.custom: sap:Administration
---
# Temporarily disable automatic address geocoding in case of service degradation

This article discusses a workaround for users to unblock issues with saving records in Dynamics 365 Field Service in the rare case that the mapping provider faces a service degradation.

## Symptom

Users can't save records, such as work orders, accounts, contacts, or system users with updated address information. The issue originates from a service degradation in the Geo Code APIs that the Universal Resource Scheduling solution uses to get latitude and longitude information for addresses.

## Resolution

Try saving the record again to ensure it's not a temporary hiccup. To unblock operations like creating or updating records in case of consistent failure, an administrator can temporarily deactivate the Auto Geo Code Addresses setting in the Field Service Settings. After reenabling the setting, users need to manually geo code records that were updated during the outage.

> [!CAUTION]
>
> Disabling auto geo coding won't update the geocoded information for records with updated addresses. Records might have no location information or outdated latitude and longitude values, which may affect scheduling activities that rely on location coordinates. We recommend keeping track of the updated records while the setting was disabled to address data gaps retroactively.

If your organization uses custom apps that call the Geo Code APIs directly from any of their processes, adjust the process to stop calling the API until the service degradation is resolved.