---
title: StartDagServerMaintenance.ps1 script fails in Exchange Server 2010
description: Resolves an Exchange Server 2010 issue that blocks you from running the StartDagServerMaintenance.ps1 script to take a DAG member out of service for maintenance.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul, excontent, genli, christys, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you run StartDagServerMaintenance.ps1 script in Exchange Server 2010

_Original KB number:_ &nbsp;3058960

## Symptoms

You try to configure a server that's in a database availability group (DAG) into maintenance mode by running the `StartDagServerMaintenance.ps1` script. However, the script fails, and you receive the following error message:

```console
VERBOSE: [Time UTC] Move-DagActiveCopy: Entering: `$MailboxServer=ExServer, `$Database=
VERBOSE: [Time UTC] Move-DagActiveCopy: Moving all replicated active databases off server ExServer
VERBOSE: [Time UTC] Move-DagActiveCopy: moving database 'DBName' off server 'ExServer'
VERBOSE: [Time UTC] Move-DagMasterCopy: Entering: `$db=DBName, `$srcServer=ExServer, `$preferredTarget=
VERBOSE: [Time UTC] Test-DagTargetCopy: Testing move criteria for DatabaseName\ExchangeServer, with `$Lossless=True and
`$CICheck=False …
VERBOSE: [Time UTC] Test-DagTargetCopy: Name='DatabaseName\ExchangeServer', Status='DisconnectedAndHealthy',
CIStatus='Healthy', CopyQueueLength=0, ReplayQueueLength=0
VERBOSE: [Time UTC] Test-DagTargetCopy: Leaving (returning 'False')
VERBOSE: [Time UTC] Test-DagTargetCopy: Testing move criteria for DBName\DR-ExServer, with `$Lossless=True
and `$CICheck=False …
VERBOSE: [Time UTC] Test-DagTargetCopy: Name='DBName\DR-ExServer', Status='DisconnectedAndHealthy',
CIStatus='Healthy', CopyQueueLength=0, ReplayQueueLength=0
VERBOSE: [Time UTC] Test-DagTargetCopy: Leaving (returning 'False')
VERBOSE: [Time UTC] Move-DagMasterCopy: 0 copies out of 3 for database DBName will be attempted for move.
Log-Error : [Time UTC] Move-DagMasterCopy: Database 'DBName' *FAILED* to move! Now attempting to perform rollback to prevent a DB outage…

At D:\Program Files\Microsoft\Exchange\V14\scripts\DagCommonLibrary.ps1:483 char:14
+ Log-Error <<<< ($DagCommonLibrary_LocalizedStrings.res_0064 –f $db,"Move-DagMasterCopy")
+ CategoryInfo : NotSpecified: ( : ) [Write-Error], WriteErrorException + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Log-Error
```

Additionally, when you run the `Get-MailboxDatabaseCopyStatus` cmdlet on the database, the database doesn't report the DisconnectedAndHealthy status as expected.

## Workaround

To work around this issue, use the following methods to manually fail over the databases from this server.  

### Put the server into maintenance mode

1. Verify that at least one other non-lagged copy of each replicated database is healthy. To do this, run the following Exchange Management Shell (EMS) command:

    ```powershell
    Get-MailboxDatabase -Server 'MaintenanceServerName' | Get-MailboxDatabaseCopyStatus
    ```

1. Move all databases off this server by running the following EMS command:

    ```powershell
    Move-ActiveMailboxDatabase -Server 'MaintenanceServerName'
    ```

    > [!NOTE]
    >  No target server is specified, and this means that next best copy will be automatically selected for activation.
1. Move the cluster core resources to another node in the DAG. To do this, run the following command at command prompt:

    ```console
    cluster.exe DAGFQDN group "ClusterGroup" /moveto: 'MaintenanceServerName'
    ```

1. Suspend all the copies on the server by running the following EMS command:

    ```powershell
    Get-MailboxDatabaseCopyStatus -Server 'MaintenanceServerName' | Suspend-MailboxDatabaseCopy -ActivationOnly:$true
    ```

1. Pause the node in the cluster by running the following command line:

    ```console
    cluster.exe DAGFQDN node '**MaintenanceServerName**' /pause
    ```

1. Prevent the databases from trying to fail over to this node by running the following EMS command:

    ```powershell
    Set-MailboxServer -Identity 'MaintenanceServerName' -DatabaseCopyAutoActivationPolicy:BLOCKED
    ```

### Remove the server from maintenance mode

To put the server back into production, follow these steps:

1. Resume the node in the cluster. To do this, run the following command line:

    ```console
    cluster.exe DAGFQDN node 'MaintenanceServerName' /resume
    ```

1. Remove the block on auto-activation on this server by running the following EMS command:

    ```powershell
    Set-MailboxServer -Identity 'MaintenanceServerName' -DatabaseCopyAutoActivationPolicy: Unrestricted
    ```

1. Resume mailbox database replication on the server by running the following EMS command:

    ```powershell
    Get-MailboxDatabaseCopyStatus -Server 'MaintenanceServerName' | Resume-MailboxDatabaseCopy
    ```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
