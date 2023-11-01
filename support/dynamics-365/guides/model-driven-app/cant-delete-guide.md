---
title: Can't delete a guide
description: Provides a resolution for an issue where you can't delete an inactive guide because it's associated to another record.
ms.author: davepinch
author: davepinch
ms.reviewer: v-wendysmith, mhart
ms.date: 11/01/2023
ms.custom: bap-template
---
# Can't delete a guide

This article provides a resolution for an issue where you can't delete a guide because it's associated with another record.

## Symptoms

As an admin, when trying to delete a guide in the Guides model-driven app, the error "The record cannot be deleted because it is associated with another record" displays.

## Resolution

1. In the [Guides model-driven app,](/dynamics365/mixed-reality/guides/model-driven-app-overview) open the guide you're trying to delete.

1. Select the **Related** tab and then **Guide Operator Sessions**.

   :::image type="content" source="media/cant-delete-guide/mda-related-records.png" alt-text="Screenshot that shows an open guide in the model-driven app with the Related tab highlighted.":::

1. Delete the records that display. These operator sessions will no longer display in the [PowerBI dashboard](/dynamics365/mixed-reality/guides/analytics-guide).

1. [Delete the inactive guide](/dynamics365/mixed-reality/guides/admin-deactivate-guide).

   > [!WARNING]
   > You can't recover the operator sessions or the guide.