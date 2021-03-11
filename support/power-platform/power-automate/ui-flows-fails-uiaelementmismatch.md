---
title: UI flows fails with UIAElementMismatch
description: UI flows fails with the UIAElementMismatch error. Provides steps to solve this issue.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# UI flows fails with error UIAElementMismatch

This article provides steps to solve the **UIAElementMismatch** error that occurs when running UI flows.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555810

## Symptoms

When trying to run UI flows, you may see this error:

:::image type="content" source="media/ui-flows-fails-uiaelementmismatch/uiaelementmismatch.jpg" alt-text="UIAElementMismatch Error":::

## Verifying issue

This error usually occurs if your UI flows has the property **Use coordinates** set to **true** and UI flows is unable to locate the right element using coordinates. It is possible that the version of the recorded app is different from version of the app used while playing back, which may cause this discrepancy.

Check that the version of the app that you are using while recording and the version of the app that is being used for playback are the same.

## Solving steps

If you see that the versions of the apps are different between recording and playback,

- Install the version of the app that was used while recording on the playback machine (OR).
- Re-record the steps using the version of the app that is available on playback.
