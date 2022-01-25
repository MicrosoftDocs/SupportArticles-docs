---
title: Two DLL hosts start when a COM+ object is enabled
description: A behavior in which two DLL hosts start when you create a COM+ object that has pooling enabled.
ms.date: 03/12/2020
ms.custom: sap:Component development
ms.reviewer: earlb
ms.technology: windows-dev-apps-component-dev
---
# Two DLL hosts start when a COM+ object enabled

This article explains a behavior that two DLL hosts start when application pooling is enabled for a COM+ application.

_Original product version:_ &nbsp; Winsock  
_Original KB number:_ &nbsp; 3148846

## Summary

When a COM+ application is configured to use application pooling, two DLL hosts start instead of one host starting.

## Why this behavior occurs

When application pooling is enabled for a COM+ application, object creation requests are routed through the RPC service. Application pooling uses a round robin algorithm to send object creation requests to the DLL host processes that are started.

When you create a Component Object Model (COM) object, you primarily use the `CoCreateInstance` or `CoCreateInstanceEx` function. The second way to create COM objects is to get the class factory from the DLL, and then use the class factory object. This method is most frequently used when you create more than one COM object at a time.

`CoCreateInstance` counts as a single object creation request. If you use the class factory approach, it counts as two object creation requests. Because the first creation is for the class factory object. If you have application pooling enabled, this configuration starts two `Dllhost.exe` processes.

.NET uses the class factory method to create COM objects. So two DLL hosts are started on .NET clients when you create an object from the targeted COM+ application.

## Status

This behavior is by design.
