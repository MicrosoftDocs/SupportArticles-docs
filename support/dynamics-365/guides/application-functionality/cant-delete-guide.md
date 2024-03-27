---
title: Can't delete a guide in Dynamics 365 Guides
description: Provides a resolution for an issue where you can't delete a guide because it's associated with another record in Dynamics 365 Guides.
ms.author: davepinch
author: davepinch
ms.reviewer: v-wendysmith, mhart
ms.date: 11/14/2023
ms.custom: sap:Application Functionality
---
# Can't delete a guide in the Guides model-driven app

This article provides a resolution for an issue where you can't delete a guide because it's associated with another record in Microsoft Dynamics 365 Guides.

## Symptoms

When you try to delete a guide in the [Guides model-driven app](/dynamics365/mixed-reality/guides/model-driven-app-overview), you receive the following error message:

> The record cannot be deleted because it is associated with another record.

## Resolution

> [!NOTE]
> You need administrator permissions to delete a guide.

To delete a guide, follow these steps:

1. In the Guides model-driven app, open the guide you're trying to delete.
1. Select the **Related** tab and then select **Guide Operator Sessions**.

   :::image type="content" source="media/cant-delete-guide/model-driven-app-related-records.png" alt-text="Screenshot that shows an open guide in the model-driven app with the Related tab highlighted.":::

1. Select the displayed records and select **Delete**. The operator sessions will no longer appear in the [Power BI dashboard](/dynamics365/mixed-reality/guides/analytics-guide).

1. [Delete the guide](/dynamics365/mixed-reality/guides/admin-deactivate-guide).

   > [!WARNING]
   > You can't recover an operator session or guide if you permanently delete it.
