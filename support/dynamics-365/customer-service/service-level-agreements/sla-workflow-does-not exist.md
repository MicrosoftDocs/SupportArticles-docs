---
title: Workflow with Id does not exist
description: Provides a resolution for the issue where SLA migration failure with "Workflow With Id = <GUID> Does Not Exist".
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/23/2023
---
# "Workflow With Id = <GUID> Does Not Exist" error while migrating SLA record from legacy to UCI

This article provides a resolution for the issue where SLA migration failure with "Workflow With Id = <GUID> Does Not Exist".

## Symptoms

SLA migration failure with "Workflow With Id = <GUID> Does Not Exist".

## Cause

This will happen at the time of legacy SLA migration if the customer has deleted the workflow associated with the SLA Item.

## Resolution

To solve this issue, 

1.	Check if SLA Item is accessible in legacy SLA.
2.	Delete the SLA and create it again in legacy because they have deleted the workflow itself.
