---
title: Troubleshoot WSUS high CPU usage
description: Discusses how to troubleshoot Windows Server Update Service high CPU usage issues.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Troubleshoot high CPU usage on a WSUS server

This article introduces several procedures for troubleshooting high CPU usage in Windows Server Update Service (WSUS).

> [!NOTE]
> **Home users**: This article is intended only for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4489045

High CPU usage can occur if the WSUS database (SUSDB) is not clean. After the server runs for a while, there can be too many updates for the WSUS server to provide to the clients.

In this situation, if a failure occurs or a new WSUS server is installed or an unrelated issue prevents clients from scanning for a few days, all the clients might start scanning and continue to scan constantly and never actually complete a scan or install updates.

To fix the issue, you have to clean up the WSUS server and decline superseded updates. Follow the steps in the order below as a monthly cleanup routine. However, if you are troubleshooting high CPU issues, we recommend that you do step 4 first and then step 3. You should defer steps 1 and 2 until the CPU usage level decreases.

## Step 1: Back up the WSUS database

Backing up the WSUS database can improve the performance slightly.

## Step 2: Run the WSUS Server Cleanup Wizard

Running the WSUS Server Cleanup Wizard can improve database performance. However, it does not reduce the number of updates that the clients are scanning. Additionally, it can take many hours or days for the wizard to run without necessarily resolving the issue.

## Step 3: Reindex the WSUS database

Reindexing the WSUS database can improve database performance if it's fragmented. To do this, run the following commands.

1. Update the `statistics` by using the `FULLSCAN` option.

   ```sql
   Use <dbname>
   Go
   Exec sp_msforeachtable 'update statistics ? with fullscan'
   Go
   ```

2. Rebuild the indexes.

   ```sql
   Use <dbname>
   Go
   Exec sp_msforeachtable 'DBCC DBREINDEX (''?'')'
   Go
   ```

## Step 4: Decline superseded updates

Declining superseded updates immediately reduces the number of updates that are being scanned.

To decline superseded updates or perform any WSUS actions in a situation where the WSUS application pool recycles too quickly, you can first stop the clients from connecting to the WSUS application pool. To do this, connect to the WSUS server by using the WSUS console, and then synchronize the WSUS server with the upstream server and with Configuration Manager (if it is used). If you are using Configuration Manager, it's important to synchronize to the latest version of the update in the Configuration Manager console so that clients will see that WSUS has current and valid updates.

To disconnect the clients, use one of the following methods.

### Method 1: Create a test application pool

1. Right-click **Application pools** in the **Internet Information Services (IIS) Manager** area, and then select **Add Application Pool** to create a test application pool.

2. Select **Client web service** > **Manage application** > **Advanced settings**, and then change the application pool to the test application pool that you created.

### Method 2: Change the port for the WSUS website

1. Select **WSUS Administration Web Site** > **Edit Bindings**.
2. Change the WSUS console to connect to the new port, run the script, and synchronize with USS.
  
   > [!NOTE]
   > This method will cause syncing with Configuration Manager to fail.

### Method 3: Use Firewall rules to block all client IP addresses or allow only USS and site server incoming connections

After the clients are disconnected from the WSUS server, you can run the [PowerShell script](decline-superseded-updates.md) by using the `-skipdecline` (and `-exclusion` period, if necessary) parameters to determine the total number of superseded updates that can be declined. Then, run the script again by using `-skipdecline` to actually decline the updates.

In extreme cases in which the PowerShell script can't run because of timeouts, you can add the supersedence column to the WSUS console when all updates are displayed, and then decline the updates manually by following these steps:

1. Open the Windows Update Services Microsoft Management Console (MMC).
2. Select the All Updates view. To do it, set the display to show the **Approval** status of **Any except Declined** with a status of **Any**, and then click **Refresh**.
3. Right-click the column headers, and then select **Supersedence**.
4. Left-click the **Supersedence** column to sort by supersedence.
5. Select and decline the superseded updates.

The performance issue can normally be resolved after the valid update is reduced to fewer than 7,000 connections (but fewer than 5,000 is preferred). You might have to restrict connections to the WSUS administration website for a few days to let the clients complete all scans. We also recommend that you reindex the database after you decline superseded updates. If you're using Configuration Manager, also perform a sync between WSUS and Configuration Manager while the clients are not connecting.  

After you complete these steps, you should limit connections if the CPU usage is still too high. To do this, follow these steps:

1. Open **Internet Information Services (IIS) Manager** > **WSUS Administration Web Site** > **Manage web site** > **Advanced settings** > **Limits** > **Maximum concurrent connections**.

2. Set the value to **50** or **100**.
3. Monitor the **W3Wp** process in Task Manager and the total CPU on the server.

4. Open Task Manager > **Resource Monitor**, and note the **PID** for the WSUS application pool. If you are unsure which w3wp process is running the WSUS application pool, you can use Appcmd ([Method 2](/archive/blogs/ericparvin/find-pid-for-iis-application-pools-worker-process)) to identify the PID easily.

By default, the PID should change only one time every 29 hours. If it changes more often, your connection limit may be too high for the current CPU and memory setting for the WSUS application pool.

Monitor for stable w3wp memory and stable overall CPU use of less than 90 percent. As the steady state CPU and memory use decrease, you can slowly increase connection limits to the WSUS administration website. Depending on what kind of situation you are in, the memory usage may take several days to return to a stable state. Increasing the connection limits might need to occur in small increments and over the course of several days.

## Reference

[High CPU/High Memory in WSUS following Update Tuesdays](https://techcommunity.microsoft.com/t5/Configuration-Manager-Archive/High-CPU-High-Memory-in-WSUS-following-Update-Tuesdays/ba-p/274265)
