---
title: Hyper-V VM Unexpectedly Missing in Windows Server 2016
description: Resolves issues that cause a virtual machine to disappear from a standalone Windows Server 2016 Hyper-V environment.
ms.date: 10/06/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\virtual machine state
- pcy: Virtualization\virtual machine state
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Hyper-V VM unexpectedly missing in Windows Server 2016

## Summary

This article discusses an issue in which a virtual machine (VM) unexpectedly disappears from a standalone Windows Server 2016 Hyper-V environment. While the VM is no longer visible in Hyper-V Manager, its associated virtual hard disk (VHD) files and data disks remain present on the host. The article provides an overview of the symptoms, potential causes, and resolution steps to assist affected users.

## Symptoms

You encounter the following symptoms:

- The VM is missing from Hyper-V Manager, but its associated VM files and data disks still exist on the host system.
- The issue occurs unexpectedly, often during nonbusiness hours (such as shortly after midnight).

When this issue occurs, the following conditions apply:

- No specific error message or event identifier is recorded in the logs.
- Other VMs on the same Hyper-V host remain unaffected and continue to operate without any issues.
- There's no evidence of manual deletion or intervention as reported by the user.
- The affected environment is in production. Recent maintenance or updating activities might have occurred.
- Recovery attempts, such as switching to a backup configuration in Azure, are successful. This condition indicates that the issue is isolated to the specific VM.

## Cause

The precise root cause of the VM disappearance isn't yet determined because of the unavailability of relevant log data. However, the following potential contributing factors are identified:

- Accidental deletion or corruption of the VM configuration files. This condition is possibly caused by antivirus software or other automated processes.

- Disk corruption or hardware issues that affect the VM configuration data.

- Early initiation of planned host decommission activities, either accidentally or because of miscommunication.

> [!NOTE]  
> Manually deleting a VM doesn't generate specific logs or event entries in Hyper-V. Therefore, it can be challenging to trace such actions after the fact.

## Resolution

To resolve the issue, follow these steps:

1. Log collection and analysis:

  Collect and upload Troubleshooting Support Script (TSS) logs that are specific to Hyper-V for further analysis. See [Data collection](#data-collection).
  
Customer guidance and best practices:

- Implement regular log retention policies to make sure that critical logs aren't purged.
- Maintain backups of VM configuration files and explore recovery options for similar scenarios.
- Review antivirus or automated processes that might inadvertently modify or delete VM files.

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

1. Use the TSS tool to collect detailed Hyper-V logs.
1. Retain logs for critical periods, especially during or after maintenance windows.
1. Archive VM configuration files and other related data as part of standard operating procedures.
1. Review event logs for any unusual activities, such as disk errors or antivirus actions that could affect VM configuration files.

## References

- [Troubleshoot Hyper-V virtual machine startup, state, and access failures](hyper-v-start-state-access-failures-clustered-standalone.md)
- [Best Practices Analyzer for Hyper-V](/previous-versions/windows-server/it-pro/windows-server-2016/virtualization/hyper-v/best-practices-analyzer/best-practices-analyzer-for-hyper-v)
- [Windows Server 2012 Hyper-V Best Practices](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/windows-server-2012-hyper-v-best-practices-in-easy-checklist-form/256060)
