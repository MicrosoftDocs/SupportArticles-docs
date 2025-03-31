---
title: User Has Not Been Granted the Requested Logon Type at This Computer
description: Helps resolve the error code 0x569 that occurs during a domain join operation.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Error code 0x569: The user has not been granted the requested logon type at this computer

This article helps resolve the error code 0x569 that occurs during a domain join operation. It provides a detailed analysis of the **NetSetup.log** and a step-by-step resolution to ensure the user account has the necessary rights.

You receive the following error message during a domain join operation:

> Logon failure: the user has not been granted the requested logon type at this computer.

When you check the **NetSetup.log** file, you see the following entries:

```output
NetpDsGetDcName: failed to find a DC having account '<computer name>$': 0x525
NetpDsGetDcName: found DC '\\<dc name>' in the specified domain
NetUseAdd to \\<dc name>\IPC$ returned 1385
NetpJoinDomain: status of connecting to dc '\\<dc name>': 0x569
NetpDoDomainJoin: status: 0x569
```

Here's more information about the error code:

|Hexadecimal error  |Decimal error  |Symbolic error string  |
|---------|---------|---------|
|0x569     |1385         |ERROR_LOGON_TYPE_NOT_GRANTED         |

This error occurs because the domain join user account lacks the **Access this computer from the network** user right at the domain controller (DC) servicing the domain join operation.

To resolve this error, follow these steps:

1. There's no need to restrict **Everyone** from accessing DCs over the network. You can add a group named "domain joiners" to the policy.
    > [!NOTE]
    > Don't add the user directly.
2. Verify that **Everyone** or the "domain joiners" group has been granted the **Access this computer from the network** right in the group policy applying to all DCs. By default, this policy is the **Default Domain Controllers Policy**.
3. Ensure that the relevant policy is linked to the organizational unit (OU) that hosts the DCs.
    > [!NOTE]
    > Place all DC computer accounts in the **Domain Controllers** OU.
4. Confirm that the DCs servicing the domain join operation have applied the relevant policy successfully.
