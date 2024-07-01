---
title: Step 6 - Configure other services to use Azure Monitor Agent
description: Learn how to configure other services to use Azure Monitor Agent as part of the process of migrating from the legacy Log Analytics agent.
ms.date: 07/08/2024
author: neilghuman
ms.author: neghuman
ms.reviewer: jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to learn how to configure other services to use Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 6: Configure other services

After you deploy Azure Monitor Agent at scale, you can configure other services to use Azure Monitor Agent instead of the legacy Log Analytics agent. Configuration guidance links are shown for various services in the following table.

| Service | Guidance link |
|--|--|
| Update Management | [Automation update management](/azure/azure-monitor/agents/azure-monitor-agent-migration-helper-workbook#automation-update-management) |
| Change Tracking | [Migration guidance from Change Tracking and inventory](/azure/automation/change-tracking/guidance-migration-log-analytics-monitoring-agent) |
| Microsoft Defender for Cloud | [Azure Monitor Agent in Defender for Cloud](/azure/defender-for-cloud/auto-deploy-azure-monitoring-agent) |
| Microsoft Sentinel | [Azure Monitor Agent migration for Microsoft Sentinel](/azure/sentinel/ama-migrate) |

## Next steps

> [!div class="nextstepaction"]
> [Step 7: Remove Microsoft Monitoring Agent and clean up configurations](step-7-microsoft-monitoring-agent-clean-up-configurations.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
