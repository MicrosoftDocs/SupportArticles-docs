---
title: Best practices for migrating to Azure Monitor Agent (AMA)
description: Discusses the best practices for migrating to Azure Monitor Agent (AMA) from the legacy Log Analytics agent.
ms.date: 07/16/2024
ms.reviewer: neghuman， jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to learn about best practices for migrating to Azure Monitor Agent so that I can move on from using the legacy Log Analytics agent.
---
# Best practices for migrating from Log Analytics agent to Azure Monitor Agent

This article provides guidance to implement a successful migration from the legacy Log Analytics agent to Microsoft Azure Monitor Agent (AMA).

## Overview

### Why migrate?

Azure Monitor Agent replaces the Log Analytics agent (previously known as Microsoft Monitoring Agent (MMA) and Operations Management Suite (OMS)) in the following components:

- Windows and Linux operating systems
- On-premises and third-party cloud environments

Azure Monitor Agent introduces a simplified and flexible method of configuring data collection by using data collection rules (DCRs).

> [!IMPORTANT]
> The Log Analytics agent is on a **deprecation path** and won't be supported after **August 31, 2024**. Any new data centers that are brought online after January 1, 2024, won't support the Log Analytics agent. If you use the Log Analytics agent to ingest data into Azure Monitor, [migrate to the new Azure Monitor agent](/azure/azure-monitor/agents/azure-monitor-agent-migration) before that date.

### More benefits of migration

In addition to providing a more focused and improved set of features than the legacy Log Analytics agent offers, Azure Monitor Agent provides some immediate benefits:

- Cost savings
- Simplified management experience
- Enhanced security and performance

## Next steps

> [!div class="nextstepaction"]
> [Step 1: Plan your migration](step-1-plan-your-migration.md)
