---
title: ServiceAnchor installation fails after migrating to online.
description: Provides a resolution for the issue where ServiceAnchor solution import\installation fails with “SLAItem either has no primary field or has a logical primary field”.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# ServiceAnchor installation fails after migrating to online

This article provides a resolution for the issue where you can't use the service-level agreement (SLA) migration tool to migrate a large number of SLAs in Dynamics 365 Customer Service.

## Symptoms

After on-prem to online migration, ServiceAnchor solution import\installation fails with below error.
Message: Entity: SLAItem either has no primary field or has a logical primary field and therefore cannot be the referenced entity in an entity relationship.

## Cause

This issue is because of active layer formed on the name attribute of the slaitem entity.

## Resolution

We need to make API call as below to remove the active layer on the name attribute of slaitem entity.  It will help to resolve this issue. Below is the API call:
https://<orgurl>/api/data/v9.1/RemoveActiveCustomizations(SolutionComponentName='Attribute',ComponentId=6FE93FC3-E9FB-4298-A3FF-4D7EDF8BAFE8)

Note: Please replace <orgurl> with actual org url.
