---
title: Closing non-blocking socket causes leak
description: Closing a non-blocking socket with linger enabled and the linger timeout set to 0 may cause a leak. This problem occurs if the other end of the connection is unresponsive.
ms.date: 03/09/2020
ms.custom: sap:Networking development
ms.reviewer: atuck
ms.technology: windows-dev-apps-networking-dev
---
# Closing a non-blocking socket with linger enabled may cause leak

This article helps you resolve the leak problem when closing a non-blocking socket with linger enabled and the linger timeout set to 0.

_Original product version:_ &nbsp; Winsock  
_Original KB number:_ &nbsp; 2770054

## Symptoms

Memory usage and thread handle count increases at the same rate that your program closes sockets. It appears to be a memory and thread handle leak.

## Cause

Sockets may be shut down in either a graceful or abortive manner. If a socket hasn't been shut down, and the `closesocket` function is called on that socket, the `closesocket` function will shut down the socket before closing it. The `closesocket` function will attempt a graceful shutdown if the linger option is enabled on the socket.

When the `closesocket` function attempts to gracefully shut down a non-blocking socket, it will attempt to create a worker thread to perform the shutdown. The worker thread will attempt to notify the other end of the communication channel that the socket is shutting down. If the other end of the channel is unresponsive, the worker thread will wait for the linger timeout to expire; then do an abortive shutdown.

If the linger timeout in the above scenario equals 0, then the worker thread will wait an infinite amount of time for the other end of the channel to respond. This thread is unable to perform any useful work, and won't exit. It has been leaked. The memory associated with the thread and the socket it's trying to shut down has also been leaked.

## Resolution

Best practice is to explicitly shut down the socket using the `shutdown` or `WSASendDisconnect` functions, then call the `closesocket` function.

Alternatively, you may set the linger timeout value to a value other than 0 - for example 1 second. The worker thread will only wait for the specified linger timeout value before shutting down the socket and exiting.

## More information

The `closesocket` function and the worker thread function are implemented in the `afd.dll`.

For more background information about linger, see [Graceful Shutdown, Linger Options, and Socket Closure](/windows/win32/winsock/graceful-shutdown-linger-options-and-socket-closure-2).
