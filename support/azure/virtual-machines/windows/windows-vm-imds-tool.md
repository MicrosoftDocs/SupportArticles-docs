---
title: Azure VM Instance Metadata Service Verification Script
description: Azure VM Instance Metadata Service Verification Script
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Troubleshooting tool for Azure VM Instance Metadata Service issues

**Applies to:** :heavy_check_mark: Windows VMs


The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can only access it from within the VM. Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when querying IMDS. IMDS IP address (`169.254.169.254`) must be handled in the same manner as the `168.63.129.16` IP address. For additional information, read about the [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)

IMDS problems on Azure virtual machines (VMs) can occur because of configuration, certificate, or connectivity issues. Microsoft provides a script-based tool to help diagnose and resolve most activation-related problems.

## Tool overview

### Azure Instance Metadata Service certificate check

**Purpose**  
This PowerShell script verifies the attestation signature provided by the Azure Instance Metadata Service (IMDS). It ensures that the certificate used in attestation is valid and trusted by attempting to build a complete certificate chain. This process helps confirm the integrity and authenticity of an Azure VM’s identity. The script is also available via Run Command.

**Key features**  

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
- [Azure VM Attested Metadata Verification Script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/IMDSCertCheck/README.md).

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.


### 2. Use Azure Run Command
   
- Navigate to your VM in the Azure portal: > **Operations** > **Run Command**.
- Select the script from the list (see the following screenshot).

:::image type="content" source="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-imds-tool/windows-vm-imds-tool-portal-runcmd.png":::   
  
> [!NOTE]
> Alternatively, you can run these commands by using a command-line interface (CLI) tool, Windows PowerShell, or Windows on ARM.

### 3. Use prepackaged Run Command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **IMDS Cert Check** to verify activation status and detect common issues.
2. Apply the suggested fixes or refer to the official documentation for advanced troubleshooting.

### **Additional resources**

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]