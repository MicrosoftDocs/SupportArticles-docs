---
title: Windows Installer source list update fails
description: Windows Installer source list doesn't update when Configuration Manager clients communicate with distribution points by using HTTPS.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Windows Installer source list update fails when distribution points are configured for HTTPS

This article helps you work around an issue in which Windows Installer source list doesn't update when Configuration Manager clients communicate with distribution points by using HTTPS.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 2905510

## Symptom

In Microsoft System Center 2012 Configuration Manager, and later versions of the program, Windows Installer source list update fails when clients communicate with distribution points by using HTTPS. You receive the following error messages in SrcUpdateMgr.log on the clients:

> UpdateURLWithTransportSettings(): HTTP requested but client settings prohibit it.  
> Failed source list update for product \<product code>, error 87d00226  
> DoUpdateSourceListAll task failed, error code 87d00226  
> Source list update task failed, will be retried after 3600 seconds

## Cause

This is an unsupported scenario.

## Workaround

> [!IMPORTANT]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around the issue, use one of the following methods:

- Use HTTP for communication from clients to distribution points if you can.
- For packages, enable **Copy the content in this package to a package share on distribution points** in the package properties.

  For applications, add the location of the application source to the following Windows Installer source list registry subkeys:

  - `HKEY_CLASSES_ROOT\Installer\Products\<product code>\SourceList\Net`
  - `HKEY_CURRENT_USER\Software\Microsoft\Installer\Products\<product code>\SourceList\Net`
