---
title: Not all printer drivers from Windows Update appear in Add Printer wizard
description: Works around an issue in which not all printer drivers that are downloaded from Windows Update are listed when in the Add Printer wizard.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
ms.subservice: printing
---
# Not all printer drivers downloaded from Windows Update are listed in Add Printer wizard

This article provides a workaround for an issue in which not all printer drivers that are downloaded from Windows Update are listed in the Add Printer wizard.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4508350

## Symptoms

On a computer that is running Windows 10, version 1803, Windows Server, version 1803 or a later version of Windows, you do the following operations:

1. Select **Start**, type *Control Panel*, and then press Enter.
2. In Control Panel, select the **View Devices and Printers** item.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/view-devices-and-printers-option.png" alt-text="Screenshot of the View devices and printers item in Control Panel.":::

3. Select **Add Printer** at the top of the window.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/add-printer.png" alt-text="Screenshot of the Add Printer option of the Device and Printers window.":::

4. After the wizard started, select **The printer that I want isn't listed**.
5. Select **Add a local printer or network printer with manual settings**, and then select **Next**.
6. On the **Choose a Printer Port** page, select the desired port, and then select **Next**.
7. On the **Install the printer driver** page, select **Windows Update**.
8. The updated **Printers** list is displayed from Windows Update. For example, if you select **KONICA MINOLTA**  under **Manufacturer**, the **Printers** list is displayed as follows.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/printer-list.png" alt-text="Screenshot of the Printer list for KONICA MINOLTA in the Install the printer driver dialog.":::
  
In this scenario, not all registered drivers are displayed.  

For example, "KONICA MINOLTA PS BW Laser Class Driver" and "KONICA MINOLTA PS Color Laser Class Driver" are not both displayed as expected.  

## Workaround

To work around this issue, manually download and install the printer driver to be installed from the Windows Update Catalog. In the example of the driver mentioned in the Symptoms section, install according to the following procedure.

1. Go to the [Windows Update Catalog](https://www.catalog.update.microsoft.com/home.aspx).
2. In the search box, enter the keyword of the driver to be downloaded, such as "Windows 10 KONICA MINOLTA PS BW Laser Class Driver," and then select **Search**.
3. After the list is displayed, select the **Download** button for the target driver, and save it to any folder.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/microsoft-update-catelog.png" alt-text="Screenshot of the search result for Windows 10 KONICA MINOLTA PS BW Laser Class Driver in Microsoft Update Catalog.":::  

4. Extract the saved .cab file to any folder.
5. Do steps 1 through 6 in the [Symptoms](#symptoms) section.
6. On the **Install the printer driver** screen, select **Have disk**.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/select-have-disk-button.png" alt-text="Screenshot of the Have Disk... option for Generic / Text Only Printer in the Add Printer Wizard dialog.":::

7. Browse to the folder that was extracted in step 4, and then select the **OK**.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/browse-disk.png" alt-text="Screenshot of the Copy manufacturer's files from: input box in the Install from Disk dialog.":::

8. After the printer driver list appears, select the target driver, and then select **Next** to go through the remaining wizard steps and complete all installation tasks. Contact your printer vendor for more information about which printer driver must be downloaded for the printer that you are using.

    :::image type="content" source="media/not-all-printer-drivers-from-windows-update-in-add-printer-wizard/install-printer-driver.png" alt-text="Screenshot of the printer driver list in the Install the printer driver dialog.":::
