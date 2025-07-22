---
title: Troubleshoot Activity Log Download Issues
description: Troubleshooting guide for Azure Activity Log Download Issues
ms.date: 07/22/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshooting Activity Log download issues

When users try to download activity logs from Microsoft Azure, they might receive error messages that indicate that the CSV file wasn't prepared. This issue often occurs if the requested logs exceed a certain volume and cause the process to fail. Understanding the root cause and implementing the right solutions can help resolve this issue efficiently.

## Common issues and solutions

- **Issue**: The download process fails because an excessive number of logs are requested. This activity generates a "file not found" error.
- **Solution**: Reduce the range of time during which logs are requested to minimize the volume and prevent errors.

### Instructions to resolve download failures

1. **Identify the error**: Check the error message to verify that it relates to the CSV file preparation failure.
2. **Adjust the time range**: Navigate to the Azure portal, and access the Activity Logs section. Reduce the time range that you're trying to download logs for. This change can help decrease the number of logs that are processed.
3. **Clear the cache**: Clear your browser cache to make sure that no outdated data is causing issues.
4. **Request fewer logs**: If possible, break down the log requests into smaller batches to avoid overwhelming the system.
5. **Check storage account**: Make sure that the storage account where logs are stored is reachable and correctly configured.

## FAQ: Azure Activity Log download

- **Why does the download fail?**
  The download might fail if the number of requested logs is too large and prevents the system from being able to process them.

- **How can I prevent this issue?**
You can prevent the issue by preventing system from being overwhelmed. To do this, reduce the time range, and request logs in smaller batches.

## References

- [Azure Activity Logs Overview](/azure/azure-monitor/essentials/activity-log)
- [Azure Storage Documentation](/azure/storage/)
- [Azure Monitor Documentation](/azure/azure-monitor/)
- [Azure portal Guide](/azure/azure-portal/)

If the issue persists after you follow these steps, open a support case for further assistance.
