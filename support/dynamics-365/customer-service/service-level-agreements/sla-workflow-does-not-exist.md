---
title: Workflow with Id does not exist
description: Provides a resolution for the issue where SLA migration failed with "Workflow with Id = [GUID] does not exist".
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/23/2023
---
# "Workflow with Id = [GUID] does not exist" error while migrating SLA record from legacy to UCI

This article provides a resolution for the issue where SLA migration failure with "Workflow with Id = [GUID] does not exist".

## Symptoms

SLA migration failure with "Workflow with Id = [GUID] does not exist".

## Cause

This will happen during SLA migration from legacy to UCI, if the customer has deleted the workflow associated with the SLA item.

## Resolution

To solve this issue, 

1.	Check if SLA item is accessible in legacy SLA.
2.	Delete the SLA and create it again in legacy because they have deleted the workflow itself.
