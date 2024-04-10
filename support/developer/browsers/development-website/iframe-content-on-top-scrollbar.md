---
title: Content of iframe on top of the scrollbar
description: This article explains that when Internet Explorer uses quirks mode as the document mode, the content of the iframe will be displayed on the top of the scrollbar.
ms.date: 06/09/2020
ms.reviewer: jeanr
---
# Content of an iFrame is rendered on top of a scrollbar in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about webpages that contain iframe with scroll bars. The content of iframe may get rendered on top of the scrollbars. It is recommended to use Internet Explorer 9's standard mode to render webpages.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2689778

## Symptoms

Consider the following scenario. You have a webpage that contains an iframe with scrollbars, and an HTML page is displayed within the iframe. In this scenario, the content of the iframe may get rendered on top of the scrollbars.

## Cause

This problem can occur if Internet Explorer is using Quirks mode as the document mode.

## Resolution

To work around this issue, use Standards Mode for Internet Explorer 9 and later versions to render the web page.

## More information

This issue only occurs if the page is either using no document type declaration or is using a faulty document type declaration. This puts the browser into Quirks mode. Quirks mode follows non-standard rules introduced with Internet Explorer 5.5 and is still available for backwards compatible with legacy web pages that expect the non-standard behavior. Microsoft recommends using the latest available standard mode to render HTML pages.
