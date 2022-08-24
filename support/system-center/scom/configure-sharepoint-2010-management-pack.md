---
title: Configure SharePoint 2010 management pack
description: Describes the steps to troubleshoot or configure the SharePoint 2010 management pack for System Center Operations Manager in some scenarios.
ms.date: 06/23/2020
ms.reviewer: edpaca, erinwi, adoyle
---
# Configure the SharePoint 2010 management pack for System Center Operations Manager

This article describes how to troubleshoot or configure the SharePoint 2010 management pack (MP) for System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2690744

## No access to SharePoint Foundation 2010 and SharePoint Server 2010 databases

### Symptoms

- Computers are populated in the **Unidentified Machines** view in the Operations Manager console under **Monitoring** > **SharePoint 2010 Products** > **Unidentified Machines**.
- Several views in the console under **Monitoring** > **SharePoint 2010 Products** are blank or **Not Monitored**, these views include:

  - Administration - Not Monitored
  - Content Databases - Blank
  - Diagram View - Not Monitored
  - Events - Blank
  - Farms - Blank
  - Performance - Blank
  - Servers - Blank
  - Service Front Ends - Blank
  - Services - Blank
  - Shared Services - Blank
  - SPHA Rules - Blank
  - Web Applications - Blank

### Resolution

Set the proper permissions on the SharePoint Foundation and SharePoint Server 2010 databases. Enable debug tracing to determine where errors may occur.

#### Required permissions

The required permissions for the configured Run As account on an individual SharePoint farm are:

- Local admin on all SharePoint 2010 front-end and application servers
- Local admin on all SQL Server machines that host SharePoint 2010 databases
- Full farm administrator rights within SharePoint 2010
- Database owner (dbo) for all SharePoint databases

> [!NOTE]
> All SharePoint Foundation 2010 and SharePoint Server 2010 databases created during initial setup require the above permissions.

Below is a list of some of the databases in SharePoint Foundation 2010 and SharePoint Server 2010, which require dbo permissions. This is not a complete list as it depends on your specific configuration.

- Application_Registry_Service
- Bdc_Service_DB
- Managed Metadata Service
- PerformancePoint Service Application
- Search_Service_CrawlStoreDB
- Search_Service_DB
- Search_Service_Application_PropertyStoreDB
- Secure_Store_Service_DB
- SharePoint_Config
- SharePoint_AdminContent
- StateService
- User Profile Services Application_ProfileDB
- User Profile Services Application_SocialDB
- User Profile Services Application_SyncDB
- User Profile Services Application_ReportingDB
- User Profile Services Application_StagingDB
- WebAnalyticsServiceApplication_ReportingDB
- WebAnalyticsServiceApplication_StagingDB
- WordAutomationServices
- WSS_Content
- WSS_Logging

> [!NOTE]
> The initial installation account for SharePoint 2010 Foundation and SharePoint 2010 Server already has the necessary permissions required in all databases created during initial installation. It is recommended that you use this installation account to configure the SharePoint Foundation 2010 and SharePoint Server 2010 management packs. If requirements for security call for the creation of a new account for the management pack administration and discovery, take into account that you will have to duplicate the same permissions already granted to the SharePoint installation account.

To grant a new account full farm administrator rights:

1. Open SharePoint 2010 Central Administration.
2. On the left panel, select **Security**.
3. In the middle pane right below **Users**, select **Manage the Farm Administrators Group**.
4. If the account you initially installed SharePoint is not already there. Then add SharePoint Run As account to the group.
5. Add the Operations Manager SharePoint account. To do this, in the top-left corner, select drop down arrow next to **New** and choose **Add Users**.
6. Select the small book icon (browse).
7. Type in the name of the Operations Manager SharePoint action account.
8. Select the search icon and wait until it returns the Operations Manager SharePoint action account.
9. Select the **Add** button.
10. Select **OK**.

#### Enable debug tracing

Enabling debug tracing will enable debug trace on those agent computers that run Windows PowerShell script-based discoveries and SPHA monitors. By default it is turned off. When it's enabled, the script-based discoveries and monitors will write debug trace information to the event log in **Operations Manager** channel on all agent computers, and all the debug trace events have an event ID of **0**.

To enable debug tracing, do the following:

1. In the Operations console, select **Monitoring**.
2. Select **SharePoint 2010 Products**.
3. Select **Administration** view.
4. On the **Actions** panel, select the task named **Set DebugTrace for SharePoint Management Pack**. A **Run Task** window will pop up.
5. To enable debug trace (the default option), select **Run**. To disable debug trace, select **Override**.
6. Set the **Enabled** parameter value to **False** in the popup dialog.
7. Select **Override** to close the dialog.
8. Select **Run**.
9. Wait for the task to finish in **Task Status** window, and then check the **Task Output** to ensure that the task completes successfully.
10. Select **Close**.

#### How to use debug tracing

Run the **Set DebugTrace For SharePoint Management Pack** task, rerun the Admin task, and then go to Operations Manager event logs on the server and check events with **ID = 0**. Look for the timestamp in the event log and then check the SharePoint ULS trace log to ensure that it is the case. For more information about the ULS trace log, see [Overview of Unified Logging System (ULS) Logging](/previous-versions/office/developer/sharepoint-2010/ff512738(v=office.14)).

#### Configure the More Secure option

The **More Secure** option will deliver the configured credentials only to the machines specified in this section. The credentials sent will be for the purpose of discovering and monitoring the SharePoint farms specified. The machines in this list should be the same machines specified in the SharePointMP.config file. The requirement is to have all distributed application components listed for each individual farm. This would include front-end server and SQL Servers that host the SharePoint databases or any component thereof.

To configure the **More Secure** option, do the following:

Option 1: Create and configure the Run As account

1. Open the Operations Manager console.
2. Go to the **Administration** tab.
3. Expand the **Security** node.
4. Right-click **Run As Accounts**.
5. Select **Create Run As Account** and select **Next**.
6. Set the **Run As Account Type** as **Windows**, give it a **Display Name** and select **Next**.
7. Enter the credentials for the Active Directory domain user account and select **Next**.
8. Select **More Secure** option and add all of the servers that are part of the SharePoint farm. This will include all SharePoint front-end, application, and SQL Servers for that SharePoint farm.
9. Select **Create**.

Option 2: Configure an already existing account

1. Open the Operations Manager console and navigate to the **Administration** tab.
2. Expand the **Run As Configuration** node and highlight **Accounts**.
3. In the middle panel, open an existing Run As account from the middle pane under **Type: Windows**, right-click the account and choose **Properties**.
4. Select the **Distribution** tab.
5. Select **More Secure** option and add all of the servers that are part of the SharePoint farm. This will include all SharePoint front-end, application, and SQL Servers for that SharePoint farm.
6. Select **OK**.

> [!NOTE]
> Distribution of Security ensures that all the servers that are part of the SharePoint farm are selected and included here. We recommend having one set of Operations Manager servers monitor only one SharePoint farm. We do not recommend having multi-homed agent computer (SharePoint servers that are monitored in multiple Operations Manager management groups).

## Configure the Run As account association

### Symptoms

- Several views in the Console under **Monitoring** > **SharePoint 2010 Products** are blank or **Not Monitored**, these views include:

  - Administration - Not monitored
  - Content Databases - Blank
  - Diagram View - Not monitored
  - Events - Blank
  - Farms - Blank
  - Performance - Blank
  - Servers - Blank
  - Service Front Ends - Blank
  - Services - Blank
  - Shared Services - Blank
  - SPHA Rules - Blank
  - Web Applications - Blank

- The following error message can be seen when the Run As account association isn't configured properly due to syntax.

    Example:

    > The Event Policy for the process started at *DateTime* has detected errors in the output. The 'StdErr' policy expression:  
    > .+  
    > matched the following output:  
    > Account OpsMgr SharePoint Action Account doesn't exist  
    > Failed to find RunAs account OpsMgr SharePoint Action Account  
    > Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile  -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"C:\Program Files\System Center Operations Manager 2007\Health Service State\Monitoring Host Temporary Files 32\9687\AdminTask.ps1"' 'SharePointMP.Config'"  
    > Working Directory: C:\Program Files\System Center Management Packs\  
    > One or more workflows were affected by this.  
    > Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
    > Instance name: Microsoft SharePoint 2010 Farm Group  
    > Instance ID: {*InstanceID*}  
    > Management group: *ManagementGroup*  
    > Error Code: -2130771918 (Unknown error (0x80ff0032))

- Machines that don't have SharePoint Foundation 2010 or SharePoint Server 2010 installed are discovered as SharePoint 2010 Servers.

### Resolution

Configure the Run As account association, configure the machine name association, and [configure the More Secure option](#configure-the-more-secure-option).

#### Configure the Run As account association

The Run As account needs to be associated within the SharePoint management pack config file. If not configured correctly, you will not be able to discover the SharePoint Servers.

To configure the SharePointMP.config file:

1. Locate the SharePointMP.config file in the management pack folder.
2. Right-click the SharePointMP.config file and choose **Edit**.
3. Locate the section as shown below.

    Example:

    \<Association Account="SharePoint Discovery/Monitoring Account" Type="Agent">

4. Change this section to reflect the **Display Name** of the Run As account you have previously configured as the Run As account for the SharePoint farm.

    Now this section should look like this:

    > \<Association Account="SPAdmin" Type="Agent">

    or

    > \<Association Account="contoso\SPAdmin" Type="Agent">

    > [!NOTE]
    > Don't confuse this with the actual Active Directory domain user account.

#### Configure the machine name association

Configure the machine name of all the servers that are part of the SharePoint farm and match the **More Secure** section of the Run As account used for the SharePoint 2010 farm.

> [!NOTE]
> To confirm this name, run a `hostname` command from a command prompt on the servers either locally or remotely for each computer that is part of the farm.

To configure the SharePointMP.config file:

1. Locate the SharePointMP.config file in the management pack folder.
2. Right-click the SharePointMP.config file and choose **Edit**.
3. Find the section as shown below.

    Example:

    > \<Machine Name="" />
    >
    > \<Machine Name="" />
    >
    > \</Association>

4. Change this section to include the SharePoint Server names, for example:

    > \<Machine Name="SRV1" />
    >
    > \<Machine Name="SRV2" />
    >
    > \</Association>

#### Confirm the Run As account has been configured

1. Open the Operations Manager event log.
2. Look for event ID 7026, and open this event. This event should indicate that the Run As account for the SharePoint management pack has successfully logged on.

An event ID 7000 in the Operations Manager event log indicates that the Run As account for the SharePoint management pack has failed to log on.

> Log Name: Operations Manager  
> Source: HealthService  
> Date:  
> Event ID: 7000  
> Task Category: Health Service  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> The Health Service could not log on the RunAs account contoso\spadmin for management group \<MGName>. The error is Logon failure: unknown user name or bad password.(1326L). This will prevent the health service from monitoring or performing actions using this RunAs account

Additionally you may also see these events:

> Log Name: Operations Manager  
> Source: HealthService  
> Date:  
> Event ID: 7021  
> Task Category: Health Service  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> The Health Service was unable to validate any user accounts in management group \<MGName>.

> Log Name: Operations Manager  
> Source: HealthService  
> Date:  
> Event ID: 7015  
> Task Category: Health Service  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<ComputerName>  
> Description:  
> The Health Service cannot verify the future validity of the RunAs account contoso\spadmin for management group \<MGName>. The error is Logon failure: unknown user name or bad password.(1326L).

## Unable to monitor multiple farms in local domain or remote domains

### Symptoms

Only one server farm is discovered as seen from the **Monitoring** > **SharePoint 2010 Products** > **Farms state view**. Servers for other farms show up in the **Monitoring** > **SharePoint 2010 Products** > **Unidentified Machines state view**.

### Resolution

Configure SharePointMP.config to discover more than one servers farm.

Make sure that each individual SharePoint farm Run As account has the [required permissions](#required-permissions).

Configure [the More Secure option](#configure-the-more-secure-option).

Example scenario: You have three farms residing in two different domains.

- Contoso - SharePoint farm administrator 1 is associated with the farm administrator account for the first SharePoint farm in *contoso.com* domain and uses the domain account *SPADMIN1*

- Contoso - SharePoint farm administrator 2 is associated with the farm administrator account for the second SharePoint farm in *contoso.com* domain and uses the domain account *SPADMIN2*

- Fabrikam - SharePoint 2010 farm administrator is associated with the farm administrator account for the third SharePoint farm in *fabrikam.com* domain and uses the domain account *FKSPADMIN*

> [!NOTE]
> For the remote domain *Fabrikam.com*, it's assumed that you have a reliable link using an Operations Management gateway server or a two way full trust for the domains.

Use the display name of the Run As account in the **Administration** > **Run As Configuration** > **Accounts** > **Type: Windows**.

To configure the SharePointMP.config file:

1. Locate the SharePointMP.config file in the management pack folder.
2. Right-click the SharePointMP.config file and choose **Edit**.
3. Find the **Association** and **Machine Name** sections in the SharePointMP.config file as shown in the example below.
  
    > \<Association Account="SharePoint Discovery/Monitoring Account" Type="Agent">  
    > \<Machine Name="" />  
    > \</Association>

4. Change the **Association** and **Machine Name** section to read as followed in this example:

    > \<Association Account="Contoso - SharePoint Farm Administrator 1" Type="Agent"> \<Machine Name="Contoso1" /> \<Machine Name="Contoso2" /> \<Machine Name="Contoso3" /> \<Machine Name="Contoso4" /> \<Machine Name="Contoso5" /> \<Machine Name="Contoso6" /> \</Association>  
    > \<Association Account="Contoso - SharePoint Farm Administrator 2" Type="Agent"> \<Machine Name="Constosrv1" /> \<Machine Name="Constosrv2" /> \<Machine Name="Constosrv3" /> \</Association>  
    > \<Association Account="Fabrikam - SharePoint 2010 Farm Administrator" Type="Agent"> \<Machine Name="Fabrikam1" /> \<Machine Name="Fabrikam2" /> \<Machine Name=" Fabrikam3" /> \</Association>

Confirm [the Run As account has been configured](#confirm-the-run-as-account-has-been-configured).

## Unable to run the configuration task

### Symptoms

You are unable to run configuration task, and the following error(s) are generated:

Example 1

> Exception calling ".ctor" with "1" argument(s): "The user Contoso\SPAdmin does not have sufficient permission to perform the operation."  
> Failed to connect to local management group  
> Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"C:\Program Files\System Center Operations Manager 2007\Health Service  State\Monitoring Host Temporary Files 49\5037\AdminTask.ps1"' 'SharePointMP.Config'"  
> Working Directory: C:\Program Files\System Center Management Packs\  
> One or more workflows were affected by this.  
> Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
> Instance name: Microsoft SharePoint 2010 Farm Group  
> Instance ID: {*InstanceID*}  
> Management group: {*ManagementGroup*}  
> Error Code: -2130771918 (Unknown error (0x80ff0032)).

Example 2

> The Event Policy for the process started at 10:44:13 PM has detected errors in the output. The 'StdErr' policy expression:  
> .+  
> matched the following output:  
> Account OpsMgr SharePoint Action Account doesn't exist  
> Failed to find RunAs account OpsMgr SharePoint Action Account  
> Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"C:\Program Files\System Center Operations Manager 2007\Health Service  State\Monitoring Host Temporary Files 32\9687\AdminTask.ps1"' 'SharePointMP.Config'"  
> Working Directory: C:\Program Files\System Center Management Packs\  
> One or more workflows were affected by this.  
> Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
> Instance name: Microsoft SharePoint 2010 Farm Group  
> Instance ID: {*InstanceID*}  
> Management group: {*ManagementGroup*}  
> Error Code: -2130771918 (Unknown error (0x80ff0032)).

### Resolution

Add the Operations Manager Administrator role to the Run As account.

To add the Run As account being used to execute the task:

1. Open the Operations console.
2. Navigate to **Administration**.
3. Select **Security**.
4. Select **User Roles**.
5. Select **Operations Manager Administrators**.
6. Add the account running the task as part of the Operations Manager Administrators role.

#### Configure SharePoint Management Pack task

The admin task configures the management pack by ensuring the existence of an override management pack, associating Run As account(s) to servers, enabling proxy settings, and initiating discoveries.

To run the **Configure SharePoint Management Pack** task, follow these steps:

1. Open the Operations Manager console.
2. Select the **Monitoring** tab of the console.
3. Expand the **SharePoint 2010 Products view**.
4. Select the **Administration state view**.
5. On the **Actions** pane, under **Microsoft SharePoint 2010 Farm Group Tasks**, select the **Configure SharePoint Management Pack**.
6. Select the appropriate task credentials (preferably the SharePoint admin Run As account you have previously set up.)
7. Select **Run** and wait for the task to finish successfully.
8. Select **Close**.

Example of successful task:

> Status:Success  
> Scheduled Time:  
> Start Time:  
> Submitted By:CONTOSO\SPADMIN  
> Run As:  
> Run Location:  
> Target:  
> Target Type:Microsoft SharePoint 2010 Farm Group  
> Category:Operations  
> Task Output:
>
> Output  
> Load configuration file SharePointMP.Config  
> Configure Microsoft.SharePoint.Foundation.2010 version 14.0.4744.1000  
> Found override management pack Microsoft.SharePoint.Foundation.2010.Override version 1.0.0.0  
> Change 'SyncTime' configuration override to 20:06 for Microsoft.SharePoint.Foundation.2010.WSSInstallation.Discovery  
> Microsoft.SharePoint.Foundation.2010.WSSInstallation.Discovery does not have configuration TimeoutSeconds  
> Change 'SyncTime' configuration override to 20:08 for Microsoft.SharePoint.Foundation.2010.SPFarm.Discovery  
> Change 'SyncTime' configuration override to 20:14 for Microsoft.SharePoint.Foundation.2010.SPService.Discovery  
> Change 'SyncTime' configuration override to 20:20 for Microsoft.SharePoint.Foundation.2010.SPSharedService.Discovery  
> Change 'SyncTime' configuration override to 20:26 for Microsoft.SharePoint.Foundation.2010.SPHARule.Discovery  
> Change 'SyncTime' configuration override to 20:32 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.Availability  
> Change 'SyncTime' configuration override to 20:32 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.Security  
> Change 'SyncTime' configuration override to 20:32 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.Performance  
> Change 'SyncTime' configuration override to 20:32 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.Configuration  
> Change 'SyncTime' configuration override to 20:32 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.Custom  
> Change 'SyncTime' configuration override to 20:38 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.SPServer.Availability  
> Change 'SyncTime' configuration override to 20:38 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.SPServer.Security  
> Change 'SyncTime' configuration override to 20:38 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.SPServer.Performance  
> Change 'SyncTime' configuration override to 20:38 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.SPServer.Configuration  
> Change 'SyncTime' configuration override to 20:38 for Microsoft.SharePoint.Foundation.2010.SPHARuleMonitor.SPServer.Custom  
> SharePoint management pack configuration completed successfully
>
> Error  
> None
>
> Exit Code: 0

## Unable to run the Configure SharePoint Management Pack task in System Center 2012 Operations Manager

### Symptoms

This error message is generated:

> The Event Policy for the process started at 6:51:29 PM has detected errors in the output. The 'StdErr' policy expression:  
> .+  
> matched the following output:  
> Exception calling "ImportManagementPack" with "1" argument(s): "This method from the System Center Operations Manager 2007  
> R2 SDK is not supported to work with System Center Operations Manager 2012. Please migrate to the System Center Operations Manager 2012 SDK."  
> Failed to create override management pack Microsoft.SharePoint.Foundation.2010.Override  
> Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"E:\Program Files\System Center 2012\Operations Manager\Server\Health Service  State\Monitoring Host Temporary Files 11\7481\AdminTask.ps1"' 'SharePointMP.Config'"  
> Working Directory: C:\Program Files\System Center Management Packs\  
> One or more workflows were affected by this.  
> Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
> Instance name: Microsoft SharePoint 2010 Farm Group  
> Instance ID: {*InstanceID*}  
> Management group: {*ManagementGroup*}  
> Error Code: -2130771918 (Unknown error (0x80ff0032)).

### Resolution

Download the updated version of the management pack compatible with the System Center Operations Manager 2012 SDK from [System Center 2012 Monitoring Pack for SharePoint 2010](https://download.microsoft.com/download/6/2/E/62EA8E44-4C18-4488-8C1F-063DFC63ED1B/Microsoft.SharePoint.2010.SCOM2012.msi).

## Unable to monitor SharePoint 2010 databases

### Symptoms

- Critical alerts are generated in the active alerts view under **Monitoring** > **SharePoint 2010 Products** > **Active Alerts**.

  > SharePoint: Database Connection Failed Alert Description
  >
  > Source: Configuration Database A critical incident has occurred where the connection to database Data Source=sp2010srv2;Initial Catalog=SharePoint_Config;Integrated Security=True;Enlist=False;Connect Timeout=15 failed.  
  Path: Configuration Database  
  Alert Monitor: SQL Database Connection Failed  
  Created:
  >
  > Alert Context:  
  Date and Time  
  HRESULT -2147217805  
  Result Data Source could not be initialized  
  Error Message Format of the initialization string does not conform to the OLE DB specification.  
  Initialization Time 23  
  Open Time 0  
  Execution Time 0  
  Fetch Time 0  
  Result Set Input Data Item  

- The **SQL Database Connection Failed** monitors are showing critical under the following views:

  **Monitoring** > **SharePoint 2010 Products** >

  - Configuration Databases  
  - Content Databases  
  - Shared Services  
  - Diagram View  

### Resolution

Create a new override for the connection string value on the **SQL Database Connection Failed** monitors.

To create the override needed, do the following:

1. From the **Monitoring** > **SharePoint 2010 Products** > **Active Alerts view**, select an affected monitor.

2. Under the **Alert Details** (bottom pane), take notice of the **Alert Description**. It should look like this:

    Example:

    > Alert Description  
    > A critical incident has occurred where the connection to database Data Source=sp2010srv2;Initial Catalog=SharePoint_Config;Integrated Security=True;Enlist=False;Connect Timeout=15 failed

3. Copy and paste the text to a text editor such as Notepad.

4. Right-click the monitor once again and select **View** or edit the settings of this monitor.

5. In the **SQL database Connection Failed Properties** windows, select the **Overrides** tab and select the **Override** button.

6. Select the **For a specific object of class: XXX** option.

    Example:

    For a specific object of class: SharePoint Configuration Database

7. In **Select Object** under matching objects, select the appropriate matching object and select **OK**.

    Example:

    Configuration Database

8. Override `ConnectionString` parameter value from

    Example:

    `Provider=SQLOLEDB;$Target/Property[Type="Microsoft.SharePoint.Foundation.2010.SPDatabase"]/ConnectionString$`

    To

    `Provider=SQLOLEDB;Data Source=SP2010srv2;Initial Catalog=SharePoint_Config;Integrated Security=SSPI;Enlist=False;Connect Timeout=15`

9. Create a new override management pack or save to an existing override management pack and save the changes by selecting **OK**.

> [!NOTE]
> Since each individual database needs its own unique database string that corresponds to its database name (**Initial Catalog**), you will need to modify the previously copied connection string, the alert description of the monitor, and change **Integrated Security** from **True**.

Examples:

> Data Source=sp2010srv2;Initial Catalog=SharePoint_Config;Integrated Security=SSPI;Enlist=False;Connect Timeout=15

> Data Source=sp2010srv2;Initial Catalog=SharePoint_AdminContent_0ada3e0b-a0f6-4af5-a311-34bcedb1c4eb;Integrated Security=True;Enlist=False;Connect Timeout=15

> Data Source=sp2010srv2;Initial Catalog=WSS_Content;Integrated Security=SSPI;Enlist=False;Connect Timeout=15

> Data Source=sp2010srv2;Initial Catalog=Bdc_Service_DB_17ab85413d424b84ac58ea247e7f5b47;Integrated Security=SSPI;Enlist=False;Connect Timeout=15

> Data Source=sp2010srv2;Initial Catalog=Search_Service_Application_CrawlStoreDB_04e2a4bcdb974275954c0ab090d8a0aa;Integrated Security=SSPI;Enlist=False;Connect Timeout=15

## Sync time overrides

We recommend using the defaults values in place for sync time. If the default values are not appropriate for your environment, take special considerations on the performance impact as this may cause by changing these values.

`SyncTime` overrides are useful during failed discovery troubleshooting. By overriding the default values, you can configure the start time of different workflows and isolate discovery problems.

`SyncTime` (start time) is a property of discoveries and monitors. `SyncTime` is a string value in the format of HH:mm. `SyncTime`, `IntervalSeconds`, and Management Pack Import time together determine the exact run time of a given workflow.

The `BaseStartTime` attribute can have value in the form of HH:mm or integer. HH:mm format works as the start time alignment based on which the cycle repeats. Integer format functions as setting the alignment start time to be the current time plus that many seconds. If you set integer value, every time you rerun the admin task, the cycle start time is recalculated.

The `Length` attribute specifies the length (in seconds) of each cycle.

The `Spacing` attribute specifies the spacing time (in seconds) between one workflow's timeout time and the next workflow's start time.

For example, if `IntervalSeconds` = 21600 (6 hours) and `SyncTime` = 01:15, the possible run time of the workflow is 1:15AM, 7:15AM, 1:15PM, 7:15PM; if the management pack is imported after 1:15AM but before 7:15AM, it will start at 7:15AM, if the management pack is imported after 1:15PM but before 7:15PM, it will start at 7:15PM. However, due to other factors such as network delay the actual start time may still vary. Do not change the default `SyncTime` value unless absolutely required.

So in case you imported the MP at 03:00 PM and the Interval seconds is set to every 8 hrs.=(28,800 seconds) and you configured the sync time to be 03:00, then it will sync at 11:00 PM or 8 hours after the sync time was set up when you imported the MP.

Possible error messages when not configuring this properly are shown below:

Example 1

> The Event Policy for the process started at 6:46:08 PM has detected errors in the output. The 'StdErr' policy expression:  
.+  
matched the following output:  
Cycle length 60 is not long enough to ensure the order of workflows  
Please change cycle length to no less than 360 or decrease times, timeout values, and/or spacing  
Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"C:\Program Files\System Center Operations Manager 2007\Health Service  State\Monitoring Host Temporary Files 22\9315\AdminTask.ps1"' 'SharePointMP.Config'"  
Working Directory: C:\Program Files\System Center Management Packs\  
One or more workflows were affected by this.  
Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
Instance name: Microsoft SharePoint 2010 Farm Group  
Instance ID: {*InstanceID*}  
Management group: {*ManagementGroup*}  
Error Code: -2130771918 (Unknown error (0x80ff0032)).

Example 2

> The Event Policy for the process started at 6:42:01 PM has detected errors in the output. The 'StdErr' policy expression:  
.+  
matched the following output:  
Cycle length must be in whole minutes (times of 60)  
Length value 500 is undefined or invalid  
Command executed: "C:\Windows\system32\cmd.exe" /c powershell.exe -NoLogo -NoProfile -Noninteractive "$ep = get-executionpolicy; if ($ep -gt 'RemoteSigned') {set-executionpolicy remotesigned} & '"C:\Program Files\System Center Operations Manager 2007\Health Service  State\Monitoring Host Temporary Files 21\9314\AdminTask.ps1"' 'SharePointMP.Config'"  
Working Directory: C:\Program Files\System Center Management Packs\  
One or more workflows were affected by this.  
Workflow name: Microsoft.SharePoint.Foundation.2010.ConfigSharePoint  
Instance name: Microsoft SharePoint 2010 Farm Group  
Instance ID: {*InstanceID*}  
Management group: {*ManagementGroup*}  
Error Code: -2130771918 (Unknown error (0x80ff0032)).

## Isolate discoveries

The following example sets the run time of the discovery to run 5 minutes after running the configuration task for a single workflow that has been failing.

```xml
<WorkflowCycle BaseStartTime="+5" Length="6240" Spacing="15">
<Workflow Id="SPFarm.Discovery" Type="Discovery" Times="1" />
```

If starting this procedure at 7:35 PM, configure the override as the following example when viewed from the **Authoring** > **Management Pack Objects** > **Overrides view** in the console to start at 7:40 PM.

- **SyncTime Override Value** = 19:40  
- **Interval Seconds** = 6240

## Add workflows to SharePoint Config file

If you want to add workflows to discover both SharePoint Foundation 2010 and SharePoint 2010 products,

> Default \<WorkflowCycle BaseStartTime="+300" Length="28800" Spacing="60">  
> \<Workflow Id="WSSInstallation.Discovery" Type="Discovery" Times="1" />  
> \<Workflow Id="SPFarm.Discovery" Type="Discovery" Times="1" />  
> \<Workflow Id="SPService.Discovery" Type="Discovery" Times="4" />  
> \<Workflow Id="SPSharedService.Discovery" Type="Discovery" Times="4" />  
> \<Workflow Id="SPHARule.Discovery" Type="Discovery" Times="1" />  
> \<Workflow Id="SPHARuleMonitor.Availability;SPHARuleMonitor.Security;SPHARuleMonitor.Performance;SPHARuleMonitor.Configuration;SPHARuleMonitor.Custom" Type="Monitor" Times="8" />  
> \<Workflow Id="SPHARuleMonitor.SPServer.Availability;SPHARuleMonitor.SPServer.Security;SPHARuleMonitor.SPServer.Performance;SPHARuleMonitor.
SPServer.Configuration;SPHARuleMonitor.SPServer.Custom" Type="Monitor" Times="8" />  
> \</WorkflowCycle>

Add the following section to the SharePointMp.config file:

> \<Workflow Id="MOSSInstallation.Discovery;WACInstallation.Discovery;SearchExpressInstallation.Discovery;SearchStandardInstallation.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="1" />  
> \<Workflow Id="SPService.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />  
> \<Workflow Id="SPSharedService.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />  
> \<Workflow Id="SPSharedService.Discovery.WAC" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />

The configuration file should now look like this:

> \<WorkflowCycle BaseStartTime="+300" Length="28800" Spacing="60">  
\<Workflow Id="WSSInstallation.Discovery" Type="Discovery" Times="1" />  
\<Workflow Id="MOSSInstallation.Discovery;WACInstallation.Discovery;SearchExpressInstallation.Discovery;SearchStandardInstallation.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="1" />  
\<Workflow Id="SPFarm.Discovery" Type="Discovery" Times="1" />  
\<Workflow Id="SPService.Discovery" Type="Discovery" Times="4" />  
\<Workflow Id="SPSharedService.Discovery" Type="Discovery" Times="4" />  
\<Workflow Id="SPService.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />  
\<Workflow Id="SPSharedService.Discovery" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />  
\<Workflow Id="SPSharedService.Discovery.WAC" management pack="Microsoft.SharePoint.Server.2010" Type="Discovery" Times="4" />  
\<Workflow Id="SPHARule.Discovery" Type="Discovery" Times="1" />  
\<Workflow Id="SPHARuleMonitor.Availability;SPHARuleMonitor.Security;SPHARuleMonitor.Performance;SPHARuleMonitor.Configuration;SPHARuleMonitor.Custom" Type="Monitor" Times="8" />  
> \<Workflow Id="SPHARuleMonitor.SPServer.Availability;SPHARuleMonitor.SPServer.Security;SPHARuleMonitor.SPServer.Performance;SPHARuleMonitor.SPServer.Configuration;SPHARuleMonitor.SPServer.Custom" Type="Monitor" Times="8" />  
> \</WorkflowCycle>
