---
title: Basic troubleshooting Azure Log Analytics Monitoring Agent problems
description: This article covers the basic aspects of the Microsoft Monitoring Agent (MMA) from Azure Log Analytics.
ms.date: 06/24/2024
author: JarrettRenshaw
ms.author: arboisse
ms.reviewer: arboisse
editor: v-jsitser
ms.service: azure-monitor
ms.custom: sap:Windows Agents
---

# Azure Log Analytics Monitoring Agent troubleshooting basics

[!INCLUDE [Azure Help Support](../../../../includes/azure/log-analytics-agent-end-of-life-note.md)]

This article is a basic guide for troubleshooting Microsoft Monitoring Agent (MMA) problems.

## Basic requirements for MMA

- For supported operating systems, see [Log Analytics Agent support operating systems](/azure/azure-monitor/platform/log-analytics-agent#supported-windows-operating-systems).

- For networking requirements, see [Log Analytics Agent TLS 1.2 protocol](/azure/azure-monitor/platform/log-analytics-agent#tls-12-protocol) and [Network requirements](/azure/azure-monitor/platform/log-analytics-agent#network-requirements).

- Your Workspace ID must be configured for the Monitoring Agent when you connect to the Log Analytics workspace.

- You must have a Monitoring Agent certificate that has the correct hostname of your server. The certificate is generated automatically when you install the Monitoring Agent. The certificate is located in **Computer Certificate\Microsoft Monitoring Agent\Certificates** (certlm.msc).

- If a proxy is used, the proxy settings of the Monitoring Agent must be made through either the Log Analytics gateway or your proxy server.

## How to find the agent version

There are two ways to find the version of Monitoring Agent.

**On the VM or on-premises server with MMA**

1. Log on to the server, and then go to **Control Panel** > **System and Security**.

2. Select **Microsoft Monitoring Agent**, and then select the **Properties** tab. The version should be listed there.

You can also query the version by running the following PowerShell cmdlet:

  ```PowerShell
  Get-WmiObject -Class Win32_Product -Filter "Name='Microsoft Monitoring Agent'" -ComputerName.
  ```

**Azure portal**

1. In the Log Analytics workspace that the Monitoring Agent is connected to, select **Logs**.

1. Run the following query:

    ```PowerShell
    Heartbeat | summarize arg_max(TimeGenerated, *) by Computer
    ```

1. Expand the query results, and then examine the **Version** column.

## Collect ETL trace for troubleshooting

When you submit a support ticket for a Monitoring Agent problem, the Microsoft support team might ask for an ETL trace to collect information for troubleshooting. Usually, you can use the [GetAgentInfo.ps1 script](/azure/azure-monitor/agents/agent-windows-troubleshoot) to collect the ETL trace.

If the script doesn't work, use the following steps to collect an ETL trace manually.

1. Select **Start**, enter *cmd*, and then select **Command Prompt** from the results to open a Command Prompt window.

1. At the command prompt, go to the following directory: *%programfiles%\Microsoft Monitoring Agent\Agent\Tools*.

1. Run the following command to stop trace logging:

   `StopTracing.cmd`

1. Run the following command to enable verbose trace logging:

   `StartTracing.cmd INF`

   **Note:** In this command, "INF" must be uppercase.

1. Reproduce the issue.

1. At the command prompt, run the following command to stop trace logging:

   `StopTracing.cmd`

1. Run the following command,  and then wait until all the traces get converted:

   `FormatTracing.cmd`

1. Collect the traces (\*.log files) from the *%windowsroot%\Logs\OpsMgrTrace* folder.

## Frequently asked questions (FAQ)

**How long is the data cached/buffered for?**

The data is cached or buffered for a maximum of 8.5 hours. The Monitoring Agent tries to upload every 20 seconds. If it can't upload, it will wait 30 seconds, and then try to upload again. After that, the wait time goes from 30 seconds to 60 seconds to 120 seconds, and so on, up to a maximum of nine minutes between retries. The agent will retry 10 times for a given "chunk" of data before it discards the data and advances to the next “chunk.” This cycle continues until the agent can successfully upload again. In practice, this means that data is buffered for up to 8.5 hours before being discarded. Any data that has been uploaded is cleared. The retry time is slightly randomized to avoid having all agents retry simultaneously.

**What's the minimum and maximum size of the cache or buffer?**

The default minimum value is 100 MB, and the maximum value is 1.5 GB. This setting can be modified in the following registry value:

- Subkey: **HKLM\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\Management Groups&#92;&lt;Management Groups ID&gt;**
- Value: **MaximumQueueSizeKb**
- Type: **DWORD**
- Default: **102400** (meaning 100 MB)
  - Min Value: **5120**
  - Max Value: **1536000**

**What occurs if the connection to the Log Analytics workspace isn't available?**

The agent gradually backs off the retry process exponentially for up to 8.5 hours per retry. It will continue to retry every 8.5 hours indefinitely, and discard the oldest data when the buffer limit is reached. When the agent can successfully connect, it will upload data until it returns to processing the latest data.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
