---
title: Internet Explorer cannot always return the same DISPID
description: Internet Explorer does not always return the same DISPID for every GetIDsOfNames call when running in Internet Explorer 9 Standards Mode or above.
ms.date: 04/20/2020
ms.reviewer: bachoang
---
# Internet Explorer may not return the same DISPID for the same property

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving Internet Explorer may not return the same `DISPID` with the same property.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2855169

## Symptoms

Imagine a scenario where an application uses a [binary behavior](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa744098(v=vs.85)) to define a custom property (let's call it *MyProp*). The binary behavior is attached to a `DOM` element running in Internet Explorer 9 standards mode or above. Customer may also be running other binary behaviors, ActiveX controls, or other browser add-ins, which call `IDispatch::GetIDsOfNames` to resolve the `DISPID` for the `MyProp` property. In certain situation, Internet Explorer does not always return the same `DISPID` for every `GetIDsOfNames` call when running in Internet Explorer 9 standards mode or above.

## Resolution

One way to work around this problem is to access the custom property `MyProp` first using `JavaScript` before calling `IDispatch::GetIDsOfNames` from a browser add-in. An example of this is to use the following function in the web page's body onload event:

```js
function foo()
{
    var a = document.getElementById("myelem");  // myelem is the id of the element which has the attached binary behavior
    if (a.myprop == null)  // myprop is the property in question
        //alert("null");
        ;
    else
        //alert("not null");
        ;
}
```
