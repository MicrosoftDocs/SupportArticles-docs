---
title: Can't start a transaction in MS DTC
description: This article describes a problem that may occur intermittently when you try to start a transaction in the MS DTC. A resolution is provided.
ms.date: 06/11/2025
ms.custom: sap:Distributed Transactions\DTC programming and runtime
---

# New transaction can't enlist in the specified transaction coordinator when you try to start a transaction in MS DTC

This article helps you resolve a problem when you start a transaction in Microsoft Distributed Transaction Coordinator (MS DTC).

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 922430

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Symptoms

Consider the following scenario:

- You have a client computer that communicates with a server computer.
- MS DTC is installed on both computers.
- One or more of the following conditions are true:
  - You restart either of the computers.
  - You restart MS DTC on either of the computers.
  - The computers are in different domains.

In this scenario, you receive the following error message when you try to start a transaction in MS DTC:

> New transaction cannot enlist in the specified transaction coordinator (0x8004d00a)

Additionally, the first transaction fails. The subsequent transactions succeed for a while. However, the subsequent transactions may fail again. If the subsequent transactions fail, you receive the following error message:

> New transaction cannot enlist in the specified transaction coordinator (0x8004d00e)

## Cause

This problem may occur when the MS DTC connection between the client computer and the server computer is closed. For example, an idle time-out, a remote procedure call (RPC) time-out, or the firewall may close the MS DTC connection between the client computer and the server computer. When a new transaction request occurs, the client computer must reestablish the MS DTC connection with the server computer.

When the client computer tries to reestablish the MS DTC connection with the server computer, the client computer sends a packet. Then, the client computer waits for a bind packet response from the server computer. By default, the client computer stops the transaction if the client computer doesn't receive a response from the server computer in 4 seconds. The response from the server computer may be delayed because of network latency issues or authentication delays. When the response from the server computer does finally reach the client computer, the subsequent transactions succeed.

The first transaction may take a long time, and then a later request to do a distributed transaction may finish immediately. This problem may occur when the client-side of MS DTC has a problem communicating with the Kerberos (KDC) server. Typically, this problem occurs if the client and the server are in different domains that have a firewall between them.

For example, this problem occurs in the following scenario:

- Web Service is in the Perimeter Network in a domain. Web Service has to use transactions with a database server in another domain in an intranet.
- A firewall is between the Perimeter Network and the intranet. The excessive delay on the first transaction occurs because User Datagram Protocol (UDP) port 88 (Kerberos) is blocked.
- The retry and the retry interval for the Kerberos request equal an excessive delay (over 100 seconds).

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To make sure that you're experiencing the problem that is described in this article, confirm that the MS DTC transaction trace log file contains the following data:

> ;eventid=TRANSACTION_PROPOGATION_FAILED_CONNECTION_DOWN_FROM_REMOTE_TM ;tx_guid=f11cd9c9-7b8a-41e3-a904-4840123bacf7 ;"failed to propogate transaction to child node ' ComputerName ' because the connection with the remote transaction manager went down"

> [!NOTE]
> In this data, the word *propogation* is a misspelling for the word *propagation*. The word *propogate* is a misspelling for the word *propagate*.

If the MS DTC transaction trace log file contains this data, follow these steps:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
2. Locate the following registry subkey:  
   `HKEY_LOCAL_MACHINE\Software\Microsoft\MSDTC`
3. Right-click **MSDTC**, point to **New**, and then select **DWORD Value**.
4. Type *CmMaxNumberBindRetries*, and then press ENTER.
5. Right-click **CmMaxNumberBindRetries**, and then select **Modify**.
6. Select **Decimal**.
7. In the **Value data** box, type *60*.

    This value increases the length of time that the client computer waits for the bind packet response from the server computer. This value is double the number of seconds before the client computer stops the transaction if the client computer doesn't receive the bind packet response. For example, a value of 60 equals 30 seconds. The value of 60 is only a recommended value. Additional testing on your configuration may be required.
8. Select **OK**.
9. Restart MS DTC.

> [!NOTE]
> For the slow response scenario, make sure that the ports that are required by Kerberos authentication (UDP 88 and Transmission Control Protocol (TCP) 88) are open when a firewall is involved in the Perimeter Network. The ports UDP 389 and TCP 389 (both for Lightweight Directory Access Protocol (LDAP) to find Key Distribution Center (KDC)) must also be open.
