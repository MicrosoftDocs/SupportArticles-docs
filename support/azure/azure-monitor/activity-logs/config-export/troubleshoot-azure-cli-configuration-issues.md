---
title: Troubleshoot Azure CLI Configuration Issues
description: Troubleshooting guide for Azure CLI configuration issues.
ms.date: 07/22/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of activity logs
---

# Troubleshoot Azure CLI configuration issues

This article discusses issues that are related to configuring Microsoft Azure to export activity logs by using PowerShell or CLI. Because of missing proxy certificates, users might experience difficulties when they try to run PowerShell commands.

## Common issues and solutions

- **Issue:** PowerShell commands don't run.
- **Root Cause:** Missing proxy certificates that are required for command execution.

### Instructions to resolve configuration issues

1. **Verify proxy settings:**
   - Navigate to the **Network & Internet** settings on your system.
   - Make sure that the proxy settings are configured correctly to allow PowerShell access.

2. **Install proxy certificates:**
   - Download the necessary proxy certificates from your network administrator.
   - Open the **Certificates Manager** snap-in by typing `certmgr.msc` in the Windows search bar.
   - Import the downloaded certificates into the **Trusted Root Certification Authorities** store.

3. **Test PowerShell command execution:**
   - Open PowerShell and run a test command to check whether the issue is resolved.
   - Example command: `Get-AzActivityLog -MaxRecord 5`.

4. **Check Azure CLI configuration:**
   - Run `az upgrade` to verify that the Azure CLI is updated to the latest version.
   - Run `az configure` to verify that the CLI is configured correctly.

## References

- [Azure CLI Documentation](/azure/cli/)
- [PowerShell Documentation](/powershell/)
- [Azure Activity Logs Overview](/azure/azure-monitor/essentials/activity-log)

If the issue persists after you follow these steps, open a support case for further assistance.
