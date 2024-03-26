---
title: Lync Server 2013 Front-End server services do not start for a long time
description: During a large Pool cold-start it can take up to an hour for the placement process to finish as it must populate all Front-End databases with data from the Backup Store. If the Pool is running and the Front-End is just started, this behavior is normal. The Lync Server Event Viewer will log Event ID 32174.
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

# Lync Server 2013 Front-End server services do not start for a long time

## Symptoms

This issue may occur under the following circumstances:

- The Lync Server 2013 pool hosts three or more Lync Server 2013 Front-End servers.   
- The Lync Server 2013 Front-End servers have had updates applied recently that required the stopping of services.   
- The Windows Server that hosts the Lync Server 2013 Front-End servers has had updates applied recently that required a system restart.   
- Components that make up the required Lync Server 2013 infrastructure fail and caused the shut down or restarting of Lync Server Front-End services.   
- Lync Server 2013 Front-End server services will not start when you have two Front-End servers and one Back-End server with mirroring. 

    ```AsciiDoc
    Resolution: 
    Shut down one of the Front-End servers. Then shut down the Back-End server to make the mirroring failover work correctly.
    ```
- The Lync Server 2013 Front-End servers will log the following Warning event in the Lync Server Event Log in Windows Event Viewer during the Lync Server 2013 service startup:

    ```AsciiDoc
    Log Name: Lync Server 
    Source: LS User Services 
    Event ID: 32174 
    Level: Warning
    
    Description: Server startup is being delayed because fabric pool manager has not finished initial placement of users. 
    Currently waiting for routing group: {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}. 
    Number of groups potentially not yet placed: 
    Total number of groups:
    
    Cause: 
    This is normal during cold-start of a Pool and during server startup. 
    If you continue to see this message many times, it indicates that insufficient number of Front-Ends are available in the Pool. 
    
    Resolution: 
    During a cold-start of a large Pool it can take up to an hour for the placement process to finish as it has to populate all the Front-End databases with data from the Backup Store. If the Pool is running and the Front-End is just started, this is usual for some time. If this repeats for a long time, make sure that all the Front-Ends configured for this Pool are up and running. If multiple Front-Ends were recently decommissioned, run Reset-CsPoolRegistrarState -ResetType QuorumLossRecovery to enable the Pool to recover from Quorum Loss and make progress.
    ```

    > [!NOTE]
    > This article discusses possible issues that occur with Lync Server 2013 intra pool Front-End server high availability.   

## Cause

In Lync Server 2013, the architecture of the Enterprise Edition (EE) Front-End pools has changed to a distributed systems architecture. Information about a particular user is kept on three Front-End servers in the pool. For each user, one Front-End server acts as the master for that user's information, and two other Front-End servers serve as replicas. If a Front-End server goes down, another Front-End server which served as a replica is automatically promoted to master. This eliminates the single point of failure of a single back end server. However this design has its limitations. For a Lync Server 2013 pool to remain in a working quorum state the Lync Server 2013 Front-End server services that are used to manage the pool's quorum must not be under 85% of the Lync Server 2013 pool's capacity or quorum state could be lost.

> [!NOTE]
> Complete quorum loss will occur if a Lync Server 2013 Front-End server pool loses 50% or more of its Lync Server 2013 Front-End server services that are used to manage the pool's quorum.

## Resolution

As mentioned in the Summary section this kind of issue can occur when you update the Front-End servers in the Lync Server 2013 EE pool or when a single point of failure occurs. Listed here are some steps that can be taken in both scenarios that can prevent this kind of issue:

Updating the Front-End servers in the Lync Server 2013 Enterprise Edition pool

For upgrades of Front-End servers, we recommend that you upgrade one server at a time. Bring one server down, apply the upgrade, then bring that server back up before upgrading another server. 

For a Front-End pool to be functional, a certain number of Front-End servers in the pool have to be up and running. For detailed information on how many Lync Server 2013 Front-End servers are required to remain running during maintenance operations review the following Microsoft TechNet documentation:

[Topologies and Components for Front End Servers, Instant Messaging, and Presence](/previous-versions/office/lync-server-2013/lync-server-2013-topologies-and-components-for-front-end-servers-instant-messaging-and-presence)

### Single point of failure

The failure of any physical grouping of a set of hardware components, for example, servers that share a single point of failure such as electrical power, overheating, a network switch or data storage, can cause a single point of failure for the Lync Server 2013 Front-End server pool. In a single point of failure scenario there is the possibility that under 85% of the Lync Server 2013 Pool's Front-End server services will remain functional. When this amount of functionality loss occurs the Lync Server 2013 Pool may lose its quorum state. This results in the issue that is described in the Summary section of this KB article. The solution for this kind of issue is described here: 

#### Using Windows Server 2012

1. Press the Windows Function key to access the Start page.   
2. Select the **All Applications** menu.   
3. Open the Lync Server Management Shell.   

#### Using Windows Server 2008 or Windows Server 2008 R2

1. Click **Start**.   
2. Select **All Programs**, then Microsoft Lync Server 2013.  
3. Click the Lync Server Management Shell.   

Use the Lync Server 2013 PowerShell cmdlet in the example listed here from the Lync Server Management Shell:

```powershell
Reset-CsPoolRegistrarState -PoolFqdn "atl-cs-001.litwareinc.com" -ResetType QuorumLossRecovery
```

> [!NOTE]
> Only services that are in a quorum loss will have to reload user data from the backup store. Other services will be unaffected by this command.

For more information about how to use the **Reset-CsPoolRegistrarState** Lync Server 2013 PowerShell cmdlet review the Microsoft TechNet documentation listed here:

[Reset-CsPoolRegistrarState](/powershell/module/skype/Reset-CsPoolRegistrarState)

## More Information

Microsoft does not recommend deploying a Lync Server 2013 Front-End pool that contains only two Front-End servers. For more information about this topic review the following Microsoft TechNet deployment documentation:

[Topologies and Components for Front End Servers, Instant Messaging, and Presence](/previous-versions/office/lync-server-2013/lync-server-2013-topologies-and-components-for-front-end-servers-instant-messaging-and-presence)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).