---
title: Troubleshoot missing heartbeats in Linux agents
description: "Troubleshoot scenarios in which a Linux Log Analytics agent doesn't report heartbeats to the Log Analytics workspace."
ms.date: 03/29/2022
ms.reviewer: irfanr, nali2, arboisse, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
keywords:
#Customer intent: As an Azure Monitor user, I want to troubleshoot why the Log Analytics agent for Linux doesn't report heartbeats to the Log Analytics workspace so that I can successfully monitor the health of my Linux virtual machine.
---
# Troubleshoot missing heartbeats in Linux agents

This article helps you troubleshoot missing heartbeats in the Microsoft Azure Log Analytics agent on a Linux-based computer.

> [!NOTE]
> There are many reasons why heartbeats might seem to be missing from Linux agents. However, this article discusses only a sampling of the scenarios that cause the problem to occur.

## Prerequisites

- A [supported Linux distribution and version](/azure/azure-monitor/agents/agents-overview#supported-operating-systems) that isn't hardened. If you don't know what your distribution or version is, run the `cat /etc/system-release` command in a shell to display this information.
- An x86 or x64 CPU architecture.
- A Log Analytics agent that isn't multi-homed to more than one workspace. To verify the multi-homing status of the agent, run the *omsadmin.sh* script:

  ```bash
  sudo sh /opt/microsoft/omsagent/bin/omsadmin.sh -l
  ```

- A firewall or proxy that's configured for the following agent resources:

  - `*.ods.opinsights.azure.com`
  - `*.oms.opinsights.azure.com`
  - `*.blob.core.windows.net`
  - `*.azure-automation.net`

  Make sure these resources use port 443 in the outbound direction, and that they allow the bypass of HTTPS inspection. For more information, see [Network requirements](/azure/azure-monitor/agents/log-analytics-agent#network-requirements).

- The [Operations Management Suite Linux Agent Log Collector](https://github.com/Microsoft/OMS-Agent-for-Linux/blob/master/tools/LogCollector/OMS_Linux_Agent_Log_Collector.md) running on your Linux computer. Operations Management Suite (OMS) is another name for the Log Analytics agent for Linux.

  If the Log Collector tool doesn't work for your operating system, manually collect the logs and configuration files that are mentioned in [Important log locations and Log Collector tool](/azure/azure-monitor/agents/agent-linux-troubleshoot#important-log-locations-and-log-collector-tool).

## Symptoms

When you view a Log Analytics workspace in the Azure portal, heartbeats aren't reported from the Log Analytics agent on a Linux virtual machine (VM).

## Cause 1: The agent is configured to report to another workspace

What if the Linux agent invokes a workspace ID (a GUID) that differs from the workspace ID of your Log Analytics workspace? In this case, the agent is configured to send its heartbeats and data to another workspace.

To get the workspace ID that the Linux agent uses, run the same *omsadmin.sh* script that you used to check for the multi-homing status of the agent:

```bash
sudo sh /opt/microsoft/omsagent/bin/omsadmin.sh -l
```

To get your workspace ID in Azure, follow these steps:

1. In the [Azure portal](https://portal.azure.com), locate and select **Log Analytics workspaces**.

1. On the list of Log Analytics workspaces, select the workspace that you want the agent data to be sent to.

1. On the **Overview** page of the workspace that you selected, find the GUID value that's listed in **Workspace ID**. Does this value differ from the workspace ID that's shown in the output of the *omsadmin.sh* script? If it does, you've discovered the cause of the problem.

### Solution: Reconfigure the agent to point to the correct workspace

Change the agent configuration to use the workspace ID that's shown in the Azure portal. You'll have to investigate why the agent is configured to report to a different workspace. There might be a valid reason for the agent to send data to a workspace other than your own.

## Cause 2: The agent process didn't start

The agent process (`omsagent`) wasn't successfully started, so there isn't any heartbeat data available.

Run the following command that uses the `ps` and `grep` tools to list the currently running processes:

```bash
ps -ef | grep -i oms | grep -v grep
```

After you find that `ps` command, examine the command output for the following `omsagent` command (as a single line) that's called within Ruby:

```bash
/opt/microsoft/omsagent/ruby/bin/ruby /opt/microsoft/omsagent/bin/omsagent \
  -d /var/opt/microsoft/omsagent/<workspace-id>/run/omsagent.pid \
  -o /var/opt/microsoft/omsagent/<workspace-id>/log/omsagent.log \
  -c /etc/opt/microsoft/omsagent/<workspace-id>/conf/omsagent.conf \
  --no-supervisor
```

> [!NOTE]
> The *\<workspace-id>* placeholder is a GUID.

If you can't find this command invocation, this means that the agent process didn't start.

### Solution: Start the agent process manually

In a Linux shell, run the following command to manually start the agent:

```bash
/opt/microsoft/omsagent/bin/service_control start
```

After you run this command, verify whether the output in *omslinux.out* now contains the expected text that you looked for earlier.

## Cause 3: Problems affect the VM SSL setup

There might be a problem that affects the Secure Sockets Layer (SSL) connection on your VM. To check for SSL problems, follow these steps:

1. Run the following [wget](https://www.gnu.org/software/wget/) command to download the Ruby test script to the local VM:

    ```bash
    wget https://raw.githubusercontent.com/ruby/openssl/master/test/openssl/test_ssl.rb
    ```

1. Move the script to the */tmp* directory.

1. Make sure that the `omsagent` user can access your root CA certificates.

1. Run the test script by using the following command:

    ```bash
    sudo --user=omsagent /opt/microsoft/omsagent/ruby/bin/ruby /tmp/test_ssl.rb
    ```

The test script determines whether an issue affects the VM SSL connection.

### Solution: Fix the CA certificates and the SSL connection

Make sure that the SSL root CA certificates are valid, and that it's possible for your VM to have SSL connections.

## Cause 4: The agent generates heartbeats but can't transmit them to the workspace

The *omsagent.log* file shows the agent is generating heartbeats, but it doesn't transmit the heartbeats successfully to the Log Analytics workspace. To make sure the heartbeats are logged in that file, run the following `tail` command to view the end of the log file:

```bash
tail omsagent.log
```

In the file, do you see several log entries that contain the following string?

> \[info\]: Sending OMS Heartbeat succeeded

For example, do you see an entry that resembles the following text?

> 2022-03-19 05:18:52 +0000 [info]: Sending OMS Heartbeat succeeded at 2022-03-19T05:18:52.812Z

Such an entry indicates that the agent is generating heartbeats and sending these heartbeats to the workspace successfully.

Or, instead of such an entry, do you see informational messages that resemble "Encountered retryable exception. Will retry sending data later" together with warning messages such as "failed to flush the buffer" or "suppressed same stacktrace"? If the output contains such messages, the agent is failing to send its heartbeats to the workspace. For example, you might see an entry that resembles the following text:

<details>
<summary>Log of transmission failure</summary>

> 2019-04-02 19:27:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:27:43.729Z
>
> 2019-04-02 19:28:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:28:43.729Z
>
> 2019-04-02 19:29:31 -0500 [info]: **Encountered retryable exception. Will retry sending data later.**
>
> 2019-04-02 19:29:31 -0500 [warn]: **temporarily failed to flush the buffer.** next_retry=2019-04-02 19:38:01 -0500 error_class="RuntimeError" error="Net::HTTP.Post raises exception: Net::OpenTimeout, 'execution expired'" plugin_id="object:2ab334e31fcc"
>
> 2019-04-02 19:29:31 -0500 [warn]: **suppressed same stacktrace**
>
> 2019-04-02 19:29:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:29:43.730Z
>
> 2019-04-02 19:30:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:30:43.731Z
>
> 2019-04-02 19:31:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:31:43.731Z
>
> 2019-04-02 19:32:04 -0500 [info]: **Encountered retryable exception. Will retry sending data later.**
>
> 2019-04-02 19:32:04 -0500 [warn]: **temporarily failed to flush the buffer.** next_retry=2019-04-02 19:36:34 -0500 error_class="RuntimeError" error="Net::HTTP.Post raises exception: Net::OpenTimeout, 'execution expired'" plugin_id="object:2ab3347a61e4"
>
> 2019-04-02 19:32:04 -0500 [warn]: **suppressed same stacktrace**
>
> 2019-04-02 19:32:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:32:43.732Z
>
> 2019-04-02 19:33:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:33:43.733Z
>
> 2019-04-02 19:34:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:34:43.734Z
>
> 2019-04-02 19:35:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:35:43.735Z
>
> 2019-04-02 19:36:43 -0500 [info]: Sending OMS Heartbeat succeeded at 2019-04-03T00:36:43.736Z
>
> 2019-04-02 19:37:04 -0500 [info]: **Encountered retryable exception. Will retry sending data later.**
>
> 2019-04-02 19:37:04 -0500 [warn]: **failed to flush the buffer.** error_class="RuntimeError" error="Net::HTTP.Post raises exception: Net::OpenTimeout, 'execution expired'" plugin_id="object:2ab3347a61e4"

</details>

If the heartbeats aren't being transmitted to the workspace, run the [Log Analytics Agent Linux Troubleshooting Tool](/azure/azure-monitor/agents/agent-linux-troubleshoot#log-analytics-troubleshooting-tool) by using the following command:

```bash
sudo /opt/microsoft/omsagent/bin/troubleshooter
```

The troubleshooting tool will list a menu of choices. Select option 2 (`Agent doesn't start, can't connect to Log Analytic Services`). The tool will then try to determine the cause of the failure.

### Solution: Get help from your infrastructure or network team to access the necessary endpoints

If the troubleshooting tool returns any errors that involve endpoint connectivity, see the [Network requirements for the Log Analytics agent](/azure/azure-monitor/agents/log-analytics-agent#network-requirements). The necessary URL to be able to send the heartbeat data is ***\<workspace-id>*.ods.opinsights.azure.com**. If you experience failures when that URL is used, consult your infrastructure or network team to restore access.

## Cause 5: Problems affect Log Analytics ingestion

In the Log Analytics workspace, the following Kusto query that looks for Linux heartbeats returns no results:

```kusto
Heartbeat
| where OSType == "Linux"
| summarize arg_max(TimeGenerated, *) by Computer
```

Because no other agent can send heartbeats either, this condition indicates general problems that affect ingestion in Log Analytics.

### Solution 1: Check for outage notifications

Verify whether the agent has [ingestion latency delays](/azure/azure-monitor/logs/data-ingestion-time#ingestion-latency-delays). If you detect obvious ingestion delays, check the Azure service health to determine whether there are any outage notifications.

### Solution 2: Wait for the ingestion problem to clear on the Azure service or region

The problem might be caused by ingestion issues on the Azure service or Azure region. [Check the status of Azure services and regions](https://status.azure.com). If you find a problem, wait for the affected service or region to return to health. Then, recheck whether heartbeats are reported to the workspace.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
