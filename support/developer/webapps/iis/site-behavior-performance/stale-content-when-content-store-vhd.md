---
title: Stale content when you store the content on a VHD
description: This article provides workaround for the problem where IIS serves stale content when you store the content on a VHD.
ms.date: 12/11/2020
ms.custom: sap:Site Behavior and Performance
ms.reviewer: mlaing, robmcm, romanf
ms.technology: iis-site-behavior-performance
---
# IIS serves stale content when you store the content on a VHD

This article helps you work around the problem where Internet Information Services (IIS) serves stale content when you store the content on a Virtual Hard Drive (VHD).

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 2814040

## Symptoms

Consider the following scenario.

- You are hosting a web application on IIS 8.0 or earlier.
- You stored the content for your web application on a VHD.
- When you make an update to the content, such as adding a new version of an image file or editing text on a page, you expect that the updated content will be served to incoming web requests.

In this scenario, the updated content is not display, and incoming web requests are responded to with the old content version.

## Cause

This behavior occurs because File Change Notifications (FCN) do not traverse across mount points. Since *HTTP.sys* is not notified that a new version of the content is available, it continues to serve the version of the content it has stored in its kernel-mode cache.

## Workaround

To work around this behavior, choose one of the following options:

- Manually flush the *HTTP.sys* cache for the web application after making updates to the content stored on the VHD. To flush the *HTTP.sys* cache for the application, restart the application pool.

- Do not store your content on a VHD.

## Steps to reproduce

1. Install IIS.
1. Create new `VDisk` (for example, `C:\VDisk\Disks\DeDup` and mount it to `C:\inetpub\wwwroot\DeDup`).
1. Copy a PNG file (2.png) to the new `VDisk`.
1. Enable DeDup on `VDisk`.
1. Optimize `VDisk` by doing `ddpcli enqueue /opt /vol "C:\inetpub\wwwroot\DeDup"` (FSUTIL reparsepoint query `C:\inetpub\wwwroot\DeDup\2.png` shows optimized).
1. Load `http://ServerName/DeDup/2.png`.
1. Edit `C:\inetpub\wwwroot\DeDup\2.png` and save it.
1. Load `http://ServerName/DeDup/2.png` - see the changes.
1. Optimize `VDisk` again (FSUTIL reparsepoint query "C:\inetpub\wwwroot\DeDup\2.png" shows optimized).
1. Load `http://ServerName/DeDup/2.png` - see the changes.
1. Edit `C:\inetpub\wwwroot\DeDup\2.png` again and save it.
1. FSUTIL reparsepoint query `C:\inetpub\wwwroot\DeDup\2.png` shows not optimized.
1. Load `http://ServerName/DeDup/2.png` - don't see the newest changes!
1. Open file directly on content server to make sure the file contains both sets of changes - it does.

## More information

- [Http.sys Response Cache](/previous-versions/windows/it-pro/windows-server-2003/cc781368(v=ws.10))

- [Instances in which HTTP.sys doesn't cache content](/troubleshoot/iis/instances-httpsys-not-cache)
