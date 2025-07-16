---
title: Troubleshoot Azure CLI Configuration Issues
description: Troubleshooting guide for Azure CLI configuration issues.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot Azure CLI Configuration Issues

This article addresses issues related to configuring the export of Azure Activity Logs using PowerShell or CLI. Users may encounter difficulties executing PowerShell commands due to missing proxy certificates.

## Common Issues and Solutions

- **Issue:** PowerShell commands fail to execute.
- **Root Cause:** Missing proxy certificates required for command execution.

### Step-by-Step Instructions to Resolve Configuration Issues

1. **Verify Proxy Settings:**
   - Navigate to the **Network & Internet** settings on your system.
   - Ensure that the proxy settings are correctly configured to allow PowerShell access.

2. **Install Proxy Certificates:**
   - Download the necessary proxy certificates from your network administrator.
   - Open the **Certificates Manager** by typing `certmgr.msc` in the Windows search bar.
   - Import the downloaded certificates into the **Trusted Root Certification Authorities** store.

3. **Test PowerShell Command Execution:**
   - Open PowerShell and run a test command to verify if the issue is resolved.
   - Example command: `Get-AzActivityLog -MaxRecord 5`

4. **Check Azure CLI Configuration:**
   - Ensure that the Azure CLI is updated to the latest version by running `az upgrade`.
   - Verify that the CLI is configured correctly by executing `az configure`.

## Reference

- [Azure CLI Documentation](https://learn.microsoft.com/azure/cli/)
- [PowerShell Documentation](https://learn.microsoft.com/powershell/)
- [Azure Activity Logs Overview](https://learn.microsoft.com/azure/azure-monitor/essentials/activity-log)

If the issue persists after following the solution steps, please open a support case for further assistance.
