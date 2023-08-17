---
title: GUID is shown instead of an owner name in the flow-generated email body
description: Provides a resolution for the issue where the system user lookup is shown as a GUID instead of an owner name in the flow-generated email body.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/09/2023
---
# A GUID is populated instead of an owner name in the flow-generated email body

This article provides a resolution for the issue where the system user lookup is shown up as a GUID instead of an owner name in the flow-generated email body.

## Symptoms

A GUID is displayed in the flow-generated email body instead of an owner name.

## Cause

This issue occurs when you migrate a legacy Dataverse connector flow to a new connector.

## Resolution

To solve this issue:

1. Create a variable in the migrated SLA action flow.
2. Set the value of the variable to the name of the owner, as shown below.
 
    ```console
    concat(outputs('Get_a_row_by_ID')?['body/firstname'], outputs('Get_a_row_by_ID')?['body/lastname'])
    ```

    :::image type="content" source="media/guid-instead-name-in-flow-generated-email/guid-instead-name.png" alt-text="Screenshot shows the variable setting to the Name value." border="false":::