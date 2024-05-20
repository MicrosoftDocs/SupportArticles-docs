---
title: TCP three-way handshake failure during SMB connection
description: Introduces the TCP three-way handshake failure during SMB connection.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# TCP three-way handshake failure during SMB connection

This article describes how to troubleshoot Transmission Control Protocol (TCP) three-way handshake failure during SMB connection.

When you analyze a network trace, you notice that there's a TCP three-way handshake failure that causes the SMB issue to occur.

Generally, the cause is a local or infrastructure firewall that blocks the traffic. This issue can occur in either of the following scenarios.

## The TCP SYN packet arrives on the SMB server, but the SMB server doesn't return a TCP SYN-ACK packet

To troubleshoot this scenario, follow these steps：

1. Run `netstat` or `Get-NetTcpConnection` to make sure that there's a listener on TCP port 445 that should be owned by the SYSTEM process.

    ```console
    netstat -ano | findstr :445
    ```

    ```PowerShell
    Get-NetTcpConnection -LocalPort 445
    ```

2. Make sure that the Server service is started and running.

3. Take a Windows Filtering Platform (WFP) capture to determine which rule or program is dropping the traffic. To do this, run the following command in a Command Prompt window:

    ```console
    netsh wfp capture start
    ```

    Reproduce the issue, and then, run the following command:

    ```console
    netsh wfp capture stop
    ```

    Run a scenario trace, and look for WFP drops in SMB traffic (on TCP port 445).

    Optionally, you could remove the anti-virus programs because they aren't always WFP-based.

4. If Windows Firewall is enabled, enable firewall logging to determine whether it records a drop in traffic.

    Make sure that the appropriate "File and Printer Sharing (SMB-In)" rules are enabled in **Windows Firewall with Advanced Security** > **Inbound Rules**.

    > [!NOTE]
    > Depending on how your computer is set up, "Windows Firewall" might be called "Windows Defender Firewall."

## The TCP SYN packet never arrives at the SMB server

In this scenario, you have to investigate the devices along the network path. You may analyze network traces that are captured on each device to determine which device is blocking the traffic.
