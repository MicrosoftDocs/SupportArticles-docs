---
title: Warning and failure duration times are wrong for SLA
description: Provides a resolution for the issue where the SLA warning and failure duration times are incorrect in Omnichannel for Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Warning and failure duration times are incorrect for the SLA

This article provides a resolution for the issue where the warning and failure duration times don't consider daylight saving time for the service-level agreement (SLA) in Omnichannel for Customer Service.

## Symptoms

Some SLAs don't take into account daylight saving time for the warning and failure duration.

## Cause

If your SLA was created in the web client that's now deprecated, the business schedule calendar doesn't support daylight saving time.

## Resolution

To use the daylight saving time functionality and many other new features, migrate your SLAs created in the web client to Unified Interface. For more information, see [Migrate automatic record creation rules and service-level agreements](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements).
