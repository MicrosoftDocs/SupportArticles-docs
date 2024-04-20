---
title: App-V applications can't be streamed from a DP
description: Describes a problem in which an App-V application cannot be streamed to a client that has the Bypass proxy server for local addresses option set.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, alvinm
ms.custom: sap:Content Management\Content Library
---
# App-V applications cannot be streamed from a distribution point if Bypass proxy server for local addresses is set

This article provides a solution for the issue that a Microsoft Application Virtualization (App-V) application cannot be streamed from a distribution point in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft Application Virtualization for Windows Desktops, Microsoft Application Virtualization for Remote Desktop Services  
_Original KB number:_ &nbsp; 2683908

## Symptoms

Consider this scenario:

- You have a domain that is named *contoso.com*.
- You have a Background Intelligent Transfer Service (BITS)-enabled Microsoft System Center 2012 Configuration Manager distribution point that is named *myserver.contoso.com*.
- The client computer has the **Bypass proxy server for local addresses** option set.
- You create a Microsoft App-V application and then configure the application to use streaming as the distribution option.
- You deploy the application, shortcuts are created, and the application is started.

In this scenario, the application cannot be streamed from the distribution point.

## Cause

This problem occurs because Windows doesn't consider computer names that contain a period (.) to be local. This behavior is by design. Because of this behavior, the client tries to access the distribution point through the proxy server.

For more information, see [Intranet site is identified as an Internet site when you use an FQDN or an IP address](https://support.microsoft.com/help/303650).

## Resolution

To resolve this problem, add the Fully Qualified Domain Name (FQDN) of the distribution point to the **Do not use proxy server for addresses beginning with** list on the client or to the Local Address Table (LAT) on the proxy server. In the sample scenario in the Symptoms section, you would add *myserver.contoso.com*.
