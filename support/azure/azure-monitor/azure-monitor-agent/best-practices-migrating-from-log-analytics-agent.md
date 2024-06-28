# Best practices for migrating to Azure Monitor Agent from the Log Analytics agent

This article provides guidance on how to implement a successful migration to Microsoft Azure Monitor Agent from the Log Analytics agent.

## Overview

### Why migrate?

Azure Monitor Agent replaces the Log Analytics agent (previously known as Microsoft Monitoring Agent (MMA) and Operations Management Suite (OMS)) in the following components:

- Windows and Linux operating systems
- Azure and non-Azure architectures
- On-premises and third-party cloud environments

Azure Monitor Agent introduces a simplified, flexible method of configuring data collection by using data collection rules (DCRs).

> [!IMPORTANT]
> The Log Analytics agent is on a **deprecation path** and won't be supported after **August 31, 2024**. Any new data centers brought online after January 1, 2024 won't support the Log Analytics agent. If you use the Log Analytics agent to ingest data to Azure Monitor, [migrate to the new Azure Monitor agent](/azure/azure-monitor/agents/azure-monitor-agent-migration) before that date.

### More benefits for migration

In addition to consolidating and improving on the previous Log Analytics agent, Azure Monitor Agent provides some immediate benefits. These benefits include the following items:

- Cost savings
- Simplified management experience
- Enhanced security and performance

## Next steps

> [!div class="nextstepaction"]
> [Step 1: Plan your migration](step-1-plan-your-migration.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
