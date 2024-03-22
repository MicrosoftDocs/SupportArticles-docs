---
title: Remote procedure call failed and did not execute error
description: Troubleshoot error 1727 that occurs during DC replication on Windows Server. Identify the cause and get to the solution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshoot domain controller replication error 1727-The remote procedure call failed and did not execute

This article solves the error message **"The remote procedure call failed and did not execute"**. This error occurs during domain controller (DC) replication on Windows Server.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows Server 2019, Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 4019721

## Symptoms

This Active Directory (AD) replication error appears in one or more of the following forms:

- Decimal: 1727
- Hex: 0x6bf
- Symbolic: RPC_S_CALL_FAILED_DNE
- Error message: The remote procedure call failed and did not execute.

## Cause

This problem occurs because of one of the following reasons:

- A network connectivity issue between the two domain controllers (DCs). See the following sections for details.
- A load-induced performance issue on the replication partner. This issue is less common and is often transient in nature. See the following sections for details.

### About the network connectivity issue

This problem occurs when the DC's replication partner can't complete the RPC connection to AD Replication's RPC Service (DRSR UUID E3514235-4B06-11D1-AB04-00C04FC2DCD2). More specifically, the replication partner can bind to the RPC endpoint mapper, but can't complete the DRSR RPC bind.

Possible root causes include:

- firewalls
- routers
- WAN optimizers
- other intermediate network devices
- network filter drivers

### About the performance issue

This problem occurs when one of the following conditions is true:

- The server is backlogged and doesn't respond to the TCP ACK or the response message. So, the sender abandons the TCP session.
- The network is too slow or unreliable. It can't deliver the TCP ACK or the response message.

## Resolution

To resolve this problem, determine any recent changes that would affect the network between the two DCs and undo those changes if possible. If there are no recent changes, you must fully examine the RPC network connectivity between the two DCs. To do so, follow either the high-level troubleshooting steps or the detailed troubleshooting steps.

## High-level troubleshooting steps

1. Take a double-sided network capture while you reproduce the problem. To do so, follow these steps:

   1. Start a network capture on both DCs.
   2. Manually start replication between the two DCs.
   3. Stop both sides of the trace when you receive the error.

2. Examine the RPC conversation between the two DCs. Determine whether there's ever a case in which the message that's sent from the requestor DC doesn't incur a response from the replication partner.

> [!NOTE]
> Occasionally, there is a partial response that includes the piggy-back TCP ACK for the request message. But the traffic has been modified or the response doesn't actually arrive at the requester DC. Therefore, the TCP stack doesn't receive an ACK.

## Detailed troubleshooting steps

Start a network capture on both DCs before you take the following steps to test DC connectivity.

### Test the source DC connectivity from the destination DC

Follow these steps on the destination DC:

1. Verify whether the source DC is listening on TCP port 135. To do so, run the `PortQry.exe -n -e 135` command.

    If the port status is FILTERED, the AD replication failure is likely to fail and return error 1722 instead. Try resolving error 1722, and then check whether the AD replication succeeds. If the problem persists, restart the detailed troubleshooting steps.

    If the status isn't FILTERED, the commands return the RPC endpoint mapper database. Search for **MS NT Directory DRS Interface** to find the upper-range port in the endpoint mapper database that the source DC is listening on for AD replication. You may get one or more entries. Make a note of the ports for ncacn_ip_tcp.

    For example, you get something that resembles the following example, which presents two upper-range ports 49159 and 49160:

    UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
    ncacn_ip_tcp:2012dc[49159]
    UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
    ncacn_ip_tcp:2012dc[49160]  

    > [!NOTE]
    > The upper-range ports are DC specific and are dynamically assigned. However, an administrator can hard-code the port that is used for AD replication by using the following registry value.
    >
    >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters  
    Registry value: TCP/IP Port  
    Value type: REG_DWORD  
    Value data: (available port)

2. Test TCP port connectivity to the upper-range ports that you note. To do so, run the following command:

    ```console
    PortQry.exe -n <SourceDC> -e <Upper_Range_Port_Number>
    ```

    For example, you run the following commands:

    ```console
    PortQry.exe -n 2012dc -e 49159
    PortQry.exe -n 2012dc -e 49160
    ```

    If port status is FILTERED, review the network trace that you've captured to determine where the packet is blocked.

3. Test DNS. Verify that the destination DC can resolve the CNAME and HOST records of the source DC. And verify that the resolved IP address is the actual IP address of the source DC. If DNS points to an old or invalid IP address, then RPC connection attempt is made to an incorrect source DC.

### Test the destination DC connectivity from the source DC

Repeat step 1 through 3 on the source DC.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
