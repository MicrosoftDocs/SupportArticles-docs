---
title: How to Set Up Hyper-V Replica Between Windows Server 2016 and Windows Server 2022
description: Provides guidance to set up Hyper-V Replica if the source VM is on Windows Server 2016 and the destination VM is on Windows Server 2022.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\hyper-v replica (hvr)
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# How to set up Hyper-V Replica between Windows Server 2016 and 2022

This article provides guidance for setting up a Hyper-V replica if the source virtual machine (VM) resides on Windows Server 2016 and the destination VM resides on Windows Server 2022.

> [!IMPORTANT]  
> Before you deploy this configuration in a production environment, test it in a controlled environment.

> [!NOTE]  
> For general information about setting up Hyper-V Replica, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).

## Prerequisites

Before you use the procedures in this article, make sure that your host computers and VMs meet the following requirements:

- You have administrator-level access to both host computers.
- The Hyper-V role is configured on both the source (Windows Server 2016) and destination (Windows Server 2022) host computers.
- The source and destination host computers are on the same network or on connected networks.
- The appropriate firewall rules exist to allow Hyper-V replication traffic. For information about the ports that are involved in Hyper-V replication, see "Hyper-V service" in [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md#hyper-v-service).
- Both host computers have sufficient storage and compute resources for the VM replicas.
- The source VM (on Windows Server 2016) and the destination VM (on Windows Server 2022) are of the same generation (both are Generation 1, or both are Generation 2).

## Configure replication

To configure Hyper-V Replica, follow these steps:

1. Configure  Hyper-V Replica on the source host computer by following these steps:

   1. On the Windows Server 2016 host computer, open **Hyper-V Manager**.
   1. Right-click the VM that you want to replicate, and then select **Enable Replication**.
   1. Follow the prompts to configure the replication settings. Provide the destination host computer's name or IP address.

1. Configure Hyper-V Replica on the destination host computer by following these steps:

   1. On the Windows Server 2022 host computer, enable the Hyper-V Replica feature.
   1. Open **Hyper-V Settings**, and then configure the **Replica Server** settings. Make sure that the Windows Server 2022 host computer is authorized to receive replication traffic from the Windows Server 2016 host computer.

Before you deploy this configuration in a production environment, test the following functionality:

1. Start replication from the source host computer to the destination host computer, and then monitor the replication status in Hyper-V Manager to make sure that the process finishes successfully.
1. Trigger a planned failover, and verify that the destination host computer can host the VM if the source host computer fails.
1. Start the failback process, and verify that when the source host computer becomes operational, the VM returns to it.

## Troubleshooting replication issues

Incorrect settings on either the source or destination server can prevent replication. If your system doesn't replicate, check the following settings:

- The Hyper-V Replica settings (including the authentication settings) on both the host and destination computers.
- The port rules in all firewalls between the source VM and the destination VM.
- The VM generation of the source and destination VMs (both Generation 1 or both Generation 2).

Additionally, verify that the source and destination host computers connect successfully.

## References

For a detailed discussion about Hyper-V Replica settings, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).
