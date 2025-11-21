---
title: Troubleshoot ephemeral OS disks in Azure Virtual Machines (VMs) and Azure Virtual Desktop (AVD)
description: Resolve deployment failures, data loss, and feature limitations with ephemeral OS disks for Azure Virtual Machines (VMs) and Azure Virtual Desktop (AVD). Get troubleshooting steps and best practices.
ms.topic: troubleshooting
ms.date: 10/23/2025
ms.reviewer: kaushika
audience: itpro
ms.custom: 
- sap:Azure Virtual Desktop\Remote Desktop Clients\Redirecting resources via the client
- pcy:wincomm-user-experience

---
# Troubleshoot ephemeral OS disks in Azure Virtual Machines (VMs) and Azure Virtual Desktop (AVD)

## Summary

Ephemeral OS disks (EOSD) are designed for Azure Virtual Machines (VMs) and Azure Virtual Desktop (AVD) session hosts, offering faster provisioning and reduced storage costs. However, users might encounter deployment failures, unexpected data loss, or functional limitations when the stateless design of EOSD and its dependencies on VM size and local storage aren't fully understood. This article helps identify and resolve these issues.

## Symptoms

- Deployment failures occur because of insufficient local storage for the OS image on specific VM sizes.
- Loss of OS-level changes after stopping, deallocating, or reimaging a VM.
- Confusion arises from unsupported EOSD features like snapshots, backups, and encryption.
- Operational delays and increased support cases for AVD and stateless workloads.

## Troubleshooting Guidance

### VM size incompatibility

**Cause**: Some VM sizes don't have enough local cache or temporary disk space to accommodate the OS image, causing deployment failures.

**Solution**:

- Check that the VM size supports EOSD by verifying the local cache or temporary disk size.
- Use the Azure CLI command `EphemeralOSDiskSupported` to confirm compatibility.
- For AVD, ensure the Temp Disk placement is selected during VM creation, as NVMe is not supported in public preview.

### Misunderstanding EOSD persistence

**Cause**: Ephemeral OS disks are designed as stateless disks, which means they don't support persistent features like snapshots, backups, or encryption.

**Solution**: Use managed OS disks for persistent features. If you need features such as backups, snapshots, or encryption, switch to managed OS disks instead of EOSD for your Azure VMs or AVD session hosts.

### Lifecycle mismanagement

**Cause**: Stop and deallocate operations wipe the OS state on EOSD, causing data loss.

**Solution**: Avoid stop and deallocate operations.

- Don't stop or deallocate VMs using EOSD, as this leads to data loss. Instead, design stateless workloads.
- Persist user profiles externally using FSLogix profile containers or Azure Files.

### Incorrect DiffDiskPlacement configuration

**Cause**: Selecting an unsupported placement option, such as NVMe, can cause deployment issues.

**Solution**: Correct DiffDiskPlacement configuration

- For AVD session hosts, ensure the Temp Disk placement is selected during deployment.
- Avoid selecting NVMe placement during public preview to prevent deployment issues.

### Regional SKU rollout gaps

**Cause**: Incomplete rollout of supported SKUs or backend bugs cause regional deployment issues.

**Solution**: Address regional SKU rollout gaps

- Monitor Azure announcements for updates on SKU availability.
- Deploy to another region or select a different SKU if rollout gaps affect your deployment.

### Best practices
- **Validate VM size and placement:** Before deployment, ensure your VM’s local cache or temporary disk can accommodate the OS image size.
- **Design stateless workloads:** Persist user profiles and application data externally using FSLogix profile containers or Azure Files.
- **Avoid stop/deallocate operations:** Use restart or delete/recreate logic for autoscale scenarios to prevent data loss.
- **Communicate limitations upfront:** Inform teams that EOSD doesn't support snapshots, backups, or Azure Disk Encryption.
- **Monitor regional availability:** Check supported SKUs and regions using Azure documentation before deployment.
- **Set up automated configuration:** Use VM extensions or scripts to reapply settings and applications after reimaging.
- **For AVD environments:**
    1. Use Temp Disk for ephemeral OS disk placement (NVMe isn't supported in public preview).
    1. Persist user profiles with FSLogix profile containers.
    1. Store application packages on Azure Files or Azure NetApp Files.
    1. Set up autoscale rules to delete and recreate hosts instead of deallocating them.

### More information

For further details, refer to the following resources:
- [Ephemeral OS disks for AVD session hosts](/azure/virtual-desktop/deploy/session-hosts/ephemeral-os-disks)
- [Ephemeral OS disks - Frequently Asked Questions](/azure/virtual-machines/ephemeral-os-disks-faq)