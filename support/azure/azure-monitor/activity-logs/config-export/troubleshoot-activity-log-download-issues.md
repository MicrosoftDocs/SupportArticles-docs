---
title: Troubleshoot Activity Log Download Issues
description: Troubleshooting guide for Azure Activity Log Download Issues
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshooting Activity Log Download Issues

When attempting to download activity logs from Azure, users may encounter errors indicating a failure to prepare the CSV file. This issue often arises when the requested logs exceed a certain volume, causing the process to fail. Understanding the root cause and implementing the right solutions can help resolve this problem efficiently.

## Common Issues and Solutions

- **Issue**: The download process fails due to an excessive number of logs being requested, resulting in a "file not found" error.
- **Solution**: Reduce the range of time for which logs are being requested to minimize the volume and prevent errors.

### Step-by-Step Instructions to Resolve Download Failures

1. **Identify the Error**: Check the error message to confirm it relates to the CSV file preparation failure.
2. **Adjust Time Range**: Navigate to the Azure portal and access the Activity Logs section. Reduce the time range for which you are attempting to download logs. This can help decrease the number of logs being processed.
3. **Clear Cache**: Clear your browser cache to ensure no outdated data is causing issues.
4. **Request Fewer Logs**: If possible, break down the log requests into smaller batches to avoid overwhelming the system.
5. **Check Storage Account**: Ensure that the storage account where logs are being stored is reachable and properly configured.

## FAQ: Azure Activity Log Download

- **Why does the download fail?**
  The download may fail if the number of logs requested is too large, causing the system to be unable to process them.

- **How can I prevent this issue?**
  By reducing the time range and requesting logs in smaller batches, you can prevent the system from being overwhelmed.

## Reference

- [Azure Activity Logs Overview](https://learn.microsoft.com/azure/azure-monitor/essentials/activity-log)
- [Troubleshooting Azure Storage Issues](https://learn.microsoft.com/azure/storage/common/storage-troubleshooting)
- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/)
- [Azure Portal Guide](https://learn.microsoft.com/azure/azure-portal/)

If the issue persists after following the solution steps, please open a support case for further assistance.
