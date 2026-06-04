---
title: Troubleshoot NFS file shares - Azure Files
description: Troubleshoot issues with NFS Azure file shares.
ms.service: azure-file-storage
ms.custom: sap:Security, linux-related-content
ms.date: 06/03/2026
ms.reviewer: kendownie
---

# Troubleshoot NFS Azure file shares

**Applies to:** :heavy_check_mark: NFS Azure file shares

[!INCLUDE [CentOS End Of Life](../../../../includes/centos-end-of-life-note.md)]

This article lists common issues related to NFS Azure file shares and provides potential causes and workarounds.

> [!IMPORTANT]
> The content of this article only applies to NFS shares. To troubleshoot SMB issues in Linux, see [Troubleshoot Azure Files problems in Linux (SMB)](files-troubleshoot-linux-smb.md). NFS Azure file shares aren't supported for Windows.

## Use the Always-On Diagnostics tool

You can use the Always-On Diagnostics (AOD) tool to collect logs on NFSv4 and SMB Linux clients. The daemon runs in the background as a system service and can be configured to detect anomalies in various sources, such as dmesg logs, debug data, error metrics, and latency metrics. It can capture data from tcpdump, nfsstat, mountstsat, and other sources, along with the system's CPU and memory usage. The tool is useful for collecting debug information on field issues that are difficult to reproduce.

The Always-On Diagnostics tool is currently compatible with systems running SUSE Linux Enterprise Server 15 (SLES 15) and Red Hat Enterprise Linux 8 (RHEL 8). Follow the installation steps that correspond to your operating system:

> [!IMPORTANT]
> Always-On Diagnostics doesn't support NFS volumes with encryption in transit enabled. To enable log collection on the impacted NFS share, you must mount the share without EiT.

### [RHEL](#tab/RHEL)

In RHEL 8, follow these instructions to install the Always-On Diagnostics tool:

1. Download the repo configuration package.

    ```bash
    curl -ssl -O https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
    ```

1. Install the repo configuration package.

    ```bash
    sudo rpm -i packages-microsoft-prod.rpm
    ```

1. Delete the repo configuration package after installing and updating the package index files.

    ```bash
    rm packages-microsoft-prod.rpm
    sudo dnf update
    ```

1. Install the package.

    ```bash
    sudo dnf install aod
    ```

### [SLES](#tab/SLES)

In SLES 15, follow these instructions to install the Always-On Diagnostics tool:

1. Add the Microsoft repo. You might need to add the Microsoft repository key to your list of trusted keys.

    ```bash
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo zypper addrepo --check --refresh --name 'Microsoft' https://packages.microsoft.com/sles/15/prod microsoft
    ```

1. Refresh the repositories.

    ```bash
    sudo zypper refresh
    ```

1. Check if the repo is added and the `aod` package is available for installation.

    ```bash
    zypper search aod
    ```

1. Install the package.

    ```bash
    sudo zypper install aod
    ```

### [Ubuntu](#tab/Ubuntu)

The Always-On Diagnostics tool isn't currently available for Ubuntu.

---

## chgrp "filename" failed: Invalid argument (22)

### Cause 1: idmapping isn't disabled

Because Azure Files disallows alphanumeric UID/GID, you must disable idmapping.

### Cause 2: Disabled idmapping gets re-enabled after encountering bad file or directory name

Even if you disable idmapping, the system can automatically re-enable it in some cases. For example, when Azure Files encounters a bad file name, it sends back an error. Upon seeing this error code, an NFS 4.1 Linux client decides to re-enable idmapping, and sends future requests with alphanumeric UID or GID. For a list of unsupported characters on Azure Files, see [Naming and referencing shares, directories, files, and metadata](/rest/api/storageservices/naming-and-referencing-shares--directories--files--and-metadata). Colon is one of the unsupported characters.

### Workaround

Make sure you disable idmapping and that nothing re-enables it. Then perform the following steps:

1. Unmount the share.
1. Disable idmapping by running the following command:

    ```bash
    sudo echo Y > /sys/module/nfs/parameters/nfs4_disable_idmapping
    ```

1. Mount the share back.
1. If you're running `rsync`, run `rsync` with the `-numeric-ids` argument from a directory that doesn't have a bad directory or file name.

## Unable to create an NFS share

### Cause: Unsupported storage account settings

NFS is only available on storage accounts with the following configuration:

- Tier: Premium
- Account Kind: FileStorage

### Solution

Follow the instructions in [Create an NFS file share](/azure/storage/files/storage-files-quick-create-use-linux).

## Can't connect to or mount an NFS Azure file share

### Cause 1: Request originates from a client in an untrusted network or untrusted IP

Unlike SMB, NFS doesn't support user-based authentication. Authentication for a share depends on your network security rule configuration. To ensure clients only establish secure connections to your NFS share, you must use either the service endpoint or private endpoints. To access shares from on-premises in addition to private endpoints, you must set up a VPN or Azure ExpressRoute connection. The storage account firewall ignores IPs added to the allowlist. To set up access to an NFS share, use one of the following methods:

- [Service endpoint](/azure/storage/files/storage-files-networking-endpoints#restrict-access-to-the-public-endpoint-to-specific-virtual-networks)
  - Accessed by the public endpoint.
  - Only available in the same region.
  - You can't use VNet peering for share access.
  - You must add each virtual network or subnet individually to the allowlist.
  - For on-premises access, you can use service endpoints with ExpressRoute, point-to-site, and site-to-site VPNs. Use a private endpoint because it's more secure.

    The following diagram depicts connectivity using public endpoints:

    :::image type="content" source="media/files-troubleshoot-linux-nfs/connectivity-using-public-endpoints.png" alt-text="Diagram of public endpoint connectivity." lightbox="media/files-troubleshoot-linux-nfs/connectivity-using-public-endpoints.png":::

- [Private endpoint](/azure/storage/files/storage-files-networking-endpoints#create-a-private-endpoint)
  - Access is more secure than the service endpoint.
  - Access to NFS share via private link is available from within and outside the storage account's Azure region (cross-region, on-premises).
  - Virtual network peering with virtual networks hosted in the private endpoint give the NFS share access to the clients in peered virtual networks.
  - You can use private endpoints with ExpressRoute, point-to-site VPNs, and site-to-site VPNs.

    :::image type="content" source="media/files-troubleshoot-linux-nfs/connectivity-using-private-endpoints.png" alt-text="Diagram of private endpoint connectivity." lightbox="media/files-troubleshoot-linux-nfs/connectivity-using-private-endpoints.png":::

### Cause 2: nfs-utils, nfs-client, or nfs-common package isn't installed

Before running the `mount` command, install the nfs-utils, nfs-client, or nfs-common package.

To check if the NFS package is installed, run:

### [RHEL](#tab/RHEL)

The same commands in this section apply to CentOS and Oracle Linux.

```bash
sudo rpm -qa | grep nfs-utils
```

### [SLES](#tab/SLES)

```bash
sudo rpm -qa | grep nfs-client
```

### [Ubuntu](#tab/Ubuntu)

The same commands in this section apply to Debian.

```bash
sudo dpkg -l | grep nfs-common
```

---

#### Solution

If the package isn't installed, install the package by using your distro-specific command.

#### [RHEL](#tab/RHEL)

The same commands in this section apply to CentOS and Oracle Linux.

OS Version 7.X

```bash
sudo yum install nfs-utils
```

OS Version 8.X or 9.X

```bash
sudo dnf install nfs-utils
```

#### [SLES](#tab/SLES)

```bash
sudo zypper install nfs-client
```

#### [Ubuntu](#tab/Ubuntu)

The same commands in this section apply to Debian.

```bash
sudo apt update
sudo apt install nfs-common
```

---

### Cause 3: Firewall blocking port 2049

The NFS protocol communicates to its server over port 2049. Make sure that this port is open to the storage account (the NFS server).

#### Solution

Verify that port 2049 is open on your client by running the following command. If the port isn't open, open it.

```bash
sudo nc -zv <storageaccountnamehere>.file.core.windows.net 2049
```

### Cause 4: Storage account deleted

If you're unable to mount the file share due to **error: connection timed out**, the storage account containing the file share might be deleted accidentally.

#### Solution

[Recover the storage account](/azure/storage/common/storage-account-recover). Then, delete and re-create the private endpoint so it's associated with the new storage account resource ID.

### Cause 5: You're trying to mount the share using the NFS client mount instead of the AZNFS mount helper, and the **Secure transfer required** and/or **Require encryption in transit for NFS** setting is enabled on the storage account.

The **Secure transfer required** setting enforces encryption in transit for all file shares within the storage account unless the **Require encryption in transit for NFS** setting is enabled, in which case **Secure transfer required** only applies to REST/HTTPS traffic. For NFS file shares, using encryption in transit requires mounting the share using the AZNFS Mount Helper, a client utility package that abstracts the complexity of establishing secure tunnels for NFSv4.1 traffic.

#### Solution

Either disable both the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting and the [Require encryption in transit for NFS](/azure/storage/files/encryption-in-transit-for-nfs-shares#where-to-configure-the-setting) setting on the storage account, or use the AZNFS mount helper to mount the share. For more information, see [Encryption in transit for NFS Azure file shares](/azure/storage/files/encryption-in-transit-for-nfs-shares).

## ls hangs for large directory enumeration on some kernels

### Cause: A bug was introduced in Linux kernel v5.11 and fixed in v5.12.5

Some kernel versions have a bug that causes directory listings to result in an endless READDIR sequence. Small directories where all entries can be shipped in one call don't have this problem.
The bug was introduced in Linux kernel v5.11 and fixed in v5.12.5. So, any version in between has the bug. RHEL 8.4 uses this kernel version.

#### Workaround: Downgrade or upgrade the kernel

Downgrade or upgrade the kernel to a version outside the affected range to resolve the issue.

## System commands fail with the "File not found" error

### Cause

Linux 32-bit applications that rely on inode numbers might not work as expected with Azure Files due to the formatting of the 64-bit inode numbers generated by the NFS service.

### Solution

To resolve this issue, use one of the following methods:

- Compress the 64-bit inode numbers to 32 bits by using the `nfs.enable_ino64=0` kernel boot option.

- Set the module parameter by adding `options nfs enable_ino64=0` to  the */etc/modprobe.d/nfs.conf* file and rebooting the VM.

You can also persist this kernel boot option in the *grub.conf* file. For more information, see the documentation for your Linux distribution.

## Unable to change the ownership of files and directories

### Cause

The client OS enforces permissions on NFS file shares, not the Azure Files service. If you enable the **Root Squash** setting on an NFS file share, the root user on the client system becomes an anonymous (non-privileged) user for access control purposes. This restriction means that even if you're logged in as root on the client system, you can't use the `chown` command to change the ownership of files and directories that you don't own.

### Solution

In the Azure portal, go to the file share and select **Properties**. Change the **Root Squash** setting to **No Root Squash**. For more information, see [Configure root squash for Azure Files](/azure/storage/files/nfs-root-squash).

When you enable **No Root Squash**, the root user on the client system has the same privileges as the root user on the server system. You can now use `chown` to change the ownership of any file or directory in the share, regardless of the current owner. After you make the changes, you can re-enable **Root Squash** if necessary.

## Need help?

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your problem resolved quickly.

## See also

- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Troubleshoot Azure Files performance](../performance/files-troubleshoot-performance.md)
- [Troubleshoot Azure Files connectivity (SMB)](../connectivity/files-troubleshoot-smb-connectivity.md)
- [Troubleshoot Azure Files authentication and authorization (SMB)](files-troubleshoot-linux-nfs.md)
- [Troubleshoot Azure Files general SMB issues on Linux](files-troubleshoot-linux-smb.md)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

 
