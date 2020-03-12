---
title: Call Shell functions from Multithreaded apartment
description: Introduces why calling shell functions from a thread that has been initialized as a multithreaded apartment may cause the functions fail.
ms.date: 03/10/2020
ms.prod-support-area-path:
ms.reviewer: DAVEAN
---
# Calling Shell Functions and Interfaces from a Multithreaded Apartment

When you call or access a shell function or shell interface from a thread that has been initialized as a multithreaded apartment, the function or interface may have its functionality impaired or completely fail.

_Original version:_ &nbsp; Windows shell and Interface  
_Original KB number:_ &nbsp; 287087

## cause

A call to **CoInitializeEx** (COINIT_MULTITHREADED) allows calls to objects created on the calling thread to be run on any thread. When accessing objects that use the apartment threading model from a multithreaded apartment, COM will synchronize access to the object. In order for this synchronization to occur, COM must marshal calls to the object. Because the shell currently doesn't provide the necessary information, either through a type library or proxy/stub code, for its objects to be marshaled, attempts to access shell objects from a multithreaded apartment fail.

## Calls that can affect shell functions

The following are examples of how calls to **CoInitializeEx** (COINIT_MULTITHREADED) can affect functions that rely on shell objects:

- GetOpenFileName/GetSaveFileName

    Users can navigate to namespace extension folders such as **My Documents** through the Open and Save As dialog boxes. However, these folders can't be browsed to because the browser can't create the required interfaces, such as IShellFolder.

- ShellExecute/ShellExecuteEx

    ShellExecute hooks can be written to extend the functionality of ShellExecute/ShellExecuteEx by implementing the IShellExecuteHook interface. When ShellExecute/ShellExecuteEx is called, registered ShellExecute hooks can't be loaded.

In both of these examples, the component that is attempting to obtain an interface pointer to a shell object with **CoCreateInstance**, IUnknown::QueryInterface, and so forth, will typically fail with error E_NOINTERFACE when called from multithreaded apartments. The reason, as noted above, is that there's no type information or proxy/stub code for the objects being requested.

## References

[Process, Threads, and Apartments](https://msdn.microsoft.com/library/ms693344%28vs.85%29.aspx)
