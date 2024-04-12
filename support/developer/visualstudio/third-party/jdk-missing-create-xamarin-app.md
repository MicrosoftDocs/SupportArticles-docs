---
title: Java Development Kit is missing
description: This article provides a workaround for an error that occurs when you create a Xamarin Android or Xamarin.Forms app in Visual Studio 2015.
ms.date: 05/16/2022
ms.custom: sap:Third Party Tools installed with Visual Studio\Other
ms.reviewer: vyedin
---
# JDK is missing when you create a Xamarin-based app in Visual Studio 2015

This article helps you work around a problem where Java Development Kit (JDK) is missing when you create a Xamarin Android or Xamarin.Forms app in Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 4483429

## Symptoms

When you create a Xamarin Android or Xamarin.Forms app in Visual Studio 2015, you may receive an error message that resembles the following error:

> Xamarin.Android for Visual Studio requires Java Development Kit. Please install it or set Java Development Kit path on Tools->Options->Xamarin->Android Settings menu.

For example, you see an error message dialog box that's similar to the following screenshot:

:::image type="content" source="media/jdk-missing-create-xamarin-app/error-message-dialog.png" alt-text="Screenshot of the error message dialog box.":::

## Cause

This issue occurs because Oracle no longer allows distribution of JDK in Visual Studio (as of January 2019).

## Workaround

To work around this issue, follow these steps:

1. Install the latest JDK 8 that's available from the [Oracle Java SE Development Kit 8 Downloads webpage](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
2. Follow the instructions in the error message to manually point your Visual Studio instance to the location of your new JDK.

> [!NOTE]
> For the best mobile development experience, we encourage you to update to the latest Visual Studio version to keep up with the latest changes in iOS and Android development.  

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
