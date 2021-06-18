---
title: Required fields are missing in Dataverse records
description: Describes an issue in which required fields are missing in Dataverse records that are created from third-party tools. Provide workarounds.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 6/18/2021
author: simonxjx
ms.author: v-six
---
# Dataverse records are created without required fields

_Applies to:_ &nbsp; Dynamics 365 Field Service, Dataverse

## Symptoms

After users input data through the [Microsoft Dataverse Web API](/powerapps/developer/data-platform/webapi/overview), some required fields are missing and not filled in the created records. For example, the required **Name** field is blank in a created case as follows:

:::image type="content" source="./media/dataverse-records-missing-required-fields/dataverse-error.jpg" alt-text="Screenshot of an example about missing required fields.":::

When you open the case, you're required to fill a value for the **Name** field.

## Cause

This issue occurs if the records are created from a third-party tool such as Postman, which doesn't validate the required fields but sends the data as is.

## Workaround

To work around this issue, make sure the following points are checked:

- Check each required field that is provided in the flows.
- Check and validate the existence of required fields in the entities that are created through HTTP requests.
