---
title: Compatibility issue when you use RIA Services
description: This article provides a workaround for the problem when you use Windows Communication Foundation (WCF) RIA Services V1.0 SP2 and Entity Framework (EF) 5 together in an application.
ms.date: 10/27/2020
ms.prod-support-area-path: General
---
# Compatibility issue when you use RIA Services V1.0 SP2 together with Entity Framework 5

This article helps you resolve the problem when you use Windows Communication Foundation (WCF) RIA Services V1.0 SP2 and Entity Framework (EF) 5 together in an application.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2975356

## Symptoms  

When you use Windows Communication Foundation (WCF) RIA Services V1.0 SP2 and Entity Framework (EF) 5 together in an application, the application may encounter unpredictable behavior.

## Cause

This issue occurs because of metadata compatibility issues between RIA Services in Microsoft Visual Studio and versions of Entity Framework later than 4.1.

## Workaround

To work around this issue, when you select a Silverlight Business Application template in Visual Studio 2010, Visual Studio 2012 or Visual Studio 2013, use RIA V1.0 SP2 together with Entity Framework 4.1 that comes as a default choice. To use later versions of Entity Framework, you have to use the publically available NuGet packages.

## More information

There are two ways to add RIA Services functionality to a Silverlight project:

- Add RIA Services functionality that is included with Visual Studio.

- Add RIA Services functionality that is available as a NuGet package.

The first way (Visual Studio) requires Entity Framework 4.1 and is supported by Microsoft.
The second way (NuGet) is recommended when you use the later versions of Entity Framework. However, this is not supported by Microsoft.

[One set of NuGet packages](http://jeffhandley.com/archive/2012/12/10/ria-services-nuget-package-updates-ndash-including-support-for-entityframework.aspx)  supports Entity Framework 5. Other NuGet packages are provided by [open RIA Services](http://www.openriaservices.net/) that is open-source project. For more information about RIA Services, see [RIA Services is getting open-sourced](https://jeffhandley.com/2013-07-03/ria-services-is-getting-open-sourced).

## Third-party solution disclaimer

[!INCLUDE [Third-party disclaimer](../includes/third-party-disclaimer.md)]
