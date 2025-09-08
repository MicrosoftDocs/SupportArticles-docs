---
title: Windows 11 support on Azure virtual machines
description: Find details about Windows 11 support on Azure virtual machines. Learn about the criteria for Windows 11 eligibility.
author: mohak006
ms.author: mohak
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Windows (Guest OS)
ms.reviewer: scotro, kageorge, jarrettr, yutorigo, v-leedennis
editor: v-jsitser
ms.topic: upgrade-and-migration-article
ms.date: 04/02/2025
---
# Windows 11 support on Azure virtual machines

**Applies to:** :heavy_check_mark: Windows VMs

This article provides details about the applicable processors for Microsoft Azure virtual machines (VMs) that meet the requirements for Windows 11 support. Many of the VM products that are offered in Azure are supported by more than one configuration of physical hardware. Therefore, the underlying hardware generations can vary. Older VM products (such as D\*v2 and D\*v3 series VMs) can be installed on hosts that run older CPUs (such as Intel Broadwell and Haswell) and don't support Windows 11.

## Product support matrix

**Windows 11 support details for different Azure VM product families**

|VM product family|Windows 11 support|
|:----|:----|
|A-Series|No|
|A-Series v2|No|
|B-Series|No|
|Bsv2-Series|Yes|
|DCv2-Series|Yes|
|DCv3-Series|Yes|
|D-Series|No|
|Dv2-Series|No|
|Dv3-Series|No|
|Dv4-Series|Yes|
|Dv5-Series|Yes|
|Ddv5-Series|Yes|
|Dav5-Series|Yes|
|DCasv5-Series|Yes|
|Dpsv5-Series|Preview / No|
|Dplsv5-Series|Preview / No|
|Dlsv5-Series|Yes|
|Ev3-Series|No|
|Eav4-Series|Yes|
|Edv4-Series|Yes|
|Ev4-Series|Yes|
|Ev5-Series|Yes|
|Ebdsv5-Series|Yes|
|Edv5-Series|Yes|
|Easv5-Series|Yes|
|ECasv5-Series|Yes|
|Epsv5-Series|Preview / No|
|F-Series|No|
|Fsv2-Series|Yes|
|FX-Series|Yes|
|G-Series|No|
|GS-Series|No|
|HB-Series|No|
|HBv2-Series|Yes|
|HBv3-Series|Yes|
|HBv4-Series|Yes|
|HC-Series|Yes|
|HX-Series|Yes|
|L-Series|No|
|Lsv2-Series|No|
|Lsv3-Series|Yes|
|Lasv3-Series|Yes|
|M-Series|No|
|Msv2-Series|Yes|
|Mv2-Series|Yes|
|NC-Series|No|
|NCv2-Series|No|
|NCv3-Series|No|
|NCasT4_v3-Series|Yes|
|NC_A100_v4-Series|Yes|
|NDasrA100_v4-Series|Yes|
|NDm_A100_v4-Series|Yes|
|ND-Series|No|
|NDv2-Series|Yes|
|NGads V620-Series|Yes|
|NV-Series|No|
|NVv2-Series|No|
|NVv3-Series|No|
|NVv4-Series|Yes|
|NVadsA10_v5|Yes|
|NP-Series|Yes|

> [!NOTE]
>
> - [Windows 11 on Arm](/windows/arm/overview) is currently in Preview release. Current Arm CPUs in Azure meet the CPU requirements for Windows 11 support. However, Windows 11 Arm images in Azure Marketplace don't meet the requirements for some security options (trusted launch, secure boot, and trusted platform module (TPM), in particular).
>
> - The Azure portal might let you choose some VM products to deploy Windows 11 on, even if those VM products don't actually support Windows 11.
>
> - You currently can't upgrade to Windows 11, version 22H2 on Azure VMs that were deployed without trusted launch.
>
> - You can set trusted launch only during VM creation and only on Azure generation 2 VMs. There's no option to set trusted launch after you create the VM.

## Criteria for Windows 11 eligibility

There are multiple [criteria for Windows 11 eligibility](/windows/whats-new/windows-11-requirements#virtual-machine-support):

- **Generation**: 2nd
- **Storage**: At least 64 GB
- **Security**: Secure boot capable, trusted launch, virtual TPM (vTPM) enabled
- **Memory**: At least 4 GB
- **Processor**: Two or more virtual processors, and a VM host processor that meets Windows 11 processor requirements

The following sections provide more detail about the three main criteria: VM generation (version), trusted launch, and CPU.

### VM generation

VMs must be generation 2. You can upgrade VMs from Generation 1 to Generation 2 by [upgrading to the Trusted launch security type](/azure/virtual-machines/trusted-launch-existing-vm-gen-1).

### Trusted launch

VMs must be enabled for Trusted launch together with secure boot and virtual TPM. [Upgrading VMs from standard security to Trusted launch](/azure/virtual-machines/trusted-launch-existing-vm-gen-1) is supported. Many VMs are affected by this requirement. This is because before [June 28, 2023](https://techcommunity.microsoft.com/t5/azure-confidential-computing/announcing-trusted-launch-as-default-in-azure-portal/ba-p/3854872), trusted launch wasn't the default security type option when you created a VM in the Azure portal. Also, when Windows 11 was released, trusted launch wasn't available as a feature in Windows Azure.

### CPU

The CPU requirements for Windows 11 have evolved. For an up-to-date list of supported processors, see [Windows processor requirements](/windows-hardware/design/minimum/windows-processor-requirements). The listed processors represent the processor models that meet the minimum floor for the supported processor generations through the latest processors at the time of publication. These processors meet the design principles regarding security and reliability, and they meet the minimum system requirements for Windows 11. Subsequently released and future generations of processors that meet the same principles are considered as supported, even if they aren't explicitly listed.

The processor list might specify the latest offerings from processor manufacturers between updates. In the [Windows 11 Minimum Hardware Requirements download file](https://download.microsoft.com/download/7/8/8/788bf5ab-0751-4928-a22c-dffdc23c27f2/Minimum%20Hardware%20Requirements%20for%20Windows%2011.pdf#page=12), the *Processor* section (section 3.5) specifies a 1 GHz or faster processor that conforms to the following requirements:

- Supports two processor cores

- Is compatible with the x64 or ARM64 instruction set

- Supports the [PF_ARM_V81_ATOMIC_INSTRUCTIONS_AVAILABLE](/windows/win32/api/processthreadsapi/nf-processthreadsapi-isprocessorfeaturepresent) instruction set (for ARM64 processors)

- Supports PAE, NX, and SSE4.1

- Supports CMPXCHG16b, LAHF/SAHF, and PrefetchW

- Meets the supported processor generation list requirements

Several CPUs that have been manufactured since 2008 meet these requirements other than the supported processor generation list. The processor generation information is documented in the following blog articles:

- A [June 28, 2021, Windows Insider Blog article](https://blogs.windows.com/windows-insider/2021/06/28/update-on-windows-11-minimum-system-requirements/) that specifies the following processors as supported:

  - Intel 8th generation and newer
  - AMD Zen 2 and newer
  - Qualcomm Series 7 and 8

- An [August 27, 2021, Windows Insider Blog article](https://blogs.windows.com/windows-insider/2021/08/27/update-on-windows-11-minimum-system-requirements-and-the-pc-health-check-app/) that adds more processors to the original supported list:

  - Intel Core X-Series 7th generation
  - Intel Xeon W-Series 7th generation
  - Intel Core 7820HQ (only selected devices that shipped with modern drivers based on Declarative, Componentized, Hardware Support Apps (DCH) design principles, including Surface Studio 2)

Processors that meet these principles are considered as supported, even if they might not appear on the supported processor list. The Intel Xeon Platinum 8370C is an example of a CPU that's supported, even though it doesn't appear on the supported processor list.

Per these guidelines, the following section shows whether the requirements are met for particular x64 processors that are associated with VM products in Azure.

#### CPUs used in Windows Azure

<details>
<summary>CPUs used in Azure</summary>

|CPU used in Windows Azure|Technology|Generation|Supported by Windows 11|
|:----|:----|:----|:----|
|Intel&reg; Xeon&reg; E5-2673 v3|Haswell|Intel 4th gen|No|
|Intel&reg; Xeon&reg; E5-2690 v3|Haswell|Intel 4th gen|No|
|Intel&reg; Xeon&reg; E5-2698 v3|Haswell|Intel 4th gen|No|
|Intel&reg; Xeon&reg; E5-2698B v3|Haswell|Intel 4th gen|No|
|Intel&reg; Xeon&reg; CPU E7-8890|Haswell|Intel 4th gen|No|
|Intel&reg; Xeon&reg; E5-2673 v4|Broadwell|Intel 5th gen|No|
|Intel&reg; Xeon&reg; E5-2690 v4|Broadwell|Intel 5th gen|No|
|Intel&reg; Xeon&reg; Platinum 8168|Skylake|Intel 7th gen|Yes|
|Intel&reg; Xeon&reg; Platinum 8171M|Skylake|Intel 7th gen|Yes|
|Intel&reg; Xeon E-2288G|Coffee Lake|Intel 8th gen|Yes|
|Intel&reg; Xeon&reg; Gold 6246R|Cascade Lake|Intel 9th gen|Yes|
|Intel&reg; Xeon&reg; Platinum 8272CL|Cascade Lake|Intel 9th gen|Yes|
|Intel&reg; Xeon&reg; Platinum 8370C|Ice Lake|Intel 10th gen|Yes|
|AMD EPYC 7551|Naples|AMD Zen 1|No|
|AMD EPYC 7452|Rome|AMD Zen 2|Yes|
|AMD EPYC 7V12|Rome|AMD Zen 2|Yes|
|AMD EPYC 7742|Rome|AMD Zen 2|Yes|
|AMD EPYC 7763|Milan|AMD Zen 3|Yes|
|AMD EPYC 7763v|Milan|AMD Zen 3|Yes|
|AMD EPYC 7V73X|Milan|AMD Zen 3|Yes|
|AMD EPYC 7V13|Milan|AMD Zen 3|Yes|
|AMD EPYC 9V33X|Genoa-X|AMD Zen 4|Yes|

</details>

## Diagnostics

In addition to the previous list of VM products, you can use the [PC Health Check app](https://www.microsoft.com/windows/windows-11-specifications) to assess the eligibility requirements for Windows 11.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
