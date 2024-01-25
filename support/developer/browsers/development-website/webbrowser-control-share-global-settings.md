---
title: Global settings of WebBrowser controls
description: This article describes certain download options of WebBrowser can be set to be global and overwritten and shared on each client.
ms.date: 06/03/2020
ms.reviewer: scotrobe
---
# WebBrowser control clients share global settings

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides methods on implementing global settings for sharing WebBrowser control clients by overriding the OnAmbientProperty method of the hosting CWnd- based class.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 183412

## Symptoms

All hosts of the WebBrowser control share the same global Internet settings.

## Resolution

For most of the global Internet settings, there is no supported method for automatically saving a set of properties for each WebBrowser host.

However, certain download options, such as whether to download ActiveX controls or not, can be overridden and specified on a per-host basis.

## Status

This behavior is by design.

## More information

As documented in the Internet Client SDK (InetSDK), WebBrowser hosts can implement the **DISPID_AMBIENT_DLCONTROL** ambient property on their default dispatch interface to override the global settings for download options.

The WALKALL sample in the InetSDK (\InetSDK\Samples\Walkall) demonstrates this technique for an MSHTML host. A similar method can be used in WebBrowser hosts to achieve the same effect.

MSHTML will also ask for a new user agent via **DISPID_AMBIENT_USERAGENT** when navigating to clicked hyperlinks. This ambient property can be overridden, but it isn't used when programmatically calling the Navigate method. It will also not cause the `userAgent` property of the DOM's navigator object or **clientInformation** behavior to be altered - this property will always reflect Internet Explorer's own **UserAgent** string.

An MFC host of the WebBrowser control can easily affect these ambient properties by overriding the **OnAmbientProperty** method of the hosting CWnd-based class:

```cpp
BOOL CWBHostView::OnAmbientProperty(COleControlSite* pSite,
                                    DISPID dispid, VARIANT* pvar)
{
USES_CONVERSION;
    // Change download properties - no java, no scripts...
    if (dispid == DISPID_AMBIENT_DLCONTROL)
    {
        pvar->vt = VT_I4;
        pvar->lVal = DLCTL_NO_SCRIPTS | DLCTL_NO_JAVA
                   | DLCTL_NO_RUNACTIVEXCTLS | DLCTL_NO_DLACTIVEXCTLS;

        return TRUE;
    }

    // Change user agent for this web browser host during hyperlinks
    if (dispid == DISPID_AMBIENT_USERAGENT)
    {
        CString strUserAgent("MyWebBrowserHost");

        pvar->vt = VT_BSTR;
        pvar->bstrVal = ::SysAllocString(T2OLE(strUserAgent));

        return TRUE;
    }

    return CView::OnAmbientProperty(pSite, dispid, pvar);
}
```

The **DISPID_AMBIENT_*** and **DLCTL_*** values are defined in `Mshtmdid.h` (\InetSDK\Include\MSHTMDID.H).

## References

For more information about developing Web-based solutions for Microsoft Internet Explorer, see [Internet Explorer mode and the DevTools](/microsoft-edge/devtools-guide-chromium/ie-mode).
