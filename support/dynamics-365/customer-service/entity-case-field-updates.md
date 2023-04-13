---
title: Case entity fields for modifiedon and modifiedby are updated for resolved cases
description: Provides a solution for when when case entity fields for modifiedon and modifiedby are inadvertently updated for resolved cases in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# modifiedon and modifiedby fields on the case entity get updated

This article provides a solution for when case entity fields for modifiedon and modifiedby are inadvertently updated for resolved cases.

## Symptom

**modifiedon** and **modifiedby** fields on the case entity get updated for resolved cases.

## Cause

**modifiedon** and **modifiedby** fields get updated for all resolved cases because of updates made in the **DeactivatedOn** field introduced in case entity, using the async job **ResolvedIncidentsUpdationOperation**. Next SLA for cases results in updates to **modifiedon** and **modifiedby** fields on the case entity. If you want to disable Next SLA, you must contact Microsoft Support.

## Resolution

Avoid using the **modifiedon** and **modifiedby** fields for reporting because they get modified when calculating Next SLA on the enhanced case grid. If you want to know when the case was resolved, use the **incidentresolution** entity and avoid using **modifiedon** on the case entity.
