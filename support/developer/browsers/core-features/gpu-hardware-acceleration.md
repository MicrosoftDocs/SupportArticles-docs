---
title: GPU hardware acceleration
description: Describes the GPU hardware acceleration feature in Internet Explorer and potential problems with it.
ms.date: 07/14/2020
ms.reviewer: ramakoni
---
# Hardware acceleration (or GPU rendering) in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces the hardware acceleration, or Graphics Processing Unit (GPU) rendering, feature in Internet Explorer. This article also discusses potential problems that might occur when you use this feature, the procedure to enable or disable this feature, and how to check your system's video card compatibility with this feature.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 4551932

## Defining hardware acceleration

Hardware acceleration, or GPU rendering, is a feature in Internet Explorer 9 and later versions that lets Internet Explorer move all graphics and text rendering from the CPU to the GPU.

> [!NOTE]
> Rendering is the process of using computer code to display the text and graphics that you see on your screen.

## Default behavior

The feature is enabled by default in Internet Explorer.

If Internet Explorer detects that your video card or video driver supports GPU hardware acceleration and Second Level Address Translation (SLAT), it will continue to use software rendering instead of GPU rendering in the following scenarios:

- Internet Explorer is running in a remote desktop session and in terminal server environments, such as Citrix.

  This behavior provides better scalability. The GPU is a limited system-wide resource. Sharing a GPU among multiple users on the same system can cause significant queueing for GPU thread scheduling. Therefore, Internet Explorer on a terminal server or Citrix will always run in software rendering support mode.

  Software mode requires that draw-related threads are scheduled and run on the system CPU. Therefore, CPU usage increases. Additionally, no change is made to the **Use software rendering instead of GPU rendering** option on the **Advanced** tab in the **Internet Options** dialog box to indicate that this mode is used.

- The computer's GPU and driver have known problems that affect reliability, functionality, security, and performance when they run Internet Explorer. These problems include:

  - Web content renders slowly.
  - Internet Explorer doesn't respond when you try to browse to websites that you view frequently.
  - Quality issues occur when you render web content or popular ActiveX controls, such as Adobe Flash.

## Enable or disable hardware acceleration

Hardware acceleration increases performance of the web browser. When the feature is enabled, some users experience issues that resemble the following when they view various websites:

- Hardware or software compatibility issues, such as websites that contain streaming or full-screen videos.
- Fonts not displayed correctly (causing blurry text).
- Browser window crashing randomly.

These issues may occur because of software or hardware incompatibility issues with this feature. To check whether the issues can be fixed, you can try disabling this feature.

To disable hardware acceleration, follow these steps:

1. Select **Start**, and then select Internet Explorer.

1. Select the **Tools** icon in the upper-right corner, and then select **Internet Options**.

1. Select the **Advanced** tab, and then select the **Use software rendering instead of GPU rendering** check box under **Accelerated graphics**.

   :::image type="content" source="media/gpu-hardware-acceleration/option-under-accelerated-graphics.png" alt-text="Screenshot of Internet Options window. Under Advanced tab, The Use software rendering instead of GPU rendering for Accelerated graphics is checked." border="false":::

1. Select **Apply**, and then select **OK**.

1. Close Internet Explorer, and then restart it so that the change takes effect.

> [!NOTE]
> To re-enable hardware acceleration, clear the **Use software rendering instead of GPU rendering** check box.

After you disable this feature, open the same webpage to see whether the problem is fixed.
