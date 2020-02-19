---
title: HIS doesn't work with VS 2013
description: Discusses that Host Integration Server 2013 is incompatible out-of-the-box with Visual Studio 2013 because Visual Studio 2013 doesn't contain any Host Integration Server 2013 templates. Provides a resolution.
ms.date: 02/18/2020
ms.prod-support-area-path: HIS Host Visual Studio template
---
# Host Integration Server 2013 does not work out-of-the-box with Visual Studio 2013

**Applies to**: Host Integration Server

_Original product version:_ &nbsp; 2013  
_Original KB number:_ &nbsp; 2970255

## Symptoms

After you install Microsoft Visual Studio 2013 on a computer that has Microsoft Host Integration Server 2013 installed, you don't see any Host Integration Server 2013 templates under the **Projects** node in the **Options** dialog box in Visual Studio.

## Cause

This problem occurs because Visual Studio 2013 doesn't include any Host Integration Server 2013 templates. By default, Host Integration Server 2013 works in a Visual Studio 2012 environment. Therefore, an out-of-the-box installation of Host Integration Server 2013 is incompatible with Visual Studio 2013.

## Resolution

To resolve this issue, install Cumulative Update 1 for HIS 2013. For more information about this update, see the following Microsoft Knowledge Base article:

[Cumulative update package 1 for Host Integration Server 2013](https://support.microsoft.com/help/2908834)
