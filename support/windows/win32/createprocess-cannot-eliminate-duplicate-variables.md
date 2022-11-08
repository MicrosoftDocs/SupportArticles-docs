---
title: CreateProcess can't eliminate variables
description: This article describes that in lpEnvironment parameter environment block, CreateProcess won't eliminate duplicated variables.
ms.date: 03/16/2020
ms.custom: sap:System services development
ms.reviewer: Franki
ms.technology: windows-dev-apps-system-services-dev
---
# CreateProcess won't eliminate duplicated variables from the environment block in lpEnvironment parameter

An application calls `CreateProcess` and passes an environment block as its `lpEnvironment` parameter.

If we have two definitions for the same variable but with different values in that block, we may expect that the child process gets the last value we set in the block when it queries for the variable. Instead, Windows returns the first value.

_Original product version:_ &nbsp; Windows Server 2008  
_Original KB number:_ &nbsp; 2505238

## Cause

This behavior is by design in Windows.

## CreateProcess function

With current design, `CreateProcess` won't remove any duplicated variables from the buffer that we pass as its `lpEnvironment` parameter. It will just set that buffer as the environment block for the new process.

For more information about the `lpEnvironment` parameter, see [CreateProcess function](/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessa).

## Environment variables

When the child process has been created and wants to access those [environment variables](/windows/win32/procthread/environment-variables), it may use `GetEnvironmentStrings` or `GetEnvironmentVariable` APIs.

- `GetEnvironmentStrings` will just return a pointer to the environment block buffer of the process, which would be the same as the buffer that we passed to `CreateProcess`.

- `GetEnvironmentVariable` will look for the variable that we want within the buffer that we passed to `CreateProcess` with a simple algorithm: it will go over the buffer from left to right, and when it finds the variable name we want, it will return its value. `GetEnvironmentVariable` won't care if there are other variables with the same name after that one in the buffer.

Summing up, with current design, it is the responsibility of the application that calls `CreateProcess` to eliminate duplicated variables from the environment block buffer.
