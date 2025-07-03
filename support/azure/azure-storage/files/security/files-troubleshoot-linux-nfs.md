---
title: Troubleshoot NFS file shares - Azure Files
description: Troubleshoot issues with NFS Azure file shares.
ms.service: azure-file-storage
ms.custom: sap:Security, linux-related-content
ms.date: 07/02/2025
ms.reviewer: kendownie
---

# Troubleshoot NFS Azure file shares

[!INCLUDE [CentOS End Of Life](../../../../includes/centos-end-of-life-note.md)]

This article lists common issues related to NFS Azure file shares and provides potential causes and workarounds.

> [!IMPORTANT]
> The content of this article only applies to NFS shares. To troubleshoot SMB issues in Linux, see [Troubleshoot Azure Files problems in Linux (SMB)](files-troubleshoot-linux-smb.md). NFS Azure file shares aren't supported for Windows.

## Applies to

| File share type | SMB | NFS |
|-|:-:|:-:|
| Standard file shares (GPv2), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-linux-nfs/no-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-linux-nfs/no-icon.png" border="false"::: |
| Standard file shares (GPv2), GRS/GZRS | :::image type="icon" source="media/files-troubleshoot-linux-nfs/no-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-linux-nfs/no-icon.png" border="false"::: |
| Premium file shares (FileStorage), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-linux-nfs/no-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-linux-nfs/yes-icon.png" border="false":::|

## Use the Always-On Diagnostics tool

You can use the Always-On Diagnostics (AOD) tool to collect logs on NFSv4 and SMB Linux clients. The daemon runs in the background as a system service and can be configured to detect anomalies in various sources, such as dmesg logs, debug data, error metrics, and latency metrics. It can capture data from tcpdump, nfsstat, mountstsat, and other sources, along with the system's CPU and memory usage. The tool is useful for collecting debug information on field issues that are difficult to reproduce.

The Always-On Diagnostics tool is currently compatible with systems running SUSE Linux Enterprise Server 15 (SLES 15) and Red Hat Enterprise Linux 8 (RHEL 8). Follow the installation steps that correspond to your operating system:

### [RHEL](#tab/RHEL)

In RHEL 8, follow these instructions to install the Always-On Diagnostics tool:

1. Download the repo config package.

    ```bash
    curl -ssl -O https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
    ```

2. Install the repo config package.

    ```bash
    sudo rpm -i packages-microsoft-prod.rpm
    ```

3. Delete the repo config package after installing and updating the package index files.

    ```bash
    rm packages-microsoft-prod.rpm
    sudo dnf update
    ```

4. Install the package.

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

2. Refresh the repositories.

    ```bash
    sudo zypper refresh
    ```

3. Check if the repo has been added and the `aod` package is available for installation.

    ```bash
    zypper search aod
    ```

4. Install the package.

    ```bash
    sudo zypper install aod
    ```

### [Ubuntu](#tab/Ubuntu)

The Always-On Diagnostics tool isn't currently available for Ubuntu.

---

## chgrp "filename" failed: Invalid argument (22)

### Cause 1: idmapping isn't disabled

Because Azure Files disallows alphanumeric UID/GID, you must disable idmapping.

### Cause 2: idmapping was disabled, but got re-enabled after encountering bad file/dir name

Even if you correctly disable idmapping, it can be automatically re-enabled in some cases. For example, when Azure Files encounters a bad file name, it sends back an error. Upon seeing this error code, an NFS 4.1 Linux client decides to re-enable idmapping, and sends future requests with alphanumeric UID/GID. For a list of unsupported characters on Azure Files, see this [article](/rest/api/storageservices/naming-and-referencing-shares--directories--files--and-metadata). Colon is one of the unsupported characters.

### Workaround

Make sure you've disabled idmapping and that nothing is re-enabling it. Then perform the following steps:

1. Unmount the share.
1. Disable idmapping with:

    ```bash
    sudo echo Y > /sys/module/nfs/parameters/nfs4_disable_idmapping
    ```

1. Mount the share back.
1. If running rsync, run rsync with the `-numeric-ids` argument from a directory that doesn't have a bad directory or file name.

## Unable to create an NFS share

### Cause: Unsupported storage account settings

NFS is only available on storage accounts with the following configuration:

- Tier: Premium
- Account Kind: FileStorage

### Solution

Follow the instructions in [Create an NFS file share](/azure/storage/files/storage-files-quick-create-use-linux).

## Can't connect to or mount an NFS Azure file share

### Cause 1: Request originates from a client in an untrusted network/untrusted IP

Unlike SMB, NFS doesn't have user-based authentication. The authentication for a share is based on your network security rule configuration. To ensure that clients only establish secure connections to your NFS share, you must use either the service endpoint or private endpoints. To access shares from on-premises in addition to private endpoints, you must set up a VPN or ExpressRoute connection. IPs added to the storage account's allowlist for the firewall are ignored. You must use one of the following methods to set up access to an NFS share:

- [Service endpoint](/azure/storage/files/storage-files-networking-endpoints#restrict-access-to-the-public-endpoint-to-specific-virtual-networks)
  - Accessed by the public endpoint.
  - Only available in the same region.
  - You can't use VNet peering for share access.
  - You must add each virtual network or subnet individually to the allowlist.
  - For on-premises access, you can use service endpoints with ExpressRoute, point-to-site, and site-to-site VPNs. We recommend using a private endpoint because it's more secure.

    The following diagram depicts connectivity using public endpoints:

    :::image type="content" source="media/files-troubleshoot-linux-nfs/connectivity-using-public-endpoints.png" alt-text="Diagram of public endpoint connectivity." lightbox="media/files-troubleshoot-linux-nfs/connectivity-using-public-endpoints.png":::

- [Private endpoint](/azure/storage/files/storage-files-networking-endpoints#create-a-private-endpoint)
  - Access is more secure than the service endpoint.
  - Access to NFS share via private link is available from within and outside the storage account's Azure region (cross-region, on-premises).
  - Virtual network peering with virtual networks hosted in the private endpoint give the NFS share access to the clients in peered virtual networks.
  - You can use private endpoints with ExpressRoute, point-to-site VPNs, and site-to-site VPNs.

    :::image type="content" source="media/files-troubleshoot-linux-nfs/connectivity-using-private-endpoints.png" alt-text="Diagram of private endpoint connectivity." lightbox="media/files-troubleshoot-linux-nfs/connectivity-using-private-endpoints.png":::

### Cause 2: nfs-utils, nfs-client or nfs-common package isn't installed

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

If the package isn't installed, install the package using your distro-specific command.

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

## ls hangs for large directory enumeration on some kernels

### Cause: A bug was introduced in Linux kernel v5.11 and was fixed in v5.12.5

Some kernel versions have a bug that causes directory listings to result in an endless READDIR sequence. Small directories where all entries can be shipped in one call don't have this problem.
The bug was introduced in Linux kernel v5.11 and was fixed in v5.12.5. So anything in between has the bug. RHEL 8.4 has this kernel version.

#### Workaround: Downgrade or upgrade the kernel

Downgrading or upgrading the kernel to anything outside the affected kernel should resolve the issue.

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

Permissions on NFS file shares are enforced by the client OS rather than the Azure Files service. If the **Root Squash** setting is enabled on an NFS file share, the root user on the client system is treated as an anonymous (non-privileged) user for access control purposes. This means that even if you're logged in as root on the client system, you can't use the `chown` command to change the ownership of files and directories that you don't own.

### Solution

In the Azure portal, navigate to the file share and select **Properties**. Change the **Root Squash** setting to **No Root Squash**. For more information, see [Configure root squash for Azure Files](/azure/storage/files/nfs-root-squash).

With **No Root Squash** enabled, the root user on the client system has the same privileges as the root user on the server system. You can now use `chown` to change the ownership of any file or directory in the share, regardless of the current owner. After you make the changes, you can re-enable **Root Squash** if necessary.

## Need help?

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your problem resolved quickly.

## See also

- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Troubleshoot Azure Files performance](../performance/files-troubleshoot-performance.md)
- [Troubleshoot Azure Files connectivity (SMB)](../connectivity/files-troubleshoot-smb-connectivity.md)
- [Troubleshoot Azure Files authentication and authorization (SMB)](files-troubleshoot-linux-nfs.md)
- [Troubleshoot Azure Files general SMB issues on Linux](files-troubleshoot-linux-smb.md)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
