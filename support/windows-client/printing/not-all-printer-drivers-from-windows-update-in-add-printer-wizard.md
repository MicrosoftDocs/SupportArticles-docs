---
title: Not all printer drivers from Windows Update appear in Add Printer wizard
description: Works around an issue in which not all printer drivers that are downloaded from Windows Update are listed when in the Add Printer wizard.
ms.date: 12/07/2020
ms.prod-support-area-path:  Windows\Windows 10\Windows 10, version 1903\Print, Fax, and ScanWindows\Windows 10\Windows 10, version 1903\Setup, Upgrades, and Drivers\Driver installation or driver update
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Not all printer drivers downloaded from Windows Update are listed in "Add Printer" wizard

_Original product version:_ &nbsp; Windows 10, version 2004, all editions, Windows Server, version 2004, all editions, Windows 10, version 1909, all editions, Windows 10, version 1903, all editions, Windows 10, version 1809, all editions, Windows 10, version 1803, all editions, Windows Server, version 1903, all editions, Windows Server version 1809, Windows Server version 1803, Windows Server 2019, all editions  
_Original KB number:_ &nbsp; 4508350

## Symptoms

On a computer that is running Windows 10, version 1803, Windows Server, version 1803 or a later version of Windows, you do the following operations: 
1. Select **Start**, type **Control Panel**, and then press Enter. 
2. In Control Panel, select the **View Devices and Printers**  item.

![View Devices and Printers](/media/4509156_en_1.png)  

3. Select **Add Printer** at the top of the window.

![Add Printer](/media/4509157_en_1.png)  

4. After the wizard started, select **The printer that I want isn't listed**. 
5. Select **Add a local printer or network printer with manual settings**, and then select **Next**. 
6. On the **Choose a Printer Port** page, select the desired port, and then select **Next**. 
7. On the **Install the printer driver** page, select **Windows Update**. 
8. The updated **Printers** list is displayed from Windows Update. For example, if you select **KONICA MINOLTA**  under **Manufacturer**, the **Printers** list is displayed as follows.

![Printer list](/media/4509158_en_1.png)  
  

In this scenario, not all registered drivers are displayed.  

For example, "KONICA MINOLTA PS BW Laser Class Driver" and "KONICA MINOLTA PS Color Laser Class Driver" are not both displayed as expected.  

## Workaround

To work around this issue, manually download and install the printer driver to be installed from the Windows Update Catalog. In the example of the driver mentioned in the Symptoms section, install according to the following procedure. 
1. Go to the [Windows Update Catalog](https://www.catalog.update.microsoft.com/home.aspx). 
2. In the search box, enter the keyword of the driver to be downloaded, such as "Windows 10 KONICA MINOLTA PS BW Laser Class Driver," and then select **Search**. 
3. After the list is displayed, select the **Download** button for the target driver, and save it to any folder.

![Microsoft catalog](/media/4509159_en_1.png)  

4. Extract the saved .cab file to any folder. 
5. Do steps 1 through 6 in the "Symptoms" section. 
6. On the **Install the printer driver** screen, select **Have disk**.
![](/media/4509160_en_1.png)  

7. Browse to the folder that was extracted in step 4, and then select the **OK**.

![Browse disk](/media/4509161_en_1.png)  

8. After the printer driver list appears, select the target driver, and then select **Next** to go through the remaining wizard steps and complete all installation tasks. Contact your printer vendor for more information about which printer driver must be downloaded for the printer that you are using.
![Install driver](/media/4509162_en_1.png)  

