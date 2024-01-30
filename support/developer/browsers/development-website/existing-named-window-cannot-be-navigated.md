---
title: Existing named window can't be navigated
description: This article discusses issues related to named windows in Internet Explorer. This happens when the target url of the new navigation and the URL of the existing target window require processes with different integrity levels.
ms.date: 06/08/2020
ms.reviewer: bachoang
---
# Named window navigation might fail to navigate the existing named window

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem that you make sure that the target URL and the URL in the target window have the same protection mode setting when calling `window.open`.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2961083

## Symptoms

When navigating a URL with a target window (such as a form post, a hyperlink, or a `window.open` call) and the target window exists, a new window might open instead or the originating window might perform the navigation instead of the target window. The behavior exists on Internet Explorer 8 and above.

## Cause

This is a problem with Internet Explorer. This can happen if the target url of the new navigation and the url of the existing target window require processes with different integrity levels. In order to be in different integrity levels, they have to be in different security zones having different Protected Mode settings.

## Resolution

Make sure the target URL is in the same integrity level as the url in the target window when calling `window.open`. You can do this by making sure the zones that the two windows are in have the same protected mode settings.

## More information

If the named window for the navigation target already exists in the same integrity level as that of the originating window, then the navigation to a URL requiring a different integrity level to that named window will occur in the originating window since it can't use the existing window.  It does this by creating a new Internet Explorer process swapping the new Internet Explorer process' window in place of the existing Internet Explorer process' window.

If the named window for the navigation target already exists in a different integrity level as that of the originating window, then the navigation to a URL requiring a different integrity level to that named window will occur in a new window since it can't find the target window.

If User Account Control (UAC) is disabled, this problem won't appear in Windows 7 but Windows 8 might still display the behavior since processes are still launched as Medium or Low Integrity level for Internet Explorer.
