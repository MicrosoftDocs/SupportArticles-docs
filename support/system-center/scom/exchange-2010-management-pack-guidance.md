---
title: Exchange 2010 management pack guidance
description: Describes some best practice guidance along with workarounds to known issues involving the Exchange 2010 management pack running on System Center Operations Manager.
ms.date: 07/06/2020
---
# Guidance, tuning and known issues for the Exchange 2010 management pack for Operations Manager

This article is intended to give some best practice guidance along with workarounds to known issues involving the Exchange 2010 management pack running on System Center 2012 Operations Manager.

_Original product version:_ &nbsp; Exchange Server 2010 Enterprise, Exchange Server 2010 Standard, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2592561

## Summary

Look through this article before calling for support or posting to the forums as the issue may be covered below. If you find that these issues are troublesome or find additional issues that you want fixed, call into Microsoft Support and raise a request for hotfix with the Exchange group.

The Exchange 2010 management pack introduced a correlation engine, the correlation engine is a stand-alone Windows service that uses the Operations Manager Software Development Kit (SDK) interface to first retrieve the health model (or instance space) and then process state change events. By maintaining the health model in memory, and processing state change events, the correlation engine is able to determine when to raise an alert based on the state of the system.

In response to a problem, several monitors change state, and the corresponding state change events are forwarded by the agent to the root management server (RMS) emulator. Once received by the RMS emulator, they are processed by the correlation engine, which may raise an alert through the RMS emulator SDK interface. This alert is then visible on the Operations Manager console.

## Correlation factors

The actions taken by the correlation engine are determined based on the several factors.

- **Monitor state change events**

  Monitors, which watch for the specific diagnostics from Exchange such as event log messages, performance counter thresholds, and PowerShell task output events, register state change events when they detect that a problem has occurred or cleared (red to green or green to red), or as agents become unavailable or are placed in maintenance mode (and subsequently made available, and/or removed from maintenance mode).

  Typically, alert rules are configured to fire when green to red state changes occur. In the Exchange Server 2010 management pack, you'll find that this is not the case. Specifically, alerts are not automatically raised by monitor state changes. The correlation engine may determine the best alert to raise.

- **Health model**

  The class hierarchy imported into Operations Manager by the Exchange Server 2010 management pack is extensive. The class hierarchy includes class relationships that define component dependencies throughout the system. By defining these component dependencies in the object representation of the product, the Exchange Server 2010 management pack is able to better understand the health of the Exchange organization. For example, if the Exchange Server 2010 management pack identifies Active Directory as offline, it will also report that Exchange messaging is not fully functional.

- **Timing**

  The correlation engine works in 90-second intervals. When state change events for multiple monitors come in at the same time, it waits to see whether anything else potentially related to the failure is detected so that it can make the most effective determination of the root cause.

## Overview of the correlation engine process

1. First, it connects to the Operations Manager SDK service to download the Health Model hierarchy and instance state (on service startup only, or as needed if errors require it).
2. Next, it queries Operations Manager for the latest state change events related to entities in the Exchange management pack.
3. If new Non-Service Impacting (NSI) state changes are detected, it raises alerts for them.
4. Key Health Indicator (KHI) monitors are then evaluated, and chains of red KHI monitors are isolated. These chains indicate issues in which a dependency has failed and is impacting dependent processes. Recognizing these relationships is the key step.
5. Alerts are raised for the root cause monitor in the KHI chain.
6. It then waits 90 seconds, and then starts over at step 2 above.

### Additional points of interest regarding the correlation engine process

- If the chain of KHIs includes both error and warning monitors, the alert is raised as an error, regardless of the class of the root cause monitor. For example, if a top-level process defines an error monitor to catch failure cases, and if it is correlated to a warning monitor in a dependency, the alert will be raised against the dependency, but it will be marked as an error instead of a warning.

- Not every class relationship is used for alert correlation.

- The KHI chain, including any forensic monitors, is included in the **Alert Context** field available in the properties of the final alert. This allows inspection of the monitors correlated to the given alert and, if alerts firing from dependency monitors, this is required to determine the specific failure referenced by the alert.

- Monitors in maintenance mode are skipped when evaluating the health model.

## Alert correlation effects

A key point to understand about the Exchange Server 2010 management pack, and the correlation engine in particular, is what the correlation engine affects, and what it doesn't affect.

The following items are different due to the correlation engine:

- Monitors are configured not to alert automatically on state change events. This allows the correlation engine to determine the best alert to raise (as described in [Correlation factors](#correlation-factors)).

- The Exchange Server 2010 management pack doesn't raise Exchange alerts that correspond to the health of your environment when the correlation engine is stopped. If the correlation engine is stopped, a general alert is raised to notify you that the correlation engine is not running.

The following items are not different due to the presence of the correlation engine:

- Overrides still work as expected; you can change certain values or disable monitors just as you do today.

- Monitors or objects in maintenance mode are skipped by the correlation engine. No special consideration is required since the monitors don't raise state change events for consumption by the correlation engine.

- Per-monitor alert rules were added to the Exchange Server 2010 management pack. Per-monitor alert rules allow monitoring personnel to enter company-specific notes for a given alert into the **Company Knowledge** field, even when the alert rules aren't used to raise alerts for their corresponding monitors.

- Other management packs are not affected by the presence of the correlation engine.

In summary, keep in mind that it's just the **monitor state change to alert** step that's enhanced by correlation.

## Operational notes

Since the correlation engine needs to maintain the instance space of the management group in memory to determine related monitors or alerts, its memory footprint is relative to the number of instances in the management group. In plain terms, the more Exchange servers and databases you have, the more memory it will require.

In observing environments at Microsoft, the correlation engine scales roughly at about 5 megabytes per monitored Exchange server. There are factors that can drive this number up or down, but it's a good starting point toward understanding the resource impact on the server hosting the service.

As stated above, the preferred location for the service is on the RMS emulator role given the close SDK interaction and core functionality of raising alerts.

While Operations Manager is not limited to a number of managed servers, it's limited to the number of managed objects and relationships between them. Operations Manager by design is an object model based solution and any managed object defined in a management pack is tracked individually in Operations Manager. The more of these unique managed objects and any relationships for these objects, the more Operations Manager has to work at tracking the health and workflow processing for them.

The maximum number of tested objects and relationships per Operations Manager management group works out as such:

- Maximum number of managed objects: 800,000 - which is based on 10,000 Agents each with 80 instances
- Maximum number of relationships: ~1,000,000

Now these are only the maximum _tested_ numbers from the Operations Manager Development team. Operations Manager can manage more than these numbers, however Operations Manager performance starts to become impacted and monitoring may be impaired if these numbers are exceeded.

The Exchange correlation engine may not process alerting if there are too many managed objects, relationships, or groups containing a large number of objects. The noticed limits to relationships and group object members are:  

- Relationships: 600,000
- Group object members: 1,000,000  

This is a known hard limit as the correlation engine will take too long to gather this information running into a timeout that will cause the process to restart, to which it will hit a timeout and restart continuously.

The Exchange 2010 management pack creates many managed objects due to the design with the correlation engine. The trouble is that the number of managed objects and relationships in Operations Manager increase rapidly with any Exchange server added to the management group. Here are some typical managed object and relationship counts based on the server added:

- Common across all Exchange servers:

  20 managed objects  
  25 relationships

- The client access server (CAS):

  40 managed objects  
  40 relationships

- Transport:

    20 managed objects  
    30 relationships

- Unified Messaging:

    15 managed objects  
    20 relationships

- Mailbox (per database copy):

    40 managed objects  
    65 relationships

> [!NOTE]
> These are approximate numbers and every environment setup will be different.  

Using these numbers you get this many managed objects and relationships for a simple four server Exchange 2010 installation:

- Total managed objects: 340
- Total relationships: 710

Additionally, if more database copies are added to the environment, these numbers increase rather quickly even without adding any more servers. Let's say we added two more databases requiring a total of four database copies. We've now added 160 new managed objects and 260 relationships. That's almost 50% more managed objects than before and a third more relationships without adding any new servers.

Due to this kind of increase in the management pack, we quickly start reaching the maximum tested numbers for the management group. In fact, larger scale Exchange 2010 installations can only manage effectively 400-500 Exchange 2010 servers in a single Operations Manager management group depending on the environment.

Make sure to look at this scale when designing the Operations Manager monitoring environment.

## Get Operations Manager prepped

Besides the scale of the objects injected into Operations Manager, this management pack has a high dataflow rate as there are not only potentially hundreds of thousands of managed objects, but also monitoring criteria such as health states, performance and event data flow for them. To allow Operations Manager to work with this high data flow, there's a few things to do to prep Operations Manager:

### On the management server that hosts the RMS emulator role

Operations Manager CU3+ is highly recommended as there are quite a few performance-based fixes including setting the standard agent queue size at 100 MB instead of the old 15 MB. This is required for Exchange 2010 agents as the amount of data to submit can at times grow quickly and the small queue can cause the agent to drop data or even stop functioning.

Additionally, there are Registry Keys to update to allow the RMS emulator to more effectively utilize the server resources and reduce additional unneeded churn. The table below covers some of these keys:

|Registry hive|Key|Type|Value|Description|
|---|---|---|---|---|
|`HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Operations Manager\3.0`|GroupCalcPollingIntervalMilliseconds|DWORD|000dbba0|Changes the Group Calculation processing to 15 minutes.|
|`HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Operations Manager\3.0\Config Service`|Polling Interval Seconds|DWORD|00000078|Changes the Config Service Polling to 2 minutes.|

Finally for the RMS emulator, ensure that there are no agents reporting directly to the RMS emulator whenever possible. The Exchange 2010 management pack hosts many non-hosted managed objects on the RMS emulator that has to process many health states as well as all alerting occurs from the RMS emulator. Having the RMS emulator process agent processing and dataflow can hinder this process and should if at all possible be avoided.

### On all management server(s)

For all management servers including the RMS emulator, there are a few more registry keys to update to allow for better resource utilization for Operations Manager processing. The following table covers some of these keys:

|Registry key|Type|Value|Description|
|---|---|---|---|
|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HealthService\Parameters\Persistence Cache Maximum`|DWORD|00019000|Allows more memory usage for the Health Service's data store on the local system.|
|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HealthService\Parameters\Persistence Version Store Maximum`|DWORD|00002800|
|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HealthService\Parameters\Persistence Checkpoint Depth Maximum`|DWORD|06400000|
|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HealthService\Parameters\State Queue Items`|DWORD|00005000|Allows more data be allowed to store in the Health Service's data store on the local system.|
  
> [!NOTE]
> These updates don't apply to gateway servers.

### Operations Manager data warehouse (if applicable)

The Exchange 2010 management pack adds some new datasets to the Operations Manager data warehouse for custom reporting. These new datasets have their own set of aggregations that can take a bit more time to complete than normal. Thus, you need to increase the timeout for data warehouse processing to allow these aggregations to finish.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Data Warehouse`

**Command Timeout Seconds** =DWORD:**00000384** - Updates the data warehouse processing timeout from 5 minutes to 15 minutes.

> [!NOTE]
> This needs to be done on every management server (including the RMS emulator).
> This may require to be up to 30 minutes for the timeout depending on how much data flow there is. (Mainly event and performance collection.)

## Management pack changes  

The sheer amount of monitoring in the Exchange 2010 management pack provides a whole host of alerting criteria never experienced in Operations Manager previously. This is by far the largest management pack to date from Microsoft, and provides a massive amount of visibility to Exchange issues. However, there are just some things in the management pack that just don't work. Some of these can actually hinder or even stop all Operations Manager alert processing due to the inherent nature of the check/alert. These issues become much more visible when you start to scale up. So some essential monitoring and override are disabled for some of the most common faulty monitoring in the Exchange management pack. These are designed to provide more accurate monitoring for highly critical issues as well as reduce the chance of impacting Operations Manager monitoring.

### Monitors

Disable the following monitor:

- KHI: The database copy is not mounted on the local server. Another database copy may be mounted on a different server.

### Optional overrides

All non-reporting based performance collections should be disabled, there are 504 performance collection rules to disable. After disabling these rules, each environment will need to review these performance collections and re-enable what they care about in their environment as needed.

## Other considerations

Due to how the management pack is designed, the correlation engine has to cache the Exchange infrastructure to be able to determine if all is healthy. It's highly important that all Exchange servers in an Exchange site are in the same Operations Manager management group. Having only part of the whole site in a single management group will cause much noise as the correlation engine is expecting to see all these servers in the site, but doesn't see them in Operations Manager. Plan accordingly to ensure that all active Exchange servers in each site are properly monitored in the same Operations Manager management group. (Best example is the North America site is managed in one management group, while the South America site is managed in another management group.)

Additionally, if any monitoring doesn't seem to be correct and causing churn/noise, turn it off by disabling the corresponding monitor. Once disabled, review the criteria and determine if it's actionable and if any additional tuning is needed. It's better to stop the alerting for a short time to ensure Operations Manager isn't about to break, than allow a noisy alert that will mask other potential issues.

Finally, make sure that your Operations Manager agents are healthy. Put in a remediation process for agents that don't report in. (You can toss a recovery process on **Health Service Heartbeat Failure**). The Exchange monitoring is based on the best health of _n_ servers. If the _1_ healthy server is not reporting in, Operations Manager thinks it's all unhealthy and can go pretty nuts in the process. (At this management pack most likely has 50+ monitoring criteria associated with that _1_ healthy server.) Keeping the agents reporting in is key to ensuring monitoring is accurate.

## Common issues  

### Issue 1

`MicrosoftExchangeServerRoleDisovery.js` returns empty discovery data for non-domain servers. Server will not be discovered as an Exchange server role in the Operations Manager database.

**Cause**

The `MicrosoftExchangeServerRoleDisovery.js` script creates a property bag that returns the role of every Exchange server. The script doesn't return any error or give any indication why it failed unless an override is placed on the discovery to enable `VerboseLogging=True`.

The script looks for the following parameters to be populated:

- Computer principal name
- Computer NetBIOS name
- Computer Active Directory site
- Computer DNS name
- Install path
- Version

If any of these parameters are not populated, the script will return an empty property bag and the server will not be discovered as an Exchange server role in the Operations Manager database.

If an Exchange Edge server is in a workgroup, the `ComputerActiveDirectorySite` parameter is not populated. Because of this, the server will not be discovered by Operations Manager. Apparently, it's common for Edge servers to be workgroup machines, so monitoring them in Operations Manager is not possible without faking some value for this parameter.

**Resolution**

Add a registry key to the server so that it returns a non-null value for Active Directory site:

1. Open Registry Editor
2. Navigate to `HKEY_LOCAL_MACHINE/System/CurrentControlSet/Services/NetLogon/Parameters`.

3. Find the `SiteName` value for this key. Populate this value with any non-null string (such as **perimeter**, **DMZ**, **Edge**, and so on)

> [!NOTE]
> Don't update the `DynamicSiteName` value, as the NetLogon service can overwrite this data. The `SiteName` value isn't automatically updated.

### Issue 2

Alerts raised by Operations Manager have 10 custom fields. In order to get the integration with other ticketing systems, the custom fields are used. The Exchange management pack (correlation engine in particular) does use same fields for their internal needs and therefore overwrites values.

For example, it stores the `CorrelatedProblemId` in `CustomField10`. And if the field is overwritten alerts cannot be closed.

**Cause**

The Exchange management pack uses **Custom Fields** as critical values, connectors that use any of the following custom fields will experience this issue:

- CustomField4
- CustomField5
- CustomField7
- CustomField8
- CustomField9
- CustomField10

**Resolution**

As the Exchange management pack uses these, workaround is to change the custom fields the connector uses.

### Issue 3

Active Directory integration breaks after installing the Exchange 2010 management pack. The moment Exchange 2010 management pack is installed on a server running an Operations Manager agent, Active Directory integration gets broken for that agent. The memberships in primary and secondary groups are all showing up correctly, but just that agent reads everything in Active Directory and tries to connect to all the management servers including RMS emulator (where RMS emulator isn't even configured with Active Directory integration).

**Cause**

The reason why this happens is because when a box is installed with Exchange 2010, the machine account gets added to the following three additional domain groups that are created.

- Exchange Trusted Subsystem (read and special)
- Exchange Servers (only special)
- Exchange Windows Permissions (only special)

And these three groups have permissions in the domain level itself. So, it gets inherited in `OperationsManager` and subsequent management group containers or SCPs. When agent has health service running under **Local System**, and when it starts up, it is able to read everything in Active Directory  under the `OperationsManager` container.

**Resolution**

The issue is fixed by removing these three groups from the `OperationsManager` container by stopping inheritance.

### Issue 4

Using System Center Operations Manager 2007, you import the Exchange 2010 management pack. As per the Exchange 2010 management pack guide, all the object discovery rules are enabled by default and should automatically discover all Exchange 2010 roles and start monitoring them. This doesn't happen, thus you face a problem where none of the Exchange 2010 server roles are getting discovered or getting monitored. It also doesn't log any error or throw any alert saying that discovery failed.

**Causes**

- This can occur if you install the 32-bit (x86) agent on a 64-bit (x64) based operating system or platform.
- This can happen if your Exchange 2010 server roles are clustered. For example, the mailbox server role or CAS server role is installed on Windows cluster server.

**Resolution**

- Install the proper agent for the platform or OS hosting the Exchange Server roles.
- Make sure that Operations Manager 2007 R2 Agent is installed on all clustered nodes. Then from the Operations Manager console > **Administration** > **Device Management** > **Agent Managed**, go to each agent computer and from the **Security** tab, enable the **Agent Proxy** check box. Restart System Center Management Service on each agent computer after doing this. Within few minutes, all Exchange 2010 server roles should get discovered and monitored as expected.

### Issue 5

When attempting to override an alert priority on an Exchange 2010 rule with the Exchange 2010 management pack, the override doesn't take effect. The default value is defined as `$Data/EventData/CorrelatedContext/RootCause/Priority$`.

**Cause**

Alerts are generated by the correlation engine, so the overrides are not taking effect. Override scope is probably the issue.

**Resolution**

Overrides class should be selected for **All objects of Class: Root Management Server**.

### Issue 6

After deploying the Exchange 2010 management pack in a System Center Operations Manager environment, the Exchange 2010 management pack may set the RMS emulator in a critical state with the following error:

> Failed to deploy Data Warehouse component. The operation will be retried. Exception 'DeploymentException': Failed to perform Data Warehouse component deployment operation: Install; Component: Script, Id: '0672dd6a-1e36-2336-b1f0-f701fe67f8a2', Management Pack Version-dependent Id: 'ab06eb14-eaf1-0f0b-04b8-f1cdd33f4acc'; Target: Database, Server name: 'serverName', Database name: 'OperationsManagerDW'. Batch ordinal: 15; Exception: Must declare the scalar variable "@SplitValue". Must declare the scalar variable "@SplitValue". One or more workflows were affected by this. Workflow name: Microsoft.SystemCenter.DataWarehouse.Deployment.Component Instance name: \<FQDN> Instance ID: {05432A69-69F6-2B53-2D79-52BD1AC6E289} Management group: groupName

If the Exchange 2010 management pack is removed, the health will return to normal (green).

**Cause**

This can occur if DB collation is set to be case-sensitive.

**Resolution**

Change the DB collation to be case insensitive to resolve this issue.

### Issue 7

When you drill down to a sub report **Top Alerts** of the SLA report in the Exchange 2010 Service Pack 1 (SP1) management pack for System Center Operations Manager 2007 R2, you get the error:

> An error has occurred during report processing, Query execution Failed For dataset TopAlerts.  
> Cannot Find either column "Exchange2010" or the user-defined Function or aggregate Exchange2010.GetserverRole, or the name is ambiguous.

**Resolution**

Don't use this report.

### Issue 8

Event messages concerning Exchange management event log. If the Exchange Server 2010 SP1 management pack is imported before all Exchange servers are upgraded to Exchange Server 2010 SP1, the event log message below may be logged regularly.

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Event ID: 26004  
> Level: Error  
> Description:  
> The Windows Event Log Provider is still unable to open the MSExchange Management event log on computer 'server'. The Provider has been unable to open the MSExchange Management event log for 565200 seconds.  
> Most recent error details: The specified channel could not be found. Check channel configuration.  
> One or more workflows were affected by this.

**Cause**

The logging of this event is expected behavior when servers that have Exchange 2010 installed use the Exchange 2010 SP1 management pack. The Exchange 2010 SP1 management pack will still monitor Exchange computers that are running Exchange Server 2010 SP1 and Exchange Server 2010 while this event is being logged.

### Issue 9

Size of the Operations database grows out of control after disabling rules in the Exchange 2010 management pack.

**Cause**

The correlation engine checks to see if alerts are created before creating a new event in the `PendingSDKDatasource` table. The basic components are Monitors and their matching rules. Each monitor has a corresponding rule. The monitors change state and the correlation engine picks up on them. If it's a new issue, a new event is created via the SDK and the event description contains the whole chain of monitors. The rules then look for the SDK events and create an alert. If the alert is disabled, the correlation engine will continue to insert events. Depending on the timing of some of the monitors and the type of failure, the number of events will continue to grow. The side effects are the size of the `PendingSDKDatasource` table grows large and the rules have trouble keeping up with the number of events. This may cause the `MonitoringHost` process running those workflows to consume large amounts of memory (private bytes). This can have a negative overall performance impact on the RMS emulator if that is where the correlation engine resides. The `PendingSDKDatasource` table does groom once a day. But depending on how unhealthy the Exchange environment is, this may be too large an interval. The main takeaway for this is not to disable an Exchange alerting rule unless you also disable the corresponding monitor.

**Resolution**

Disable the monitors that correspond with the alerting rules.

### Issue 10

When you drill into the **Top Alerts** sub report on the SLA report, you get the following error:

> An error has occurred during report processing, Query execution Failed For dataset TopAlerts.  
> Cannot Find either column "Exchange2010" or the user-defined Function or aggregate Exchange2010.GetserverRole, or the name is ambiguous

**Cause**

This report is deprecated and not to be used.

**Resolution**

Don't use this report.
