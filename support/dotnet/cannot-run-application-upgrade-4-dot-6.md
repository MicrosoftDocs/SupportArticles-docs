---
title: Can't run .NET program after upgrading
description: When upgrading .NET Framework 4.5.2 to .NET Framework 4.6 or 4.6.1, you may experience issues when you run .NET Framework applications.
ms.date: 05/06/2020
ms.prod-support-area-path: 
ms.reviewer: Brettl
---
# Known issues when upgrading .NET Framework from version 4.5.2 to 4.6 or 4.6.1 on Windows Server 2012

This article provides information about the issue that .NET Framework applications cannot run when upgrading .NET Framework 4.5.2 to .NET Framework 4.6 or 4.6.1.

_Original product version:_ &nbsp; Windows Server 2012, .NET Framework 4.6.1, 4.6, 4.5.2  
_Original KB number:_ &nbsp; 4340191

## Introduction

When you upgrade from a fully updated system that is running on Microsoft .NET Framework 4.5.2 to Microsoft .NET Framework 4.6.1, you may experience issues when you run .NET Framework applications if you do not download and install updates that apply to .NET Framework 4.6.1.

## Symptoms

Consider the following scenario:

- You use .NET Framework 4.5.2 on Windows Server 2012.
- You have installed all the latest updates that apply to .NET Framework 4.5.2. This includes the May 2018 updates [4096494](https://support.microsoft.com/help/4096494/description-of-the-security-and-quality-rollup-for-net-framework-4-5-2) and [4095518](https://support.microsoft.com/help/4095518/description-of-the-security-only-update-for-net-framework-4-5-2-for-wi), or any newer updates.
- You download and install .NET Framework 4.6 or 4.6.1. However, you do not immediately install updates that apply to .NET Framework 4.6 and 4.6.1.

In this situation, some components of .NET Framework 4.6 or 4.6.1 are not upgraded as expected. This causes some .NET Framework applications not to start or run correctly.

## Resolution

To resolve this issue, try one of the following methods.

- Scan Windows Update, and then install the latest .NET Framework updates that apply to .NET Framework 4.6 and 4.6.1 immediately after you install .NET Framework 4.6 or 4.6.1.

- Upgrade to .NET Framework 4.6.2 or a newer version of .NET Framework instead of upgrading to .NET Framework 4.6 or 4.6.1. To do this, download any of the following installers:  

  - [.NET Framework 4.6.2 Web installer](https://go.microsoft.com/fwlink/?linkid=780597)
  - [.NET Framework 4.6.2 Offline installer](https://go.microsoft.com/fwlink/?linkid=780601)
  - [.NET Framework 4.7.2 Web installer](https://go.microsoft.com/fwlink/?LinkId=863262)
  - [.NET Framework 4.7.2 Offline installer](https://go.microsoft.com/fwlink/?linkid=863265)
