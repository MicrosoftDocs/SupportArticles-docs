---
title: Required fields are missing in Dataverse records
description: Describes an issue in which required fields are missing in Dataverse records that are created from third-party tools. Provide workarounds.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/18/2021
author: squassina
ms.author: risquass
---
# Dataverse records are created without required fields

_Applies to:_ &nbsp; Dynamics 365 Field Service, Dataverse

## Symptoms

After users input data through the [Microsoft Dataverse Web API](/powerapps/developer/data-platform/webapi/overview), some required fields are missing or not populated in the created records. For example, the required **Case Title** field is blank in a created case, as shown in the following screenshot.

:::image type="content" source="media/dataverse-records-missing-required-fields/dataverse-error.png" alt-text="Screenshot of an example about missing required fields.":::

When you open the affected case, you must enter a value for the **Case Title** field.

:::image type="content" source="media/dataverse-records-missing-required-fields/missing-fields-case.png" alt-text="Screenshot to enter a value for the Case Title field.":::

## Cause

This issue occurs if the records are created from a third-party tool such as Postman. Such tools don't check for the required fields. Instead, they send the data as is.

## Workaround

To work around this issue, make sure that you check the following items:

- Check that the required fields are included in the flows.
- Check for the existence of required fields in the entities that are created through HTTP requests.
