---
title: Azure Instance Metadata Service Troubleshooting Tool
description: Azure Instance Metadata Service Troubleshooting Tool
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure Instance Metadata Service Troubleshooting Tool

**Applies to:** :heavy_check_mark: Windows VMs

## Azure VM Attested Metadata Verification Script

Location: [IMDSCertCheck](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/IMDSCertCheck)

This PowerShell script verifies the attestation signature provided by the Azure Instance Metadata Service (IMDS). It ensures that the certificate used in attestation is valid and trusted by attempting to build a complete certificate chain. This process helps confirm the integrity and authenticity of an Azure VM’s identity. The script is also available via Run Command.

### Key Features

- Confirms that `169.254.169.254` is reachable.
- Retrieves attested metadata from the Azure Instance Metadata Service.
- Extracts and decodes the cryptographic signature.
- Attempts to build a certificate chain for validation.
- Warns if any certificates in the chain are missing and provides a link to Microsoft documentation for remediation.

```
Example Warning
Certificate not found: 'CN=Microsoft Azure XXXX, ...'
```

Please refer to the following [link to download missing certificates:](
https://learn.microsoft.com/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains)

---


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
