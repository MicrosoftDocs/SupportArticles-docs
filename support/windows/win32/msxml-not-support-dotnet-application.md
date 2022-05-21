---
title: MSXML is not supported in .NET applications
description: This article describes the MSXML is not supported in .NET applications.
ms.date: 11/03/2020
ms.custom: sap:System Services Development
ms.reviewer: Dave Anderson
ms.technology: windows-dev-apps-system-services-dev
---
# The use of MSXML is not supported in .NET applications

This article introduces the MSXML is not supported in .NET applications.

_Original product version:_ &nbsp; MSXML  
_Original KB number:_ &nbsp; 815112

## Summary

Microsoft does not support the use of MSXML (Microsoft's COM-based XML parser) in .NET applications.

MSXML uses threading models and `garbage-collection` mechanisms that are not compatible with the .NET Framework. Using MSXML in .NET applications through COM interoperability can result in unexpected problems that are difficult to debug. Microsoft does not recommend or support directly instantiating and using `MSXML` objects in .NET code, nor does Microsoft recommend or support marshalling `MSXML` interface pointers across the interop boundary.

## More information

Support for implementing standards-based XML functionality in .NET applications is built into the .NET Framework. The .NET Framework classes in the `System.xml` namespaces should be used to implement standards-based XML functionality in .NET applications.
