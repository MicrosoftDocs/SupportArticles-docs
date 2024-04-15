---
title: Visual Studio .NET source code debugging
description: This article describes how to enable Visual Studio .NET source code debugging using Reference Source Code Center.
ms.date: 04/26/2020
ms.custom: sap:Debuggers and Analyzers\Visual Studio Debugger
ms.reviewer: gaurap
ms.topic: how-to
---
# Limitations with Visual Studio .NET source code debugging using Reference Source Code Center

This article introduces a Microsoft Visual Studio .NET source debugging feature for published portions of the .NET managed sources and how to enable it.

_Original product version:_ &nbsp;  Visual Studio  
_Original KB number:_ &nbsp; 2588094

## Summary

With Visual Studio, you can enable .NET source stepping for published portions of the .NET managed sources. For more information on the steps to get this feature working, see [Microsoft Reference Source Code Center](https://referencesource.microsoft.com/).

## Description of the feature

This feature is designed to work for a subset of managed .NET components whose source code is indexed and published onto the Reference Source Code Center source server. The .NET sources published using this service are RTM (major *in box* releases), service packs, and widely distributed non-security releases. For those who prefer working offline, there are downloadable source packages available as well.

This feature is binary version specific for what is deployed on your system. Therefore, for minor hotfix updates or security releases that may not be published, you may not find sources for those specific patched binaries available. For more information, contact [Reference Source Server Discussion Forums](https://social.msdn.microsoft.com/Forums/home?forum=refsourceserver).
