---
title: Call shell functions from multithreaded apartment
description: This article introduces why calling shell functions from a thread that has been initialized as a multithreaded apartment may cause the functions fail.
ms.date: 12/19/2023
ms.custom: sap:Desktop app UI development\Windows Shell API
ms.reviewer: DAVEAN
ms.subservice: desktop-app-ui-dev
---

# Calling shell functions and interfaces from a multithreaded apartment

When you call or access a shell function or shell interface from a thread that has been initialized as a multithreaded apartment, the function or interface may have its functionality impaired or completely fail.

_Original version:_ &nbsp; Windows shell and Interface  
_Original KB number:_ &nbsp; 287087

## Cause

A call to `CoInitializeEx (COINIT_MULTITHREADED)` allows calls to objects created on the calling thread to be run on any thread. When accessing objects that use the apartment threading model from a multithreaded apartment, COM will synchronize access to the object. In order for this synchronization to occur, COM must marshal calls to the object. Because the shell currently doesn't provide the necessary information, either through a type library or proxy/stub code, for its objects to be marshaled, attempts to access shell objects from a multithreaded apartment fail.

## Calls that can affect shell functions

The following are examples of how calls to `CoInitializeEx (COINIT_MULTITHREADED)` can affect functions that rely on shell objects:

- GetOpenFileName/GetSaveFileName

    Users can navigate to namespace extension folders such as **My Documents** through the **Open and Save As** dialog box. However, these folders can't be browsed to because the browser can't create the required interfaces, such as `IShellFolder`.

- ShellExecute/ShellExecuteEx

    `ShellExecute` hooks can be written to extend the functionality of `ShellExecute` or `ShellExecuteEx` by implementing the `IShellExecuteHook` interface. When `ShellExecute` or `ShellExecuteEx` is called, registered `ShellExecute` hooks can't be loaded.

In both of these examples, the component that is attempting to obtain an interface pointer to a shell object with `CoCreateInstance`, `IUnknown::QueryInterface`, and so forth, will typically fail with error `E_NOINTERFACE` when called from multithreaded apartments. The reason, as noted above, is that there's no type information or proxy/stub code for the objects being requested.

## References

[Process, Threads, and Apartments](/windows/win32/com/processes--threads--and-apartments)
