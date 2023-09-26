---
title: Modifiedon and modifiedby are updated for resolved cases
description: Provides a resolution for the issue where case entity fields for modifiedon and modifiedby are inadvertently updated for resolved cases in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# modifiedon and modifiedby fields in the case entity get updated

This article provides a resolution for the issue where case entity fields for **modifiedon** and **modifiedby** are inadvertently updated for resolved cases in Dynamics 365 Customer Service.

## Symptoms

The **modifiedon** and **modifiedby** fields in the case entity get updated for resolved cases.

## Cause

The **modifiedon** and **modifiedby** fields get updated for all resolved cases because of updates made in the **DeactivatedOn** field introduced in the case entity, using the async job `ResolvedIncidentsUpdationOperation`. **Next SLA** for cases results in updates to **modifiedon** and **modifiedby** fields in the case entity. If you want to disable **Next SLA**, you must contact [Microsoft Support](https://support.microsoft.com/).

## Resolution

To resolve this issue, avoid using the **modifiedon** and **modifiedby** fields for reporting because they get modified when calculating **Next SLA** on the enhanced case grid. If you want to know when the case was resolved, use the `incidentresolution` entity and avoid using **modifiedon** in the case entity.
