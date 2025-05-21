---
title: User actions in Management Reporter Report Designer are slow
description: Describes performance issues in Management Reporter 2012. Provides a resolution.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# User actions in Management Reporter Report Designer are slow

This article provides a resolution for the performance issues in Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2778941

## Symptoms

A typical delay between user interface actions (clicking, selecting, opening reports, and so on) in Report Designer should be a few seconds at most and typically are less than one second. If these actions take multiple seconds to complete, you may be experiencing a proxy issue.

This article does not cover issues with report generation.

## Cause

The most common reason for slowness in Report Designer is that **Automatically detect** settings is enabled in Internet Explorer and Management Reporter is not receiving a valid WPAD (Web Proxy Auto-Discovery Protocol) response.

## Resolution

If you do not use WPAD on your DHCP or DNS servers, then you should clear the **Automatically detect** settings in Internet Explorer. You can find this setting in **Internet options**, select the **Connections** tab, and then select **LAN settings**.

## More information

More information on WPAD can be found at [About implementing WPAD](/previous-versions/tn-archive/cc995261(v=technet.10)).
