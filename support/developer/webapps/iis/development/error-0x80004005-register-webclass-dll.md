---
title: Error 0x80004005 when you register WebClass
description: This article provides resolutions for the problem that occurs when you try to register the DLL on a computer.
ms.date: 03/24/2020
ms.custom: sap:Development
ms.reviewer: MCLAY
ms.technology: iis-development
---
# Error 0x80004005 when you try to register a WebClass DLL

This article helps you resolve the problem where an unexpected error might be thrown when you register a `WebClass` DLL.

_Original product version:_ &nbsp;  Internet Information Server  
_Original KB number:_ &nbsp; 307495

## Symptoms

If you use a Microsoft Internet Information Server (IIS) application (`WebClass`) to create a dynamic-link library (DLL) in Visual Basic 6.0, you receive the following error message when you try to register the DLL:

> DLLRegisterServer in \<path to DLL> failed.  
> Return Code was: 0x80004005

This error message occurs when you try to register the DLL on a computer other than the one on which it was created.

## Cause

The `WebClass` run-time files must be installed to register a `WebClass` DLL. This error occurs if you try to register the DLL on a computer that doesn't have the `WebClass` run-time files installed and registered.

## Resolution

To resolve this problem, use one of the following methods:

- The best way to deploy a `WebClass` is to use the Package and Deployment Wizard. The Package and Deployment Wizard packages the dependent `WebClass` run-time DLLs when your `WebClass` is deployed.
- Copy and register the *Mswcrun.dll* file to the computer on which you're trying to register your `WebClass` DLL.

## Steps to reproduce behavior

1. In Visual Basic 6.0, use the IIS **Application Project** option to create a `WebClass`.
2. Copy the DLL to a computer that doesn't have the *Mswcrun.dll* file.
3. At a command prompt, type `regsvr32 WebClass DllName.dll` to register the DLL.
