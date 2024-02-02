---
title: Find a compatible printer driver for a computer running a 64-bit version of Windows
description: Describes how to find a compatible printer driver for a computer running a 64-bit version of Windows. Useful if you require a driver for a printer that isn't supported on a computer running a 64-bit version of Windows.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-installing-print-drivers, csstroubleshoot
---
# How to find a compatible printer driver for a computer that's running a 64-bit version of Windows

This article describes how to find a compatible printer driver for a computer that's running a 64-bit version of Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 895612

This article may be useful if you can't obtain a Windows Hardware Quality Labs (WHQL) signed printer driver from the printer manufacturer or from the Microsoft Windows Update Web site. It also provides methods to find a printer driver for a printer that isn't supported on your computer that's running a 64-bit version of Windows.

> [!NOTE]
> To print from a computer that's running a 64-bit version of Windows, you must have a 64-bit printer driver. You can't use a 32-bit printer driver on a computer that's running a 64-bit version of Windows.

## How to locate a compatible printer driver for your computer running a 64-bit version of Windows

We recommend that you first visit the Windows Vista Compatibility Center to find links to the latest 64-bit printer drivers. Its database contains thousands of the most popular printers and you can easily search by product name, number, or brand.

If you can't find the printer drivers, try these methods in the following order.

### Method 1: Search for a supported driver that's included in the Windows 64-bit operating system

To search for a supported driver that's included in the Windows 64-bit operating system, follow these steps:

1. On the computer that's running a 64-bit version of Windows, select **Start** > **Settings** > **Printers and Faxes**.
2. Double-click **Add Printer**.
3. Select **Next**, and then follow the instructions on the screen.

### Method 2: Search for a WHQL signed driver on the Microsoft Windows Update Web site

To search for a WHQL signed driver on the Microsoft Windows Update Web site, select **Start** > **Windows Update**, and then follow the instructions on the Windows Update Web site.

### Method 3: Search for a WHQL signed driver on the printer manufacturer's Web site

For information about how to search for a WHQL signed driver on the printer manufacturer's Web site, contact your printer manufacturer.

### Method 4: Search for a non-WHQL signed driver

> [!IMPORTANT]
> We don't recommend printer drivers that aren't WHQL signed, because Microsoft has no compatibility test results about the quality of these printer drivers.

Drivers that aren't WHQL signed are also known as unsigned drivers. Drivers that are WHQL signed are also known as signed drivers. Search any one of the following locations for a non-WHQL signed driver for your printer:

- The printer manufacturer's Web site
- Beta drivers on the printer manufacturer's Web site
- Computer hardware Web sites

## How to choose a compatible printer driver if you can't locate a printer driver for your printer

The printer emulation type and the physical features of the printer are important printer property values. The physical features of the printer are things such as duplex mode and the number of paper trays. Printer emulation is the most important of these two printer property values.

### Printer emulation

Printer emulation describes the type of encoding that Windows uses to transmit the page data to the printer. Printer emulations are sometimes referred to as printing languages. A computer that's running a 64-bit version of Windows must transmit the page data in a language or emulation that the printer understands. If the computer that's running a 64-bit version of Windows doesn't use the correct emulation, print jobs aren't decipherable.

There are a few common printer languages or emulations. The most common ones are:

- PostScript Variants: PostScript Level 1, PostScript Level 2, PostScript Level 3.
- PCL - PCL = Page Control Language.
    - PCL 5 - Variants include PCL5c, where c= color, and PCL5e, where e=enhanced.
    - PCL 6 - It's also called PCL XL.
    - PCL 4 - It's only used in some low end laser printer devices.
- KPDL - used by Kyocera laser printer, similar to PostScript 2.
- RPDL - used by Ricoh printers.
- HP/GL and HP/GL2 - used by some plotters.
- CaPSL - older language, used in some older Canon Laser devices.
- Canon Extended Mode - used in older Canon Bubble Jet printers.
- Epson EscP/2 - used in some serial printers and older inkjet printers from Epson.
- Epson Esc/Page - used in many Epson laser printers.
- Epson Script - used in some Epson laser printers.
- Dot-Matrix printers - frequently use Epson24, Epson9, IBMProprint, Oki9, or Oki24.

> [!NOTE]
> There are many other common languages on printers in the East Asian marketplace, because some East Asian regions require more complex fonts.

Modern inkjet printers may not use a common set of printer languages, because precise ink control is typically a compatibility issue.

To determine what emulation your printer supports, use either of the following methods:

- If your printer can print an information page, print this information page. For example, some printers have a menu with a **Print Configuration** command that you can use to obtain printer information.
- View the printer specifications on the printer manufacturer Web site or in the printer manual.

> [!NOTE]
> Some printers support more than one type of printer emulation.

Some printer manufacturers may interpret different printer emulations in different ways. If you use a printer driver from the same printer manufacturer that supports your printer emulation, you can possibly prevent some compatibility problems. For example, if your printer supports PostScript level 3 as its default printer emulation, look up the list of printer drivers that are supplied with the 64-bit version of Windows. You can do it to find another printer from the same printer manufacturer that uses the same printer emulation. Here are the steps.

> [!NOTE]
> When you use the following method, the print job is printed locally and the print job is then redirected to the network path. If you use this procedure, you don't receive printer updates from the print server when you update the printer driver on the print server.

1. On the computer that's running a 64-bit version of Windows, check if the correct printer drivers are located. You can also visit the Windows Update Web site or the printer manufacturer's Web site. If you can't find the correct driver, continue to the next step.
2. Sign in to the computer that's running a 64-bit version of Windows by using an account that has administrative permissions.
3. On the physical printer, use the device menus to print a configuration page. The printed configuration page typically lists the supported printer emulations. For example, the configuration page might list PostScript, PCLXL, or PCL as supported printer emulations.
4. On the computer that's running a 64-bit version of Windows, select **Start** > **Settings** > **Printers and Faxes**.
5. Double-click **Add Printer**.
6. Select **Next**.
7. Select **Local printer**, clear the **Automatically detect and install** check box, and then select **Next**.
8. Select **Create a new port**, and then select **Local Port** next to **Type of Port**.
9. In the **Port Name** dialog box, type the path of the printer by using the following syntax:

    \\\ **print server name**\\**printer name**
10. Select **Next**.
11. In the **Install Printer Software** page, select the correct manufacturer under the **Manufacturer** column. Then select the name of a printer that supports the same printer emulation as your printer. Select **Next** > **Finish**. For example, you have an HP LaserJet printer that supports PostScript emulation. Try to locate another HP LaserJet printer model that has a similar model number and supports PostScript emulation.
12. In Printers and Faxes, right-click the printer that you added, and then select **Properties**.
13. Select the **General** tab, and then select **Print Test Page**.
14. If the test page prints correctly, you have found a matching printer driver. If the test page is unreadable, find another printer driver, or try another emulation type.

### Tips for locating a compatible printer driver

You can use the name of your printer to get more information to find a compatible printer driver. For example:

- The Canon LBP-2460 PS printer driver is for Canon Laser Beam printers.
- The 2460 series prints 24 pages per minute by using PostScript emulation.

If the printer contains PS2 in the name, it typically refers to PostScript level 2. PS3 in the device name typically refers to PostScript level 3.

For some printers, a printer driver has v.*the PostScript emulator version that the printer uses* in the title. For example, the Canon LBP-8III Plus PS-1 v51.4 uses version 51.4 of the PS1 language.

For laser printers in the US and Europe, almost 80% of network laser printers use either PostScript or PCL as their main language. Of this 80%, PCL5 is the most common PCL type that's used and PostScript level 2 is the most common PostScript type.

Some personal laser printers are less standard. Typically, PostScript level 3 is a superset of PostScript level 2. So if you have a printer that understands PostScript level 3, and a driver that uses PostScript level 2, the printed test may be decipherable. Similarly, PCL6/XL is based on PCL5e, and PCL5e is based on PCL5.

## How to match the physical features of an unsupported printer

If you select a similar printer in the Add Printer Wizard on a computer running 64-bit Windows, consider the physical features of the printer. For example, if you require duplex printing on your documents, the compatible driver that you choose must also support duplex printing.

Other issues to consider include the availability of paper input and output trays, and the default orientation of the paper input. For example, printer drivers offer different methods to select duplex printing. If you choose a printer driver from the same manufacturer as your printer, you can increase the chance that duplex is implemented in the same way across the whole range of devices. Besides, if you pick a printer model that has a similar model series number, you can increase the chance that the printer driver is compatible.

## Issues that you may experience when you use a compatible printer driver

If you select a compatible printer, you may experience compatibility issues. For example, you want to print to a monochrome laser printer. In this situation, you must find a printer driver that uses the same printer emulation. The same printer emulation typically ensures that the document prints legibly. But you may not have the required duplex feature available.

If you print to a color laser printer, and you install a compatible printer driver that uses the same printer emulation, you can print decipherable documents. However, subtle differences in text color may not be preserved. It means that documents such as photographs may not print with a high image quality.

If you print to a dot-matrix printer device, and you install a compatible printer driver that uses the same printer emulation, you may experience one or more of the following symptoms:

- Some fonts in your print job may appear different from what you expect.
- The printer may print slower because the print driver has to draw the fonts as a bitmap before printing can start.

It may be difficult to match an inkjet printer with a compatible printer driver. The rules that apply to other classes of printers don't always apply to inkjet printers, because there are many different types of inkjet printers on the market.

> [!NOTE]
> Installing a WHQL signed printer driver that's designed to match your specific printer always produces better results.

## Technical support for x64-based versions of Windows

Your hardware manufacturer provides technical support and assistance for x64-based versions of Windows. Your hardware manufacturer provides support because an x64-based version of Windows was included with your hardware. Your hardware manufacturer might have customized the installation of Windows with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your x64-based version of Windows. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
