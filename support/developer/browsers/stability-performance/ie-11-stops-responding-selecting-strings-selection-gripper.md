---
title: Internet Explorer 11 stops responding when selecting strings
description: Provides a workaround for the issue that Internet Explorer 11 stops responding when selecting strings with the selection gripper.
ms.date: 09/28/2021
ms.reviewer: ramakoni, yuhara
---
# Internet Explorer 11 stops responding when selecting strings with the selection gripper

[!INCLUDE [](../../../includes/browsers-important.md)]

_Original product version:_ &nbsp; Internet Explorer 11 on Windows 10

## Symptoms

On a touch-enabled device, you use the selection gripper by touching a text field on a webpage in Internet Explorer 11. When you move the selection gripper on the left side to overlap the gripper on the right side, Internet Explorer 11 stops responding.

For example, when you double-tap a string in a text field to select all of it, the issue occurs if you tap and hold the left selection gripper and move the gripper to the end of the string.

## Resolution

To fix this issue in Windows 10, version 1909, install the update [KB5005624](https://support.microsoft.com/topic/september-21-2021-kb5005624-os-build-18363-1830-preview-b2a3af81-696b-4d59-8d7b-a05389407bb8) released on September 21, 2021.

## Workaround

To work around this issue in other versions of Windows 10 or if you don't want to install the update for Windows 10, version 1909, end the Internet Explorer (iexplore.exe) process in the **Task Manager** and restart Windows.
