---
title: Can't install Windows Server 2019 on servers with a high processor count
description: Provides workarounds for an issue in which Windows Server 2019 can't be installed on servers with a high processor count.
ms.date: 05/18/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rblume, v-lianna
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# Can't install Windows Server 2019 on servers with a high processor count

This article provides workarounds for an issue in which Windows Server 2019 can't be installed on servers with a high processor count.

When you install Windows Server 2019 on servers with a high processor count, the installation fails at the setup stage, and you encounter the following issues:

- The mouse and keyboard don't respond.
- Windows Setup can't recognize the storage device.

In the memory dump file, "USB Port Reset Failures" occur on the port with the CD-ROM.

This is a known limitation when installing Windows Server 2019 on servers that have the latest processor with a high processor count.

To work around this issue, use one of the following methods:

- Install Windows Server 2022 instead of Windows Server 2019.
- Disable hyper-threading in firmware before installing Windows Server 2019. After the installation, hyper-threading can be enabled.
- Update the installation media with the latest rollup packages. Both the [install.wim](/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14) and [boot.wim](/windows-hardware/manufacture/desktop/winpe-add-packages--optional-components-reference) files need to be updated.
