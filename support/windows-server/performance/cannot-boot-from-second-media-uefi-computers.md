---
title: UEFI computers always boot from the first bootable media
description: Describes a problem in which a Unified Extensible Firmware Interface (UEFI) based computer can't boot Windows from the second bootable media.
ms.date: 06/28/2021
author: v-lianna
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, annsheng, zhaling, aadake
ms.prod-support-area-path: No Boot (not BugChecks)
ms.technology: windows-server-performance
---
# Can't boot from the second bootable media on UEFI-based computers

This article describes an issue in which a Unified Extensible Firmware Interface (UEFI) based computer can't boot Windows from the second bootable media.

Assume that two Windows bootable media ([CD-ROM](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=401) or [Device Logical Unit](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=380)) are attached to a UEFI-based computer. The computer boots from the first media even if you set the second media as the first bootable media or choose to boot from the second media.

For example, suppose the first bootable media is Windows Server 2016 and the second one is Windows Server 2019. When you try to boot the computer from Windows Server 2019, the computer boots from Windows Server 2016 instead.

This is by design. Windows UEFI codes only support boot from the first bootable media.

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]