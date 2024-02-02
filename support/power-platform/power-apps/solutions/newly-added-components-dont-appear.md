---
title: Newly added components don't show in the app after importing an update
description: Provides a workaround for an issue where newly added components don't appear in the app after importing an update into the app.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
---
# Newly added components don't appear in the app after you import an update

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After you import an update into an app, the newly added components don't appear in the app.

## Cause

A model-driven app change that uses **All** when selecting a component, such as a view, isn't reflected after importing an update into the app in the target environment. This issue can happen after you take the following steps:

Step 1: You initially didn't select **All** in the app designer, but selected the components individually. For example, you selected two views. Then you exported the app from your development environment in a managed solution and imported it into your test (target) environment.

Step 2: You created another solution with the same app in the development environment. You selected **All** to select all views in the app designer. The solution is then exported from your development environment as a managed solution and imported into your test (target) environment.

## Workaround

To work around this issue, select each component individually, such as the newly added views described in step 2, rather than select **All**.
