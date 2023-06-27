---
title: Workflow with Id doesn't exist
description: Provides a resolution for the issue where SLA migration fails with the "Workflow with Id = [GUID] does not exist" error.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/27/2023
---
# "Workflow with Id = [GUID] does not exist" error while migrating SLA record from legacy to UCI

This article provides a resolution for the issue where SLA migration fails with the "Workflow with Id = [GUID] does not exist" error.

## Symptoms

SLA migration failure with "Workflow with Id = [GUID] does not exist".

## Cause

This happens during SLA migration from legacy to Unified Interface, if the customer has deleted the workflow associated with the SLA item.

## Resolution

- Check if the SLA item is accessible in legacy SLA.
- Delete the SLA and create it again in legacy because the workflow is deleted.
