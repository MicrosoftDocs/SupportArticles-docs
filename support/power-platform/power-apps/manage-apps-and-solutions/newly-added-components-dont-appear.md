---
title: Newly added components don’t appear in the app after import
description: Describes an issue where newly added components don’t appear in the app after importing an update to the app.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/18/2021
author: squassina
ms.author: risquass
---
# Newly added components don’t appear in the app after import

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

Newly added components don’t appear in the app after importing an update to the app.

## Cause

A model-driven app change that uses All when selecting a component, such as a view, aren’t reflected after importing an update to the app in the target environment. This can happen when the following are true:

- You didn’t initially select **All** in the app designer but selected the components individually. For example, you select two views, and then export the app in a managed solution from your development environment and imported it to your test (target) environment.
- Then you created another solution with the same app in the development environment. You selected **All** to select all views in the app designer. The solution is then exported as managed from your development environment and imported into your test (target) environment.

## Workaround

To work around this behavior, select each component individually, such as the newly added views described in step 2, rather than select **All**.
