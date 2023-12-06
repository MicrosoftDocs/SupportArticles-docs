---
title: Booking timestamp created with incorrect time
description: Resolve incorrect booking timestamps from mobile updates.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Booking timestamp created with incorrect time

There are some scenarios where booking timestamps are created with incorrect time when the booking status is updated in the Field Service mobile application.

## Symptoms

On the *Booking* entity, there is a an internal-use-only field called offline timestamp (msdyn_offlinetimestamp). This field captures the current time when a booking status is updated in offline mode. When the syncing the booking to the server, it uses the offline timestamp to create the booking timestamp. If this field doesn't have any value, then current time is used.

## Resolution

Here are some ways to resolve scenarios that result in incorrect timestamps.

1. Offline Timestamp field is missing on the Booking for: When the field is missing from the form, it will show a form warning notification in offline mode. Add the field back to the form.

1. The default Booking JavaScript Library is disabled or removed on  a booking form. Make the default scripts and events are enabled.

1. Work order system status gets changed via API or business process flow in offline mode without triggering OnChange events. When the status changes to *Completed* and the work order syncs back to the server, the plugin completes all related bookings. This process creates booking timestamps. Since the Offline Booking Timestamp wasn't captured, the system creates the booking timestamp using current time. We strongly recommend to not change status via API or business process flow in offline mode.
