---
title: Exchange Server 2010 datacenter switchover
description: Describes how to perform a datacenter switchover for a database availability group (DAG) in Exchange Server 2010.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# Exchange Server 2010 datacenter switchover

_Original KB number:_ &nbsp; 10086

**Who is it for?**

Exchange 2010 administrators who help perform datacenter switchover for DAG in Exchange 2010.

**How does it work?**

We'll take you through a series of steps that are specific to your situation.

**Estimated time of completion:**

30-60 minutes.

## Welcome to the guide

### Stop-DatabaseAvailabilityGroup

To start this procedure, you will use the `Stop-DatabaseAvailabilityGroup` cmdlet to mark a member of a database availability group (DAG) as failed, or to mark all DAG members in a specific Active Directory site as failed.

### Obtain approval for datacenter switchover

Has the datacenter switchover been approved?

Before you begin the datacenter switchover, contact all those who may be affected by the switchover.

After you obtain approval by all affected parties, continue with the datacenter switchover.

### Online or physically accessible DAG

Is the primary datacenter online or physically accessible?

- If yes, see [Network connectivity](#network-connectivity).
- If no, see [DAG extended to multiple Active Directory sites](#dag-extended-to-multiple-active-directory-sites).

### Network connectivity

Do the remote and primary datacenters have network connectivity?

- If yes, see [Exchange Servers Online](#exchange-servers-online-if-remote-and-primary-datacenters-have-network-connectivity).
- If no, see [Exchange Servers Online](#exchange-servers-online-if-remote-and-primary-datacenters-dont-have-network-connectivity).

### Exchange Servers Online (if remote and primary datacenters have network connectivity)

Are the Exchange servers in the primary datacenter online?

- If yes, see [DAG Extended](#dag-extended-if-exchange-servers-are-in-primary-datacenter-online).
- If no, see [DAG Extended](#dag-extended-if-exchange-servers-arent-in-primary-datacenter-online).

### DAG Extended (if Exchange servers are in primary datacenter online)

Is your DAG extended to multiple Active Directory sites?

- If yes, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-in-the-shell-if-dag-is-extended-to-multiple-ad-sites).
- If no, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-if-dag-not-extended-to-ad-sites).

### Run Stop-DatabaseAvailabilityGroup in the shell (if DAG is extended to multiple AD sites)

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> - ActiveDirectorySite <Primary_Site>
    ```

2. Repeat step 1 for all Active Directory sites that contain DAG members that are not in the recovery datacenter Active Directory site.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

   The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

2. Verify that the cluster services on all Exchange servers that were accessible in the primary datacenter were forcibly cleaned up. To do this, follow these steps on all Exchange servers that were accessible in the primary datacenter:

   1. Start Services.msc.
   2. In the **Services** list, locate **Cluster Service**.
   3. Verify that the parameter in the **Startup Type** list is set to **Disabled**.
   4. Close Services.

If the Startup Type is not set to **Disabled**, forcibly clean up the cluster services and then verify the **Startup Type** again. To forcibly clean up the cluster services, run the following command at a Command Prompt on all accessible Exchange Servers:

```console
Cluster node /forcecleanup
```

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the `Stop-DatabaseAvailabilityGroup` command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run Stop-DatabaseAvailabilityGroup if DAG not extended to AD sites

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> - MailboxServer <DAG_Member_InPrimary_Site>
    ```

2. Repeat step 1 for all DAG members that are not in the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

1. Verify that the cluster services on all Exchange servers that were accessible in the primary datacenter were forcibly cleaned up. To do this, follow these steps on all Exchange servers that were accessible in the primary datacenter:

   1. Start Services.msc.
   2. In the **Services** list, locate **Cluster Service**.
   3. Verify that the parameter in the **Startup Type** list is set to **Disabled**.
   4. Close Services.

If the Startup Type is not set to **Disabled**, forcibly clean up the cluster services and then verify the **Startup Type** again. To forcibly clean up the cluster services, run the following command at a Command Prompt on all accessible Exchange Servers:

```console
Cluster node /forcecleanup
```

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### DAG Extended (if Exchange servers aren't in primary datacenter online)

Is your DAG extended to multiple Active Directory sites?

- If yes, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-if-dag-is-extended-to-ad-sites).
- If no, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-if-dag-isnt-extended-to-multiple-ad-sites).

### Run Stop-DatabaseAvailabilityGroup in the shell (DAG is extended to multiple AD sites)

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> - ActiveDirectorySite <Primary_Site> -ConfigurationOnly:$True
    ```

2. Repeat step 1 for all Active Directory sites are not the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell (DAG isn't extended to multiple AD sites)

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
     Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -MailboxServer <DAG_Member_In_Primary_Site>-ConfigurationOnly:$True
    ```

1. Repeat step 1 for all DAG members that are not in the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Exchange Servers Online (if remote and primary datacenters don't have network connectivity)

Are the Exchange servers in the primary datacenter online?

- If yes, see [DAG extended to multiple Active Directory sites](#dag-extended-to-multiple-active-directory-sites-if-exchange-servers-are-in-the-primary-datacenter-online).
- If no, see [DAG extended to multiple Active Directory sites](#dag-extended-if-exchange-servers-arent-in-primary-datacenter-online).

### DAG extended to multiple Active Directory sites (if Exchange servers are in the primary datacenter online)

Is your DAG extended to multiple Active Directory sites?

- If yes, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-the-stop-databaseavailabilitygroup-cmdlet-in-the-shell-dag-extended-to-multiple-active-directory-sites).
- If no, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-the-stop-databaseavailabilitygroup-cmdlet-in-the-shell-dag-not-extended-to-multiple-active-directory-sites).

### Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell (DAG extended to multiple Active Directory sites)

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -ActiveDirectorySite <Primary_Site> - ConfigurationOnly:$True
    ```

2. Repeat step 1 for all Active Directory sites that are not the recovery datacenter Active Directory site.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name>| FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Physical access to a primary data center](#physical-access-to-a-primary-data-center).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell (DAG not extended to multiple Active Directory sites)

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup –Identity <DAG_Name>  -MailboxServer <DAG_Member_In_Primary>  - ConfigurationOnly:$True
    ```

2. Repeat step 1 for all DAG members that are not in the recovery datacenter Active Directory site.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [You have physical access to a primary data center that is not connected by a network](#you-have-physical-access-to-a-primary-data-center-that-is-not-connected-by-a-network).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Physical access to a primary data center

Complete this step if you have physical access to a primary data center that is not connected by a network. If you cannot complete this step, go to the next step.

1. If Exchange Management Shell access to the primary datacenter is available, run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -ActiveDirectorySite<Primary_Site>
    ```

2. Repeat step 1 for all additional Active Directory sites that are not the recovery datacenter Active Directory site.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

2. Verify that the cluster services on all Exchange servers that were accessible in the primary datacenter were forcibly cleaned up. To do this, follow these steps on all Exchange servers that were accessible in the primary datacenter:

   1. Start Services.msc.
   2. In the **Services** list, locate **Cluster Service**.
   3. Verify that the parameter in the **Startup Type** list is set to **Disabled**.
   4. Close Services.

If the Startup Type is not set to **Disabled**, forcibly clean up the cluster services and then verify the **Startup Type** again. To forcibly clean up the cluster services, run the following command at a Command Prompt on all accessible Exchange Servers:

```console
Cluster node /forcecleanup.
```

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the `Stop-DatabaseAvailabilityGroup` command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### DAG extended to multiple Active Directory sites

Is your DAG extended to multiple Active Directory sites?

- If yes, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-in-the-shell-dag-is-extended-to-multiple-ad-sites).
- If no, see [Run the Stop-DatabaseAvailabilityGroup cmdlet in the shell](#run-stop-databaseavailabilitygroup-if-dag-isnt-extended-to-multiple-ad-sites).

### Run Stop-DatabaseAvailabilityGroup if DAG is extended to AD sites

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -ActiveDirectorySite<Primary_Datacenter> -ConfigurationOnly: $True
    ```

1. Repeat step 1 for all Active Directory sites that are not the recovery datacenter Active Directory site.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run Stop-DatabaseAvailabilityGroup if DAG isn't extended to multiple AD sites

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -MailboxServer <DAG_Member_In_Primary_Site> -ConfigurationOnly:$True
    ```

1. Repeat step 1 for all DAG members that are not in the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the StartedMailboxServers and StoppedMailboxServers lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity | FL
    ```

The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### You have physical access to a primary data center that is not connected by a network

Complete this step if you have physical access to a primary data center that is not connected by a network. If you cannot complete this step, go to the next step.

1. If Exchange Management Shell access to the primary datacenter is available, run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -MailboxServer <DAG_Member_In_Primary_Site>
    ```

1. Repeat step 1 for all DAG members that are not in the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run the Stop-DatabaseAvailabilityGroup cmdlet

To stop the database availability group, follow these steps:

1. On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

    ```powershell
    Stop-DatabaseAvailabilityGroup -Identity <DAG_Name> -MailboxServer <DAG_Member_In_Primary_Site>- ConfigurationOnly:$True
    ```

2. Repeat step 1 for all DAG members that are not in the recovery datacenter.

To verify that the command completed correctly, follow these steps:

1. Verify that the servers are stopped by viewing the `StartedMailboxServers` and `StoppedMailboxServers` lists for the DAG. To do this, run the following command in the shell:

    ```powershell
    Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
    ```

    The `StoppedMailboxServer` list should show all mailbox servers in the primary datacenter and the `StartedMailboxServers` list should show all mailbox servers in the recovery datacenter.

> [!NOTE]
> If a domain controller in the primary datacenter is not available, the Stop-DatabaseAvailabilityGroup command may return an Active Directory provider error. This error can be safely ignored.

**Did the Stop-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Restore-DatabaseAvailabilityGroup](#restore-databaseavailabilitygroup-if-stop-databaseavailabilitygroup-completes-correctly).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Restore-DatabaseAvailabilityGroup (if Stop-DatabaseAvailabilityGroup completes correctly)

Before you can start the `Restore-DatabaseAvailabilityGroup` procedure, the `Stop-DatabaseAvailabilityGroup` must be completed successfully.

**Did Stop-DatabaseAvailabilityGroup complete successfully?**

- If yes, and you now want to use the Restore-DatabaseAvailabilityGroup cmdlet as part of a datacenter switchover of a DAG, see [Stop the Cluster service on each DAG member in the recovery datacenter](#stop-the-cluster-service-on-each-dag-member-in-the-recovery-datacenter).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Stop the Cluster service on each DAG member in the recovery datacenter

To stop the Cluster service on each DAG member in the recovery datacenter, follow these steps:

1. At a command prompt, run one of the following commands, depending on the operating system being used by the DAG member:

   - For Windows Server 2008 R2, run the command `Stop-Service Clussvc`
   - For Windows Server 2008 SP2, run the command `Net Stop Clussvc`

> [!NOTE]
> You must use an elevated command prompt (run as administrator) if the default administrator account is not used. If the command is not run as an administrator, you receive the error message **Access denied**.

Cluster services are stopped on remaining nodes.

**Is the Cluster service stopped on all DAG members in your recovery datacenter?**

- If yes, see [Run the Restore-DatabaseAvailabilityGroup cmdlet in the shell](#run-the-restore-databaseavailabilitygroup-cmdlet-in-the-shell-if-cluster-service-stopped-on-all-dag-members).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Run the Restore-DatabaseAvailabilityGroup cmdlet in the shell (if Cluster service stopped on all DAG members)

**To restore the database availability group, follow these steps:**

On a server in the recovery datacenter, use the Exchange Management Shell to run the following command:

```powershell
Restore-DatabaseAvailabilityGroup -Identity <DAG_Name> -ActiveDirectorySite <Recovery_Site>- AlternateWitnessDirectory:<AWSPath> - AlternateWitnessServer:<AWSName>
```

When you run this command, the following events occur:

1. A DAG member in the recovery datacenter is randomly selected and its Cluster service is started in `/forceQuourm` mode.
   - DAG members on the `StoppedMailboxServers` list are evicted from the DAG's cluster. This adjusts the membership count.
   - If the resulting membership count is EVEN or results in a SINGLE node, the Cluster is configured by using a Node and File Share Majority quorum and it begins to use the Alternate Witness Server and Alternate Witness Directory.
2. Cluster services are started on the remaining DAG members and they successfully join the DAG's cluster

Verify that the DAG members are up and the Cluster Group is online.

To do this on a computer that is running Windows Server 2008 R2, run the following commands within PowerShell:

- `Import-Module FailoverClusters`
- `Get-ClusterNode -Cluster <DAG_Name>`
- `Get-ClusterGroup -Cluster<DAG_Name>`

To do this on a computer that is running Windows Server 2008 SP2, run the following commands at a command prompt:

- `Cluster <DAG_Name> node`
- `Cluster <DAG_Name> group`

> [!NOTE]
> If nodes are not evicted from the DAG's cluster and you receive error 0x46, see [Exchange 2010: Restore- DatabaseAvailabilityGroup does not evict nodes error 0x46](/archive/blogs/timmcmic/exchange-2010-restore-databaseavailabilitygroup-fails-to-evict-nodes-error-0x46) for information about how to resolve this issue.

**Did the Restore-DatabaseAvailabilityGroup command complete correctly?**

- If yes, see [Client access and database activation in the remote site](#client-access-and-database-activation-in-the-remote-site).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Client access and database activation in the remote site

Start with procedures to address client access and database activation in the remote site.

This completes the datacenter switchover.

**What do you want to do now?**

- If nothing more at this point, congratulations, Exchange Server 2010 Datacenter Switchover is now completed.
- If you want to complete the datacenter switchback, see [Start Switchback](#start-switchback).

### Start Switchback

After a switchover is completed, you will want to reverse the server roles so that the original Master is the active server again and the Replica is the standby server again.

To start this procedure, bring the primary datacenter online.

#### Supporting Services

Make sure that following supporting services are running:

- Active Directory / domain controllers / global catalog / FSMO role holders
- Domain Name Services (DNS)
- Witness Server
- Supporting Exchange roles: Client Access and Hub Transport

The following optional services may also be needed:

- Dynamic Host Configuration Protocol servers (DHCP), if DHCP addresses are used for DAG networks
- Edge Transport server
- Unified Messaging server

> [!NOTE]
> Other services specific to your network may be needed.

**Are all required services running as expected?**

- If yes, see [Verify network connectivity between all DAG members](#verify-network-connectivity-between-all-dag-members).
- If no, see [Start Switchback](#start-switchback).

### Verify network connectivity between all DAG members

To verify that all the DAG members are connected on the network, use one of the following methods:

- Use the Ping command to test network connectivity between DAG members
- Map administrative shares between DAG members to test network connectivity

After you verify that connectivity between datacenters is functioning and all cluster inter-node communications are operating correctly, go to the next step.

**Have datacenter communications been verified to be working correctly?**

- If yes, see [DAG members Cluster service startup type Disabled](#dag-members-cluster-service-startup-type-disabled).
- If no, see [Verify network connectivity between all DAG members](#verify-network-connectivity-between-all-dag-members).

### DAG members Cluster service startup type Disabled

Verify that Cluster service on the DAG members in the primary datacenter has startup type set to **Disabled**. If they do not, either the `Stop-DatabaseAvailabilityGroup` command was not successful or the DAG members in the primary datacenter did not receive eviction notification after network connectivity between datacenters was restored.

Follow these steps on all Exchange servers that were accessible in the primary datacenter:

1. Start Services.msc.
2. In the **Services** list, locate **Cluster Service**.
3. Verify that the parameter in the **Startup Type** list is set to **Disabled**.
4. Close Services.

If Cluster service cleanup has not occurred and Cluster service does not have the startup type set to Disabled, forcibly clean up the cluster services on the DAG members in the primary datacenter. To do this, run the following command at a Command Prompt on all DAG members:

```console
Cluster node /forcecleanup
```

Verify the Startup Type again.

**Does the Cluster service show startup type as Disabled?**

- If yes, see [DAG extended to multiple Active Directory sites](#dag-extended-to-multiple-active-directory-sites-if-cluster-service-shows-startup-type-as-disabled).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### DAG extended to multiple Active Directory sites (if Cluster service shows startup type as Disabled)

Is your DAG extended to multiple Active Directory sites?

- If yes, see [Start-DatabaseAvailabilityGroup](#start-databaseavailabilitygroup-if-dag-is-extended-to-multiple-ad-sites).
- If no, see [Start-DatabaseAvailabilityGroup](#start-databaseavailabilitygroup-if-dag-isnt-extended-to-multiple-ad-sites).

### Start-DatabaseAvailabilityGroup (if DAG is extended to multiple AD sites)

Use the Exchange Management Shell to run the following command:

```powershell
Start-DatabaseAvailabilityGroup -Identity <DAG_Name> -ActiveDirectorySite <Primary_Site>
```

Repeat the command for all Active Directory sites that were stopped during the datacenter switchover process.

After you run this command, DAG members in the primary datacenter are added to the DAG's cluster.
If the resulting membership count is EVEN, the cluster will use the Node and File Share Majority quorum.

To verify that the DAG members are up and the Cluster Group is online, run the following commands:

- In Windows Server 2008 R2, run the following commands within PowerShell:
  - `Import-Module FailoverClusters`
  - `Get-ClusterNode -Cluster`
  - `Get-ClusterGroup -Cluster`

- In Windows Server 2008 SP2, run the following commands at a command prompt:

  - Cluster <DAG_Name> node
  - Cluster <DAG_Name> group

Run the following command:

```powershell
Get-DatabaseAvailabilityGroup -Identity <DAG_Name>| FL
```

In the results, the `StartedMailboxServers` list should show all DAG members and the `StoppedMailboxServers` list should be empty.

> [!NOTE]
> Nodes may not always join the cluster and you receive an invalid node error. If this occurs, retry the command.

**Were the DAG members added to the cluster successfully?**

- If yes, see [Reset the DAG's Witness Server and Alternate Witness Server properties](#reset-the-dags-witness-server-and-alternate-witness-server-properties).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Start-DatabaseAvailabilityGroup (if DAG isn't extended to multiple AD sites)

Use the Exchange Management Shell to run the following command:

```powershell
Start-DatabaseAvailabilityGroup -Identity <DAG_Name> -MailboxServer <DAG_Member_In_Primary_Site>
```

Repeat the command for all Mailbox servers that were stopped during the datacenter switchover process.

After you run this command, DAG members in the primary datacenter are added to the DAG's cluster.
If the resulting membership count is EVEN, the cluster will use the Node and File Share Majority quorum.

To verify that the DAG members are up and the Cluster Group is online, run the following commands in the shell:

- In Windows Server 2008 R2, run the following commands:
  - `Import-Module FailoverClusters`
  - `Get-ClusterNode -Cluster <DAG_Name>`
  - `Get-ClusterGroup -Cluster <DAG_Name>`
- In Windows Server 2008 SP2, run the following commands:
  - `Cluster <DAG_Name> node`
  - `Cluster <DAG_Name> group`

Run the following command:

```powershell
Get-DatabaseAvailabilityGroup -Identity <DAG_Name> | FL
```

In the results, the StartedMailboxServers list should show all DAG members and the StoppedMailboxServers list should be empty.

> [!NOTE]
> Nodes may not always join the cluster and you receive an invalid node error. If this occurs, retry the command.

**Were the DAG members added to the cluster successfully?**

- If yes, [Reset the DAG's Witness Server and Alternate Witness Server properties](#reset-the-dags-witness-server-and-alternate-witness-server-properties).
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Reset the DAG's Witness Server and Alternate Witness Server properties

To reset the DAG's Witness Server and Alternate Witness Server properties, run the following command in the shell:

```powershell
Set-DatabaseAvailabilityGroup -Identity <DAG_Name>-WitnessServer <Witness_Server_Name>-AlternateWitnessServer <Alternate_Witness_Server_Name>
```

When you run this command, the Witness Server and the Alternate Witness Server properties are configured so that the correct witness server is being used.

If the Cluster configuration does not match the DAG configuration, the Cluster is updated with the correct configuration.

> [!NOTE]
> An error may occur if the incorrect file share witness is verified to be in use. For more information, see [Exchange 2010 - File Share Witness oddities](/archive/blogs/timmcmic/exchange-2010-file-share-witness-oddities).

#### Remove Activation Blocks

After any activation blocks are removed, active database copies can be moved to servers in the primary datacenter

**Did this solve your problem?**

- If yes, congratulations, Exchange Server 2010 Datacenter Switchover is now completed.
- If no, go to [Contact Microsoft Support](#contact-microsoft-support).

### Contact Microsoft Support

If you encounter issues when you try to complete this procedure, [contact Microsoft Support for help](https://support.microsoft.com/). Once you open the support page, select the version of Exchange 2010 you are using.

On the **Create an incident** webpage, select **Clustering and High Availability (Including Deployment)** in the **Problem type** list, select **Database Availability Group (DAG)** in the **Category** list, and then select **Start request** in the **Contact Microsoft** area.
