---
title: Troubleshoot Virtual TPM, Shielded VM, and Host Guardian Service Issues
description: Helps troubleshoot virtual TPM (vTPM), shielded virtual machine (VM), and Host Guardian Service (HGS) issues in Hyper-V clusters.
ms.date: 08/12/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhuge, v-lianna
ms.custom:
- sap:virtualization and hyper-v\shielded virtual machines
- pcy:WinComm Storage High Avail
ai-usage: ai-assisted
---
# Troubleshoot vTPM, shielded VM, and HGS issues in Hyper-V clusters

This guide provides a structured approach to resolving issues with virtual Trusted Platform Module (vTPM), shielded virtual machine (VM), and Host Guardian Service (HGS) in Hyper-V clusters. Always test changes in a nonproduction environment and maintain backups before implementing solutions. For unresolved issues, consult your hardware vendor or Microsoft support.

VTPM, shielded VM, and HGS are vital features in Hyper-V clusters, especially for ensuring secure virtual environments and compliance with modern operating system requirements, such as Windows 11. However, issues with these features can arise due to misconfigurations, hardware or firmware incompatibilities, or software errors. These problems might impact VM startup, migration, or security configuration, causing significant disruptions. This guide consolidates common scenarios, their causes, and resolutions to help restore secure VM operations efficiently.

## End-user and technical symptoms

- VMs with vTPM enabled fail to start or migrate between cluster nodes.
- VMs remain operational only on their original hosts and can't fail over.
- Shielded VMs can't start, migrate, or fail over.
- Shield icons persist in management tools even after disabling shielding.
- Attestation or key unwrap operations fail when using HGS over HTTPS.
- VMs disappear from the cluster or management tools after cluster-aware updating or patching.
- BitLocker enablement fails, or device encryption is reported as unsupported.
- HGS attestation fails on all or some guarded hosts.
- VMs fail to start after enabling TPM or upgrading the operating system.
- Expanding an HGS cluster with nodes of differing hardware models fails.
- Device encryption support reports errors such as "Feature is not available," "winre is not configured," or "hardware security test interface failed."

## Specific error messages and event IDs

- > Key protector could not be unwrapped.
- > HGS cannot be an owner because it does not have private keys.
- > Local security policy for virtual machine could not be generated automatically.  

    Error code: 0x80131500
- > The computed authentication tag did not match the input authentication tag.

    Error code: 0xC000A002
- > The virtual machine doesn't have a key protector, and the key protector can't be added automatically in a guarded fabric.
- > Invoke-CimMethod: [Function Name] failed using algorithm: Rsa.

    HRESULT: 0x80131500
- Event ID 2014, `Microsoft-Windows-HostGuardianService-Client/Admin`.
- Event ID 57, `CertificateServicesClient-CertEnroll`, and Event ID 11, `Microsoft-Windows-CAPI2/Operational`.
- "TransientError Host Unreachable" during HGS attestation/key unwrap.
- "HasPrivateSigningKey = False" after guardian import.
- Cluster logs showing "Catastrophic failure (0x8000FFFF)."

## Cause 1: Certificate and key protector issues

- Missing or mismatched certificates: vTPM and shielded VMs require signing and encryption certificates. Problems arise if certificates are missing or improperly restored during migration or export/import processes.
- Untrusted or broken key protectors/guardians: Guardian misconfigurations or missing private keys can block VM operations.
- Deleted or unrestored certificates: Shielded VM certificates that are accidentally deleted or not restored cause VMs to become nonoperational.
- Certificate Subject Alternative Name (SAN) or trust issues: HGS over HTTPS fails if certificates lack the required SANs or if there are trust issues.

### Resolution: Certificate and key protector resolution

1. Export and import certificates with private keys:

    - Export certificates from the source host using **certlm.msc** or PowerShell:

        ```powershell
        Export-PfxCertificate -Cert (Get-ChildItem -Path Cert:\LocalMachine\My<thumbprint>) -FilePath C:\path\to\export.pfx -Password (ConvertTo-SecureString -String '' -AsPlainText -Force)
        ```

    - Import certificates on the destination host:

        ```powershell
        Import-PfxCertificate -FilePath C:\path\to\export.pfx -CertStoreLocation Cert:\LocalMachine\My -Password (ConvertTo-SecureString -String '' -AsPlainText -Force)
        ```

2. Regenerate key protectors:

    ```powershell
    $Owner = Get-HgsGuardian -Name "UntrustedGuardian"
    $KP = New-HgsKeyProtector -Owner $Owner -AllowUntrustedRoot
    Set-VMKeyProtector -VMName -KeyProtector $KP.RawData
    Enable-VMTPM -VMName
    ```

3. Update signing and encryption certificates. Use `Set-VMKeyProtector` to assign the correct certificates.
4. Resolve missing certificates. Create a new VM using the original VHDX file and configure the vTPM and key protector settings.

## Cause 2: TPM, hardware, driver, and firmware incompatibilities

- TPM model or firmware incompatibility: Earlier TPM models, such as HPE Gen9/Gen10, might lack support for required algorithms like RSAPSS.
- Outdated storage drivers/firmware: Encryption features often require updated drivers and firmware.
- Central processing unit (CPU) compatibility issues: Live migration might fail if CPU compatibility isn't configured across cluster nodes.

### Resolution: Firmware, driver, and hardware remediation

1. Update storage and TPM firmware. Work with hardware vendors to apply the latest updates.
2. Check TPM support for required algorithms:

    Verify RSAPSS support using:

    ```powershell
    Get-WmiObject -Namespace "Root\CIMV2\Security\MicrosoftTpm" -Class Win32_Tpm
    ```

## Cause 3: Configuration and script errors

- Improper PowerShell script usage: Errors in automation scripts for enabling vTPM or shielded VM features can cause issues.
- Misconfiguration in HGS or cluster setup: Problems occur when required Windows features aren't enabled or HGS registration is incorrect.
- Mixing management tools: Concurrent modifications using tools like System Center Virtual Machine Manager (SCVMM), Failover Cluster Manager, and PowerShell can corrupt VM configurations.

### Resolution: Configuration, script, and management fixes

1. Correct PowerShell scripts. Ensure scripts appropriately handle vTPM enabling and verification.
2. Fix VM configuration corruption. Re-create VM shells with existing VHDX files and reassign key protectors.
3. Enable required Windows features:

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName IsolatedUserMode
    ```

4. Maintain guarded fabric consistency. Import VMs onto hosts within the same guarded fabric.

## Cause 4: File system and cluster configuration corruption

- Corrupted `.vmcx` (VM configuration) files: Cluster-aware updating (CAU) or failovers might corrupt VM configuration files.
- Guarded fabric/cluster node inconsistencies: Shielded VMs must be hosted on the same guarded fabric to function correctly.

### Resolution: Permissions, registry, and file system checks

1. Check file and folder permissions. Verify access rights for VM configurations and VHDX files.
2. Validate registry settings. Confirm settings for virtualization-based security, TPM, and HGS.

## Cause 5: Networking and security protocol issues

- Networking changes/disruptions: Network reconfigurations can temporarily interrupt HGS attestation.
- TLS/protocol mismatches: HGS might default to older TLS versions, and disabling TLS 1.0 without enabling TLS 1.2 can cause failures.

### Resolution: HGS attestation, protocol, and networking steps

1. Configure TLS protocols. Update registry settings to enable TLS 1.2 and disable TLS 1.0.
2. Resolve HTTPS certificate issues. Ensure certificates include the required SANs for all nodes.
3. Troubleshoot attestation failures. Test network connectivity using `Test-NetConnection`.

## Cause 6: Supportability and documentation gaps

- Unsupported HGS cluster expansion: Adding nodes with differing hardware models to an HGS cluster is unsupported.
- Documentation gaps: Lack of guidance for certain PowerShell or WMI methods can lead to configuration errors.

### Resolution: Best practices and documentation

1. HGS cluster expansion: Add only identical hardware nodes to HGS clusters.
2. Shielding existing VMs: Use WMI's `PrepareSpecializedMachine` method to shield VMs.

## Data collection

To gather data for troubleshooting:

- Collect logs via Event Viewer (Application, System, CAPI2, HostGuardianService-Client).
- Generate cluster logs:

    ```powershell
    Get-ClusterLog -Destination
    ```

- Use network diagnostic tools like `Test-NetConnection` and Wireshark.

## References

- [PrepareSpecializedMachine method of the Msps_ProvisioningService class](/previous-versions/windows/desktop/mspsserviceprov/msps-provisioningservice-preparespecializedmachine)
- Hyper-V and HGS official documentation on configuration and troubleshooting
