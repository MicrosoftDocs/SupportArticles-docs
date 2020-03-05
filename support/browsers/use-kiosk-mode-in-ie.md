---
title: How to use Kiosk Mode in Internet Explorer
description: This article describes how to use Kiosk Mode in Internet Explorer.
ms.date: 03/03/2020
ms.prod-support-area-path: Internet Explorer
---
# How to use Kiosk Mode in Internet Explorer

Internet Explorer includes a Kiosk Mode feature that allows you to only access Web pages. This article describes how to use the Kiosk Mode feature in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 154780

When you run Internet Explorer in Kiosk mode, the Internet Explorer title bar, menus, toolbars, and status bar are not displayed and Internet Explorer runs in Full Screen mode. The Windows 95 taskbar is not displayed, but you can switch to other running programs by pressing ALT+TAB or CTRL+ALT+DEL. Because Internet Explorer is running in Full Screen mode, you cannot access the Windows 95 desktop until you quit Internet Explorer.

## How to Start Internet Explorer in Kiosk Mode

To start Internet Explorer in Kiosk mode, click **Start**, click **Run**, type the following command in the **Open** box, and then click **OK**:

```console
iexplore -k page
```

where **page** is the Web page address for the Web page that you want to appear when Internet Explorer starts. If you do not specify a Web page in the **Open** box, Internet Explorer opens your start page. Note that the Web page that you specify can be a Web page on the Internet, on your computer, or on another computer on the network.

To start Internet Explorer in Kiosk mode and start Internet Explorer with the Microsoft Web site, click **Start**, point to **Run**, and then type iexplore -k www.microsoft.com in the **Open** box.

To start Internet Explorer in Kiosk mode and start Internet Explorer with the Example.htm Web page that is located in the My Documents folder on your computer, click **Start**, point to **Run**, and then type iexplore -k "c:\my documents\example.htm" in the **Open** box.

To start Internet Explorer in Kiosk mode and start Internet Explorer with the Example.htm Web page that is located on another computer on the network, click **Start**, point to **Run**, and then type iexplore -k\\\\**server**\\**share**\example.htm in the
**Open** box, where **server** and **share** are the network server and share on which the Web page is located.

## How to Quit Internet Explorer in Kiosk Mode

To quit Internet Explorer when it is running in Kiosk mode, press ALT+F4. Note that you cannot quit Kiosk mode if you do not also quit Internet Explorer.

## Keyboard Shortcuts for Kiosk Mode

|Key combination|Function|
|--|--|
  | CTRL+A   |        Select all (editing)|
   |CTRL+B   |        Organize favorites|
  | CTRL+C   |        Copy (editing)|
  | CTRL+F  |         Find (on current page)|
  | CTRL+H  |         View History folder|
   |CTRL+L |          Open Location dialog box|
  | CTRL+N     |      New window (opens in non-Kiosk mode)|
   |CTRL+O |          Open Location dialog box (same as CTRL+L)|
   |CTRL+P     |      Print|
   |CTRL+R   |        Refresh|
   |CTRL+S   |        Save|
   |CTRL+V     |      Paste (editing)|
   |CTRL+W   |        Close (same as ALT+F4)|
   |CTRL+X   |        Cut (editing)|
  | ALT+F4 |          Close|
   |ALT+LEFT ARROW |  Back|
   |ALT+RIGHT ARROW | Forward|
  | ESC    |          Stop|
   |F5  |             Refresh|
