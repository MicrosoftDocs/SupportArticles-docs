---
title: Endpoint.Address value problem when you use the channel
description: This article provides resolutions for the problem that when you use the discovery client channel in Windows Communication Foundation, the Endpoint.Address property is always set to http://schemas.microsoft.com/dynamic.
ms.date: 12/11/2020
---
# When you use the discovery client channel in Windows Communication Foundation, the Endpoint.Address property is always set to `http://schemas.microsoft.com/dynamic`

This article helps you resolve the problem that when you use the discovery client channel in Windows Communication Foundation, the `Endpoint.Address` property is always set to `http://schemas.microsoft.com/dynamic`.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2015626

## Symptoms

In Windows Communication Foundation, if you discover a service by using a DynamicEndpoint or by using a custom binding that contains a `DiscoveryClientBindingElement`, then the `Endpoint.Address` property will be set to `http://schemas.microsoft.com/dynamic`.

## Cause

The `Endpoint.Address` value reflects what the user passed in and therefore is not changed.

## Resolution

To access the address of the discovered service, use the `RemoteAddress` property in the channel.
