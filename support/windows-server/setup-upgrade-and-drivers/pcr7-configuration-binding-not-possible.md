---
title: PCR7 configuration in System Information shows as Binding not possible
description: Explains why System Information on either Windows Server or Windows Client shows the PCR7 configuration as Binding not possible, and how to troubleshoot the issue.
ms.date: 10/09/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, abjos
ms.custom:
- sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# PCR7 configuration in System Information shows as "Binding not possible" in either Windows Client or Windows Server

## Summary

This article applies to both Windows Server and Windows Client. It explains why the PCR7 configuration in System Information (*msinfo32*) shows **Binding not possible** even when TPM 2.0 and Secure Boot are enabled and BitLocker protection is active. The article also shows how to investigate EFI boot components that prevent PCR7 binding.

## Symptoms

When you open msinfo32 and review **System Summary**, **PCR7 Configuration** displays the value **Binding not possible**.

## Cause

PCR7 binding depends on the measurements created during the UEFI Secure Boot process. If an additional certificate authority (CA) hash or an EFI driver or boot application measurement appears in the PCR7 measurement sequence before the final Windows boot manager Windows Production CA measurement, BitLocker might not select the PCR 7, 11 validation profile.

In this situation, BitLocker can use the PCR 0, 2, 4, and 11 validation profile. Using that profile, Windows measures the exact binary hashes of the applicable boot components instead of relying on the CA certificate of measurement.

> [!IMPORTANT]  
> The **Binding not possible** status doesn't by itself mean BitLocker is disabled or that the TPM isn't ready. Confirm the protector status and PCR validation profile by using `manage-bde`.

## Resolution

### Troubleshoot the PCR7 binding

To identify the PCR validation profile that the BitLocker TPM protector uses, open an elevated PowerShell window, and then run the following command:

```powershell
manage-bde -protectors -get $env:systemdrive
```

In the command output, review the TPM's PCR Validation Profile. This part of the output resembles the following example:

```output
    TPM:
      ID: {00000000-0000-0000-0000-000000000000}
      PCR Validation Profile:
        7, 11
        (Uses Secure Boot for integrity validation)
```

This output shows one of the following sets of values:

- `7, 11`: BitLocker is using the PCR7-based validation profile.
- `0, 2, 4, 11`: BitLocker didn't select PCR7 binding.

If your environment requires the PCR7 binding, analyze the Measured Boot log to determine whether an extra EFI boot component or CA measurement prevents the PCR7 binding. For information about how to work use the Measured Boot log, see [Decode the Measured Boot log](../../windows-client/windows-security/decode-measured-boot-logs-to-track-pcr-changes.md). Search the decoded output for `PCR[07]`, and review the PCR7 measurements in the order in which they occur. For example, the sequence can include the following statements:

1. `EV_EFI_VARIABLE_AUTHORITY`
1. `EV_SEPARATOR`
1. `EV_EFI_VARIABLE_AUTHORITY`

Review the `EV_EFI_VARIABLE_AUTHORITY` entries to determine which certificate authority is associated with the measured EFI driver or boot application. An extra CA hash before the final Windows boot manager Windows Production CA measurement can prevent BitLocker from selecting PCR7.

For more information about Measured Boot, see [Measured Boot](/windows/security/hardware-security/tpm/how-windows-uses-the-tpm#measured-boot).

### Contact hardware or software vendor

If the Measured Boot log identifies an extra EFI driver, Option ROM, boot application, boot loader, or associated CA measurement, contact the hardware or software vendor. Ask the vendor to identify the component and provide a supported update, configuration change, or removal method.

Don't manually remove Secure Boot certificates or boot components without vendor guidance. Before making firmware or boot-chain changes, ensure the BitLocker recovery key is available and follow the vendor's supported procedure.

### Alternative: Use the PCR 0, 2, 4, 11 validation profile

If BitLocker uses the PCR 0, 2, 4, 11 validation profile, no change is required solely because PCR7 binding is unavailable. Verify that BitLocker protection is enabled, and record the active PCR validation profile for troubleshooting purposes. Windows remains protected when BitLocker uses either the PCR 0, 2, 4, 11 profile or the PCR 7, 11 profile.

## Data collection

If you need assistance from Microsoft Support, collect the applicable deployment and servicing information by using the [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

## More information

- [BitLocker drive encryption in Windows 11 for OEMs](/windows-hardware/design/device-experiences/oem-bitlocker)
- [Decode Measured Boot logs to track PCR changes](../../windows-client/windows-security/decode-measured-boot-logs-to-track-pcr-changes.md)
- [PCR banks on TPM 2.0 devices](/windows/security/hardware-security/tpm/switch-pcr-banks-on-tpm-2-0-devices)
- [manage-bde protectors](/windows-server/administration/windows-commands/manage-bde-protectors)
- [Secure Boot troubleshooting guide](https://support.microsoft.com/servicing/os/secure-boot/2026/03/secure-boot-troubleshooting-guide)
