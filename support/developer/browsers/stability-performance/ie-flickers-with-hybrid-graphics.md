---
title: Internet Explorer flickers on computers with hybrid graphics
description: Describes a problem with flickering that may be seen on certain notebook POCs, and describes a workaround.
ms.date: 03/16/2020
---
# Internet Explorer may flicker on computers with hybrid graphics

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides steps to solve the flickering issue that occurs on certain computers with *hybrid graphics*.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2387811

## Symptoms

On certain computers with *hybrid graphics*, such as notebook PCs, Internet Explorer may get into a state where the page it is displaying flickers while showing animated content. The flickering may also occur while mousing over certain elements on the page, such as menus, which respond to the mouse movement.

## Cause

This problem can occur when the computer's hybrid graphics implementation turns off one of the graphics processors. For example, a computer may shut down one of its graphics processors to save on power consumption.

## Resolution

To work around this problem, follow these steps:

1. Close all instances of Internet Explorer.
2. Open a new instance of Internet Explorer and resume browsing.

In many cases, you can easily return to the pages that were open when Internet Explorer was closed during step 1 above:

1. Click to create a new tab.
2. Click the Reopen Last Browsing Session link. Internet Explorer will attempt to reopen tabs that were contained in the last Internet Explorer window to be closed.

## More information

*Hybrid graphics* typically consists of two graphics processors (GPUs). One GPU provides high performance, for example when a notebook computer is plugged in, and the other provides the option of operating with low power consumption. Such a system may, for example, switch to using the energy- saving GPU when a notebook PC is unplugged, and turn off the high-power GPU.
