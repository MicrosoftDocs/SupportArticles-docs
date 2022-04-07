---
title: I received the error “The specified program requires a newer version of Windows”
description: Provides a resolution to the error that requires a newer version of Windows.
ms.date: 04/07/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
---

# I received the error “The specified program requires a newer version of Windows”

This article provides a resolution to the error that requires a specified program to have a newer version of Windows.

_Applies to:_&nbsp;Visual Studio 2015

## Symptoms
You want to install Visual Studio 2015 on a computer already having Windows 7 SP1 or newer installed but you receive an error message that the Visual Studio installer requires a newer version of Windows.

![screenshot of Visual Studio installer newer version of Windows](https://user-images.githubusercontent.com/79461015/159976305-700f59e4-5609-47c9-9b79-249c8eca6b31.png)

## Resolution
Customers may receive this error during a Visual Studio 2015 installation due to automatically applied compatibility settings which lower the Windows run-time incorrectly. To work around this issue, remove compatibility settings in the Visual Studio installer.

1. Right-click the **Visual Studio Installer** icon.
1. Select **Properties** > **Compatibility** tab.
1. Select **Change settings for all users**.
1. Uncheck **Run this program in compatibility mode for** < select your OS >

![screenshot of Win Newer Version Error Solution](https://user-images.githubusercontent.com/79461015/159976476-ac6cec70-9959-469e-a1e0-722e18685407.png)

5. Click **Ok**.
6. Exit the configuration window.
7. Launch the Visual Studio Installer again.

![screenshot of VS Installer](https://user-images.githubusercontent.com/79461015/159976553-31736f73-62d4-43f6-917a-a2d1ecbeb1a1.png)
