---
title: Warning and failure duration times are incorrect for SLA
description: Provides a solution for warning and failure duration times are incorrect for the SLA in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Warning and failure duration times are incorrect for SLA

This article provides a solution for when SLA warning and failure duration times are incorrect.

## Symptom

Some SLAs don't take into account daylight saving time for warning and failure duration.

## Cause

If your SLA was created in the web client that is now deprecated, the business schedule calendar doesn't support daylight saving time.

## Resolution

To use the daylight saving time functionality and many other new features, migrate your SLAs created in the web client to Unified Interface. More information: [Migrate automatic record creation rules and service-level agreements](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements)
