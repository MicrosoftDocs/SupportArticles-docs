---
title: Troubleshoot Secure Boot certificate updates on Linux Trusted Launch VMs
description: Diagnose and resolve Secure Boot certificate update issues on Azure Trusted Launch VMs running Linux, including shim bootloader and firmware certificate verification.
ms.date: 06/05/2026
author: scotro
ms.author: scotro
ms.service: azure-virtual-machines
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: arrenc
ms.custom:
- sap:virtual machines\vm management - configuration and setup
- pcy:VM Conf and Setup
appliesto:
  - <a href=https://learn.microsoft.com/azure/virtual-machines/trusted-launch target=_blank>Azure Trusted Launch VMs</a>
  - <a href=https://learn.microsoft.com/azure/confidential-computing/confidential-vm-overview target=_blank>Azure Confidential VMs</a>
---

# Troubleshoot Secure Boot certificate updates on Linux Trusted Launch VMs

This article helps you diagnose and resolve Secure Boot certificate update issues on Azure Trusted Launch virtual machines (TVM) and Confidential VMs (CVM) running supported Linux distributions.

## Applies to

- Ubuntu Server 22.04 LTS, 20.04 LTS
- Red Hat Enterprise Linux (RHEL) 9.4, 9.5, 9.6, 8.6, 8.8, 8.10
- SUSE Enterprise Linux 15 SP3, SP4, SP5
- Alma Linux 8.7, 8.8, 9.0
- Rocky Linux 8.6, 8.10, 9.2, 9.4, 9.6
- Oracle Linux 8.3–8.8, 9.0, 9.1
- Debian 11, 12
- Azure Linux 1.0, 2.0

## How Linux Secure Boot differs from Windows

Linux Trusted Launch VMs use the same Azure virtual firmware and Secure Boot certificate infrastructure as Windows VMs. The same Microsoft certificates (KEK, DB, DBX) are stored in the virtual firmware. However, the boot chain differs:

| Component | Windows | Linux |
|---|---|---|
| Boot chain | Boot Manager → OS | **shim** → GRUB2 → kernel |
| Cert that signs bootloader | Windows UEFI CA 2011/2023 | Microsoft UEFI CA 2011/2023 (signs shim) |
| Guest-side monitoring | Registry + Event IDs | `mokutil`, `efi-readvar`, `dmesg` |
| Update mechanism | Windows Update (automatic) | Platform firmware update + distro shim package |

The **shim** bootloader is signed by Microsoft's UEFI CA. When the 2011 CA expires in June 2026, VMs need the 2023 CA in firmware to validate future shim updates.

## Symptoms

You experience one or more of the following on an Azure Gen2 Trusted Launch Linux VM:

- VM fails to boot after a shim or GRUB update with a Secure Boot violation error.
- `mokutil --sb-state` shows Secure Boot is enabled, but `mokutil --db` shows only 2011-era certificates.
- `dmesg | grep -i secureboot` shows Secure Boot validation warnings.
- VM created before March 2024 has not received firmware certificate updates.

## Cause

Microsoft Secure Boot certificates issued in 2011 begin expiring in June 2026. Azure Trusted Launch and Confidential VMs running Linux use the same firmware certificate infrastructure (DB, KEK, DBX) as Windows VMs. The firmware certificates are platform-managed and injected at VM creation time.

Long-running VMs created before March 2024 may not have the 2023 certificates in virtual firmware. Without them, future shim and GRUB updates signed exclusively by the Microsoft UEFI CA 2023 won't validate against the firmware DB.

> [!NOTE]
> VMs created after March 2024 (including VMs deployed from older Marketplace images) receive 2023 certificates at creation. The at-risk population is VMs that have been continuously running since before March 2024.

## Determine Secure Boot certificate status

### Option 1: Run the diagnostic script via Run Command

Use the **Detect-SecureBootCertStatus-Linux.sh** RunCommand script:

1. In the Azure portal, navigate to your VM.
2. Select **Operations** > **Run command** > **RunShellScript**.
3. Download and paste the script from the [Azure Support Scripts repository](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Linux/SecureBootCertCheck).
4. Select **Run**.

### Option 2: Check manually

**Check Secure Boot state:**

```bash
# Is Secure Boot enabled?
mokutil --sb-state

# List certificates in the Secure Boot DB
mokutil --db | grep -A2 "Certificate"

# List certificates in KEK
mokutil --kek | grep -A2 "Certificate"

# Check for 2023 certificates specifically
mokutil --db | grep -i "2023"
```

**Check shim version and signature:**

```bash
# Ubuntu/Debian
dpkg -l | grep shim-signed
apt list --installed 2>/dev/null | grep shim

# RHEL/CentOS/Alma/Rocky/Oracle
rpm -qa | grep shim
rpm -qi shim-x64

# SUSE
rpm -qa | grep shim
```

**Check boot chain via dmesg:**

```bash
dmesg | grep -iE "secureboot|secure boot|uefi|shim|grub"
```

**Check EFI variables (requires root):**

```bash
# If efivarfs is mounted
ls /sys/firmware/efi/efivars/ | grep -i SecureBoot

# Read Secure Boot state directly
cat /sys/firmware/efi/efivars/SecureBoot-*/data 2>/dev/null | xxd | head -1
# Last byte: 01 = enabled, 00 = disabled
```

## Resolve certificate update issues

### Firmware certificate updates (platform-managed)

The Secure Boot certificates in virtual firmware (DB, KEK, DBX) are managed by the Azure platform, not by the Linux guest OS.

- **VMs created after March 2024:** 2023 certificates are pre-provisioned in virtual firmware. No action needed for firmware certs.
- **VMs created before March 2024:** Firmware certificates need updating. This update is coordinated between the guest OS and the Azure host platform.

> [!NOTE]
> The same Event 1795 host firmware issue that affected Windows VMs also affects Linux VMs. The host-side fix shipped in the Azure 2605_2 host OS servicing package (rolled out by end of May 2026). If firmware cert updates fail, restart or redeploy the VM.

### Shim bootloader updates (distro-managed)

Each Linux distribution ships its own shim bootloader, signed by Microsoft's UEFI CA. Distro maintainers must provide updated shims signed by the new Microsoft UEFI CA 2023.

**Update shim to the latest version:**

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install --only-upgrade shim-signed grub-efi-amd64-signed

# RHEL/CentOS/Alma/Rocky/Oracle
sudo dnf update shim-x64 grub2-efi-x64

# SUSE
sudo zypper update shim grub2-x86_64-efi
```

After updating, restart the VM:

```bash
sudo reboot
```

### Verify after update

```bash
# Confirm Secure Boot is still enabled
mokutil --sb-state

# Check that 2023 certificates are in DB
mokutil --db | grep -i "2023"

# Verify boot completed without errors
dmesg | grep -iE "secureboot|secure boot" | tail -5
journalctl -b | grep -i "secure boot"
```

## Pre-March 2024 VMs vs. newer VMs

| VM Creation Date | Firmware Certs | Shim Status | Action |
|---|---|---|---|
| **After March 2024** | 2023 certs pre-provisioned | Depends on image freshness | Update shim package from distro repos |
| **Before March 2024** | 2011 certs only | May have older shim | Restart/redeploy VM for firmware update + update shim |

## Impact of not updating

Linux VMs that don't receive the 2023 certificates will:

- **Continue to boot normally** with the current shim/GRUB/kernel chain.
- **Not be able to validate** future shim or GRUB updates signed exclusively with the 2023 CA.
- Have a **degraded security posture** — new boot-level security fixes may require the 2023 CA for signature validation.
- **Not** experience an immediate boot failure — the existing trust chain continues to work until old certificates are actively revoked via DBX.

> [!IMPORTANT]
> Azure cannot force Secure Boot certificate updates remotely via the hypervisor. The firmware certificate update requires platform coordination triggered by the guest OS. For the shim bootloader, customers must update via their distribution's package manager.

## Distro-specific considerations

### Ubuntu

- Canonical ships `shim-signed` package with shims signed by Microsoft.
- Check: `dpkg -l shim-signed | grep -E "^ii"`
- Ubuntu 22.04 LTS images from Azure Marketplace should have recent shims.

### RHEL

- Red Hat ships `shim-x64` package.
- Check: `rpm -q shim-x64`
- RHEL 8.x and 9.x images in Marketplace are maintained by Red Hat.

### SUSE

- SUSE ships `shim` package.
- Check: `rpm -q shim`
- SLES 15 SP3+ supports Trusted Launch.

### Azure Linux (Mariner/Azure Linux)

- Microsoft-maintained shim — updates ship via Azure Linux package repos.
- Check: `rpm -q shim-unsigned-x64` or `rpm -q shim`

## More information

- [Secure Boot update from 2011 to 2023 certificates: TVM and CVM (KB 5085395)](https://support.microsoft.com/topic/845ec199-03fa-4629-bdc3-822ae0bbe6ca)
- [Trusted Launch for Azure virtual machines](/azure/virtual-machines/trusted-launch)
- [Known issues and resolutions for Secure Boot certificates updates (KB 5085790)](https://support.microsoft.com/topic/5813673d-2577-4718-ad28-2554a9178e40)
- [Troubleshoot Secure Boot certificate updates on Windows Trusted Launch VMs](../windows/troubleshoot-secure-boot-cert-updates-trusted-launch.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
