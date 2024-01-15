---
title: Add-ons intercept WM_CLOSE fail
description: This issue affects Internet Explorer add-ons attempting to hook into the WM_CLOSE message to prevent a tab from closing. In Internet Explorer 9 and later versions, this action may fail, which results in the tab closing before the add-on wishes.
ms.date: 04/21/2020
---
# Add-ons that intercept the WM_CLOSE message may fail in Internet Explorer 9 later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving the issue that a browser tab or window can't be prevented from closing by the `WM_CLOSE` message intercepted by some add-ons in Internet Explorer 9 or a later version.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2587178

## Symptoms

Some add-ons for Internet Explorer attempt to prevent a browser tab or window from closing by intercepting the `WM_CLOSE` message before the tab receives it. In Internet Explorer 9 or a later version, this action may not prevent the tab from closing.

## Cause

Internet Explorer 9 or a later version, like Internet Explorer 8, isolates tabs to their own processes. When a tab is closed in Internet Explorer 8, the underlying tab process must first close before the tab visually disappears. To make Internet Explorer 9 or a later version more responsive to the user, the browser will now hide a tab as soon as the user closes it. Internet Explorer 9 or a later version will handle much of the mechanics of closing a tab or window while the tab is invisible.

## Resolution

Intercepting or hooking the `WM_CLOSE` message is not a supported method of preventing a tab in Internet Explorer from closing.

However, the author of the add-in or of the web pages may be able to make changes that allow this method to work in Internet Explorer 9 or a later version. This new tab close behavior will not be used if the `window.onbeforeunload` event has any registered handlers. The following code is an example of this approach, as it might be implemented in script on the page:

```javascript
function myHandler()
{
 // do nothing
}
window.onbeforeunload = myHandler;
```

## More information

For more information about Internet Explorer, see [Internet Explorer help](https://support.microsoft.com/hub/4230784/internet-explorer-help).
