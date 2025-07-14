---
title: Time-out occurs when an application calls the Poll method
description: This article provides workarounds for the timeout issue that occurs when an application calls the Poll method.
ms.date: 12/28/2020
author: aartig13
ms.author: aartigoyle
ms.reviewer: roriddle, dev_triage
ms.custom: sap:Class Library Namespaces
---
# Time-out occurs when an application calls the Poll method

_Original product version:_ &nbsp; .NET Core

## Symptom

A time-out occurs when you run an application that is using the `System.Net.Security.SslStream` class and that calls the `System.Net.Socket.Poll` method to check data on the underlying socket. When this happens, the `Poll` method returns false.

## Cause

The `SslStream` class is reading data from the socket faster than the application can read data from the stream buffer.

## Workaround

To work around this issue, use one of the following methods:

- Don't use the `Poll` method in the application. Use the [Asynchronous Programming Model (APM)](/dotnet/standard/asynchronous-programming-patterns/asynchronous-programming-model-apm) pattern to get callbacks when data arrives instead.
- If you must use the `Poll` method, when the method returns true, make sure that all the stream buffer data has been read before you enter another `Poll` call.
