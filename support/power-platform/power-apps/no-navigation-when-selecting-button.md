---
title: No response when selecting a button in Unified Interface apps
description: Describes an issue in which you aren't navigated to the previous page when you select a button in a Unified Interface app. Provides a workaround.
ms.reviewer: xianc
ms.topic: troubleshooting
ms.date: 08/10/2021
author: simonxjx
ms.author: v-six
---
# No response when selecting a button in a Unified Interface app

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you select a button in a Unified Interface app, there's no response. For example, when you select the **Save and Close** button, it's expected that you're navigated to the previous page. You may need to select the button several times to navigate to the previous page.

## Cause

Browser history is shared by Unified Interface apps and [iFrames](/powerapps/maker/model-driven-apps/iframe-properties-legacy) of app forms. If you create custom scripts in an iFrame that allow navigation or authentication redirection, the iFrame will add extra history entries to the browser history. When you select a button in a Unified Interface app, you're navigated to the history entry of the iFrame, instead of the entry of the Unified Interface app. To navigate to the previous page, you may need to select the button several times until the history entries of the iFrame are navigated.

## Workaround

When you create custom scripts in iFrames, you need to manage the [Window.history](https://developer.mozilla.org/docs/Web/API/Window/history) property to make sure that there's no extra and unexpected history entries before the correct backwards navigation.
