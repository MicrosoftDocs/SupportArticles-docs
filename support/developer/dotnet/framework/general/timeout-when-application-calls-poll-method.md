---
title: Time-out occurs when an application calls the Poll method
description: This article provides workarounds for the timeout issue that occurs when an application calls the Poll method.
ms.date: 07/08/2025
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: roriddle, dev_triage
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer, I want to fix time-outs that occur when my application calls the Poll method so that my application doesn't hang or lose socket data.
---
# Time-out occurs when an application calls the Poll method

_Applies to:_ .NET Core

## Symptom

A time-out occurs when you run an application that is using the `System.Net.Security.SslStream` class and that calls the `System.Net.Socket.Poll` method to check data on the underlying socket. When this happens, the `Poll` method returns false.

## Cause

The `SslStream` class is reading data from the socket faster than the application can read data from the stream buffer.

## Solution

To work around this issue, use one of the following methods:

- Don't use the `Poll` method in the application. Use the [Asynchronous Programming Model (APM)](/dotnet/standard/asynchronous-programming-patterns/asynchronous-programming-model-apm) pattern to get callbacks when data arrives instead.
- If you must use the `Poll` method, when the method returns true, make sure that all the stream buffer data has been read before you enter another `Poll` call.
