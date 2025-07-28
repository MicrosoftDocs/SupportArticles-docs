---
title: Troubleshoot Activity Log Download Issues
description: Troubleshooting guide for Azure activity log download issues
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot Activity Log download issues

When users try to download activity logs from Microsoft Azure, they might receive error messages that indicate that the CSV file wasn't prepared. This issue often occurs if the requested logs exceed a certain volume and cause the process to fail. Understanding the root cause and implementing the right solutions can help resolve this issue efficiently.

## Common issues and solutions

- **Issue**: The download process fails because an excessive number of logs are requested. This activity generates a "file not found" error.
- **Solution**: Reduce the range of time during which logs are requested to minimize the volume and prevent errors.

### Instructions to resolve download failures

1. Check the error message to verify that it relates to the CSV file preparation failure.
2. Navigate to the Azure portal, and access the **Activity Logs** section.
3. Reduce the time range that you're trying to download logs for. This change can help decrease the number of logs that are processed.
4. Clear your browser cache to make sure that no outdated data is causing issues.
5. If possible, break down the log requests into smaller batches to avoid overwhelming the system.
6. Make sure that the storage account where the logs are stored is reachable and correctly configured.

## FAQ: Azure activity log download

**Q1: Why does the download fail?**

**A1:** The download might fail if the number of requested logs is excessive and prevents the system from being able to process the logs.

**Q2: How can I avoid download failures?**

**A2:** To avoid this issue, prevent the system from being overwhelmed. To do this, reduce the time range for the download, and request logs in smaller batches.

## References

- [Azure Activity Logs Overview](/azure/azure-monitor/essentials/activity-log)
- [Azure Storage documentation](/azure/storage/)
- [Azure Monitor documentation](/azure/azure-monitor/)
- [Azure portal guide](/azure/azure-portal/)

If the issue persists after you follow these steps, open a support case for further assistance.
