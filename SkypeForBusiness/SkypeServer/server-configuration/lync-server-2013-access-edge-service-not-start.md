---
title: Lync Server 2013 Access Edge service not start or stops responding
description: Discusses that Lync Server 2013 Access Eedge service fails to start or stops responding after it starts. This problem occurs when the EnableUserReplicator setting is enabled on the Lync Server 2013 Access Edge configuration. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Server 2013 Access Edge service fails to start or stops responding after it starts

## Symptoms

The Lync Server 2013 Access Edge service fails to start or stops responding (hangs) after it starts.

When this problem occurs, the following events are logged in the Lync Server event logs on the Lync Server 2013 Edge server:

```AsciiDoc
Log Name: Lync Server Source: LS User Replicator Event ID: 30006 Task Category: (1009) Level: Error Keywords: Classic User: N/A Description: Failed to update the list of domains in this forest to synchronize. User replicator cannot synchronize any objects without knowing which domains to synchronize from. ReplicationType: LocalRegistrarReplication Cause: This failure occurred because DsGetDcName failed to provide any valid domain controllers to connect to. User Replicator doesn't have a list from a previous cycle, and cannot proceed. DsGetDcName failures usually stop occurring after some time. Resolution: If this error continues to occur, the computer should be rebooted to fix the NetLogon service which services calls to DsGetDcName. Log Name: Lync Server Source: LS User Services Event ID: 32136 Task Category: (1006) Level: Error Keywords: Classic User: N/A Description: First run of User Replicator on a pristine Database failed. Local store could not be prepared for first time use. Cause: Connectivity issues with the database or Active Directory. Resolution: The first run of User Replicator on a pristine Database needs to succeed for this Server to become operational. The failure is usually due to lack of Active Directory connectivity or failure to synchronize from one or more Domains that this Server has been configured to replicate users from. Run instantur.exe to identify the actual cause of the error and resolve them and then restart the Server 
```

## Cause

This problem occurs because the EnableUserReplicator setting is enabled in the Lync Server 2013 Access Edge configuration.

## Resolution

To resolve this problem, follow these steps.

### Step 1: Stop the Access Edge service

If the Lync Server 2013 Access Edge service is in a suspended state, use Windows Task Manager to completely stop the service process on the server that is running the Lync Server 2013 Access Edge service. To do this, follow these steps for the appropriate version of the operating system.

> [!NOTE]
> If the Lync Server 2013 Access Edge service is already stopped, go to Step 2.

#### Windows Server 2012

1. Press the Windows logo key to access the **Start** page.   
2. Right click the **Start** page, and then click the **All Apps** tile.   
3. Double-click the **Task Manager** tile.   
4. Click the **Processes** tab   
5. Expand **SIP Server Service**.   
6. Select **Lync Server Access Edge**, and then click **End Task**.   

#### Windows Server 2008 or Windows Server 2008 R2

1. Click **Start**, click **Run**, type taskmgr.exe, and then click **OK**.   
2. Click the **Processes** tab.   
3. Select the **RTCSrv.exe** process, and then click **End Process**.   

### Step 2: Disable the User Replicator service

Use Lync Server Management Shell to disable the Lync Server 2010 User Replicator service on the Lync Server 2013 Edge server. To start the shell, follow these steps for the appropriate version of the operating system.

#### Windows Server 2012

1. Press the Windows logo key to access the **Start** page.   
2. Click the **Lync Server Management Shell** tile.   

#### Windows Server 2008 or Server 2008 R2

1. Click **Start**, point to **All Programs**, and then click **Microsoft Lync Server**.   
2. Click **Lync Server Management Shell**.   

### Step 3: Replicate the Central Management Store

Run the following Lync Server PowerShell cmdlets in the given order.

- To reset the EnableUserReplicator flag to **False** for the Lync Server 2013 Access Edge configuration:

    ```powershell
    Set-CsAccessEdgeConfiguration -EnableUserReplicator $FalseNote The default setting for the EnableUserReplicator flag is **False**.   
    ```
- To invoke the Central Management Store (CMS) replication to the Lync Server 2013 Edge server:

    ```powershell
    Invoke-CsManagementStoreReplication
    ```  
- To view the status of the CMS replication to the Lync Server 2013 Edge server:

    ```powershell
    Get-CsManagementStoreReplicationStatus   
    ```

### Step 4: Restart the Edge server

After the CMS store replication has finished successfully, restart the Lync Server 2013 Edge server.

## More Information

For more information about how to configure the Lync Server 2013 Access Edge service, go to the following Microsoft TechNet websites:

- [Set-CsAccessEdgeConfiguration](/powershell/module/skype/Set-CsAccessEdgeConfiguration)
- [Get-CsAccessEdgeConfiguration](/powershell/module/skype/Get-CsAccessEdgeConfiguration)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).