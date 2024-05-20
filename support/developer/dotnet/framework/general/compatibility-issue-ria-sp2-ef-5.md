---
title: Compatibility when you use RIA V1.0 and EF 5
description: Works around a problem in which your application may meet unpredictable behavior.
ms.date: 05/11/2020
ms.reviewer: enamulkh
---
# Compatibility issue when you use RIA Services V1.0 SP2 together with Entity Framework 5

This article helps you resolve the compatibility problem that occurs when you use Windows Communication Foundation (WCF) Rich Internet Applications (RIA) Services V1.0 SP2 and Entity Framework (EF) 5 together in an application.

_Original product version:_ &nbsp; Entity Framework 4.1  
_Original KB number:_ &nbsp; 2975356

## Symptoms  

When you use WCF RIA Services V1.0 SP2 and EF 5 together in an application, the application may meet unpredictable behavior.

## Cause

This issue occurs because of metadata compatibility issues between RIA Services in Microsoft Visual Studio and versions of Entity Framework later than 4.1.

## Workaround

To work around this issue, when you select a Silverlight Business Application template in Microsoft Visual Studio 2010, Visual Studio 2012 or Visual Studio 2013, use RIA V1.0 SP2 together with Entity Framework 4.1, which comes as a default choice. To use later versions of Entity Framework, you have to use the publicly available NuGet packages.

## Methods to add RIA Services to a Silverlight project

There are two ways to add RIA Services functionality to a Microsoft Silverlight project:

- Add RIA Services functionality that is included with Visual Studio.

    This method requires Entity Framework 4.1 and is supported by Microsoft.

- Add RIA Services functionality that is available as a NuGet package.

    This method is recommended when you use the later versions of Entity Framework. However, it's not supported by Microsoft.

## More information

For more information about RIA Services, see [RIA Services is Getting Open-Sourced](https://jeffhandley.com/2013-07-03/ria-services-is-getting-open-sourced). For NuGet packages, see the repository at [NuGet.org](https://www.nuget.org).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
