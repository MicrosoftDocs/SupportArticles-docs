---
title: Print driver default settings are not inherited through
description: Address an issue in which default settings are not inherited from a down-level print server to a Windows 10 Version 1709-based client in Point and Print.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
---
# Print driver default settings are not inherited through "Point and Print" in Windows 10 Version 1709

This article provides a solution to the issue in which print driver default settings are not inherited through "Point and Print" in Windows 10 Version 1709.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 10, version 1709  
_Original KB number:_ &nbsp; 4052855

## Symptoms

Consider the following scenario:

- You have a client that is running Windows 10 Version 1709 or Windows Server Version 1709.
- You have a print server that is running Windows Server 2016, Windows Server 2012, or Windows Server 2012 R2, or Windows Server 2008 R2.
- You install printer drivers by using the "Point and Print" process.

In this scenario, the client does not inherit default settings from the print server.

## Cause

This issue occurs because of a mismatch in the universal driver (or PScript5 driver) between the print server and the client.

## Resolution

To fix this issue, set the printer settings manually on the client following these steps:

1. Right-click the **Start** button, and then select **Settings**.
2. Select **Devices**.
3. In the center of the **Devices** window, select **Devices and printers**.
4. In the **Devices and Printers**  window, right-click the icon of a printer that you installed from the server computer. Then, select **Printing preferences**.
    > [!Note]
    > The **Printing Preferences** dialog box opens.
5. In the dialog box, select the **Advanced**  button.
    > [!Note]
    > The **Advanced Options** dialog box opens. You can change the printer settings in this dialog box.

## Status

Microsoft has confirmed that this is an issue in the Microsoft products that are listed in the "Applies to" section.

This issue has been fixed in Windows 10, version 1803 and Windows Server, version 1803.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
