---
title: Winload.exe error code 0xc0000605 on an Azure VM
description: Describes a Winload.exe error (0xc0000605) that occurs on an Azure virtual machine (VM).
ms.date: 07/21/2020
ms.reviewer: jarrettr
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Winload.exe error code 0xc0000605 on an Azure VM

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010131

## Symptoms

Windows doesn't start and generates the following error:

> File: \Windows\System32\winload.exe  
Status: 0xc0000605  
Info: A component of the operating system has expired.

## Cause

This issue occurs for the following reasons:

- The image that's used to build the virtual machine isn't an RTM (Release to Manufacturing) image but is instead a preview image that has an expiration date.
- The preview image has a designated life cycle, and the trial period for the image is over.

## Resolution

Unfortunately, there's no way to fix this issue. You must redeploy the VM with the correct image. All the non-RTM or trial images have an expiration date. After the expiration date, the machine may not start or it may keep shutting itself down. These images are provided for testing purposes only.

For the images provided in Azure Marketplace, you can find the trial period information in the description of the image:

:::image type="content" source="media/error-code-0xc0000605/trial-period-information.png" alt-text="Screenshot shows the trial period information of SharePoint Server 2016 in Azure Marketplace." border="false":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
