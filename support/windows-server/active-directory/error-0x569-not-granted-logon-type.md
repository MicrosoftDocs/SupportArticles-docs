---
title: The User Has Not Been Granted The Requested Logon Type at This Computer
description: Helps resolve the error code 0x569 that occurs during a domain join operation. It provides a detailed analysis of the NetSetup.log and offers a step-by-step resolution to ensure the user account has the necessary rights.
ms.date: 03/19/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, v-lianna
ms.custom:
- 'sap:active directory\on-premises active directory domain join'
- pcy:WinComm Directory Services
---
# Error code 0x569: the user has not been granted the requested logon type at this computer

This article helps resolve the error code 0x569 that occurs during a domain join operation. It provides a detailed analysis of the **NetSetup.log** and offers a step-by-step resolution to ensure the user account has the necessary rights.

You receive the following error message during a domain join operation:

> Logon failure: the user has not been granted the requested logon type at this computer.

When you check the **NetSetup.log** file, you see the following entries:

```output
mm/dd hh:mm:ss NetpDsGetDcName: failed to find a DC having account '<computer name>$': 0x525
mm/dd hh:mm:ss NetpDsGetDcName: found DC '\\<dc name>' in the specified domain
mm/dd hh:mm:ss NetUseAdd to \\<dc name>\IPC$ returned 1385
mm/dd hh:mm:ss NetpJoinDomain: status of connecting to dc '\\<dc name>': 0x569
mm/dd hh:mm:ss NetpDoDomainJoin: status: 0x569
```

Here's more information about the error code:

|HEX error  |Decimal error  |Symbolic error string  |
|---------|---------|---------|
|0x569     |1385         |ERROR_LOGON_TYPE_NOT_GRANTED         |

This error occurs because the domain join user account lacks the **Access this computer from the network** user right.

To resolve this error, follow these steps:

1. Verify that the user account performing the domain join operation (or a security group that owns the domain join user account as a member) has been granted the **Access this computer from the network** right in the default domain controllers policy.
2. Ensure that the default domain controllers policy is linked to the organizational unit (OU) that hosts the domain controller (DC) computer account that is servicing the domain join operation.
3. Confirm that the DC servicing the domain join operation applies the policy successfully, specifically user rights settings defined in the default domain controllers policy.
