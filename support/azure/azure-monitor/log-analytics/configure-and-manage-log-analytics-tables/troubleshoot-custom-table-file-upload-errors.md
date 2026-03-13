---
title: Troubleshoot File Upload Errors when Creating Custom Tables in Azure
description: Troubleshooting guide for file upload errors when creating custom tables in Azure Log Analytics.
ms.date: 12/08/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: v-gsitser, v-ryanberg, neghuman
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot file upload errors when creating custom tables in Azure

Creating custom tables in Azure Log Analytics can sometimes present challenges, particularly when dealing with file uploads that result in errors. This article provides a step-by-step approach to troubleshoot and resolve issues related to creating custom tables.

## Symptoms

File upload errors occur when creating custom tables.

## Cause

The file format isn't supported by Azure for table creation.

## Resolution

Follow these steps to resolve this issue.

1. **Verify the file format**

Ensure the file you're attempting to upload is in a supported format. For more information, see [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs).

2. **Check the file size**

Confirm that the file size doesn't exceed the limits set by Azure. Large files may need to be split into smaller parts.

3. **Review documentation**

Familiarize yourself with [Add or delete tables and columns in Azure Monitor Logs](/azure/azure-monitor/logs/create-custom-table).

4. **Upload the file**

    1. Navigate to the [Azure portal](https://portal.azure.com) and access your Log Analytics workspace.
    1. Select **Custom Logs** and follow the prompts to upload your file.

Monitor for any error messages and address them as per the guidance provided in the documentation.

## References

- [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs)
- [Azure Monitor troubleshooting documentation](../../welcome-azure-monitor.yml)
