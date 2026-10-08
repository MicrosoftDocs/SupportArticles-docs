---
title: Collect support information from Azure Linux virtual machines
description: Learn how to collect an sos report or supportconfig diagnostic bundle from an Azure Linux virtual machine for troubleshooting with Microsoft Support.
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.date: 09/17/2026
ms.reviewer: divargas, esanchezvela
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: linux-related-content
ai-usage: ai-assisted
---

# Collect support information from Azure Linux virtual machines

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

This article describes how to collect support information from Azure Linux virtual machines (VMs) by using the `sos` or `supportconfig` utilities. Use this information when troubleshooting with Microsoft Support.

When you troubleshoot Linux workloads in Azure, a diagnostic bundle provides a snapshot of the system configuration, operating state, logs, kernel information, network configuration, storage layout, and installed packages. 

To troubleshoot this issue, collect the following items:

- An `sos` report on Red Hat Enterprise Linux (RHEL), CentOS, Oracle Linux, Ubuntu, Debian, Azure Linux, and similar distributions. 
- A `supportconfig` archive on SUSE Linux Enterprise Server (SLES) and openSUSE.

These bundles establish a technical baseline of the affected VM and provide a centralized, consistent source of information. They capture hundreds of data points in a standardized format instead of relying on fragmented screenshots, individual log files, or manual command output. This information accelerates root-cause analysis, reduces back-and-forth communication, preserves evidence of transient issues, supports correlation across system components, and improves collaboration with Microsoft Support.

> [!IMPORTANT]
> In rare cases, collecting a diagnostic bundle can cause a server to crash. Don't run the collection during a critical window. Review the potential impact before you proceed.

## Prerequisites

Ensure the following prerequisites are met before collecting support information:

- Root or `sudo` access to the Linux VM.
- Access to the secure file transfer workspace provided with your Microsoft Support request.

### Collect supportconfig on SLES or openSUSE

The `supportconfig` utility collects a large archive of system configuration and operating system diagnostics. The messages displayed while the command runs report collection progress. These messages aren't the diagnostic data that Microsoft Support analyzes.

1. Run `supportconfig` to gather all logs and disable automatic kernel module collection.

   ```bash
   sudo supportconfig -l -k
   ```

   The `-l` option gathers all logs. The `-k` option disables automatic kernel module collection, which significantly reduces the risk of unexpected server behavior.

1. If collection takes too long, check for old log files in `/var/log`. Move old logs to another location when possible instead of deleting them, because you might need to retain them for compliance.

1. When the collection finishes, locate the following files:

   - Checksum file: `/var/log/scc_<hostname>_<date>_<unique-id>.txz.md5`
   - Diagnostic archive: `/var/log/scc_<hostname>_<date>_<unique-id>.txz`

   :::image type="content" source="media/collect-support-information-from-azure-linux-virtual-machines/supportconfig-suse.png" alt-text="Screenshot of terminal output while supportconfig collects diagnostics on SLES.":::

1. Transfer the diagnostic archive to your workstation, and then upload it through the secure file transfer workspace provided with your Microsoft Support request. Don't send the archive through email, a Microsoft Teams session, or an Azure Storage account.

### Collect an sos report

Use RHEL, Ubuntu, Debian, or Azure Linux 4.0 to collect support information by using the appropriate tools.

# [RHEL](#tab/redhat)

Azure images for RHEL, CentOS, AlmaLinux, Rocky Linux, Oracle Linux, and Azure Linux commonly include the `sos` utility. The console messages report collection progress; they aren't the diagnostic data that Microsoft Support analyzes.

1. Run the report in batch mode and include all logs.

   ```bash
   sudo sos report --batch --all-logs
   ```

1. Locate the archive in `/var/tmp/`. Its name should follow this pattern.

   ```output
   sosreport-<hostname>-<date>-<random-string>.tar.xz
   ```

   :::image type="content" source="media/collect-support-information-from-azure-linux-virtual-machines/sosreport-redhat.png" alt-text="Screenshot of terminal output while sos collects diagnostics on a Red Hat system.":::

1. Transfer the archive to your workstation, and then upload it through the secure file transfer workspace provided with your Microsoft Support request.

# [Ubuntu or Debian](#tab/ubuntudebian)

On Ubuntu, Debian, and similar distributions, use the `sosreport` command. The default image might not include the package.

1. Check whether the `sosreport` package is installed. Run the following command. 

   ```bash
   sudo apt list --installed | grep sosreport
   ```

1. If the package isn't installed, update the package index and install it. Run the following command. 

   ```bash
   sudo apt update && sudo apt install sosreport
   ```

1. Run `sosreport`.

   ```bash
   sudo sosreport --batch --all-logs
   ```

1. Locate the archive in `/tmp/`. Its name should follow this pattern.

   ```output
   sosreport-<hostname>-<date>-<random-string>.tar.xz
   ```

   :::image type="content" source="media/collect-support-information-from-azure-linux-virtual-machines/sosreport-ubuntu.png" alt-text="Screenshot of terminal output while sosreport collects diagnostics on Ubuntu.":::

1. Transfer the archive to your workstation, and then upload it through the secure file transfer workspace provided with your Microsoft Support request.

# [Azure Linux 4](#tab/azl4)

Azure Linux 4 was in beta as of September 2026. Its default image might not include the `sos` package.

1. Install the `sos` package if necessary. Run the following command.

   ```bash
   sudo dnf install sos
   ```

1. Run the report in batch mode and include all logs.

   ```bash
   sudo sos report --batch --all-logs
   ```

1. Locate the archive in `/var/tmp/`. Its name should follow this pattern.

   ```output
   sosreport-<hostname>-<date>-<random-string>.tar.xz
   ```

   :::image type="content" source="media/collect-support-information-from-azure-linux-virtual-machines/sosreport-azurelinux4.png" alt-text="Screenshot of terminal output while sos collects diagnostics on Azure Linux 4.":::

1. Transfer the archive to your workstation, and then upload it through the secure file transfer workspace provided with your Microsoft Support request.

---

## Next steps

After you upload the archive, provide its filename and collection time so Microsoft Support can correlate the diagnostic snapshot with the reported issue.

[!INCLUDE [AI disclaimer](../../../includes/ai-generated-attribution.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]