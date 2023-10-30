---
title: Can't delete an inactive guide
description: Provides a resolution for an issue where you can't delete an inactive guide because it's associated to another record.
ms.author: davepinch
author: davepinch
ms.reviewer: v-wendysmith, mhart
ms.date: 10/27/2023
ms.custom: bap-template
---
# Can't delete an inactive guide

This article provides a resolution for an issue where you can't delete an inactive guide because it's associated with another record.

## Symptoms

When trying to delete an inactive guide in the model-driven app, the error "The record cannot be deleted because it is associated with another record" displays.

## Resolution

1. In the model-driven app, open the guide you're trying to delete.

   :::image type="content" source="media/cant-delete-guide/mda-related-records.png" alt-text="Screenshot that shows an open guide in the model-driven app with the Related tab highlighted.":::

1. Select the **Related** tab and then **Guide Operator Sessions**.

1. Delete the records that display.

1. Then delete the inactive guide.