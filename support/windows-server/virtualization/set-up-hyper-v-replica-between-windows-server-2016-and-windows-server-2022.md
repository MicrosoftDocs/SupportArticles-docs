---
title: How to Set Up Hyper-V Replica between Windows Server 2016 and Windows Server 2022
description: Provides guidance for setting up Hyper-V Replica when the source virtual machine(VM) resides on Windows Server 2016 and the destination VM resides on Windows Server 2022.
ms.date: 08/28/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\hyper-v replica (hvr)
- pcy:WinComm Storage High Avail
---

# How to set up Hyper-V Replica between Windows Server 2016 and Windows Server 2022

This article provides guidance for setting up a Hyper-V replica when the source virtual machine (VM) resides on Windows Server 2016 and the destination VM resides on Windows Server 2022.

> [!IMPORTANT]  
> Before you deploy this configuration in a production environment, test it in a controlled environment.

> [!NOTE]  
> For general information about setting up Hyper-V Replica, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).

## Prerequisites

Before you use the procedures in this article, make sure that your host computers and VMs meet the following requirements:

- Make sure that you have Administrator-level access to both host computers.
- Make sure that the Hyper-V role is configured on both the source (Windows Server 2016) and destination (Windows Server 2022) host computers.
- Make sure that the source and destination host computers are on the same network or on connected networks.
- Make sure that the appropriate firewall rules are in place to allow Hyper-V replication traffic. For information about the ports that are involved in Hyper-V replication, see "Hyper-V service" in [Service overview and network port requirements for Windows]../networking/service-overview-and-network-port-requirements#hyper-v-service).
- Make sure that both host computers have sufficient storage and compute resources for the VM replicas.
- Make sure that the source VM (on Windows Server 2016) and the destination VM (on Windows Server 2022) are of the same generation (both are Generation 1, or both are Generation 2).

## Configure replication

To configure the Hyper-V replica, follow these steps:

1. Configure the Hyper-V Replica on the source host computer by following these steps:

   1. On the Windows Server 2016 host computer, open **Hyper-V Manager**.
   1. Right-click the VM that you want to replicate, and then select **Enable Replication**.
   1. Follow the prompts to configure the replication settings. Provide the destination host computer's name or IP address.

1. Configure Hyper-V Replica on the destination host computer by following these steps:

1. On the Windows Server 2022 host computer, enable the Hyper-V Replica feature.
1. Open **Hyper-V Settings**, and then configure the **Replica Server** settings. Make sure that the Windows Server 2022 host computer is authorized to receive replication traffic from the Windows Server 2016 host computer.

Before you deploy this configuration into a production environment, test the following functionality:

1. Start replication from the source host computer to the destination host computer, and then monitor the replication status in Hyper-V Manager to make sure that the process completes successfully.
1. Trigger a planned failover, and then verify that the destination host computer can host the VM if the source host computer fails.
1. Start the failback process, and then verify that when the source host computer becomes operational, the VM returns.

## Troubleshooting replication issues

Incorrect settings on either the source or destination server can prevent replication. If your system doesn't replicate, check the following settings:

- The Hyper-V Replica settings (including the authentication settings) on both the host and destination computers.
- The port rules in all firewalls between the source VM and the destination VM.
- The VM generation of the source and destination VMs (both Generation 1 or both Generation 2).

Additionally, verify that the source and destination host computers connect successfully.

For a detailed discussion of Hyper-V Replica settings, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).
