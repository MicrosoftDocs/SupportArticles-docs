---
title: Desktop Bridge app fails to start
description: Provides a workaround for the issue that a Desktop Bridge app fails to start when running it as an administrator.
ms.date: 05/24/2021
ms.prod-support-area-path: Desktop app UI development
ms.reviewer: ishimada, soshogoh
---
# A Desktop Bridge app fails to start when running it as an administrator

_Applies to:_ &nbsp; Windows 10 Enterprise, version 21H1, Windows 10 Pro Education, version 2004  

## Symptoms

Assume that you log on as an administrator and install a [Desktop Bridge app](/windows/uwp/debug-test-perf/windows-desktop-bridge-app-tests) in Windows 10, version 2004 or version 20H2. Then, you log off the administrator account. In this scenario, standard users can't run the Desktop Bridge app as the administrator (by using the **Run as administrator** option) after installing it.

## More information

This happens because the administrator account profile is not loaded. As a workaround, keep the administrator account signed in.

## Status

Microsoft is aware of this issue and is working to resolve it for future versions of Windows.