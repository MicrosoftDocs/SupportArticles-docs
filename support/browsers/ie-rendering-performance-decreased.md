---
title: Zoom level reduces rendering performance
description: This article describes the Quirks mode is incompatible with the zoom function of the webpage, you can use the latest Windows Internet Explorer standard mode to avoid this problem.
ms.date: 06/09/2020
ms.prod-support-area-path: 
ms.reviewer: jeanr
---
# Decreased rendering performance in Internet Explorer when adjusting zoom level in Quirks mode

This article provides information about the reduction of web page zoom performance when Quirks mode is enabled in the web browser and provides suggestions.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 2738239

## Summary

Most web browsers will switch to Quirks Mode if a web page uses non-standard HTML document declaration. Apart from most non-Microsoft web browsers, Windows Internet Explorer uses a Quirks Mode rendering engine, which is not based on a Standards Mode rendering engine. The Quirks Mode rendering engine for Windows Internet Explorer is based on Windows Internet Explorer 5.5. It was first introduced with Windows Internet Explorer 6 for backwards compatibility with legacy web pages.

## More information

Quirks Mode is not aware of page zooming, a feature that has been available since Windows Internet Explorer 7. Quirks Mode has not received any performance improvements to maintain backwards compatibility for page zooming. As a result, poor performance may be detected when using page zooming on web pages when using Quirks Mode.

This behavior is by design when Quirks Mode gets used. Recommended to use the most current Windows Internet Explorer standards mode, which is not affected by this page zooming issue.

## References

More information on Windows Internet Explorer document modes can be found at the following locations:

- [Creating Standards-Enabled Websites](https://docs.microsoft.com/previous-versions/windows/internet-explorer/ie-developer/samples/hh273394(v=vs.85))

- [Defining Document Compatibility](https://docs.microsoft.com/previous-versions/windows/internet-explorer/ie-developer/compatibility/cc288325(v=vs.85))

- [Optical Zooming in Legacy Document Modes](https://blogs.msdn.com/b/ie/archive/2012/08/28/optical-zooming-in-legacy-document-modes.aspx)

- [Interoperable Html5 Quirks Mode in IE 10](https://blogs.msdn.com/b/ie/archive/2011/12/14/interoperable-html5-quirks-mode-in-ie10.aspx)
