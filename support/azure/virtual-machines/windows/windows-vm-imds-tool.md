---
title: Azure VM Instance Metadata Service Verification Tool
description: Azure VM Instance Metadata Service Verification Tool
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure VM Instance Metadata Service Verification Tool

**Applies to:** :heavy_check_mark: Windows VMs

The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can access the API only from within the virtual machine (VM). Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when they query IMDS. The IMDS IP address (`169.254.169.254`) must be handled in the same manner as the `168.63.129.16` IP address. For more information, see [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)

IMDS problems on Azure VMs can occur because of configuration, certificate, or connectivity issues. Microsoft provides a script-based tool to help diagnose and resolve most activation-related problems.

## Overview

This PowerShell script confirms the attestation signature that's provided by the Azure Instance Metadata Service (IMDS). The script makes sure that the certificate that's used in attestation is valid and trusted. It performs this action by trying to build a complete certificate chain. This process helps confirm the integrity and authenticity of an Azure VM’s identity. The script is also available through the Run command.

## Key features  

- Confirms that `169.254.169.254` is reachable.
- Validates IMDS certificate presence and correctness.
- Identifies certificate-related IMDS failures.
- Suggests corrective steps.

```
Example Warning
Certificate not found: 'CN=Microsoft Azure XXXX, ...'
```

For more information, see: 

- [Cause: Azure Instance Metadata Service connection issue](activation-watermark-appears.md#cause-1-azure-instance-metadata-service-connection-issue).
- [Azure VM Attested Metadata Verification Script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_IMDSValidation).

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use Azure Run command
   
- Navigate to your VM in the Azure portal: **Operations** > **Run Command**.
- Select the script from the list (see the following screenshot).

:::image type="content" source="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png" alt-text="Azure portal view Run command example." lightbox="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png":::   
  
> [!NOTE]
> Alternatively, you can run these commands by using a command-line interface (CLI) tool, Windows PowerShell, or Windows on ARM.

### 3. Use prepackaged Run command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **IMDS Cert Check** to verify the activation status and detect common issues.
2. Apply the suggested fixes, or refer to the official documentation for advanced troubleshooting.

## Additional resources

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
