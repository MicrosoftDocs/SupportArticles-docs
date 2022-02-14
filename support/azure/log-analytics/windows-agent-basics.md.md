---
title: Basic troubleshooting Azure Log Analytics Monitoring Agent problems
description: This article covers the basic aspects of the Microsoft Monitoring Agent (MMA) from Azure Log Analytics.
ms.date: 01/24/2022
author: genli 
ms.author: Armand.Boisselle
ms.reviewer: armand.boisselle
editor: v-jsitser
ms.service: azure-other-services
keywords: 
---

# Azure Log Analytics Monitoring Agent troubleshooting basics

This article provides basic guide for troublehooting Microsoft Monitoring Agent with Azure Log Analytics.

## Basic requirements for running the MMA

- For supported operating systems, see [Log Analytics Agent support operating systems](/azure/azure-monitor/platform/log-analytics-agent#supported-windows-operating-systems).

- For networking requirements, see [Log Analytics Agent TLS 1.2 protocol](/azure/azure-monitor/platform/log-analytics-agent#tls-12-protocol) and [Network firewall requirements](/azure/azure-monitor/platform/log-analytics-agent#network-firewall-requirements).

- Your Workspace ID must be configured for the Monitoring Agent when connecting to the Log Analytics workspace.

- You must have a Microsoft Monitoring Agent (MMA) certificate with the correct Hostname of your server.  

- The proxy settings of the MMA agent connecting to the workspace must be via either OMS Gateway or an actual corporate proxy. 

## How to find the Agent version

Log on to the device, and go to **Control Panel** > **System and Security**. Select **Microsoft Monitoring Agent** and then select the **Properties** tab. The version should be listed there.

## ETL data collection and decoding ETLs

### ETL data collection

Follow these steps for Windows Agent ETL data collection:

1. Select **Start**, enter *cmd* and then select *Command Prompt* from the results to open a command prompt window.

1. At the command prompt, go to the following directory: **%programfiles%\System Center 2012\Operations Manager\Server\Tools*, and then check the directory according to the Agent (either the OMS or SCOM Agent version).

1. Run the following command to stop trace logging: `StopTracing.cmd`.

1. Run the following command to enable verbose trace logging: `StartTracing.cmd INF`. *Note*: INF must be uppercase.

1. Reproduce the issue.

1. At the command prompt, run the following command to stop trace logging: `StopTracing.cmd`.

1. Run this command: `FormatTracing.cmd"`, and then wait until all the traces get converted.

1. Collect the traces (*.log files) from the %windowsroot%\Logs\OpsMgrTrace folder.

### Decoding ETLs

Follow these steps to prepare to decode ETFs:

1. Identify which Advisor Knowledge build was most recently published to Public. Look for the last entries on [this page](https://scadvisorcontent.blob.core.windows.net/ipcontentdirectagent/IntelligencePackHistory.xml). Here's an example:

   ```
   <Publication> <Timestamp>2019-04-01T16:11:25.4664808Z</Timestamp> <PublishTo>PUBLIC</PublishTo> <BuildNumber>8.0.1.164</BuildNumber> <DefinitionFile>https://scadvisorcontent.blob.core.windows.net/ipcontentdirectagent/ipdefinition/IntelligencePackDefinition_Promote_20190401-161125.xml</DefinitionFile> </Publication>
   ```

2. Go to the corresponding build in the Advisor Knowledge repo: *\reddog\builds\branches\git_mgmt_loganalytics_advisorknowledge_master\8.0.1.164*

1. Download this [TMF file](\reddog\builds\branches\git_mgmt_loganalytics_advisorknowledge_master\8.0.1.164\retail-amd64-deploy\Symbol\AdvisorKnowledge_8.0.1.164_Release.tmf) (it contains trace message formats for all modules).  

1. Place the TMF file you downloaded in step 3 into agent TMF folder: *C:\Program Files\Microsoft Monitoring Agent\Agent\Tools\TMF*.

1. Once you've completed these steps, you can decode the managed traces using the steps listed in the **ETL data collection** section of this article. 

**Note:** If you're looking at older traces, you'll have to download the TMF from an older Advisor Knowledge public build.

## Windows agent cache, retry, and buffer FAQs

**How long is the data cached/buffered?**

The data is cached or buffered for a maximum of 8.5 hours. The agent tries to upload every 20 seconds. If it can’t upload, it will wait 30 seconds, and then try to upload again. After that, the wait time goes from 30 s->60 s->120 s-> etc.), up to a maximum of a 9-minute wait between retries. The agent will retry 10 times for a given “chunk” of data before discarding it and moving to the next “chunk.” This cycle continues until the agent can successfully upload again. In practice, this means data is buffered for up to 8.5 hours before being discarded. Any data that has been uploaded is cleared. The retry time is slightly randomized to avoid all agents retrying at the same time.

**What's the minimum and maximum size of the cache/buffer?**

100 MB The default minimum setting is 100 MB, and the maximum is 1.5 GB. This setting can be modified in the registry by following the tuning parameters section on [Windows Agent - Rate Limits, Caching, Tuning Parameters](Windows Agent - Rate Limits, Caching, Tuning Parameters).

**What happens if the link or network to LAW is down?**

As described above, the agent backs off retrying exponentially for up to 8.5 hours per retry. It will continue to retry every 8.5 hours indefinitely and discard the oldest data when the buffer limit is reached. When the agent can successfully connect, it will upload data until it's back to processing the latest data.