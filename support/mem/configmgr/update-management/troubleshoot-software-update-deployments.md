---
title: Troubleshoot software update deployments
description: Describes how to troubleshoot software update deployments that don't run successfully. For example, updates fail to download and there are unexpected reboots during update installation.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\Software Update Groups or Deployments
---
# Troubleshoot software update deployments in Configuration Manager

This article describes how to troubleshoot software update deployments that don't run successfully.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090264

## Summary

When you deploy software updates in Configuration Manager, you typically add the updates to a software update group. Then deploy the software update group to clients. When you create the deployment, the update policy is sent to client computers. The update content files are downloaded from a distribution point to the local cache on the client computer. The updates are then available for installation on the client. Normally this process is completed successfully with little effort. However, issues may sometimes arise that cause update deployment to fail. We cover the two most common failure scenarios and provide troubleshooting suggestions for each.

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

When software update deployment fails, the problem generally falls into one of two categories:

- Updates fail to download.
- You experience unexpected reboots, or updates are installed outside a maintenance window.

## Updates fail to download

1. When updates don't get downloaded to the client, first check the CAS.log, ContentTransferManager.log, and DataTransferService.log files for errors. To learn about how updates are downloaded, see [Track the software update deployment process in Configuration Manager](track-software-update-deployment-process.md)

2. Verify that the client is in the appropriate boundary associated with the boundary group for the distribution point. For more information about boundary groups, see [Configuring boundaries and boundary groups in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/hh427326(v=technet.10)).

3. Check the Software Update Package status and verify that the updates are downloaded and installed on the distribution points. If the content isn't installed on the distribution point that's associated with the client's boundary group, check whether fallback for content location must be enabled. For more information, see [What is fallback and what does it mean?](/archive/blogs/cmpfekevin/what-is-fallback-and-what-does-it-mean).

4. If the client receives the download location but fails to download content, try to download the content manually by accessing the URL for the content. You can find the URL by reviewing DataTransferServices.log.

## Installation, supersedence, or detection issues with specific updates

1. Check to see whether the scan failed during the deployment evaluation. For more information about scan failures, see [Troubleshoot software update scan failures in Configuration Manager](troubleshoot-software-update-scan-failures.md).
2. Review WUAHandler.log and WindowsUpdate.log to find the errors received during update installation.
3. To rule out an installation issue with the update itself, manually install the update or install it from Microsoft Update (if possible). See whether the update installation is successful.
4. Most .NET Framework update failures are caused by corrupted .NET Framework installations. In these cases, try to manually install the update. If the installation process fails, see [Fix Windows Update errors](https://support.microsoft.com/help/10164/fix-windows-update-errors).

For more information, see [Installation, supersedence, or detection issues with specific updates](troubleshoot-software-update-management.md#installation-supersedence-or-detection-issues-with-specific-updates).

## You experience unexpected reboots, or updates are installed outside a maintenance window

If possible, [enable verbose and debug logging](enable-verbose-logging.md) if the issue can be reproduced.

1. Review the ServiceWindowManager.log file on the client, and identify the service windows that are available.

   ServiceWindowManager.log contains information about maintenance windows and their start and end time. This information can be very useful when you troubleshoot issues related to software update installation on clients.

    To find a list of available maintenance windows (service windows) on a client, open ServiceWindowManager.log, and search for the **Refreshing Service Windows** string. Immediately following this line, you'll see a list of the applicable service windows on the computer, as in the following example:

    ```output
    Refreshing Service Windows..... ServiceWindowManager  
    Populating instance of ServiceWindow with ID=7cb56688-692f-4fae-b398-0e3ff4413adb, ScheduleString=02C159C0381A200002C159C0381B200002C159C0381C200002C159C0381D200002C159C0381E2000, Type=6 ServiceWindowManager  
    This is a one shot Service Window that has already finished. ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 00, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=90a5f436-364c-48c7-8dc7-c5014abcbea8, ScheduleString=00084AC028592000, Type=6 ServiceWindowManager  
    StartTime is 02/09/14 00:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 1, hours: 05, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=45dca355-3249-4845-b8aa-72d0e604548e, ScheduleString=02C24AC0381C2000, Type=6 ServiceWindowManager  
    StartTime is 02/12/14 22:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 07, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=87e4759c-2884-45e6-9261-c33ba53f596c, ScheduleString=02C24AC0381D2000, Type=6 ServiceWindowManager  
    StartTime is 02/13/14 22:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 07, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID={1E957DDD-0A26-434C-952A-586F3E31E319}, ScheduleString=00302B0018192000, Type=1 ServiceWindowManager  
    StartTime is 02/16/14 01:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 03, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=36da6950-3d1e-4027-be0e-7b16a4daee7e, ScheduleString=02C24AC0101E2000, Type=6 ServiceWindowManager  
    StartTime is 02/14/14 22:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 02, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=028bfbc0-7120-4081-a268-0e664a92ac4a, ScheduleString=00074AC0005F2000, Type=6 ServiceWindowManager  
    StartTime is 02/15/14 00:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 1, hours: 00, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=49fd80be-ac4b-4877-974d-ecd09958926d, ScheduleString=02C24AC0381B2000, Type=6 ServiceWindowManager  
    StartTime is 02/11/14 22:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 07, mins: 00, secs: 00 ServiceWindowManager  
    Populating instance of ServiceWindow with ID=ad27b0ca-8c74-43c7-8200-1f601880bd75, ScheduleString=02C24AC0381A2000, Type=6 ServiceWindowManager  
    StartTime is 02/10/14 22:00:00 ServiceWindowManager  
    Duration for the Service Window is Total days: 0, hours: 07, mins: 00, secs: 00 ServiceWindowManager
    ```

    Generally, service windows with IDs containing all lowercase alpha-numeric characters are non-business hour (NBH) maintenance windows. They're based on business hours configured in Software Center. However, service windows with IDs containing all uppercase alpha-numeric characters are maintenance windows defined for the collection in the Configuration Manager console. In the example, all service windows are non-business hour windows, except the one with ID 1E957DDD-0A26-434C-952A-586F3E31E319. This window is a maintenance window defined for the collection that holds the client.

2. Review the UpdatesDeployment.log file. Locate the following line to check whether the deployment was set to ignore the maintenance window:

    ```output
    Notify reboot with deadline = Sunday, Feb 09, 2014. - 21:30:17, Ignore reboot Window = True, NotifyUI = True
    ```

3. Review the MaintenanceCoordinator.log file. Locate the following line to check whether the deployment was set to ignore the maintenance window. A value of **1** for `swoverride` means that the ignore maintenance window setting is enabled.

    ```output
    RequestPersistence(id=Update download job, persist=1, swoverride=1, swType=4, pendingWFDisable=0, deadline=1)
    ```

4. Review the SCNotify.log file, and look for the following lines to check whether the user clicked the restart notification to initiate a restart:

    ```output
    ConfirmRestartDialog: User chose to restart/logoff. (Microsoft.SoftwareCenter.Client.Pages.ConfirmRestartDialog at ButtonRestart_Click)  
    ConfirmRestartDialog: user is allowed to restart (Microsoft.SoftwareCenter.Client.Pages.ConfirmRestartDialog at ButtonRestart_Click)  
    The user is allowed to restart the computer. Initiating restart. (Microsoft.SoftwareCenter.Client.Data.WmiDataConnector at RestartComputer)
    ```

5. View the deployment properties in the Configuration Manager console to check whether the deployment is set to override maintenance windows. If the deployment isn't set to override maintenance windows, but the client logs suggest that the deployment did override maintenance windows, review the audit status messages to check whether the deployment was modified by someone.

   To review audit status messages, navigate to Configuration Manager console > **Monitoring**  > **System Status** > **Status Message Queries**. Right-click **All Status Messages**, click **Show Messages**, select the timeframe, and then click **OK**.

   In the Configuration Manager **Status Message Viewer** window, navigate to **View** > **Filter**, and then filter for **Message ID = 30197**. If the deployment was modified, you'll see a status message that resembles the following one:

   ```output
   Severity Type Site code Date / Time System Component Message ID Description  
   Information Audit PR1 2/9/2014 11:57:49 PM PR1SITE.CONTOSO.COM Microsoft.ConfigurationManagement.exe 30197 User "DOMAIN\User" modified updates assignment 4 ({BAFB1BDB-7A6C-4DCF-9866-6C22DF92346A}).
   ```
