---
title: Azure VM Instance Metadata Service Verification Tool
description: Learn how to use the IMDS Verification Tool to diagnose certificate chain, connectivity, and store issues on Azure Windows VMs.
ms.service: azure-virtual-machines
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jugross, azurevmcptcic
---
# Azure VM Instance Metadata Service verification tool

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

The Azure VM Instance Metadata Service (IMDS) Verification Tool is a PowerShell script that diagnoses certificate chain, connectivity, and certificate store problems related to IMDS on Windows VMs. You can use the tool as an Azure Run Command (`Windows_IMDSValidation`) or download it from GitHub.

## How the tool works

The tool runs six diagnostic phases:

| Phase | Check | What it does |
|---|---|---|
| 1 | **IMDS Reachability** | Tests TCP connectivity to `169.254.169.254:80` |
| 2 | **Attestation Fetch** | Retrieves the attested document from IMDS and displays the signing certificate details (subject, issuer, thumbprint, validity) |
| 3 | **Chain Validation** | Builds the X509 certificate chain and walks **each element** to identify the exact certificate causing a failure, including the specific error status |
| 4 | **Store Inventory** | Checks whether each certificate in the chain is permanently installed in the correct store. Flags certificates that were auto-downloaded through AIA, certificates in the wrong store, and certificates in the Disallowed store |
| 5 | **Connectivity** | Tests TCP port 80 connectivity to AIA, CRL, and OCSP endpoints needed for certificate download and revocation checking |
| 6 | **Summary** | Provides actionable recommendations with specific download URLs for any missing certificates |
| 7 | **AutoFix** (optional) | When you specify `-AutoFix`: downloads missing certificates, installs them, re-validates the chain, and runs `fclip.exe` to clear the activation watermark |

## Certificate chain architecture

The tool validates the following four-level IMDS attestation certificate chain:

```
DigiCert Global Root G2 (Root CA)
  +-- Microsoft TLS RSA Root G2 (cross-signed intermediate)
        +-- Microsoft TLS G2 RSA CA OCSP xx (OCSP responder intermediate)
              +-- CN=metadata.azure.com (leaf certificate)
```

> [!IMPORTANT]
> **OCSP intermediate rotation:** Azure rotates which OCSP responder intermediate it uses (numbered 02, 04, 06, 08, 10, 12, 14, 16). The tool dynamically detects which OCSP intermediate your VM is currently using rather than checking only a single hardcoded thumbprint.

> [!NOTE]
> **"Microsoft TLS RSA Root G2" isn't a root CA** despite its name. It's a cross-signed intermediate certificate issued by DigiCert Global Root G2.

## How to run the tool

## [Azure portal](#tab/portal)

1. In the Azure portal, go to your VM.
1. Select **Operations** > **Run Command**.
1. Select **Windows_IMDSValidation** from the script list.
1. Select **Run**.

:::image type="content" source="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png" alt-text="Screenshot of the Azure portal Run command view showing the Windows_IMDSValidation IMDS verification script." lightbox="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png":::

## [Azure CLI](#tab/cli)

```azurecli
az vm run-command invoke \
    --resource-group <resource-group> \
    --name <vm-name> \
    --command-id RunPowerShellScript \
    --scripts @Windows_IMDSValidation.ps1
```

## [Azure PowerShell](#tab/powershell)

```azurepowershell
Invoke-AzVMRunCommand -ResourceGroupName <resource-group> `
    -VMName <vm-name> `
    -CommandId RunPowerShellScript `
    -ScriptPath .\Windows_IMDSValidation.ps1
```

## [Run locally](#tab/local)

1. Download the script from [GitHub](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_IMDSValidation).
1. Open PowerShell as an administrator on the VM.
1. Run the script:

```powershell
Set-ExecutionPolicy Bypass -Force
.\Windows_IMDSValidation.ps1
```

To automatically fix missing certificates, add `-AutoFix`:

```powershell
.\Windows_IMDSValidation.ps1 -AutoFix
```

> [!NOTE]
> Without `-AutoFix`, the script is diagnostic only and makes no changes to the system. With `-AutoFix`, the script downloads missing intermediate certificates, installs them to the correct store, revalidates the chain, and runs `fclip.exe` to clear any activation watermark. The script skips certificates in the Disallowed store because they represent explicit policy decisions.

---

## Interpret results

### Phase 3: Chain validation

| Output | Meaning |
|---|---|
| `[OK]` for all elements | Certificate chain is healthy |
| `[FAIL]` with `Revoked` / `ExplicitDistrust` | Certificate is in the Disallowed store |
| `[FAIL]` with `UntrustedRoot` | Root CA is missing or distrusted |
| `[FAIL]` with `PartialChain` | An intermediate certificate is missing |
| `[FAIL]` with `RevocationStatusUnknown` | Cannot reach CRL/OCSP endpoints for revocation checking |

### Phase 4: Store inventory

| Output | Meaning | Action |
|---|---|---|
| `[OK]` | Certificate in correct store | None needed |
| `[MISS] (active chain)` | Certificate used in the chain but not permanently installed | Download and install from the URL shown |
| `[MISS] (active chain) (was auto-downloaded via AIA)` | Certificate was fetched at runtime but is only cached, not permanently installed | Install permanently to avoid failures if AIA is later blocked |
| `[MISS] (known)` | Certificate is in the known list but not used by this VM's current chain | May not be needed for this VM (OCSP rotation) |
| `[WARN] Also found in:` | Certificate exists in a non-standard store | Chain validation still works but consider moving to the correct store |
| `[WARN] Certificate is in the DISALLOWED store!` | Certificate is explicitly blocked | Remove from Disallowed store |

### Phase 5: Connectivity

| Output | Meaning |
|---|---|
| `[+]` for all endpoints | All certificate download and validation endpoints reachable |
| `[-] BLOCKED` for AIA endpoints | Firewall or proxy is blocking certificate downloads. This action prevents auto-download of missing intermediates |
| `[-] BLOCKED` for CRL/OCSP endpoints | Revocation checking fails. Chain validation reports `RevocationStatusUnknown` |

## Common scenarios

For detailed troubleshooting steps for each scenario, see [IMDS certificate chain issues](windows-vm-imds-certissues.md).

## Additional resources

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [IMDS Certificate Chain Issues](windows-vm-imds-certissues.md)
- [IMDS Connection Issues](windows-vm-imds-connection.md)
- [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)
- [Source code on GitHub](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_IMDSValidation)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
