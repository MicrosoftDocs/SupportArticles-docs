---
title: Failed to redirect connected UDP traffic
description: This article provides workarounds for the redirection failure problem that occurs when the connected UDP traffic is redirected to a local proxy using a WFP callout driver.
ms.date: 04/20/2021
author: aartig13
ms.author: aartigoyle
ms.reviewer: jesweare, dev_triage
ms.custom: sap:Other Driver
---
# Failed to redirect connected UDP traffic to a local proxy service

_Applies to:_ &nbsp; Windows Driver Kit 10

## Symptoms

Consider the following scenario:

- A local process sends User Datagram Protocol (UDP) packets by using the Windows Sockets ([Winsock](/windows/win32/winsock/getting-started-with-winsock)) API.
- An application Layer Enforcement (ALE) callout driver was developed using Windows Filtering Platform (WFP), which redirects traffic from the local process.
- A local proxy service receives the UDP packets that are redirected by the callout driver.

In this scenario, if the local process uses the [connect](/windows/win32/api/winsock2/nf-winsock2-connect) and [send](/windows/win32/api/winsock2/nf-winsock2-send) functions to send UDP packets through a connected UDP protocol, the packets are dropped and the redirection to the local proxy service fails.

## Cause

The issue occurs because the WFP redirect records are referenced incorrectly.

## Workaround

To redirect traffic successfully to the local proxy service, use the [sendto](/windows/win32/api/winsock/nf-winsock-sendto) function to send UDP packets through a connectionless UDP protocol.

## More information

To learn how to enable application layer enforcement (ALE) callout drivers to inspect and redirect connections, see [Using Bind or Connect Redirection](/windows-hardware/drivers/network/using-bind-or-connect-redirection).
