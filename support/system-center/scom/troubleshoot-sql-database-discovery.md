---
title: Troubleshoot SQL Server database discovery
description: Describes how to diagnose and fix SQL Server database discovery issue in System Center 2012 Operations Manager and later versions.
ms.date: 04/15/2024
---
# Troubleshoot SQL Server database discovery in Operations Manager

This guide helps administrators diagnose and fix SQL Server database discovery issue in System Center 2012 Operations Manager and later versions.

By using the SQL Server 2012 database discovery in System Center 2012 Operations Manager as the example, we'll take you through a series of troubleshooting steps that help you understand and fix discovery issues.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 4089249

## Before you start

Before you start troubleshooting, it's important to check the following:

1. What is the name and class of the object that needs to be discovered?

    For SQL Server database discovery, the SQL Server database class is specific to the version of SQL Server that hosts the database. If you use SQL Server 2012, the name is SQL Server 2012 DB.

2. Is the appropriate Monitoring Agent installed?

    If the agent isn't installed, follow [Install Agent on Windows Using the Discovery Wizard](/system-center/scom/manage-deploy-windows-agent-console) to install the agent.

3. Is proxy enabled on the agent?

    You must [enable agent proxy](/powershell/module/OperationsManager/Enable-SCOMAgentProxy) for SQL Server database discovery.

4. Is the latest version of SQL Server management pack installed?

    Most objects are version specific, for example, the management pack for SQL Server 2012 may not work on a SQL Server 2012 R2 instance. Additionally, the latest version of the management pack contains fixes for known issues in earlier versions. Installing the latest version sometimes fixes the SQL Server database discovery issue.

## Check the target of the discovery rule

The target of SQL Server DB discovery rule must be discovered before the discovery rule runs. In our example, the target of SQL Server 2012 DB discovery rule is SQL Server 2012 DB Engine.

### Determine the target of the SQL Server 2012 DB discovery rule

1. In the Operations Manager console, go to **Authoring** > **Management Pack Objects** > **Object Discoveries**.
2. Click **Scope**, select **View all Targets**, and then click **Clear all**.
3. Input **SQL Server 2012 DB** in **Look for**, check **SQL Server 2012 DB**, and then click **OK**.

    :::image type="content" source="media/troubleshoot-sql-database-discovery/search-target.png" alt-text="Search target in the Scope Management Pack Objects dialog box." border="false":::

4. Locate the target of returned discovery rule (the **Target** column), in our example, the target is **SQL Server 2012 DB Engine**.

    :::image type="content" source="media/troubleshoot-sql-database-discovery/target-rule.png" alt-text="Locate the Target column of the returned discovery rule.":::

### Determine if the target object is discovered

1. In the Operations Manager console, go to **Monitoring** > **Discovered Inventory**.
2. Click **Change Target Type...** in the **Tasks** pane.
3. Select **View all target**, input **SQL Server 2012 DB Engine** in **Look for**.
4. Select **SQL Server 2012 DB Engine**, and then click **OK**.

    :::image type="content" source="media/troubleshoot-sql-database-discovery/find-target.png" alt-text="Look for and view all targets in the Select Items to Target dialog box.":::

5. In **Discovered Inventory**, look for the name of the SQL Server or the name of the cluster that hosts the database. If you can't find any of them, you need to troubleshoot the DB Engine discovery rule.

## Check the health state of Windows agent

If the Windows agent shows a gray state, follow [Troubleshoot gray agent states in System Center Operations Manager](troubleshoot-gray-agent-states.md) to fix the issue.

## Check if the discovery is overridden

To do this, follow these steps:

1. In the Operations Manager console, go to **Authoring** > **Management Pack Objects** > **Object Discoveries**.
2. Click **Scope**, select **View all targets**, and then click **Clear All** if it isn't greyed out.
3. Check the **SQL Server 2012 DB** checkbox in **Look for**, and then click **OK**.
4. Right-click **Discover Databases for a Database Engine**, and then select **Choose Overrides** > **Summary** > **For the Object Discovery**.
5. Review any overrides that may affect the discovery rule.

    :::image type="content" source="media/troubleshoot-sql-database-discovery/overrides-summary.png" alt-text="Review any overrides that may affect the discovery rule in the Overrides Summary." border="false":::
  
## Check the Run As account that's running the discovery

The SQL Server 2012 DB discovery uses the **SQL Server Discovery Account** Run As profile. To check whether the Run As account is associated with this profile, follow these steps:

1. In the Operations Manager console, go to **Administration** > **Run As Configuration** > **Profiles**, and then open the properties of the **SQL Server Discovery Account** profile.
2. Move to the **Run As Accounts** page.

   :::image type="content" source="media/troubleshoot-sql-database-discovery/run-as-accounts.png" alt-text="The Run As accounts that are listed in the Run As accounts page." border="false":::

   If a Run As account is listed in this page, it's the account that's used to run the discovery. If nothing is listed, the default Run As account on the server is used to run the discovery. To find the default Run As account on the server, follow these steps:
  
   1. In the Operations Manager console, go to **Administration** > **Run As Configuration** > **Profiles**, and then open the properties of the Default Action Account profile.
   2. Move to the **Run As Accounts** page, locate the server name in the **Path** column, and then note the corresponding account in the **Account Name** column.

      :::image type="content" source="media/troubleshoot-sql-database-discovery/default-action-account.png" alt-text="Locate the Path column and the account name column." border="false":::

      > [!NOTE]
      > This account is usually the Local System Action Account, sometimes it may be a user account.

Make sure that the Run As account has the required SQL Server permissions. For necessary permissions, check the SQL Server management pack guide.

## Examine the Operations Manager event log on the agent for errors

Look for the following events and errors:

- Events that reference the discovery rule workflow. The discovery name is **Discover Databases for a Database Engine**, and the workflow name is **Microsoft.SQLServer.2012.DatabaseDiscoveryRule**.
- Errors that are related to the Run As account. These errors may occur after the Health Service restarts.
- Errors that are related to the DiscoverSQL2012DB.vbs script. Here are some examples:
  
  - Event 21405

    > Log Name:      Operations Manager  
    > Source:        Health Service Modules  
    > Date:          \<Date Time>  
    > Event ID:      21405  
    > Task Category: None  
    > Level:         Warning  
    > Keywords:      Classic  
    > User:          N/A  
    > Computer:      ContosoSQL  
    > Description:  
    > The process started at \<Time> failed to create System.Discovery.Data, no errors detected in the output.  The process exited with 4294967295
    >
    > Command executed: "C:\Windows\system32\cscript.exe" /nologo "DiscoverSQL2012DB.vbs" {GUID1} {GUID2} 7103 ContosoSQLContosoSQL  ContosoSQL\MSSQLSERVER MSSQLSERVER  "Exclude:" 60005, 1433  
    > Working Directory: C:\Program Files\System Center Operations Manager\Agent\Health Service State\Monitoring Host Temporary Files 47\13948\  
    > One or more workflows were affected by this.
    >
    > Workflow name: Microsoft.SQLServer.2012.DatabaseDiscoveryRule  
    > Instance name: sql_instance1  
    > Instance ID: {GUID2}  
    > Management group: management_group

    To fix this issue, change the port number in the SQL Server instance from *60005, 1433* to *60005,1433*. The additional space causes the command line to pass incorrect variables.
  
  - Event 7103

    > Log Name:      Operations Manager  
    > Source:        Health Service Script  
    > Event ID:      7103  
    > Task Category: None  
    > Level:         Error  
    > Keywords:      Classic  
    > User:          N/A  
    > Computer:      SQL.CONTOSO.com  
    > Description:  
    > Management Group: CONTOSO_OM. Script: DiscoverSQL2012DB.vbs. Instance: MSSQLSERVER: SQL Database discovery script 'DiscoverSQL2012DB.vbs' for instance 'MSSQLSERVER'  failed.

    To fix this issue, make sure that the Run As account has required permissions. For necessary permissions, check the SQL Server management pack guide.

## Enable verbose ETL tracing

1. Enable verbose ETL tracing, and then override the discovery rule to force it to run more frequently on the problematic agent.

2. Review TracingGUIDSNative.log and TracingGUIDSScript.log for events that are associated with the discovery. Look for events that reference the **DiscoverSQL2012DB.vbs** script or the **Microsoft.SQLServer.2012.DatabaseDiscoveryRule** workflow.

3. For script-based discovery, the TracingGUIDSScript.log also contains the parameters that are used to start the script. Check whether the discovery data (in XML format) is returned.

### Sample discovery data

```xml
<DataItem type="System.DiscoveryData" time="2017-05-10T17:23:25.8370063-04:00" sourceHealthServiceId="D5E3AD1A-589F-DDE5-B4AE-18D955BE5408">
    <DiscoveryType>0</DiscoveryType>
    <DiscoverySourceType>0</DiscoverySourceType>
    <DiscoverySourceObjectId>{21A3C28F-B3CB-59A1-54C4-73232A9BA7EE}</DiscoverySourceObjectId>
    <DiscoverySourceManagedEntity>{26B3B2EF-806B-6EA4-35DD-E669C83E36C8}</DiscoverySourceManagedEntity>
    <ClassInstances>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>CONTOSO\Administrator</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>OperationsManager</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>CONTOSO\Administrator</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>OperationsManagerAC</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>sa</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>master</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>CONTOSO\Administrator</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>Latin1_General_CI_AS_KS_WS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>FULL</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>ReportServer</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>sa</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>msdb</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>sa</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>True</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>tempdb</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>sa</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>FULL</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>model</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>CONTOSO\Administrator</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>Latin1_General_CI_AS_KS_WS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>ReportServerTempDB</Value>
                </Setting>
            </Settings>
        </ClassInstance>
        <ClassInstance TypeId="{A7E5C5ED-6C02-3C7A-A608-0A3F93BF8E62}">
            <Settings>
                <Setting>
                    <Name>{0F700489-D513-FC14-2FE1-B514BC789F42}</Name>
                    <Value>MSSQLSERVER</Value>
                </Setting>
                <Setting>
                    <Name>{4FA240D2-044B-43EB-2A29-2BB59529FE9A}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{5C324096-D928-76DB-E9E7-E629DCC261B1}</Name>
                    <Value>MS-SQL.contoso.com</Value>
                </Setting>
                <Setting>
                    <Name>{625728CF-4AA8-7C0C-CBD4-AE75DF10A924}</Name>
                    <Value>MULTI_USER</Value>
                </Setting>
                <Setting>
                    <Name>{7DA12F00-1EAB-64EE-5283-49786282143B}</Name>
                    <Value>READ_WRITE</Value>
                </Setting>
                <Setting>
                    <Name>{830426A5-00D9-62AC-5869-B47179C55712}</Name>
                    <Value>CONTOSO\Administrator</Value>
                </Setting>
                <Setting>
                    <Name>{864E42E9-9E24-E2B9-3FD0-ECD5C4A56E8B}</Name>
                    <Value>SQL_Latin1_General_CP1_CI_AS</Value>
                </Setting>
                <Setting>
                    <Name>{87FB4803-BD4E-A6B8-0EDB-8F1E7E518272}</Name>
                    <Value>False</Value>
                </Setting>
                <Setting>
                    <Name>{925403A3-BD88-4DF5-B4D2-E514425E22A9}</Name>
                    <Value>SIMPLE</Value>
                </Setting>
                <Setting>
                    <Name>{C815DA4F-5C36-40EE-E39A-DE3532CCDF3E}</Name>
                    <Value>OperationsManagerDW</Value>
                </Setting>
            </Settings>
        </ClassInstance>
    </ClassInstances>
</DataItem>
```

### Export the discovery script and run it manually

If no discovery data is returned, the reason may be that returned data is too large. Operations Manager discoveries have a size limit of 4 MB, if the data item is larger than 4 MB, it's dropped without any warning.

In this case, following these steps:

1. Export the script from the Management Pack
  
    1. Export the Management Pack from Operations Manager by running the following command from an Operations Manager Shell instance:

        ```powershell
        get-scommanagementpack -Name Microsoft.SQLServer.2012.Discovery | Export-SCOMManagementPack -path c:\temp
        ```

        > [!NOTE]
        > Make sure that you specify a valid path. Don't include the management pack name in the path.

    2. Locate the Microsoft.SQLServer.2012.Discovery.xml file in the c:\temp folder, and then open it in Notepad or an XML editor.

    3. Search for `<ScriptName>DiscoverSQL2012DB.vbs</ScriptName>`, copy the content of the \<ScriptBody> element, and then paste it to a new text file.

        :::image type="content" source="media/troubleshoot-sql-database-discovery/script-body.png" alt-text="Screenshot of the ScriptBody line that you need to copy and paste to a new text file.":::

    4. Remove the start tag \<ScriptBody> and the end tag \</ScriptBody>.
    5. Find and replace the following characters in the file:
  
        Replace **\&lt;** with **<**  
        Replace **\&gt;** with **>**  
        Replace **\&amp;** with **&**  

    6. Save the new file as *DiscoverSQL2012DB.vbs*.

2. Manually run the script
  
    1. Look for a line that's similar to the following in TracingGUIDSScript.log:

        > "C:\Windows\system32\cscript.exe" /nologo "DiscoverSQL2012DB.vbs" {21A3C28F-B3CB-59A1-54C4-73232A9BA7EE} {26B3B2EF-806B-6EA4-35DD-E669C83E36C8} 7103 MS-SQL.contoso.com MS-SQL.contoso.com  MS-SQL MSSQLSERVER "Exclude:" "1433"

        > [!NOTE]
        > This is the command that's used to run the DiscoverSQL2012DB.vbs script.

    2. Copy this line, and then paste it in command prompt to run the DiscoverSQL2012DB.vbs script.

### Issues that you may experience when you run the script

- No data is returned.

    This issue occurs if TCP/IP is disabled on the SQL Server instance.
  
    **Resolution**

    Open [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager), go to **SQL Server Network Configuration** > **Protocols for 'SQL_Instance'**, and then enable TCP/IP.

- An exception occurs when you run the script.

    **Resolution**

    Check whether there is a permission or WMI issue.

    To check WMI issue, follow these steps:

    1. On the SQL server, open WBEMTEST.
    2. Connect to `root\Microsoft\SqlServer\ComputerManagement11`.
    3. Run the `select * from SQLService where SQLServiceType=1` query.

        :::image type="content" source="media/troubleshoot-sql-database-discovery/sql-query.png" alt-text="Run a query to see whether you receive a WMI error or output.":::

    4. If you receive a WMI error or no output, make sure that you have a backup of the server, open an elevated command prompt, and then run the following command to repair the WMI namespace:

        ```console
        mofcomp.exe "C:\Program Files (x86)\Microsoft SQL Server\110\Shared\sqlmgmproviderxpsp2up.mof"
        ```

## Examine the discovery data for missing objects

- If the missing objects aren't included in the discovery data, there may be a permission issue or an issue with WMI.

    For example, if the Run As account doesn't have the necessary permissions, you may get an output like the following:

    > \<DataItem type="System.DiscoveryData" time="2018-01-29T14:27:53.0318929-05:00" sourceHealthServiceId="D5E3AD1A-589F-DDE5-B4AE-18D955BE5408">  
        \<DiscoveryType>0\</DiscoveryType>  
        \<DiscoverySourceType>0\</DiscoverySourceType>  
        \<DiscoverySourceObjectId>{21A3C28F-B3CB-59A1-54C4-73232A9BA7EE}\</DiscoverySourceObjectId>  
        \<DiscoverySourceManagedEntity>{26B3B2EF-806B-6EA4-35DD-E669C83E36C8}\</DiscoverySourceManagedEntity>  
    \</DataItem>

    To check WMI issue, follow these steps:

    1. On the SQL server, open WBEMTEST.
    2. Connect to `root\Microsoft\SqlServer\ComputerManagement11`.
    3. Run the `select * from SQLService where SQLServiceType=1` query:

        :::image type="content" source="media/troubleshoot-sql-database-discovery/sql-query.png" alt-text="Run a query to see whether you receive a WMI error or output.":::

    4. If you receive a WMI error or no output, make sure that you have a backup of the server, open an elevated command prompt, and then run the following command to repair the WMI namespace:

        ```console
        mofcomp.exe "C:\Program Files (x86)\Microsoft SQL Server\110\Shared\sqlmgmproviderxpsp2up.mof"
        ```

- If the missing objects are included in the discovery data, review the following event logs:

  - The Operations Manager event logs

    Look for events which report that discovery data is dropped. For example, event 5000 or 4506.

    When there's too much data in the sending queue, data may be dropped. To fix this issue, increase the size of the queue on the agent.

  - The management server's event log

    Look for events which report that discovery data is dropped, or reference SQL Server performance issues which prevent timely writing data to the Operations Manager database.

## More information

For more information about System Center Operations Manager, post a question in our forum [here](https://social.technet.microsoft.com/Forums/systemcenter/en/home?category=systemcenteroperationsmanager).

For all the latest news, information and tech tips, visit [System Center Blog](https://techcommunity.microsoft.com/t5/system-center-blog/bg-p/SystemCenterBlog).
