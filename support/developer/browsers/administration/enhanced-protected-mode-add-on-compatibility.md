---
title: Enhanced Protected Mode add-on compatibility
description: Describes Enhanced Protected Mode for Windows 8.1 Preview, and explains how to disable the feature when it is necessary.
ms.date: 10/13/2020
ms.reviewer: fhigman, ramakoni
---
# Enhanced Protected Mode add-on compatibility

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces the Enhanced Protected Mode feature in Internet Explorer 11.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 2864914

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect the computer.

## Summary

Enhanced Protected Mode is a security feature that was introduced in Windows 8. By default, this feature is turned off in Internet Explorer on the Windows 8.1 desktop.

When this feature is enabled, add-ons such as toolbars, browser helper objects (BHOs), and extensions are loaded only if they are compatible with Enhanced Protected Mode. If you have to load an incompatible add-on, you can disable Enhanced Protected Mode for the desktop browser. This action lets incompatible add-ons load, but it may increase the risk of having malware or other potentially harmful software installed on your computer.

## Introduction

To enable Internet Explorer to protect your computer and personal data, Enhanced Protected Mode isolates untrusted web content in a restricted environment that's known as an AppContainer. This process limits how much access malware, spyware, or other potentially harmful code has to your system.

Add-ons that are incompatible with Enhanced Protected Mode are not loaded when Enhanced Protected Mode is enabled.

If you have an incompatible add-on installed, you can choose to disable Enhanced Protected Mode for the desktop browser. To do this, you can follow the steps in the Workaround section. However, because Enhanced Protected Mode provides protection from malware, you may want to first contact your add-on vendor to see whether a compatible version of the add-on is available.

## Workaround

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

To disable Enhanced Protected Mode, follow these steps:

1. Start Internet Explorer for the desktop.
2. Tap or select **Tools**, and then tap or select **Internet options**.
3. On the **Advanced**  tab, clear the **Enable Enhanced Protected Mode** check box under **Security**.
4. Tap or select **OK**.

:::image type="content" source="media/enhanced-protected-mode-add-on-compatibility/enable-enhanced-protected-mode-check-box.png" alt-text="Screenshot shows the highlighted Enable Enhanced Protected Mode check box under Advanced tab in Internet Properties window." border="false":::

> [!NOTE]
> You must restart your browser for this setting to take effect.

## References

For more information about Enhanced Protected Mode, see [Understanding Enhanced Protected Mode](/archive/blogs/ieinternals/understanding-enhanced-protected-mode).
