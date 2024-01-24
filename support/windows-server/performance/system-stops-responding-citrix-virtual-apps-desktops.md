---
title: System stops responding when using Citrix Virtual Apps and Desktops
description: Helps resolve an issue in which the system stops responding when using Citrix Virtual Apps and Desktops to access a terminal server.
ms.date: 11/23/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, jasone, v-lianna
ms.custom: sap:system-hang, csstroubleshoot, ikb2lmc
ms.subservice: performance
---
# System stops responding when using Citrix Virtual Apps and Desktops

This article helps resolve an issue in which the system stops responding when using Citrix Virtual Apps and Desktops to access a terminal server.

When you use Citrix Virtual Apps and Desktops to access a terminal server, the system may stop responding when you try to sign in, sign out, or shut down the server. This issue is triggered by a deadlock in Local Session Manager (LSM) and Remote Desktop Services (*termsvcs.exe*).

This issue occurs because Citrix Virtual Apps and Desktops use a Windows Terminal Server (WTS) API when handling a remote desktop request. If a terminal server or remote desktop server component is handling an incoming remote desktop request, it can't make direct or indirect blocking calls to remote desktop services (such as IWTS* or IWRDs APIs). 

If you encounter this issue, make sure you have the Citrix components fully patched. If you still encounter this issue, follow up with [Citrix](https://www.citrix.com/support/) for additional support.

> [!NOTE]
> To avoid a possible deadlock when calling any methods on this interface, don't make any function or method calls that will directly or indirectly result in a Remote Desktop Services API being called. If you need to make an outbound call, start a new thread and make the outbound call from the new thread.

For more information, see the following articles:

- [WTSQuerySessionInformationW function (wtsapi32.h)](/windows/win32/api/wtsapi32/nf-wtsapi32-wtsquerysessioninformationw)
- [IWRdsProtocolConnection interface (wtsprotocol.h)](/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolconnection)
- [IWTSProtocolConnection interface (wtsprotocol.h)](/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolconnection)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
