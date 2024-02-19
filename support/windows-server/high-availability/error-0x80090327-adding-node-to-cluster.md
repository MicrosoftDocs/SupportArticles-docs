---
title: Error 0x80090327 when adding a node to a cluster
description: Provides a solution to fix error 0x80090327 that occurs when you add a node to a cluster.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, vlvasque, shasankp, ansol, v-lianna
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot, ikb2lmc
---
# Error 0x80090327 when adding a node to a cluster

This article provides a solution to fix error 0x80090327 that occurs when you add a node to a cluster.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 5015645

You fail to add a node to a cluster. When checking the cluster logs, you find that a sponsor node rejects the connection with error 0x80090327.

Example cluster log for the joining node:

```output
113533 [Verbose] 00001ef8.000010d4::<Date Time> WARN  cxl::ConnectWorker::operator (): HrError(0x000004ca)' because of '[SV] Schannel Authentication or Authorization Failed'
```

Example cluster logs for the sponsor node:

```output
22064 [Verbose] 000016ec.00000e7c::<Date Time> ERR   mscs_security::SchannelSecurityContext::AuthenticateAndAuthorize: HrError(0x80090327)' because of '[Schannel] Server: missing context attributes, requested: 34836, received: 2076'
22065 [Verbose] 000016ec.00000e7c::<Date Time> WARN  mscs::ListenerWorker::operator (): HrError(0x80090327)' because of '[SV] Schannel Authentication or Authorization Failed'
```

## Remove Transport Layer Security (TLS) 1.3 registry keys

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

This issue occurs because TLS 1.3 is enabled on the sponsor node. To resolve this issue, remove the following registry keys:

|Name  |Data  |Path  |
|---------|---------|---------|
|`DisabledByDefault`     |00000000        |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client`         |
|`Enabled`     |00000001        |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client`         |
|`DisabledByDefault`     |00000000        |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server`         |
|`Enabled`     |00000001        |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server`         |

> [!NOTE]
> These keys are only supported in Windows Server 2022. For more information, see [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-).
