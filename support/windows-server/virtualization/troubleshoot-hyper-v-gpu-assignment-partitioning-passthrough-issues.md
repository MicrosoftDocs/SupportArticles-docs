---
title: Troubleshooting guidance for Hyper-V GPU assignment, partitioning, and passthrough
description: Troubleshoot issues that occur when configuring GPU passthrough for virtual machines by using either Discrete Device Assignment (DDA) or GPU partitioning (GPU-P).
ms.date: 08/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\discrete device assignment gpu
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Hyper-V GPU assignment, partitioning, and passthrough troubleshooting guidance

_Applies to:_ &nbsp; Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows 11, and Windows 10

This article provides troubleshooting guidance for issues that are related to GPU passthrough in a Hyper-V environment. The article includes a checklist for troubleshooting, a description of known issues, and instructions to resolve common issues. You might encounter common issues when you set up host servers to provide GPU passthrough or configure virtual machines (VMs) to use GPU passthrough.

## Troubleshooting checklist

The following checklist provides the general troubleshooting steps that you should follow for any GPU passthrough issue. Many of the issues that you might encounter originate as problems that involve hardware compatibility, operating system compatibility, drivers, or basic configuration. If these steps don't resolve your issue, continue to the "Common issues and solutions" section.

### Step 1: Verify that the functionality that you want is supported

Make sure that your environment is supported for the specific method that you want to use. Follow these guidelines:

- To use live migration for VMs that use GPU acceleration, you have to use GPU-P and Windows Server 2025 or a newer version on the host computer. For more information about the differences in capabilities between Discrete Device Assignment (DDA) and GPU-P, see [Plan for GPU acceleration in Windows Server](/windows-server/virtualization/hyper-v/plan/plan-for-gpu-acceleration-in-windows-server).

- To use failover clusters and deploy GPUs by using DDA, you have to use Windows Server 2025. For more information, see [Use GPUs with Discrete Device Assignment in clustered VMs](/windows-server/virtualization/hyper-v/deploy/use-gpu-with-clustered-vm?tabs=windows-admin-center&pivots=windows-server).

- You can't assign the same GPU by using both DDA and GPU-P.

- To monitor GPU usage in Task Manager, the host computer must run Windows Server 2022 or a later version.

- DDA and GPU-P aren't supported on desktop-class hardware or client operating systems such as Windows 10 or 11 Pro.

- To use DDA to assign GPUs, the host computer has to run Windows Server 2016 or a newer version.

- If you want to use GPU-P, the host computer has to run Windows Server 2025 or a newer version.

- Currently, you can assign only a single GPU partition to a VM. Both the VM and the GPU partition must be on the same host computer.

### Step 2: Verify that the server and GPU hardware support GPU passthrough

Make sure that the host computer uses server-class hardware and includes a supported CPU, motherboard, and GPU. If you're using GPU-P on clustered host computers, the processors must be capable of Input/Output Memory Management Unit (IOMMU) DMA bit tracking. (This requirement includes processors that support Intel VT-D or AMD-Vi.)

Review the vendor documentation for the hardware to verify that it supports Hyper-V GPU-P or DDA, as necessary. You can use vendor-provided scripts, such as `SurveyDDA.ps1` from Microsoft's open source GitHub repository [https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/hyperv-tools/DiscreteDeviceAssignment](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/hyperv-tools/DiscreteDeviceAssignment).

> [!IMPORTANT]  
> At this time, the following GPUs support GPU-P:
>
> - NVIDIA A2
> - NVIDIA A10
> - NVIDIA A16
> - NVIDIA A40
> - NVIDIA L2
> - NVIDIA L4
> - NVIDIA L40
> - NVIDIA L40S
>
> For more information, see [NVIDIA Virtual GPU Software User Guide](https://docs.nvidia.com/grid/latest/grid-vgpu-user-guide/index.html).

> [!NOTE]  
> Check the vendor information for any compatibility restrictions that apply to the GPU.

For more information about host computer prerequisites for DDA, see [Deploy graphics devices by using Discrete Device Assignment: Prerequisites](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda#prerequisites).

For more information about host computer prerequisites for GPU-P, see [GPU Partitioning: Requirements](/windows-server/virtualization/hyper-v/gpu-partitioning#requirements).

If your hardware doesn't support the GPU passthrough functionality that you want to use, upgrade the hardware. Incompatible hardware can cause various issues when you try to configure or use GPUs.

### Step 2: Check the host computer operating system and BIOS or UEFI settings

1. Make sure that the Hyper-V server role is installed and enabled on the host computer, and that you have administrative permissions for the computer.

1. Check the BIOS/UEFI configuration of the host computer:
   - If you're using GPU-P, make sure that [Single Root I/O Virtualization (SR-IOV)](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-) and VT-d/IOMMU are enabled.
   - If you're using DDA, consider enabling SR-IOV. This setting might resolve some issues.
   > [!IMPORTANT]  
   > If you change any BIOS or UEFI settings, restart the computer before you continue.

### Step 4: Check the versions of the guest operating systems

Make sure that the VMs use operating systems that support GPU passthrough.

- DDA is supported for Generation 1 or 2 VMs. Supported guests include:
  - Windows 10 or later
  - Windows Server 2016 or later

  For more information about non-Windows VMs, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows Server and Windows](/windows-server/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows).

- GPU-P is supported for Generation 2 VMs that use the following operating systems:
  - Windows 10 or later
  - Windows 10 Enterprise multi-session or later
  - Windows Server 2019 or later
  - Linux Ubuntu 18.04 LTS, Linux Ubuntu 20.04 LTS, Linux Ubuntu 22.04 LTS

### Step 5: Check Windows Update status

Make sure that the host computer and all VMs all have relevant Windows updates installed.

If you install any updates, restart the affected computers.

### Step 6: Check the drivers and GPU licensing

To use GPU passthrough, you must have the correct software and correct license. The drivers that you need might differ depending on whether you're using DDA or GPU-P, and also depend on the functionality that you want to use. For example, to use live migration together with GPU-P, you must use the driver that's included in the NVIDIA vGPU Software v18.*x* or a later version. Also, you must have a license that supports GPU-P.

License or driver problems can cause the following symptoms, among others:

- The Hyper-V or Windows Admin Center doesn't list GPUs as available for provisioning.
- The Hyper-V or Windows Admin Center lists GPUs as "Ready for DDA assignment," but not for GPU-P.
- Device manager on the VMs or host computer lists the GPUs as disabled or unrecognized.
- You see error messages that include error code 48F or error code 003.
- You can't configure a GPU pool for GPU-P.

To check the drivers and licensing, follow these steps:

1. Review the GPU vendor documentation and verify that you have the correct and most recent GPU drivers installed on both the host computer and the VMs.

   > [!IMPORTANT]  
   > NVIDIA's vGPU drivers don't update or replace datacenter version drivers (non-vGPU drivers) that are installed on the host computer. To use GPU-P, you have to manually remove any NVIDIA datacenter version drivers before you install the vGPU software.

1. If you have to make any driver changes, follow these steps:

   1. Uninstall any incorrect drivers. For example, if you want to use GPU-P together with NVIDIA vGPU hardware, uninstall all non-vGPU NVIDIA drivers.
   1. Install the correct drivers.
   1. Restart the affected computer (host computer or VM).

1. Make sure that you have the correct licenses for the GPUs that you're using, that you have the correct number of licenses, and that the licenses are installed or activated correctly.

   > [!NOTE]  
   > For more information about NVIDIA licenses, see [NVIDIA License System User Guide](https://docs.nvidia.com/license-system/latest/nvidia-license-system-user-guide/index.html).

1. To verify that the GPU is now available, open a Windows PowerShell Command Prompt window on the host computer, and then run the following command:

   ```powershell
   Get-VMHostPartitionableGpu
   ```

 > [!NOTE]  
 > If the GPU is still not available, see [After you update Windows, the GPU doesn't function or appears as an unknown device](#after-you-update-windows-the-gpu-doesnt-function-or-appears-as-an-unknown-device).

### Step 7 Check your administration tools

- Windows Admin Center:
  - Install the latest version of Windows Admin Center.
  - Install the **GPUs** extension, version 2.8.0 or later.
- Windows PowerShell: Install the Hyper-V module.

### Step 8 Check the VM configuration

If you're using GPU-P, see [Partition and assign GPUs to a virtual machine](/windows-server/virtualization/hyper-v/partition-assign-vm-gpu?tabs=windows-admin-center) for detailed information about how to configure the GPU and how to configure VMs. That article also provides information about common issues that you might encounter when you configure or assign GPU partitions.

If you're using DDA to assign GPUs, follow these steps for each VM to make sure that the VMs are correctly configured:

1. Sign in to the Hyper-V host as an administrator.

1. Open an elevated PowerShell Command Prompt window, and then run the following command:

   ```powershell
   Get-VM -Name <VMName>
   ```

   > [!NOTE]  
   > In this command, \<VMName> is the name of the VM that you're checking.

1. Check that the settings that are listed in the following table have the specified values.

   | Setting | Value |
   | --- | --- |
   | `Automatic Stop Action` | **TurnOff** |
   | `GuestControlledCacheTypes` | **True** |
   | `LowMemoryMappedIoSpace` | **3000000000** |
   | `HighMemoryMappedIoSpace` | **33280000000** |

For more information, see the following articles:

- [Deploy graphics devices by using Discrete Device Assignment: Configure the VM for DDA](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda#vm-preparation-for-graphics-devices)
- [Deploy devices by using Discrete Device Assignment: MMIO space](/windows-server/virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment#mmio-space)

## Common issues and solutions

### Windows Server 2022 Hyper-V or VMWare: Task Manager Processes tab doesn't display GPU or vGPU usage

Consider the following scenario:

- You run Hyper-V or VMWare VMs on a Windows Server 2022 host.
- The VMs are configured to use GPUs.
- You open Task Manager to check the GPU processes.

In this scenario, you don't see the **GPU** column on the **Processes** tab or on the columns menu. In such cases, the VMs default to using [Windows Display Driver Model](/windows-hardware/drivers/display/windows-vista-display-driver-model-design-guide) (WDDM) 1.*x*. This model doesn't support GPU monitoring in Task Manager.

To resolve this issue, follow these steps:

1. Make sure that the host computer and all VMs have relevant Windows updates installed.

   If you install any updates, restart the affected computers.

1. On each affected VM, follow these steps to check the display driver version:
   1. Open a Command Prompt window, and then run the `dxdiag` command.
   1. In the DirectX Diagnostic Tool, select the **Display** tab, and then look for **Driver Model**. This value should be WDDM 2.*x* or a later version.
   1. If the driver model is 2.*x* or later, consider upgrading the host computer to Windows Server 2025. Otherwise, go to the next step.
1. On each affected VM, follow these steps to update the drivers and rebuild the performance counters:
   1. Uninstall the incorrect drivers.
   1. Install the correct drivers.
   1. Restart the affected VM.
   1. After the VM restarts, rebuild the performance counters. At the command prompt, run the following commands, in sequence:

      ```console
      lodctr /R
      diskperf -y
      ```

1. If the preceding steps didn't resolve the issue, consider upgrading the host computer to Windows Server 2025

### After you update Windows, the GPU doesn't function or appears as an unknown device

In this case, a VM suddenly can't use a GPU. Device Manager might list the GPU as disabled or as an unknown device. You might also see error message that includes error code 48F or error code 003.

This situation typically means that a driver is corrupted, or a stale version of the driver was installed during the update. Simply reinstalling the correct driver might not resolve the problem, because stale or incorrect information might remain in the registry or system files.

> [!IMPORTANT]  
>
> - Make sure that you complete the steps that are described in the [Troubleshooting Checklist](#troubleshooting-checklist) section. If the issue persists, use the following procedure.
> - Before you use this procedure, check with your vendor to make sure that cleaning up registry information or system files is advised in your situation. If it isn't, skip those steps.
> - You must have administrative permissions to use this procedure.

To clean up this information and resolve this issue, follow these steps on the affected VM:

1. Restart the VM into [Safe mode](https://support.microsoft.com//windows/windows-startup-settings-1af6ec8c-4d4a-4b23-adb7-e76eef0b847f).

1. To enumerate the current drivers, open an elevated Command Prompt window, and then run the following command:

   ```console
   pnputil /enum-drivers
   ```

1. To remove the old drivers and clean up related system files and registry entries, follow these steps:

   1. Uninstall any incorrect drivers. For example, if you want to use GPU-P together with NVIDIA vGPU hardware, uninstall all non-vGPU NVIDIA drivers. To uninstall the driver, run the following command at the command prompt:

      ```console
      pnputil /delete-driver <Published Name> /uninstall /force
      ```

      > [!NOTE]  
      > In this command, \<Published Name> is the name of the driver.

   1. Use the [DevNodeClean](https://www.microsoft.com/download/details.aspx?id=42286&msockid=2984b5ddab276c5d2200a0dbaa9d6d1d) tool to remove stale device nodes.

   1. To repair the system files, run the following commands, in sequence, at the command prompt:

      ```console
      sfc /scannow
      DISM /Online /Cleanup-Image /RestoreHealth
      ```

   1. Install the correct GPU drivers from the vendor.

1. Restart the VM.

1. To verify that the GPU is now available, open a Windows PowerShell Command Prompt window on the host computer, and then run the following command:

   ```powershell
   Get-VMHostPartitionableGpu
   ```

### Can't assign a GPU to a VM because of insufficient resources

When you're assigning a GPU to a VM, you might see error messages such as the following messages:

> This Device Cannot Find Enough Free Resources to Use (Code:12)

> GPU Partition: Error Insufficient system resources exist to complete the requested service.

Such messages indicate that the VM has insufficient allocated Memory-Mapped IO (MMIO) space, or is otherwise misconfigured. For information about how to calculate and configure the resources that VMs need, see the following articles:

- For DDA, see [Deploy devices by using Discrete Device Assignment: MMIO space](/windows-server/virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment#mmio-space).
- For GPU-P, see [Partition and assign GPUs to a virtual machine](/windows-server/virtualization/hyper-v/partition-assign-vm-gpu?tabs=windows-admin-center) and your NVIDIA vGPU documentation.

## Data collection

If you still can't resolve your issue, contact Microsoft Support or your vGPU vendor for more assistance. Prepare to share the information that you gathered while troubleshooting and the results of your troubleshooting. Additionally, gather the following information:

- To gather information about GPUs, run the following PowerShell command:

  ```powershell
  Get-PnpDevice -FriendlyName "<device-friendly-name>"
  ```

- If you're using GPU-P, run the following PowerShell command on the host computer to get the details of the partitionable GPUs:

  ```powershell
  Get-VMHostPartitionableGpu | FL Name, ValidPartitionCounts
   ```

- Note the **Driver Model** information on the **Display** tab of the DirectX Diagnostic Tool.
- In Device Manager, note the properties of the affected GPU from the **General**, **Driver,** and **Location Path** tabs.
- In Windows Admin Center, note the GPU status.
- Note any applicable load information that you see in Task Manager and `nvidia-smi`.

## More information

- [Plan for GPU acceleration in Windows Server](/windows-server/virtualization/hyper-v/plan/plan-for-gpu-acceleration-in-windows-server)
- [GPU Partitioning](/windows-server/virtualization/hyper-v/gpu-partitioning)
- [Partition and assign GPUs to a virtual machine](/windows-server/virtualization/hyper-v/partition-assign-vm-gpu)
- [Deploy devices by using Discrete Device Assignment](/windows-server/virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment)
- [Deploy graphics devices by using Discrete Device Assignment: Prerequisites](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda#prerequisites)
- [Use GPUs with Discrete Device Assignment in clustered VMs](/windows-server/virtualization/hyper-v/deploy/use-gpu-with-clustered-vm?tabs=windows-admin-center&pivots=windows-server)

For more information about the NVIDIA hardware, software, and licenses, see the following articles:

- [NVIDIA Virtual GPU Software User Guide](https://docs.nvidia.com/grid/latest/grid-vgpu-user-guide/index.html)
- [NVIDIA License System User Guide](https://docs.nvidia.com/license-system/latest/nvidia-license-system-user-guide/index.html)

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
