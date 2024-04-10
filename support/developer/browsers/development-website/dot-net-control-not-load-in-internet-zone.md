---
title: .NET control does not load in Internet Zone
description: This article discusses an important change made in Internet Explorer 8 and later versions that could impact developers or users.
ms.date: 03/16/2020
---
# .NET control does not load in Internet Explorer in Internet Zone

[!INCLUDE [](../../../includes/browsers-important.md)]

With Internet Explorer 8 and later versions, it is no longer possible to load .NET controls in Internet zone under the default(medium-high) security setting.

_Original product version:_ &nbsp; Internet Explorer 8 and later versions  
_Original KB number:_ &nbsp; 2403106

## More information

In Internet Explorer 8 and later versions, we have added a new UI-less [URLAction](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537183(v=vs.85)) (0x2005) that we check before loading the .NET MIME Filter, mscorie.dll, for content from the Internet zone. By default it is set to **DISABLE** in Medium-High or High templates that are the default security templates used by Internet Zone and Restricted Sites Zone respectively. This `URLAction` is enabled by default in the other security zones.

This change prevents the loading of mscorie.dll for a .NET control on a page, if that control's URL has a DISABLED policy for the new 0x2005 `UrlAction`. This `URLAction` cannot be configured via the Internet options control panel.

Mscorie.dll contains a Multipurpose Internet Mail Extensions (MIME) Type Filter. This filter hooks into Internet Explorer and monitors all incoming data streams with the MIME type application/octet-stream. A primary role of this filter is to examine the incoming stream to see whether or not the stream is managed code. If the filter determines that the incoming data is a .NET Framework module, the filter loads a managed assembly named *IEHost* that then handles loading the .NET control.

If you want to allow loading .NET controls for any web site that is impacted by this change, you can add it to the trusted sites zone. The site that needs to be added is that of the control and not that of the page. Alternatively, you can set the above `URLAction` to enable in the registry. This can compromise the security of your system.
