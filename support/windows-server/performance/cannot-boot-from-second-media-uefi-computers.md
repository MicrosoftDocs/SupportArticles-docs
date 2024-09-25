---
title: Can't boot Windows from secondary bootable devices on UEFI computers
description: Describes a problem in which a Unified Extensible Firmware Interface (UEFI) based computer can't boot Windows from the second bootable media.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, annsheng, zhaling, aadake, v-lianna
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# Can't boot Windows from secondary mass storage bootable devices on UEFI-based computers

This article describes an issue in which a Unified Extensible Firmware Interface (UEFI) based computer can't boot Windows from the second bootable media.

Assume that two Windows bootable media devices such as a [CD-ROM](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=401) or other USB Mass Storage Device ([Device Logical Unit](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=380)) are attached to a UEFI-based computer. The computer boots from the first media even if you set the second media as the first bootable media or choose to boot from the second media.

For example, suppose the first bootable media is Windows Server 2016 and the second one is Windows Server 2019. When you try to boot the computer from Windows Server 2019, the computer boots from Windows Server 2016 instead.

This is by design. The current Windows OS versions do not support [Device Logical Unit](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=380)–[Vendor-Defined Messaging Device Path](https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf#page=384). A Windows ISO image will boot only when it is mounted from the primary bootable Device Logical Unit mass storage device.

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]
