---
title: Troubleshoot Azure CLI Configuration Issues
description: Troubleshooting guide for Azure CLI configuration issues.
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of activity logs
---

# Troubleshoot Azure CLI configuration issues

This article discusses issues that are related to configuring Microsoft Azure to export activity logs by using PowerShell or CLI. Because of missing proxy certificates, users might experience difficulties when they try to run PowerShell commands.

## Common issues and solutions

- **Issue:** PowerShell commands don't run.
- **Root cause:** Missing proxy certificates that are required for command execution.

### Instructions to resolve configuration issues

1. Verify proxy settings:
   1. Navigate to the **Network & Internet** settings on your system.
   1. Make sure that the proxy settings are configured correctly to allow PowerShell access.

2. Install proxy certificates:
   1. Download the necessary proxy certificates from your network administrator.
   1. Open the **Certificates Manager** snap-in by typing `certmgr.msc` in the Windows search bar.
   1. Import the downloaded certificates into the **Trusted Root Certification Authorities** store.

3. Open PowerShell, and run a test command to check whether the issue is resolved. For example, run the following command:

      ```powershell
      `Get-AzActivityLog -MaxRecord 5`
      ```

4. Check the Azure CLI configuration:
   1. To verify that the Azure CLI is updated to the latest version, run `az upgrade`.
   1. To verify that the CLI is configured correctly, run `az configure`.

## References

- [Azure CLI Documentation](/azure/cli/)
- [PowerShell Documentation](/powershell/)
- [Azure Activity Logs Overview](/azure/azure-monitor/essentials/activity-log)

[!INCLUDE [azure-help-support](../../../../includes/azure-help-support.md)]
