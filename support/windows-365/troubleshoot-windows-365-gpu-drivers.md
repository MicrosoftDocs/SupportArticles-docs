---
title: Troubleshoot Windows 365 GPU Drivers
description: Provides a solution to a known issue with graphic card drivers on Windows 365 GPU-enabled Cloud PCs.
ms.date: 05/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: feadebay,erikje
ms.custom: intune-azure, get-started
---
# Troubleshoot Windows 365 GPU drivers

This article provides a solution to a known issue with graphic card drivers on Windows 365 GPU-enabled Cloud PCs.

## NVIDIA GPU driver version

When you use Windows 365 GPU-enabled Cloud PCs, you might encounter a driver error if the NVIDIA driver is outdated. This issue can occur due to a mismatch in the underlying graphics card driver version. 

The error message resembles the following screenshot. You can see an error dialog on the **NVIDIA \*\*\*** driver in Device Manager.

:::image type="content" source="media/troubleshoot-windows-365-gpu-drivers/error-in-device-manager.png" alt-text="Screenshot showing the error in Device Manager.":::

> [!NOTE]
> The actual dialog error number version might be different.

## Resolution

To fix this issue, you need to download a new NVIDIA driver. Follow these troubleshooting steps:

1. Verify if you're using the NVIDIA GPU:

   1. Open **Device Manager** on your Cloud PC.
   2. Expand **Display Adapters**.
   3. If **NVIDIA \*\*\*** appears, continue with the next steps. If not, no update is needed for this Cloud PC.

2. Download and install the latest driver:

   1. Go to the Microsoft-approved [NVIDIA GRID/vGPU driver download page](/azure/virtual-machines/windows/n-series-driver-setup#nvidia-gridvgpu-drivers).
   2. Download the latest driver for your Windows operating system.
   3. Extract the files and run the installer (no need to uninstall your current driver).
   4. Restart your Cloud PC once the installation is complete.

3. Verify that the update is successful:

   1. After restarting, open **Device Manager** again.
   2. Expand **Display Adapters** and confirm that the error has disappeared.

If you're using any of the NVIDIA driver series, such as NV, NVv3, and NVads A10V5 series or NCas_T4_V3 VM series, go to [Install NVIDIA GPU drivers on N-series VMs running Windows](/azure/virtual-machines/windows/n-series-driver-setup#nvidia-gridvgpu-drivers) to download the latest drivers.

## Reference

[GPU Cloud PCs in Windows 365](/windows-365/enterprise/gpu-cloud-pc)

[!INCLUDE [Third-party disclaimer](../includes/third-party-disclaimer.md)]
