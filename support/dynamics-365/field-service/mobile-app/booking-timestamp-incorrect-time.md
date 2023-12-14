---
title: Booking timestamp is created with incorrect time
description: Resolves the incorrect booking timestamp created when the booking status is updated in the Dynamics 365 Field Service mobile app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/14/2023
ms.custom: sap:issue-not-listed
---
# Booking timestamp is created with an incorrect time in the Field Service mobile app

This article provides a resolution for an issue where a booking timestamp is created with incorrect time when the booking status is updated in the Microsoft Dynamics 365 Field Service mobile app.

## Symptoms

On the `Booking` entity, there's an internal-use-only field called **Offline Timestamp** (`msdyn_offlinetimestamp`). This field captures the current time when a booking status is updated in offline mode. When the system synchronizes the booking to the server, it uses the offline timestamp to create the booking timestamp. If this field has no value, the current time is used.

## Resolution

Here are some ways to resolve scenarios that result in incorrect timestamps.

- The **Offline Timestamp** field is missing from the booking form. In this case, it shows a form warning notification in offline mode.

  To solve this issue, add the **Offline Timestamp** field back to the form.

- The default booking JavaScript library on a booking form is disabled or removed.

  To solve this issue, ensure the default scripts and events are enabled.

- The [work order system status](/dynamics365/field-service/work-order-status-booking-status) is changed via API or a business process flow in offline mode without triggering the `OnChange` event. When the status changes to *Completed* and the work order syncs back to the server, the plug-in completes all related bookings. This process creates booking timestamps. Since the offline booking timestamp wasn't captured, the system creates the booking timestamp using the current time.

  We strongly recommend not changing the work order system status via API or a business process flow in offline mode.
