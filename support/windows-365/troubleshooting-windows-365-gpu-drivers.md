---
title: Troubleshooting Windows 365 GPU drivers
description: Provides a solution to a known issue with graphic card drivers on Windows 365 GPU Enabled Cloud PC.
ms.date: 04/29/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: feadebay,erikje
ms.custom: intune-azure, get-started
---
# Troubleshooting Windows 365 GPU drivers

This article provides a solution to a known issue with graphic card drivers on Windows 365 GPU Enabled Cloud PC.

## NVIDIA A10 GPU driver version

When you use Windows 365 GPU Enabled Cloud PCs, you might encounter a driver error issue if the Nvidia A10 driver is outdated. This issue can occur due to mismatch in the underlying graphics card driver versions. 

The error message resembles the following screenshot. You can see an error dialog on the **Nvidia A10-24Q** driver in Device Manager.

:::image type="content" source="media/troubleshooting-windows-365-gpu-drivers/error-in-device-manager.png" alt-text="Error in Device Manager.":::

> [!NOTE]
> The actual dialog error number version might be different.

## Resolution

To fix this issue, you need to download a new Nvidia A10 driver to fix the issue. Follow these troubleshooting steps:

1. Verify if you're using the NVIDIA A10 GPU:

   * Open **Device Manager** on your Cloud PC.
   * Expand **Display Adapters**.
   * If **NVIDIA A10** appears, continue with the next steps. If not, the update isn't necessary for this Cloud PC.

2. Download and install the latest driver:

   * Visit the Microsoft certified **NVIDIA GRID/vGPU driver** download [page](/azure/virtual-machines/windows/n-series-driver-setup#nvidia-gridvgpu-drivers)
   * Download the latest driver for your Windows operating system.
   * Extract the files and run the installer (no need to uninstall your current driver).
   * Restart your Cloud PC once the installation is complete.

3. Verify the update was successful:

   * After restarting, open **Device Manager** again.

Expand **Display Adapters** and confirm that the error is disappeared.

## More information

* [Azure N-series NVIDIA GPU driver setup for Windows - Azure Virtual Machines | Microsoft Learn](/azure/virtual-machines/windows/n-series-driver-setup#nvidia-gridvgpu-drivers)
* [GPU Cloud PCs in Windows 365 | Microsoft Learn](/windows-365/enterprise/gpu-cloud-pc)
