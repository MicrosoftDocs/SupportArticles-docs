---
title: Fail to add service reference to Silverlight project
description: Describes a problem that you see custom tool warning when adding a service reference to a Silverlight Project. Provides a solution.
ms.date: 05/08/2020
ms.reviewer: bretb, tref, ppratap, jamesche
---
# Custom tool warning when adding a service reference to a Silverlight Project

This article helps you resolve the custom tool warnings when you add a service reference to a Silverlight project.

_Original product version:_ &nbsp; Visual Studio Premium 2010, Visual Studio Professional 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2702288

## Symptoms

When trying to add a Windows Communication Foundation (WCF) service reference to a Silverlight 4 or Silverlight 5 project in Visual Studio 2010, the following warnings may occur:

> Custom tool warning: Endpoint 'NetTcpBinding_IService1' at address 'net.tcp://machine.mydomain.com:4502/WCFNetTcp/Service1.svc' is not compatible with Silverlight 5. Skipping...  
> Custom tool warning: No endpoints compatible with Silverlight 5 were found. The generated client class will not be usable unless endpoint information is provided via the constructor.

## Cause

These warnings occur because Silverlight doesn't support WCF endpoints configured to work over a secure NetTcp binding, and the service being imported contains one or more secure NetTcp bindings.

## Resolution

If the WCF service being imported only exposes the endpoint with a secure NetTcp binding, the Silverlight application won't be able to use that service until it's updated to expose a compatible endpoint. The documentation listed in the **References** section contains resources for adding compatible endpoints for WCF and Silverlight applications.

## References

- [How to: Use Windows Authentication to Secure a Service for Silverlight Applications](/previous-versions/windows/silverlight/dotnet-windows-silverlight/dd744835(v=vs.95))

- [Configuring Web Service Usage in Silverlight Clients](/previous-versions/windows/silverlight/dotnet-windows-silverlight/cc197941(v=vs.95))

- [HTTP Communication and Security with Silverlight](/previous-versions/windows/silverlight/dotnet-windows-silverlight/cc838250(v=vs.95))
