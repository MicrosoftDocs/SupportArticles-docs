---
title: Issue with cascading crew changes when assigning a booking
description: Resolve issues with cascading crew changes in Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Issue with cascading crew changes when assigning a booking

This article helps resolve issues with cascading crew changes when assigning a booking in Dynamics 365 Field Service.

## Symptoms

Cascade crew changes doesn't work when assigning a booking from a single resource to a crew or group.

## Resolution

This issue occurs if the value of *msdyn_CascadeCrewChanges* in the booking is set to false when a booking is assigned from a single resource to a crew or group.

To fix the issue, open the booking and set the value of *msdyn_CascadeCrewChanges* to *Yes*. Then, assign the booking to a crew again.

For more information, see [Group resources in crews](/dynamics365/field-service/resource-crews).
