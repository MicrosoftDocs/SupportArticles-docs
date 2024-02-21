---
title: Calendar dates are corrupted when migrating SLAs from legacy to Unified Interface
description: Solves the Calendar dates are corrupted error that occurs when SLAs are migrated from legacy to Unified Interface in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta, mpanduranga
ms.author: v-psuraty
author: v-psuraty
ms.date: 02/21/2024
---
# "Calendar dates are corrupted" error when migrating SLAs from legacy to Unified Interface

This article solves the "Calendar dates are corrupted" error message that occurs when service-level agreements (SLAs) are migrated from legacy to Unified Interface in Microsoft Dynamics 365 Customer Service.

## Symptoms

After SLAs are migrated from legacy to Unified Interface in Dynamics 365 Customer Service, SLA item and time calculations for the failure and warning times don't work as expected due to a corrupted calendar. Additionly, when you try to [apply an SLA](/dynamics365/customer-service/administer/apply-slas) on the `Incident` entity, you receive the following error message:

> Error Code:0x10000003 Calendar \<CalendarID> dates are corrputed. Try to create a new Calendar.

## Cause

This issue occurs when the legacy calendar isn't properly configured to Unified Interface during migration.

## Resolution

To solve this issue, create a new calendar and replace the existing calendar in the SLA item with the new one. Or, open the legacy calendar in Unified Interface and save it.

## More information

- [Enable silent, seamless migration from legacy to Unified Interface service scheduling experience](/dynamics365-release-plan/2020wave2/service/dynamics365-customer-service/enable-silent-seamless-migration-legacy-uci-service-scheduling-experience)
- [Service scheduling overview](/dynamics365/customer-service/use/uci-scheduling-overview)
- [Navigate the service calendar](/dynamics365/customer-service/use/uci-navigate-service-calendar)
