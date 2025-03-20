---
title: The User Has Not Been Granted the Requested Logon Type at This Computer
description: Helps resolve the error code 0x569 that occurs during a domain join operation. It provides a detailed analysis of the NetSetup.log and offers a step-by-step resolution to ensure the user account has the necessary rights.
ms.date: 03/19/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
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

1. There is little reason to restrict **Everyone** from accessing domain controllers (DCs) over the network. You can add a group named "domain joiners" to the policy.
    > [!NOTE]
    > Don't add the user directly.
2. Verify that **Everyone** or the group "domain joiners" has been granted the **Access this computer from the network** right in the group policy applying to all DCs. By default, this policy is **Default Domain Controllers Policy**.
3. Ensure that the relevant policy is linked to the organizational unit (OU) that hosts the DCs.
    > [!NOTE]
    > Place all DC computer accounts in the **Domain Controllers** OU.
4. Confirm that the DCs servicing the domain join operation apply the relevant policy successfully.
