---
title: Optimize WSUS client performance
description: This article provides general guidelines for optimizing the performance of the WSUS clients and for fixing scan failure issues.
ms.date: 12/05/2023
ms.reviewer: kaushika, jchornbe
ms.custom: sap:Software Update Management (SUM)\WSUS Database Maintenance
---
# General guidance on optimizing WSUS client performance

This article provides general guidelines for optimizing Microsoft Windows Server Update Services (WSUS) client performance.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 2517455

## Summary

After deploying a WSUS server, you may experience the following performance issues on clients:

- You may experience prolonged high CPU utilization when you scan for updates or when you install updates.
- The scans fail.

This article provides general guidelines for optimizing the performance of the clients and for fixing the issue if the scans ultimately fail. However, keep in mind that a scan is still a CPU-intensive operation. The Svchost.exe process contains the Automatic Updates service. When you perform a scan, the Svchost.exe process can cause CPU usage to reach 100 percent for a certain period of time. For example, Microsoft Office updates use Windows Installer, and when Microsoft Office updates are detected, these updates can contribute to 100 percent CPU utilization for a short period of time.

Read this article entirety before attempting any procedure contained here.

## Run the WSUS Server Cleanup Wizard  

Update scan performance can also be affected by the number of updates the client needs to evaluate. The WSUS Server Cleanup Wizard will help to remove redundant updates and optimize the performance for both the WSUS server and the clients. To run the WSUS Server Cleanup Wizard, follow the steps below:

1. In the WSUS administration console, select **Options** > **Server Cleanup Wizard**.
2. By default, this wizard will remove unneeded content and any computers that have not contacted the server for 30 days or more. Select all possible options, and then select **Next**.
3. The wizard will begin the cleanup process and will present a summary of its work when it's finished. Select **Finish** to complete the process.

For more information, see [Using the Server Cleanup Wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc708578(v=ws.10)?redirectedfrom=MSDN).

## Check custom WSUS admin scripts  

If you are using a script to approve updates, be cautious that you don't approve expired and declined updates. These updates are set to be expired by Microsoft and are never approved for install. Reactivating these updates may cause update scan failures on the clients.

We recommend avoid using **Any** for approval state when enumerating updates. Instead, use a combination of other `ApprovedState` values. For example, the following PowerShell code will restrict the update search result to updates that are approved with the latest revision and not approved updates, which are safe to approve:

```PowerShell
$updateScope.ApprovedStates = [Microsoft.UpdateServices.Administration.ApprovedStates]::LatestRevisionApproved -bor [Microsoft.UpdateServices.Administration.ApprovedStates]::NotApproved foreach($update in $wsus.GetUpdates($updateScope)) { #Approve the update $update.Approve($updateaction,$targetgroup) }
```

For more details, check following WSUS SDK documentation:

- [UpdateScope.ApprovedStates Property](/previous-versions/windows/desktop/aa353751(v=vs.85)?redirectedfrom=MSDN)
- [ApprovedStates Enumeration](/previous-versions/windows/desktop/aa354257(v=vs.85)?redirectedfrom=MSDN)

## Reset Windows Update components  

If the performance issue happens on only a few of clients, you can try resetting the Windows Update component on these clients and see if the problem is resolved. Refer to the following article for details steps and tools:

[Windows Update - additional resources](/windows/deployment/update/windows-update-resources)

> [!NOTE]
> Aggressive mode of the script (or step 4 of the above article) should only be run as the last possible resort. Performing that step or running the script in Aggressive mode will wipe the datastore on the local computer, completely erasing all of the user's settings, update history, and local cache. This can prove to be very troublesome especially for a system administrator, since there is no way to know what updates were previously installed on the machine after wiping the datastore.

If the client computer is running Windows 7, it's recommended that you run the built-in troubleshooter instead of following the steps outlined in the above article. This troubleshooter performs steps similar to the above article, but is non-destructive and might be a bit more effective.

To run this troubleshooter, follow the steps below:

1. Open the Windows Update troubleshooter by selecting the **Start** > **Control Panel**.
2. Select **Find and fix problems**.
3. Under **System and Security**, select **Fix problems with Windows Update**.

If you're prompted for an administrator password or confirmation, type the password or provide confirmation, then allow the troubleshooter to complete.
