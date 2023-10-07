---
title: Date Window Start or End fields don't exist
description: Resolves missing Date Window Start/End fields in Dynamics 365 Field Service with Time From/To Promised fields.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 10/07/2023
---
# Date Window Start/End fields don't exist in Dynamics 365 Field Service

This article informs about the deprecation of the **Date Window Start** and **Date Window End** fields in Microsoft Dynamics 365 Field Service.

## Symptoms

The **Date Window Start** and **Date Window End** fields are suddenly missing in Dynamics 365 Field Service.

## Resolution

As of the 2021 Wave 2 update, the **Date Window Start** and **Date Window End** fields have been removed to simplify the experience. Use the **Time From Promised** and **Time To Promised** fields to manage time expectations for when jobs should be performed.

To revert this change, see the **Pre/Post Booking Flexibility Date Field Population** setting in the [Agreements section of Field Service settings](/dynamics365/field-service/configure-default-settings#agreement-settings).  
