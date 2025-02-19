---
title: No response when selecting back button in Unified Interface apps
description: Works around an issue in which you aren't returned to the previous page when you select the back button in a Unified Interface app.
ms.reviewer: xianc
ms.custom: sap:Running model-driven app forms
ms.date: 08/10/2021
author: xianc0908
ms.author: xianc
---
# No response from the back button in a Unified Interface app

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you select the back button or the **Save & Close** button in a Unified Interface app, there's no response. For example, when you select either button on an entity record page, you expect to be returned to the previous page. However, you might have to select the button several times until the program navigates to the desired page.

:::image type="content" source="media/no-navigation-when-selecting-button/back-save-close-button.png" alt-text="Screenshot of the back button or the Save & Close button.":::

## Cause

Browser history is shared by Unified Interface apps and [iFrames](/powerapps/maker/model-driven-apps/iframe-properties-legacy) of app forms. If you create custom scripts in an iFrame that allow navigation or authentication redirection, the iFrame adds extra history entries to the browser history. When you select the back button or the **Save & Close** button on an entity record page, you're navigated to the history entry that was added by the custom scripts from the iFrame instead of the entry of the Unified Interface app. To navigate to the previous page, you have to select the button several times to force the program to navigate through the history entries that were added by the custom scripts from the iFrame.

## Workaround

When you create custom scripts in iFrames, manage the [**Window.history**](https://developer.mozilla.org/docs/Web/API/Window/history) property to remove any extra or unexpected history entries that are listed before the correct backward navigation entry.
