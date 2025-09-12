---
title: Can't install JDK in Visual Studio 2017
description: You can't install JDK package in Visual Studio 2017. To solve this problem, update to latest version of Visual Studio 2017.
ms.date: 04/20/2020
ms.custom: sap:Third Party Tools installed with Visual Studio\Other
ms.reviewer: vyedin
---
# Error for installation of JDK in Visual Studio 2017: Failed to download

This article helps you work around an error (failed to download) that occurs when you install Java Development Kit (JDK) in Microsoft Visual Studio 2017.

_Original product version:_ &nbsp; Visual Studio 2017  
_Original KB number:_ &nbsp; 4483430

## Symptoms

When you install JDK in Visual Studio 2017, you receive one of the following error messages:  

- Message 1

    > "Package 'JavaJDKV2,version=1.8.6,chip=x86' failed to download"

- Message 2

    > "Package 'JavaJDKV2,version=1.8.6,chip=x64' failed to download"

- Message 3

    > "ackage 'JavaJDKV1,version=1.8.18' failed to download"

- Message 4

    > "PackageId:JavaJDKV2;PackageAction:DownloadPackage"

## Cause

This issue occurs because Oracle no longer allows distribution of JDK in Visual Studio (as of January 2019).

## Workaround

To work around this issue, try the following methods:

- We recommend updating to the latest version of Visual Studio 2017. The latest version of Visual Studio 2017 uses an OpenJDK distribution for mobile development and avoids setup issues that concern Oracle JDK.

- If you can't update your Visual Studio, install the latest JDK 8 that's available from the [Java SE Development Kit 8 Downloads](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html). Then set the JDK path by following these steps:

    1. Select **Tools**.
    1. Select **Options**.
    1. Select **Xamarin**.
    1. Select **Android Settings**.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
