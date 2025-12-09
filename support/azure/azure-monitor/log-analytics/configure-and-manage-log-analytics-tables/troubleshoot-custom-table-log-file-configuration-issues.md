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

    a. Navigate to the [Azure portal](https://portal.azure.com) and access your Log Analytics workspace.
    b. Check the integrity of the log files by reviewing the Log Management section.

2. **Check application team fixes**

    a. Ensure that the application team has addressed any log file issues.
    b. Confirm that the logs are now accessible and can be queried without errors.

3. **Test log queries**

    a. Use the Log Analytics query editor to run test queries.
    b. Confirm that the queries return expected results and that there are no errors.

4. **Monitor log performance**

    a. Use Azure Monitor charts to track log performance and identify any anomalies.
    b. Set up alerts for any unusual activity or errors in log queries.

## References

- [Azure Monitor overview](/azure/azure-monitor/fundamentals/overview)
- [Azure Monitor documentation](/azure/azure-monitor/)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]