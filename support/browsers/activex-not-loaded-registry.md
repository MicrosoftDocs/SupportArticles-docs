---
title: ActiveX control is not loaded in Website
description: When the basic code attribute is not specified in the HTML code on the web page, or the basic code has been modified, the ActiveX control cannot be loaded.
ms.date: 04/20/2020
ms.reviewer: mmcgough
ms.prod-support-area-path: 
---
# ActiveX control is not loaded with modified CODEBASE value in the registry

This article provides information about resolving how to modify the registry value to load ActiveX controls.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10  
_Original KB number:_ &nbsp; 262380

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [256986](https://support.microsoft.com/help/256986).

## Symptoms

When you view a Web page that attempts to load an ActiveX control, a red X may be displayed instead, the ActiveX control may not be loaded, or the Web page may display a message similar to:

> ActiveX control failed to load!-- Please check browser security settings.

:::image type="content" source="./media/remove-pii.png" alt-text="test":::

:::image type="content" source="./media/remove-pii_700.png" alt-text="test":::

:::image type="content" source="./media/full-screen-1200.png" alt-text="test":::

:::image type="content" source="./media/full-screen-1920.png" alt-text="test":::

## Cause

This problem can occur if all of the following conditions exist:

- The Web page is attempting to load an ActiveX control from the Microsoft Internet Explorer components gallery.
- The `CODEBASE` attribute is not specified in the Hypertext Markup Language (HTML) code on the Web page, or the `CODEBASE` attribute specifies a version that will not be found, such as `#version=-1`, `-1`, `-1`, `-1`.
- The **CODEBASE** value in the client computer's registry has been modified. This value can be modified manually or by corporate administrators with the Internet Explorer Administration Kit (IEAK). At stage 5 (the Policies and Restrictions section) in the IEAK, there is a **Code Download** option under **Corporate Settings** that is set to the following value by default:

    ``` console
    [CODEBASE];(http://activex.microsoft.com/objects/ocget.dll)
    ```

    The version number of -1, -1, -1, -1 is typically used to force an ActiveX control to download every time a page is accessed. The internal network in an enterprise may be configured not to allow access to the Internet; if that happens, `activex.microsoft.com` is not accessible. This option allows corporate administrators to specify a custom path for Internet Explorer to use when no `CODEBASE` attribute is specified by the Web page that tries to load ActiveX controls that are not already installed.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To resolve this issue, modify the **CODEBASE** value in the registry to restore the default setting as follows:

1. Start Registry Editor (Regedit.exe).
2. Locate and click the key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings`.
3. Modify the `CodeBaseSearchPath` string value. Change the value data to **CODEBASE**.

## References

For more information, see [HTML attribute reference](https://developer.mozilla.org/docs/Web/HTML/Attributes).
