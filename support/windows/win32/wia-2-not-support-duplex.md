---
title: WIA 2.0 doesn't support duplex scan
description: When scanning documents using an application that uses the Windows Image Acquisition (WIA) Automation Library 2.0, the application will fail to perform a duplex scan.
ms.date: 03/16/2020
ms.custom: sap:Graphics and multimedia development
ms.reviewer: dbristol
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# WIA Automation Library 2.0 does not support duplex scan

This article helps you resolve the problem that when you scan documents using an application that uses Windows Image Acquisition (WIA) Automation Library 2.0, the application will fail to perform a duplex scan.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2709992

## Symptoms

When scanning documents using an application that uses the WIA Automation Library 2.0, the application will fail to perform a duplex scan. The application scans one side of the document but not the second side.

## Cause

This is a limitation of the WIA Automation Library 2.0.

## Resolution

You can avoid this problem by developing your application using native WIA 2.0 (Windows Visa and Windows 7) or WIA 1.0 (Windows XP).

## More information

[WIA Tutorial](/windows/win32/wia/-wia-wia-tutorial) provides step-by-step instructions to use WIA in real-world applications.
