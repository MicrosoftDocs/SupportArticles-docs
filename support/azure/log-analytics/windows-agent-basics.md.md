---
title: Basic troubleshooting Azure Log Analytics Monitoring Agent problems
description: This article covers the basic aspects of the Microsoft Monitoring Agent (MMA) from Azure Log Analytics.
ms.date: 01/24/2022
author: genli 
ms.author: armand.boisselle
ms.reviewer: armand.boisselle
editor: v-jsitser
ms.service: log-analytics
ms.subservice: virtual-network
keywords: 
---

# Azure Log Analytics Monitoring Agent troubleshooting basics

This article provides basic information for troubleshooting Microsoft Monitoring Agent (MMA) with Azure Log Analytics.

## Basic requirements for running MMA

- For supported operating systems, see [Log Analytics Agent support operating systems](/azure/azure-monitor/platform/log-analytics-agent#supported-windows-operating-systems).

- For networking requirements, see [Log Analytics Agent TLS 1.2 protocol](/azure/azure-monitor/platform/log-analytics-agent#tls-12-protocol) and [Network firewall requirements](/azure/azure-monitor/platform/log-analytics-agent#network-firewall-requirements).

- Your Workspace ID must be configured for the Monitoring Agent when connecting to the Log Analytics workspace.

- You must have a Monitoring Agent certificate with the correct Hostname of your server. Generally, the certificate is generated automatically when you install the Monitoring Agent. The certificate is located in **Computer Certificate\Microsoft Monitoring Agent\Certificates**.

- If a proxy is used, the proxy settings of the MMA agent must be via either Log Analytics gateway or your proxy server.

## How to find the agent version

There are two ways you can do this:

**On the VM or on-premises server with MMA**

Log on to the server, and go to **Control Panel** > **System and Security**. Select **Microsoft Monitoring Agent** and then select the **Properties** tab. The version should be listed there. 

You can also query the version by running the following PowerShell command:

  ```PowerShell
  Get-WmiObject -Class Win32_Product -Filter "Name='Microsoft Monitoring Agent'" -ComputerName.
  ```

**Azure portal**

In the Log Analytics that the Monitoring Agent connected to, select **Logs**, and run the following Heartbeat query:

Run the following query, expand Query result.  and look at the version column:
 ```PowerShell
Heartbeat | summarize arg_max(TimeGenerated, *) by Computer`
```
## Collect ETL trace for troubleshooting

When you submit a support ticket for a MMA problem, Microsoft support team might ask for an ETL trace to collect information for troubleshooting. Use the following steps to collect an ETL trace.

1. Select **Start**, enter *cmd* and then select *Command Prompt* from the results to open a command prompt window.

1. At the command prompt, go to the following directory: `%programfiles%\Microsoft Monitoring Agent\Agent\Tools`.

1. Run the following command to stop trace logging: `StopTracing.cmd`.

1. Run the following command to enable verbose trace logging: `StartTracing.cmd INF`. *Note*: INF must be uppercase.

1. Reproduce the issue.

1. At the command prompt, run the following command to stop trace logging: `StopTracing.cmd`.

1. Run this command: `FormatTracing.cmd"`, and then wait until all the traces get converted.

1. Collect the traces (*.log files) from the %windowsroot%\Logs\OpsMgrTrace folder.

## FAQs

**How long is the data cached/buffered?**

The data is cached or buffered for a maximum of 8.5 hours. The agent tries to upload every 20 seconds. If it can't upload, it will wait 30 seconds, and then try to upload again. After that, the wait time goes from 30s->60s->120s-> etc.), up to a maximum of a 9-minute wait between retries. The agent will retry 10 times for a given "chunk" of data before discarding it and moving to the next “chunk.” This cycle continues until the agent can successfully upload again. In practice, this means data is buffered for up to 8.5 hours before being discarded. Any data that has been uploaded is cleared. The retry time is slightly randomized to avoid all agents retrying at the same time.

**What's the minimum and maximum size of the cache/buffer?**

100 MB The default minimum setting is 100 MB, and the maximum is 1.5 GB. This setting can be modified in the registry by following the tuning parameters section on [Windows Agent - Rate Limits, Caching, Tuning Parameters](Windows Agent - Rate Limits, Caching, Tuning Parameters).

**What happens if the link or network to LAW is down?**

As described above, the agent backs off retrying exponentially for up to 8.5 hours per retry. It will continue to retry every 8.5 hours indefinitely and discard the oldest data when the buffer limit is reached. When the agent can successfully connect, it will upload data until it's back to processing the latest data.

