---
title: Google Android 27 emulator fails to start
description: This article provides a workaround for a problem where a Google Android 27 emulator won't start on a computer with Visual Studio 2017.
ms.date: 04/27/2020
ms.custom: sap:Third Party Tools installed with Visual Studio\Other
---
# GPU Driver Issue when you start a Google Android 27 emulator in Visual Studio 2017

This article helps you resolve a problem (GPU Driver Issue) that occurs when a Google Android 27 emulator won't start on a computer with Microsoft Visual Studio 2017.

_Original product version:_ &nbsp; Visual Studio 2017  
_Original KB number:_ &nbsp; 4477609

## Symptoms

Assume that you have a Google Android 27 emulator image on a 32-bit computer that has Microsoft Visual Studio 2017 installed. When you try to start that emulator, it fails to start, and you receive an error (GPU Driver Issue). For example, you see an error message dialog box that's similar to the following screenshot:

:::image type="content" source="./media/android-27-emulator-not-start/gpu-driver-issue-details.png" border="false" alt-text="Screenshot of the issue details in the GUP Driver Issue dialog box.":::

## Workaround

To work around this problem, follow these steps:

1. Open Android Device Manager.
2. Create a new default emulator that targets API 25 or 26. Or, select a higher API level (28+), depending on your goals for development.
3. Retarget your app to use the new API.

We also recommend deploying to a real device when it's possible, as this is faster and less error-prone than using an emulator.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
