---
title: Date window start/end field don't exist
description: Resolve missing Date Window Start/End fields in Field Service with Time From/To Promised fields.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Date window start/end field don't exist

This article informs about the deprecation of the *date window start/end* fields in Dynamics 365 Field Service.

## Symptoms

The *Date Windows Start* and *Date Window End* fields are suddenly missing in Field Service.

## Resolution

As of the 2021 Wave 2 update, the *Date Window Start* and *Date Window End* fields have been removed to simplify the experience. Use the *Time From Promised* and *Time To Promised* fields to manage time expectations for when jobs should be performed.

To revert this change, see the **Pre/Post Booking Flexibility Date Field Population** setting in the [Agreements section of Field Service settings](/dynamics365/field-service/configure-default-settings#agreement-settings).  
