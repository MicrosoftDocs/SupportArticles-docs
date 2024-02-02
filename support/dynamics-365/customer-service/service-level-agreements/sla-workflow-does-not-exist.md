---
title: Workflow with ID does not exist error
description: Provides a resolution for an issue where an SLA migration fails with the Workflow with ID = [GUID] does not exist error.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/27/2023
---
# "Workflow with ID = [GUID] does not exist" error when migrating SLA records from legacy to Unified Interface

This article provides a resolution for an issue where a service-level agreement (SLA) migration fails with the "Workflow with ID = [GUID] does not exist" error.

## Symptoms

An SLA migration fails with the following error message:

> Workflow with ID = [GUID] does not exist.

## Cause

This issue occurs during the SLA migration from legacy to Unified Interface, and the user has deleted the workflow associated with the SLA item.

## Resolution

To solve this issue,

1. Check if the SLA item is accessible in the legacy SLA.
2. Delete the SLA and create it again in legacy because the workflow is deleted.
