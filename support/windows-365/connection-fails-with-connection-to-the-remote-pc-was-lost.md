---
title: Connection fails with "connection to the remote PC was lost."
description: Introduces how to resolve the connection failure with "Failed to open a Microsoft Entra ID credential prompt."
audience: itpro
manager: dcscontentpm
ms.date: 04/02/2025
ms.reviewer: wincicuex, erikje
ms.topic: troubleshooting
---
# Connection fails with "connection to the remote PC was lost."

After a user authenticates on the sign in page, when the user tries to connect to the Cloud PC, the user might encounter the following message:

> Lost connection  
> The connection to the remote PC was lost. This might be because of a network connection problem. If this keeps happening, ask your admin or tech support for help.

## Cause

This error commonly occurs because of network filtering.

Connecting to a Cloud PC from a Windows 365 Link has the same Network requirements as other clients. The network connection being used might be blocking, or filtering endpoints that are required to use the service.

## Resolution

To resolve this issue, fix the networking problem. For more information, see [End user devices](https://learn.microsoft.com/en-us/azure/virtual-desktop/required-fqdn-endpoint?tabs=azure#end-user-devices).
