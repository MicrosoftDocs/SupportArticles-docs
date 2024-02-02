---
title: Hidden text in webpage can be copied
description: This article describes that even if the webpage hides the text, it will be copied when the visible text is copied.
ms.date: 06/09/2020
ms.reviewer: heikom
---
# When copying text from webpage, Hidden text may be copied too

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about hidden text that can be copied from a webpage and provides solutions to prevent this behavior.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2974910

## Symptoms

When you copy text from a webpage in Internet Explorer, hidden text may be copied as well, and will become visible when pasting that text into another application.

## Cause

When you select the surrounding container of the hidden text, the hidden text is selected also.

## Resolution

This issue has been resolved when using Standards Mode from Internet Explorer 9 and later versions. To enable Standards Mode, see [How to Enable Standards Support](/previous-versions/windows/internet-explorer/ie-developer/samples/gg699338(v=vs.85)).

## More information

The following snippet of a webpage demonstrates the issue when you select both visible lines and then use copy + paste into a text editor:

```html
<html>
    <body>
        This is a visible text.
        <div style="visibility:hidden">This text is hidden</div>
        This is a visible text.
    </body>
<html>
```
