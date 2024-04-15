---
title: Installing VC Runtime fails
description: This article provides the resolution to avoid the filename, directory name, or volume label syntax is incorrect error message that occurs when installing VC Runtime.
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: smondal
---
# Error when you install VC Runtime: The filename, directory name, or volume label syntax is incorrect

This article helps you resolve an error message that occurs when you try to install the Microsoft Visual C++ Redistributable Package.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 2629642

## Symptoms

When you try to install Visual C++ Redistributable Package from a folder name containing a double byte (for example, :::no-loc text="ダウンロード":::), you receive the following error message:

> Extraction Failed  
> The filename, directory name, or volume label syntax is incorrect.

## Cause

This problem occurs because the SFX cabbing technology used by Visual C++ Redistributable Package doesn't support double-byte character set (DBCS) characters. This issue can occur when languages other than the native operating system language is used. For example, if you are using the English operating system and use a language that uses double byte characters, such as Chinese or Japanese, either on the local machine or a universal naming convention (UNC) share.

## Resolution

Use a path that doesn't contain double byte characters.
