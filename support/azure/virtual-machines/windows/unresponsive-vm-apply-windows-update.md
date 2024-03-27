---
title: Azure VM is unresponsive with C01A001D error when applying Windows Update
description: This article provides steps to resolve issues where Windows update generates an error and becomes unresponsive in an Azure VM.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 06/09/2023
ms.author: genli
---

# VM is unresponsive with "C01A001D" error after applying Windows Update

This article provides steps to resolve issues where Windows Update (KB) generates an error and becomes unresponsive in an Azure VM running Windows Server 2016.

## Symptoms

You are unable to apply the following Windows Update (and particularly after KB5003638, released on June 8, 2021) on a Windows Server 2016 VM without experiencing the following symptoms:

- The VM cannot boot, and Remote Desktop Protocol (RDP) connections to the VM fail.

- When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, the Windows Update (KB) in progress is displayed, but fails with error code: 'C01A001D'.

:::image type="content" source="media/unresponsive-vm-apply-windows-update/unresponsive-windows-update.png" alt-text="Screenshot shows the V M fails with the C01A001D error code.":::

## Cause

You may see error C01A001D (STATUS_LOG_FULL) for the following reasons after installing Windows Updates and Language Packs:

- Insufficient free disk space
- A permission issue related to the handling of files located in *%systemroot%\system32\config\TxR* directory after applying [KB5003638](https://support.microsoft.com/topic/june-8-2021-kb5003638-os-build-14393-4467-d9dfce91-b425-483a-8280-f54d7005b231).

## Resolution

To prevent the problem described above from occurring in the first place, complete the following resolution steps on Windows Server 2016 VMs before applying the [Windows Update KB5003638 (OS Build 14393.4467)](https://support.microsoft.com/en-us/topic/june-8-2021-kb5003638-os-build-14393-4467-d9dfce91-b425-483a-8280-f54d7005b231) released on June 8, 2021. You can also complete these steps on the failed VM, but you must first revert the VM to the state before you applied this update by [restoring the VM from backup](/azure/virtual-machines/windows/expand-os-disk).

1. Ensure that the OS volume has at least 1 GB of free space.
2. In the Search Windows box, enter **winver** to open the About Windows dialog box and determine the last Windows update applied. If the number after “OS Build 14393” is lower than 4350, then apply either of the following updates (as allowed by your company’s update policy), and then restart the VM:

    - [April 13, 2021—KB5001347 (OS Build 14393.4350)](https://support.microsoft.com/topic/april-13-2021-kb5001347-os-build-14393-4350-ee0e6301-3428-4a14-8e67-d69c5b31c66a)
    - [May 11, 2021—KB5003197 (OS Build 14393.4402)](https://support.microsoft.com/topic/may-11-2021-kb5003197-os-build-14393-4402-672e4557-b496-4ec7-bf26-3268aaf16697)

:::image type="content" source="media/unresponsive-vm-apply-windows-update/about-windows.png" alt-text="Screenshot of the About Windows dialog box with the O S build number highlighted.":::

3. After the OS build is updated to [April 13, 2021—KB5001347 (OS Build 14393.4350)](https://support.microsoft.com/topic/april-13-2021-kb5001347-os-build-14393-4350-ee0e6301-3428-4a14-8e67-d69c5b31c66a) or [May 11, 2021—KB5003197 (OS Build 14393.4402)](https://support.microsoft.com/topic/may-11-2021-kb5003197-os-build-14393-4402-672e4557-b496-4ec7-bf26-3268aaf16697), download and run the [Known Issue Rollback 062521 01.msi](https://download.microsoft.com/download/e/c/6/ec684975-1ad7-4d6f-a228-2da17b0a72b3/Windows%2010%20(1607)%20Known%20Issue%20Rollback%20062521%2001.msi) on the VM that applies local or domain policy. This msi file applies to both Windows 10 and Windows Server 2016. Note the appearance of **KB5001347 Issue 001 Rollback.admx** in the *%systemroot%\policydefinitions* folder after the item is installed.
4. Open a policy editor and enable the following setting in local or domain policy:

    - **Path**: Computer configuration\Administrative Templates

    - **Setting**: KB5001347 Issue 001 Rollback

    - **Value**: Enabled
5. Restart all the VMs running Windows Server 2016 that fall within the scope of the policy you have just configured.

After completing the steps above, you can now safely apply the [Windows Update June 8, 2021—KB5003638 (OS Build 14393.4467)](https://support.microsoft.com/en-us/topic/june-8-2021-kb5003638-os-build-14393-4467-d9dfce91-b425-483a-8280-f54d7005b231) or later.

> [!NOTE]
> If you cannot revert the state of a VM in a non-boot state, [open a support ticket with Azure Support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
