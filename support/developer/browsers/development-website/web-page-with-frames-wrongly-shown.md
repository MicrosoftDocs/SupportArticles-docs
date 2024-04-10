---
title: Web page with frames wrongly shown in Internet Explorer
description: Provides the solution to solve the problem that the web page that has frames is not displayed correctly in Internet Explorer.
ms.date: 02/26/2020
ms.reviewer: davidg
---
# Web page with frames isn't displayed properly in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces the resolution to fix the issue that a web page that contains frames is shown as a blank page in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 169522

## Symptoms

When you are using Internet Explorer to view a Web page, a blank page may be displayed instead of a defined set of frames. If you right-click an empty area of the Web page and then click **View Source**, or if you right-click an empty area of the Web page, click **Properties**, and then click **Analyze**, you may receive the following message:

> This document might not display properly because there is a FRAMESET within the BODY of the document. The page author can resolve this problem by the following steps:
>
> 1. Removing the BODY tag.
> 2. Insuring that there is no additional HTML code between the HEAD of the document and the FRAMESET.

## Cause

This behavior occurs if the author of the Web page has mistakenly located the \<FRAMESET> tag after the \<BODY> tag in the main or "framing" Hypertext Markup Language (HTML) document.

## Resolution

Contact the Web page author (or the administrator of the Web server) and request all \<FRAMESET> tags and their underlying instructions be moved so that they precede any \<BODY> tags.

## Status

This behavior is by design.

## More information

The framing HTML document defines the frame regions to be displayed in the browser and the documents or objects that initially appear in the frames.

For more information about the HTML syntax for frames, see [Implementing HTML Frames](https://www.w3.org/TR/wd-frames-970331.html).
