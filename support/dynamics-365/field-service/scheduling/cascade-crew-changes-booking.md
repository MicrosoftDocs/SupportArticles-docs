---
title: Issue with cascade crew changes when assigning a booking
description: Resolves issues with cascade crew changes in Dynamics 365 Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:Schedule Board
---
# Issue with cascade crew changes when assigning a booking

This article helps resolve issues with cascade crew changes when assigning a booking in Microsoft Dynamics 365 Field Service.

## Symptoms

"Cascade crew changes" doesn't work when assigning a booking from a single resource to a crew or group.

## Resolution

This issue occurs if the value of [msdyn_CascadeCrewChanges](/common-data-model/schema/core/applicationcommon/foundationcommon/crmcommon/projectcommon/bookableresourcebooking#cascadecrewchanges) in the booking is set to **false** when a booking is assigned from a single resource to a crew or group.

To fix the issue, open the booking and set the value of `msdyn_CascadeCrewChanges` to **Yes**. Then, assign the booking to a crew again.

For more information, see [Group resources in crews](/dynamics365/field-service/resource-crews).
