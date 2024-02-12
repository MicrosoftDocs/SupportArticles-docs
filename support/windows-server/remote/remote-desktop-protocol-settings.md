---
title: Remote Desktop Protocol settings in Windows Server 2003 and in Windows XP
description: Discusses the connection settings that are stored in the Default.rdp file on Windows Server 2003-based and Windows XP-based computers.
ms.date: 04/12/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
---
# Remote Desktop Protocol settings in Windows Server 2003 and in Windows XP

This article discusses the connection settings that are stored in the Default.rdp file on Windows Server 2003-based and Windows XP-based computers.

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page:
[Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 885187

## Introduction

When you use the Remote Desktop Protocol (RDP) to connect to a remote computer, the Default.rdp file is created on the client computer. This article discusses the connection settings that are stored in the Default.rdp file.

## More information

When you use RDP to connect to a remote computer, you can use the Remote Desktop Connection **Options** dialog box to configure many of the connection settings. To configure these settings, follow these steps:  

1. Click **Start**, click **Run**, type _mstsc.exe_, and then click **OK**.
2. In the **Remote Desktop Connection** dialog box, click **Options**.

You can save *.rdp files with different settings if you connect to multiple remote computers. To save a new configuration, click **Save As** on the **General** tab in **Options**.

### Settings that are stored in the Default.rdp file

By default, the Default.rdp file is created in your My Documents folder. The following RDP settings are stored in the Desktop.rdp file:

#### desktopwidth: i

This setting corresponds to the desktop width that you select on the **Display** tab in Remote Desktop Connection **Options**.

> [!NOTE]
> Microsoft Windows CE-based devices support only full-screen mode.

#### desktopheight: i

This setting corresponds to the desktop height that you select on the **Display** tab in Remote Desktop Connection **Options**.

> [!NOTE]
> Microsoft Windows CE-based devices support only full-screen mode.

#### session bpp: i

This setting corresponds to the color depth that you select in **Colors** on the **Display** tab in Remote Desktop Connection **Options**.

> [!NOTE]
> Microsoft Windows CE-based devices support only full-screen mode.

#### winposstr: s

This setting corresponds to the window position that you select on the **Display** tab in Remote Desktop Connection **Options**.

> [!NOTE]
> On desktop computers, this setting determines the **Remote Desktop Connection** dialog box position on the screen. The six numbers represent a string form of the WINDOWPOS structure. For more information about the WINDOWPOS function, visit the following Microsoft Web site:
>
> [WINDOWPOS structure](/windows/win32/api/winuser/ns-winuser-windowpos)

> [!NOTE]
> Microsoft Windows CE-based devices support only full-screen mode.

#### auto connect: i

This setting isn't used by desktop computers or by Windows CE-based clients.

#### full address: s

This setting determines the computer that you connect to. The setting corresponds to the entry in the **Computer** box on the **General** tab of Remote Desktop Connection **Options**.

#### compression: i

This setting determines whether data is compressed when it's transmitted to the client computer.

|Value|Setting|
|---|---|
|0|Compression is off.|
|1|Compression is on.|
  
#### keyboardhook: i

This setting determines where Windows key combinations are applied. This setting corresponds to the selection in the **Keyboard** box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Applied on the local computer.|
|1|Applied on the remote computer.|
|2|Applied in full-screen mode only.|
  
#### audiomode: i

This setting determines where sounds are played. This setting corresponds to the selection in the **Remote computer sound** box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Play sound on the client computer.|
|1|Play sound on the host computer.|
|2|Don't play sounds.|
  
#### redirectdrives: i

This setting determines whether disk drives are automatically connected when you log on to the remote computer. This setting corresponds to the selection in the **Disk Drives** box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Drives aren't automatically reconnected.|
|1|Drives are automatically reconnected.|
  
#### redirectprinters: i

This setting determines whether printers are automatically connected when you log on to the remote computer. This setting corresponds to the selection in the **Printers** check box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Printers aren't automatically reconnected.|
|1|Printers are automatically reconnected.|
  
#### redirectcomports: i

This setting determines whether COM ports are automatically connected when you log on to the remote computer. This setting corresponds to the selection in the **Serial Ports** box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|COM ports aren't automatically reconnected.|
|1|COM ports are automatically reconnected.|
  
#### redirectsmartcards: i

This setting determines whether smart cards are automatically connected when you log on to the remote computer. This setting corresponds to the selection in the **Smart cards** box on the **Local Resources** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Smart cards aren't automatically reconnected.|
|1|Smart cards are automatically reconnected.|
  
#### displayconnectionbar: i

This setting determines whether the connection bar is displayed when you log on to the remote computer in full-screen mode. This setting corresponds to the selection in the **Display the connection bar when in full screen mode** check box on the **Display** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Connection bar doesn't appear.|
|1|Connection bar appears.|
  
#### username: s

This setting determines the user name that is displayed in RDP. The setting corresponds to the entry in the **User name** box on the **General** tab of Remote Desktop Connection **Options**.

#### domain: s

This setting determines the user name that is displayed in the **Remote Desktop Connection** dialog box. It corresponds to the entry in the **Domain** box on the **General** tab of Remote Desktop Connection **Options**.

#### alternate shell: s

This setting determines whether a program is started automatically when you connect with RDP. The setting corresponds to the entry in the **Program path and file name** box on the **Programs** tab of Remote Desktop Connection **Options**.

#### shell working directory: s

This setting is the folder location for the application that is started automatically when you connect with RDP. The setting corresponds to the entry in the **Program path and file name** box on the **Programs** tab of Remote Desktop Connection **Options**.

#### disable wallpaper: i

This setting determines whether the desktop background appears when you log on to the remote computer. This setting corresponds to the selection in the **Desktop background** check box on the **Experience** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Wallpaper appears.|
|1|Wallpaper doesn't appear.|
  
#### disable full window drag: i

This setting determines whether folder contents appear when you drag the folder to a new location. This setting corresponds to the selection in the **Show contents of window while dragging** check box on the **Experience** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Folder contents appear while dragging.|
|1|Folder contents don't appear while dragging.|
  
#### disable menu anims: i

This setting determines how menus and windows appear when you log on to the remote computer. This setting corresponds to the selection in the **Menu and window animation** check box on the **Experience** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Menu and window animations are permitted.|
|1|Menu and window animations aren't permitted.|
  
#### disable themes: i

This setting determines whether themes are permitted when you log on to the remote computer. This setting corresponds to the selection in the **Themes** check box on the **Experience** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Themes are permitted.|
|1|Themes aren't permitted.|
  
#### bitmapcachepersistenable: i

This setting determines whether bitmaps are cached on the local computer. This setting corresponds to the selection in the **Bitmap caching** check box on the **Experience** tab of Remote Desktop Connection **Options**.

|Value|Setting|
|---|---|
|0|Caching isn't enabled.|
|1|Caching is enabled.|
  
#### autoreconnection enabled: i

This setting determines whether a client computer automatically tries to reconnect after being disconnected.

|Value|Setting|
|---|---|
|0|Client computer doesn't automatically try to reconnect.|
|1|Client computer automatically tries to reconnect.|
  
