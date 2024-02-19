---
title: Can't create a Hyper-V virtual switch
description: Fixes an issue in which you can't re-create a victual switch for Hyper-V on an upgraded 64-bit Windows-10-based computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bobcombs, ajayps
ms.custom: sap:hyper-v-network-virtualization-hnv, csstroubleshoot
---
# Can't create a Hyper-V virtual switch on 64-bit versions of Windows 10

This article solves an error message when you try to re-create a Hyper-V virtual switch (vSwitch) for the same physical adapter.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3101106

## Symptoms

After you delete a vSwitch on a computer that has been upgraded to Windows 10, you can't re-create the vSwitch for the same physical adapter. When this problem occurs, you receive the following error message:

> Virtual Switch Manager  
Error applying Virtual Switch Properties changes  
Failed while adding virtual Ethernet switch connections.

:::image type="content" source="media/cannot-create-hyper-v-virtual-switch/error-applying-virtual-switch-properties-changes.png" alt-text="Screenshot of the Virtual Switch Manager error message.":::

It indicates that the vSwitch still exists, even though it's no longer listed in the Hyper-V Virtual Switch Manager.

## Cause

This problem occurs because a new network setup functionality introduced in Windows 10 doesn't completely delete all objects from the previous vSwitch installation. This problem is scheduled to be fixed in the next Windows 10 update.

## Resolution

To fix this problem automatically, select the following Download link. In the **File Download** dialog box, select **Run** or **Open**, and then follow the steps in the Easy fix wizard.

[Download](https://aka.ms/easyfix20159)

> [!IMPORTANT]
> Before you run the Easy fix, note the following points:
>
> - You will lose network connectivity after the wizard finishes.
> - You must restart your computer manually after the wizard finishes.
> - You will have to connect manually to all known Wi-Fi networks after your computer restarts.
> - You must re-create the vSwitch by using the Hyper-V Virtual Switch Manager after your computer restarts.

> [!NOTE]
>
> - This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
> - If you are not on the computer that has the problem, save the Easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.
