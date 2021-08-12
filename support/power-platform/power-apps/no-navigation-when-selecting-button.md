---
title: No response when selecting back button in Unified Interface apps
description: Works around an issue in which you aren't navigated to the previous page when you select a button in a Unified Interface app.
ms.reviewer: xianc
ms.topic: troubleshooting
ms.date: 08/10/2021
author: simonxjx
ms.author: v-six
---
# No response when selecting back button in a Unified Interface app

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you select a button in a Unified Interface app to do a back navigation, there's no response. For example, when you select the back or the **Save & Close** button on an entity record page, it's expected that you're navigated to the previous page. However, you may need to select the button several times to navigate to the previous page.

:::image type="content" source="media/no-navigation-when-selecting-button/back-button.PNG" alt-text="Screenshot of the back button.":::

## Cause

Browser history is shared by Unified Interface apps and [iFrames](/powerapps/maker/model-driven-apps/iframe-properties-legacy) of app forms. If you create custom scripts in an iFrame that allow navigation or authentication redirection, the iFrame will add extra history entries to the browser history. When you select the back or the **Save & Close** button on an entity record page in a Unified Interface app, you're navigated to the history entry added by the custom scripts from the iFrame, instead of the entry of the Unified Interface app. To navigate to the previous page, you need to select the button several times until the history entries added by the custom scripts from the iFrame are navigated.

## Workaround

When you create custom scripts in iFrames, you need to manage the [Window.history](https://developer.mozilla.org/docs/Web/API/Window/history) property to make sure that there's no extra and unexpected history entries before the correct backwards navigation.
