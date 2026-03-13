---
title: Troubleshoot Log File Configuration Issues when Managing Custom Tables in Azure
description: Troubleshooting guide for log file configuration issues when managing custom tables in Azure.
ms.date: 12/08/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: v-ryanberg, neghuman
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot log file configuration issues when managing custom tables in Azure

## Symptoms

When managing custom tables in Azure Log Analytics, users are unable to query logs due to a problem with the log file configuration.

## Cause

This issue isn't related to configuration settings. It's due to problems with the log file itself.

## Resolution

Follow these steps to resolve this issue.

1. **Verify log file integrity**

    1. Navigate to the [Azure portal](https://portal.azure.com) and access your Log Analytics workspace.
    1. Check the integrity of the log files by reviewing the Log Management section.

2. **Check application team fixes**

    1. Ensure that the application team has addressed any log file issues.
    1. Confirm that the logs are now accessible and can be queried without errors.

3. **Test log queries**

    1. Use the Log Analytics query editor to run test queries.
    1. Confirm that the queries return expected results and that there are no errors.

4. **Monitor log performance**

    1. Use Azure Monitor charts to track log performance and identify any anomalies.
    1. Set up alerts for any unusual activity or errors in log queries.

## References

- [Azure Monitor overview](/azure/azure-monitor/fundamentals/overview)
- [Azure Monitor documentation](/azure/azure-monitor/)