---
title: Issue with cascade crew changes when assigning a booking
description: Resolves issues with cascade crew changes in Dynamics 365 Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: v-wendysmith
ms.date: 01/14/2026
ms.custom: sap:Schedule Board
---
# Issue with cascade crew changes when assigning a booking

This article helps resolve issues with cascade crew changes when assigning a booking in Microsoft Dynamics 365 Field Service.

## Symptoms

"Cascade crew changes" doesn't work when assigning a booking from a single resource to a crew or group.

## Cause

This issue occurs if the value of [msdyn_CascadeCrewChanges](/common-data-model/schema/core/applicationcommon/foundationcommon/crmcommon/projectcommon/bookableresourcebooking#cascadecrewchanges) in the booking is set to **false** when a booking is assigned from a single resource to a crew or group.

## Resolution

1. Go to [https://make.powerapps.com/](https://make.powerapps.com/) and select your environment.
1. Select **Tables** and open the `Bookable Resource Booking` table.
1. Set the value of `msdyn_CascadeCrewChanges` to **Yes**. Then, assign the booking to a crew again.

For more information, go to [Group resources in crews](/dynamics365/field-service/resource-crews).
