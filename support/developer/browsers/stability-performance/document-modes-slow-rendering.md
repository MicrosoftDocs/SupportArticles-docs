---
title: Slow rendering for document modes from before Internet Explorer 9
description: Describes an issue that causes slow rendering in Internet Explorer 11. Occurs when websites are displayed in document mode from Internet Explorer 8 and earlier. A resolution is provided.
ms.date: 04/26/2020
ms.reviewer: jeanr
---
# Slow rendering in Internet Explorer 11 for document modes from before Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the information to solve a slow rendering issue in Internet Explorer 11.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3071916

## Symptoms

In Internet Explorer 11, you might experience slow rendering when websites are displayed in Internet Explorer 5 Quirks mode or in Internet Explorer 7 or Internet Explorer 8 document mode. This issue occurs only when the website does not belong to the intranet site zone or to the LocalMachine zone.

## Cause

This issue may occur when the **Natural Text Metrics** setting is used. This setting is turned on by default for all security zones except intranet and LocalMachine when Internet Explorer 11 is using nonstandard document modes such as Internet Explorer 5 Quirks, Internet Explorer 7, and Internet Explorer 8.

## Resolution

To resolve this issue, use one of the following methods:

- Use the latest available document mode.
- Move your website to the intranet security zone.
- Enable the `FEATURE_FORCE_NATURAL_TEXT_METRICS` registry key. Do this in the following location:

    ```console
    HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_FORCE_NATURAL_TEXT_METRICS  
    "iexplore.exe"=dword:00000000
    ```

## More information

Using the `FeatureControl` key will disable **Natural Text Metrics** for all websites. If you want to change this feature for a particular website, put the site into the intranet zone instead of setting the feature control key.
