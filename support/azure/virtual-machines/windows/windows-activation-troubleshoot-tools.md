---
title: Troubleshooting Tools for Windows Activation 
description: Provides script-based tools to help diagnose and resolve Windows activation problems on Azure virtual machines.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.date: 10/24/2025
ms.reviewer: v-jsitser, scotro, v-ryanberg
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM, troubleshooting tools for Windows VM activation
---
#  Troubleshooting tools for Windows activation issues on Azure virtual machines

Windows activation problems on Azure virtual machines (VMs) can occur because of configuration, certificate, or connectivity issues. Microsoft provides two script-based tools to help diagnose and resolve most activation-related problems.

## Tools overview

### 1. Windows activation validation

**Purpose**  
  
Validates the activation status of your Windows VM and checks for common issues that prevent successful activation.

**Key features**  
  
  - Confirms Windows activation state.
  - Detects misconfigurations.
  - Provides actionable guidance.

For more information, see [Windows activation validation](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/WindowsActivationValidation/README.md).

### 2. Azure Instance Metadata Service certificate check

**Purpose**  

Verifies the integrity and availability of certificates that are required for activation through Azure Instance Metadata Service (IMDS).

**Key features**  

  - Validates IMDS certificate presence and correctness.
  - Identifies certificate-related activation failures.
  - Suggests corrective steps.

For more information, see: 

- [Cause: Azure Instance Metadata Service connection issue](activation-watermark-appears.md#cause-1-azure-instance-metadata-service-connection-issue).
- [Azure VM Attested Metadata Verification Script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/IMDSCertCheck/README.md).

## How to run these tools

You can run these tools in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use Azure Run Command
   
- Navigate to your VM in the Azure portal: > **Operations** > **Run Command**.
- Select the script from the list (see the following screenshot).

:::image type="content" source="media/windows-activation-troubleshoot-tools/azure-portal-view.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-activation-troubleshoot-tools/azure-portal-view.png":::   
  
> [!NOTE]
> Alternatively, you can run these commands by using a command-line interface (CLI) tool, Windows PowerShell, or Windows on ARM.

### 3. Use prepackaged Run Command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **Windows Activation Validation** to verify activation status and detect common issues.
2. If certificate-related errors are suspected, run **IMDS Certificate Check**.
3. Apply the suggested fixes or refer to the official documentation for advanced troubleshooting.

### **Additional resources**

- [Additional troubleshooting guidance](/azure/virtual-machines/windows/troubleshoot-activation-problems)
- [Virtual Machines licensing FAQ](https://azure.microsoft.com/pricing/licensing-faq/?msockid=16f3be2d0f1066e62759a8150e8867c4).

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
