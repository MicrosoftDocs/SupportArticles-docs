---
title: GUID is populating instead of owner name in flow generated email body.
description: Provides a resolution for the issue where system user lookup is shown up as GUID instead of name in the flow generated email body.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# GUID is populating instead of owner name in flow generate email body

This article provides a resolution for the issue where system user lookup is shown up as GUID instead of name in the flow generated email body.

## Symptoms

GUID is populating in flow generated email body instead of owner name.

## Cause

This issue happens when migrated legacy dataverse connector flow to new connector.

## Resolution

1.	Create a variable in migrated SLA action flow. 
2.	Set the value of the variable to Name of the owner as below.
 
    concat(outputs('Get_a_row_by_ID')?['body/firstname'], outputs('Get_a_row_by_ID')?['body/lastname'])

    :::image type="content" source="media/guid-instead-name-in-flow-generated-email/guid-instead-name.png" alt-text="The screenshot shows variable setting to Name value.":::