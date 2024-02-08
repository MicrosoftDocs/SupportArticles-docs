---
title: Can't install ServiceAnchor after migrating to Dynamics 365 online
description: Provides a resolution for the issue where importing or installing the ServiceAnchor solution fails with an error after you migrate your on-premises solutions to Dynamics 365 online.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/09/2023
---
# The ServiceAnchor installation fails after migrating to Dynamics 365 online

This article provides a resolution for the issue where the ServiceAnchor solution import or installation fails with the "SLAItem either has no primary field or has a logical primary field" error.

## Symptoms

After you migrate your on-premises solutions to Dynamics 365 online, the ServiceAnchor solution import or installation fails with the following error.

> Message: Entity: SLAItem either has no primary field or has a logical primary field and therefore cannot be the referenced entity in an entity relationship.

## Cause

This issue occurs due to the active layer formed on the `Name` attribute of the `slaitem` entity.

## Resolution

To solve this issue, make an API call, as shown below, to remove the active layer on the `Name` attribute of the `slaitem` entity.

`https://[orgURL]/api/data/v9.1/RemoveActiveCustomizations(SolutionComponentName='Attribute',ComponentId=6FE93FC3-E9FB-4298-A3FF-4D7EDF8BAFE8)`

> [!NOTE]
> Replace [orgURL] with the actual organization URL.
