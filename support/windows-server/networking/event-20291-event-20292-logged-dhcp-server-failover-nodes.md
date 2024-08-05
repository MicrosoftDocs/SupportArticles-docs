---
title: Event IDs 20291 and 20292 are logged on DHCP server failover nodes
description: Describes the issue in which Event ID 20291 and Event ID 20292 are logged many times on DHCP server failover nodes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rnitsch, markusr, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
---
# Event ID 20291 and Event ID 20292 are logged on DHCP server failover nodes

This article describes the issue in which Event ID 20291 and Event ID 20292 are logged many times on DHCP server failover nodes.

These events are located in the path of **Applications and Services Logs** > **Microsoft** > **Windows** > **DHCP-Server** > **Microsoft-Windows-DHCP Server Events/Admin** in the Event Viewer and are displayed as follows:

- DHCP2

    ```output
    Source: Microsoft-Windows-DHCP-Server 
    Event ID: 20291
    Task Category: DHCP Failover
    Description: A BINDING-ACK message with transaction id: 84584 was sent for IP address: 10.10.10.10 with reject reason: (Outdated binding information) to partner server: DHCP01 for failover relationship: DHCP1-DHCP2-Failover.
    ```

- DHCP1

    ```output
    Source: Microsoft-Windows-DHCP-Server 
    Event ID: 20292
    Task Category: DHCP Failover
    Description: A BINDING-ACK message with transaction id: 84585 was received for IP address: 10.10.10.10 with reject reason: (Outdated binding information) from partner server: DHCP2 for failover relationship: DHCP1-DHCP2-Failover. 
    ```

## Many duplicate requests within a second

A possible reason is that multiple relay agents are configured to forward the DHCP client broadcast requests to the DHCP failover nodes from the DHCP client subnet.

The relay agents forward the same DHCP broadcast packet with a slightly different time and different relay agent IP address information. This action causes the reject reason code of "Outdated binding information" in the event logs.

The DHCP server will consider the request as a duplicate request. DHCP failover has a time granularity of seconds. Hence, many duplicate requests within a second cause this issue.

## The events won't cause an actual error

You can ignore these events with a reject reason code of "Outdated binding information." These events don't indicate an actual error and won't affect the address lease and the update of the partner server.

Configuring a delay on one of the relay agents might also help.
