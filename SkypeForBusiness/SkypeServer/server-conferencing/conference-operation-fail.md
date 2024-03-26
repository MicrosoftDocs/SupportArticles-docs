---
title: Conference creation, modification, or deletion fails for some application endpoints in Lync or Skype for Business
description: Conference creation, modification, or deletion fails for some application endpoints. Provides a solution for this issue.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: corbinm, arianr, nsuter
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2015
  - Lync Server 2013
ms.date: 03/31/2022
---

# Conference creation, modification, or deletion fails for some application endpoints in Lync or Skype for Business

## Symptoms

Consider the following scenario:

- You have an on-premises Microsoft Skype for Business Server 2015 or Lync Server 2013 enterprise pool.   
- You have one or more third-party applications using trusted application endpoints that create a large number of conferences.   
- An outage or network disconnect occurs for one or more of your Skype for Business Server 2015 or Lync Server 2013 Front-End servers.   

In this scenario, you find that some portion of the endpoints used by your applications cannot create, modify, or delete conferences. The endpoint receives a "503 syncReplicationFailed" or "400 conferenceAlreadyExists" error for every conference it tries to create, modify, or delete.

## Cause

Replication of stateful data from the primary Front-End server to both of its secondary Front-End servers fails while trying to create, modify, or delete a conference. 

During an outage or disconnect of one or more Front-End servers, the currently active Front-End servers may take ownership of certain sets of users, and in the process, require the creation of new secondary replicas for those users.

When many conferences are created over time by a third-party application, the Persisted Service Data (PSD) table may grow to a size at which replication to the new secondary replicas takes an excessive amount of time to complete. This prolonged process causes queues on the server to become full for longer than expected, and it triggers replication failures during conference operations. 

## Resolution

To prevent this issue, use the PurgeAppEndpointUserDataFromPSD.ps1 ​tool from the Skype for Business 2015 Resource Kit:

[https://gallery.technet.microsoft.com/How-to-purge-application-eb80d022](https://gallery.technet.microsoft.com/how-to-purge-application-eb80d022)

This tool locates any entries related to conferences that were created by application endpoints but that have since been deleted. It also purges those entries from the PersistedServiceData table.

> [!NOTE]
> If you were actively affected by this issue before running this tool, you may notice that currently affected application endpoints continue to fail during conference operations, even after you run the tool. This issue may persist until the secondary replication process has completed.

You can use the Get-CsPoolUpgradeReadinessState PowerShell command to determine whether all the secondary replication processes have completed. When the state is **Busy**, there are still secondary replication tasks in progress, and therefore some portions of the application endpoints may still be affected. After the state transitions to **Ready**, all secondary replication tasks should have completed, and all application endpoints should now be able to complete conference operations.

Follow these steps on every affected pool: 

1. Optional: Run the following SQL query on the RTCLocal SQL instance of your Front-End servers to determine the current number of entries in the PersistedServiceData table. The value returned may vary between individual Front-End servers in a particular pool. 

    ```sql
    select count(*) from [rtc].[dbo].[PersistedServiceData] psd with (nolock)
    inner join [rtc].[dbo].[Document] d with (nolock) on psd.DocId = d.DocId
    ```
2. Run the following command: 

    ```powershell
    PurgeAppEndpointUserDataFromPSD.ps1 -PoolName <pool name> -Command select
    ```
3. Open the output files and visually confirm that it's safe to delete their data.   
4. Run the following command: 

    ```powershell
    PurgeAppEndpointUserDataFromPSD.ps1 -PoolName <pool name> -Command delete
    ```
5. Optional: While the tool is running, you can run the SQL query from step 1 to verify that the count is being reduced. After the script has finished running, you can run the SQL query one more time to determine the final number of entries in the PersistedServiceData table on each Front-End server. This number should be less than the count seen in step 1.    

By default, this script will process application endpoints that are currently homed on a particular pool. If application endpoints have been moved to a different pool, you can use the optional AllPoolEndpoints switch to indicate that you want to include application endpoints homed on any pool, as follows:

```powershell
PurgeAppEndpointUserDataFromPSD.ps1 - PoolName <Pool name> -Command delete -AllPoolEndpoints
```

### Ongoing maintenance

This tool purges all relevant entries that are currently in the PersistedServiceData table, however, as any third-party applications that use conferences continue to create new conferences, the size of the table will continue to grow. Therefore, we recommend that you run the PurgeAppEndpointUserDataFromPSD.ps1 ​tool periodically to ensure the size of the PersistedServiceData table does not grow to the point where this issue occurs again.

The frequency with which to run this tool depends on the rate at which these third-party applications create conferences. You can use the SQL query from step 1 in the "Resolution" section to monitor the size of the table and to determine how quickly it is growing. This will help you determine an appropriate schedule for your environment.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
