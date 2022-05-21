---
title: Icon overlay handlers aren't displayed
description: Describes a product limitation in Windows that restricts the number of icon overlays, which means that some registered icon overlays aren't displayed as expected.
ms.date: 03/12/2020
ms.custom: sap:Desktop app UI development
ms.reviewer: davean
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# Registered icon overlay handlers aren't used by Windows Shell

This article helps you resolve the problem where Windows Shell doesn't display some icon overlays.

_Original product version:_ &nbsp; Windows 10, 8.1, 8  
_Original KB number:_ &nbsp; 3106961

## Symptoms

You discover that Windows Shell doesn't display some icon overlays that are provided by registered icon overlay handlers. This behavior affects applications that register an icon overlay handler to provide extra information about a file or a folder.

## Cause

The number of icon overlay handlers that the system can support is limited by the amount of available space for icon overlays in the system image list. There are currently 15 slots allotted for icon overlays, 4 of which are reserved by the system. When there are more than 11 icon overlay handlers registered in the system, only the first 11 icon overlays that are provided by icon overlay handlers are added to the system image list. The remaining icon overlay handlers aren't used.

## Resolution

Software developers shouldn't rely solely on icon overlay handlers to provide extra information about files or folders. Extra information about a file or folder should also be accessible to users through other means, such as through the [Windows Property System](/windows/win32/properties/windows-properties-system).

## More information

An icon overlay is a small image in the lower-left corner of an icon that represents a `Shell` object. An icon overlay is typically added to an object's icon to provide extra information. For example, a commonly used icon overlay is the small arrow that indicates the icon represents a link instead of the actual file or folder. In addition to the standard icon overlays that are provided by the system, software developers can provide custom icon overlays by implementing and registering an icon overlay handler.

Microsoft OneDrive and OneDrive for Business register multiple icon overlay handlers to indicate the synchronization and share states of the files that are managed by those applications. Because OneDrive is installed by default in Windows 10 systems, the number of icon overlay handlers that other applications can register before the problem that's described in the [Symptoms](#symptoms) section appears effectively reduced. OneDrive currently registers five icon overlay handlers, and there are four system icon overlays. This leaves just six slots in the system image list for use by other icon overlay handlers.

Also, icon overlay handlers aren't used under folders that are synchronized with cloud file system, such as OneDrive and OneDrive for Business. The handlers aren't even executed under such folders.

For more information, see [Creating icon overlay handlers](/previous-versions/cc144123(v=vs.85)).
