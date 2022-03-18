---
title: Linux performance counters missing in Log Analytics workspace
description: Helps troubleshoot an issue where performance counters are missing in a Linux agent connected workspace.
ms.date: 03/15/2022
author: genlin
ms.author: genli
ms.reviewer: irfanr
ms.service: log-analytics
---
# Linux performance counters are missing in Log Analytics workspace

This article provides troubleshooting steps for an issue where Linux performance counters and other non-heartbeat data are missing in a Log Analytics workspace.

## Prerequisites

Ensure that the Linux agent can be supported. For supported operating systems, see [Linux operating systems supported by Log Analytics agents](/azure/azure-monitor/agents/agents-overview#linux).

Determine Linux distribution by using one of the following methods if you're uncertain:

- Run the `cat /etc/system-release` command.

- Collect logs for the Linux agent by using [Linux Agent Log Collector](https://github.com/Microsoft/OMS-Agent-for-Linux/blob/master/tools/LogCollector/OMS_Linux_Agent_Log_Collector.md). Find the Linux distribution from the Linux Log Collector output.

Here are troubleshooting steps for this issue. If there are multiple faulty Linux agents, use these steps on one agent first. After the issue is resolved, apply the same steps to other agents.

## Step 1: Check if Linux agent sends heartbeats

Basic heartbeats must work first. If the Linux agent doesn't send any recent heartbeats to the workspace, performance counters or other data won't be sent to the workspace.

To check if the Linux agent sends heartbeats, go to the workspace in the Azure portal and run the following query:

```powershell
Heartbeat | where OSType == "Linux" | summarize arg_max(TimeGenerated, *) by Computer
```

If the query result doesn't show the computer with the Linux agent installed, it means the Linux agent doesn't send heartbeats. To resolve this issue, see [Missing Heartbeats for Linux Agent](https://dev.azure.com/Supportability/AzureMonitoringAgents/_wiki/wikis/AzureMonitoringAgents/466119/Linux-Agents-Install-Issues-and-Missing-Heart-Beats).

If the query result shows the computer, it means it can communicate with the Log Analytics workspace, which rules out Log Analytics ingestion issues. In this case, proceed to Step 2.

## Step 2: Check if other Linux agents send performance counters

Run the following query in the workspace. The most recent performance counters data will be collected based on time frame that's set in the Log Search Dialog.

```powershell
Perf | summarize arg_max(TimeGenerated, *) by Computer | order by TimeGenerated desc
```

If some Linux computers and desired performance counters data are listed in the query result, and the time stamps are recent, it means that their Linux agents are configured to collect performance counters and send them to the workspace successfully. In this case, the issue is isolated to these Linux agents. The workspace configuration is set correctly and these Linux agents get correct configuration.

If the compute with the faulty agent installed shows in the query result, the issue is resolved; if not, proceed to the Step 3.

## Step 3: Check if the agent receives current configuration from workspace

The workspace configuration tells the agent what data to collect and send to the workspace. Check the current configuration of the faulty Linux agent by using the omsagent log. The log can be found in //var//opt//microsoft//omsagent//workspaceid//log//. You also can get it through the collected log data in Step 1.

Open the log file, search the string *[info]: using configuration file: \<ROOT>* from the bottom up. The search result indicates the most recent time when the Linux agent gets configuration data from the workspace.

If some performance counters entries between the \<Root> tags look like the following samples, check if the entries match up to what is shown in the **Advanced Settings** > **Data** > **Linux Performance Counters**.

```output
type oms_omi object_name Logical Disk instance_regex .* counter_name_regex (% Used Inodes|Free Megabytes|% Used Space|Disk Transfers/sec|Disk Reads/sec|Disk Writes/sec) interval 10s omi_mapping_path /etc/opt/microsoft/omsagent/67e8d8fd-48a4-46ec-b41a-a62fcc02ce2e/conf/omsagent.d/omi_mapping.json

type oms_omi object_name Memory instance_regex .* counter_name_regex (Available MBytes Memory|% Used Memory|% Used Swap Space|% Available Memory) interval 10s omi_mapping_path /etc/opt/microsoft/omsagent/67e8d8fd-48a4-46ec-b41a-a62fcc02ce2e/conf/omsagent.d/omi_mapping.json

type oms_omi object_name Processor instance_regex .* counter_name_regex (% Processor Time|% Privileged Time) interval 10s omi_mapping_path /etc/opt/microsoft/omsagent/67e8d8fd-48a4-46ec-b41a-a62fcc02ce2e/conf/omsagent.d/omi_mapping.json
type oms_omi object_name Process instance_regex .* counter_name_regex (Used Memory|Pct User Time|Pct Privileged Time) interval 10s omi_mapping_path /etc/opt/microsoft/omsagent/67e8d8fd-48a4-46ec-b41a-a62fcc02ce2e/conf/omsagent.d/omi_mapping.json
```

:::image type="content" source="./media/linux-agent-performance-counter-missing/screenshot-collected-linux-performance-counters.png" alt-text="Screenshot of collected linux performance counters data":::

If there's no such performance counters entry in the log file, check the time stamp for the *[info]: using configuration file:* entry. If the time stamp predates the time when performance counters are configured to collect, the Linux agent doesn't receive the current configuration from the workspace. To solve this issue, force the Linux agent to pull the current configuration from the workspace.

### Force agent to pull configuration from workspace

Run the following command to force an agent to pull the current configuration from a workspace:

```python
sudo -u omsagent python /opt/microsoft/omsconfig/Scripts/PerformRequiredConfigurationChecks.py
```

The following output is returned if it works:

```output
[2020/02/20 02:13:25] [4427] [INFO] [0] [/opt/microsoft/omsconfig/Scripts/PerformRequiredConfigurationChecks.py:0] dsc_host lock file is acquired by : PerformRequiredConfigurationChecks
Operation PerformRequiredConfigurationChecks completed successfully. Operation was successful.
```

If the result isn't expected, run the following command to stop and start the agent by using a Linux command prompt:

```console
/opt/microsoft/omsagent/bin/service_control stop
/opt/microsoft/omsagent/bin/service_control start
```

After this command runs, the agent will pull new configuration data from the workspace. Once the agent starts again, check if performance counters data shows in the omsagent log.

If the performance counters data shows, go to the Azure portal and run the following command to check if the Linux agent sends performance counters data to the workspace. The Linux agent may take a few minutes to appear.

```powershell
Perf | summarize arg_max(TimeGenerated, *) by Computer | order by TimeGenerated desc
```

If the Linux agent appears in the query result, this issue is resolved. If the Linux agent doesn't appears, consider that there are different problems with it.
