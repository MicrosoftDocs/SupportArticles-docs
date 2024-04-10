---
title: Unicode BiDi isolation in dir not working
description: The Unicode BiDi isolation in CSS dir property doesn't work in Internet Explorer and Microsoft Edge.
ms.date: 03/26/2020
ms.reviewer: saziz
---
# Unicode BiDi isolation in CSS dir property doesn't work in Internet Explorer and Microsoft Edge

[!INCLUDE [](../../../includes/browsers-important.md)]

This article discusses a by design behavior that Unicode BiDi isolation in CSS `dir` property does not work Internet Explorer and Microsoft Edge.

_Original product version:_ &nbsp; Microsoft Edge, Internet Explorer  
_Original KB number:_ &nbsp; 4459265

## Symptom

When you use Internet Explorer or Microsoft Edge to open a web page that has `unicode-bidi` set to isolation values though Cascading Style Sheets (CSS) or the HTML `dir` attribute, the isolation values do not take effect. As a result, some right-to-left and bilingual text is displayed incorrectly.

## Cause

Internet Explorer and Microsoft Edge currently don't support Unicode BiDi isolation.

## More information

In other browsers, the `dir` attribute sets can be established through the following two dependent properties:

- `direction` to the **author-specified** value
- `unicode-bidi` to the **isolate** value

But the second action does not apply to Internet Explorer and Microsoft Edge.

## Reference

For more information, see the Mozilla web pages: [direction](https://developer.mozilla.org/docs/Web/CSS/direction) and [unicode-bidi](https://developer.mozilla.org/docs/Web/CSS/unicode-bidi).
