---
title: Azure VM Instance Metadata Service Verification Tool for Linux
description: Learn how to use the IMDS Verification Tool to diagnose certificate chain, connectivity, and store issues on Azure Linux VMs.
ms.service: azure-virtual-machines
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.reviewer: scotro, jugross, azurevmcptcic
---
# Azure VM IMDS verification tool for Linux

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

The Azure VM Instance Metadata Service (IMDS) Verification Tool for Linux is a bash script that diagnoses certificate chain, connectivity, and certificate store problems related to IMDS on Linux VMs. The tool automatically detects your Linux distribution and provides distro-specific fix commands.

## How the tool works

The tool runs seven diagnostic phases:

| Phase | Check | What it does |
|---|---|---|
| 1 | **IMDS Reachability** | Tests connectivity to `169.254.169.254` |
| 2 | **Attestation Fetch** | Retrieves the attested document and extracts the signing certificate from the PKCS#7 envelope |
| 3 | **Chain Validation** | Validates the certificate chain against the system trust store by using `openssl verify` |
| 4 | **OCSP Detection** | Automatically detects which OCSP intermediate (02-16) your VM is using |
| 5 | **Store Inventory** | Checks for DigiCert Root G2, Microsoft TLS RSA Root G2, and the OCSP intermediate in the trust store |
| 6 | **Connectivity** | Tests TCP connectivity to AIA, CRL, and OCSP endpoints |
| 7 | **Summary** | Detects your distribution and provides the correct fix commands |
| 8 | **AutoFix** (optional) | When you specify `--autofix`: downloads missing certificates, installs them, updates the trust store, and re-validates the chain |

## Supported distributions

| Distribution | Cert Path | Update Command |
|---|---|---|
| Ubuntu / Debian | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| RHEL / CentOS / Oracle Linux / Azure Linux | `/etc/pki/ca-trust/source/anchors/` | `update-ca-trust` |
| SUSE / openSUSE | `/usr/share/pki/trust/anchors/` | `update-ca-certificates` |

## How to run the tool

## [Azure CLI](#tab/cli)

```azurecli
az vm run-command invoke \
    --resource-group <resource-group> \
    --name <vm-name> \
    --command-id RunShellScript \
    --scripts @Linux_IMDSValidation.sh
```

## [Download and run locally](#tab/local)

```bash
curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/master/RunCommand/Linux/Linux_IMDSValidation/Linux_IMDSValidation.sh | sudo bash
```

To automatically fix missing certificates, add `--autofix`:

```bash
curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/master/RunCommand/Linux/Linux_IMDSValidation/Linux_IMDSValidation.sh | sudo bash -s -- --autofix
```

> [!NOTE]
> Without `--autofix`, the script is diagnostic only and makes no changes to the system. With `--autofix`, the script downloads missing intermediate certificates, converts them from DER to PEM, installs them to the correct distro-specific trust directory, runs the trust store update command, and re-validates the chain.

Or download and run manually:

```bash
chmod +x Linux_IMDSValidation.sh
sudo ./Linux_IMDSValidation.sh
```

---

## DER to PEM conversion

> [!IMPORTANT]
> Microsoft provides certificates in **DER format**. Linux trust stores require **PEM format**. The tool's fix commands include the conversion step. If you install certificates manually, always convert first:

```bash
openssl x509 -in certificate.der -inform DER -out certificate.crt
```

## Additional resources

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [IMDS Certificate Chain Issues (Linux)](linux-vm-imds-certissues.md)
- [IMDS Certificate Chain Issues (Windows)](../windows/windows-vm-imds-certissues.md)
- [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains)
- [Source code on GitHub](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Linux/Linux_IMDSValidation)
