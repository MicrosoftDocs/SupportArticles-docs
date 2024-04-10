---
title: Animated GIF is not animated in separate instances
description: This article provides a workaround for the problem where an animated GIF is not animated in separate instances of the WebBrowser control in the same process.
ms.date: 01/04/2021
ms.reviewer: 
ms.topic: troubleshooting
---
# Animated GIF is not animated in all instances of the WebBrowser control in the same process

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem where an animated GIF is not animated in separate instances of the WebBrowser control in the same process.

_Applies to:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3214423

## Symptoms

Consider the following scenario:

- You have an application that hosts two separate instances of the Internet Explorer WebBrowser control in the same process.
- You load the same animated GIF in both instances of the Internet Explorer WebBrowser control.

In this scenario, the GIF is animated in only one of the Internet Explorer WebBrowser control instances. The GIF in the other control remains frozen or behaves incorrectly.

## Workaround

To work around this issue, do not use the same instance of the animated GIF in different WebBrowser control instances that are in the same process.

## Status

Microsoft confirms this to be a problem in Internet Explorer 11 when the program hosts the WebBrowser control.
