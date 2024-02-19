---
title: A printer driver cannot be installed through Windows Update in Windows Server
description: Discusses an issue in which a printer drive cannot be installed from Windows Update in Windows Server 2016 and Windows Server 2019. Provides a workaround.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
---
# A printer driver cannot be installed through Windows Update in Windows Server 2016 and Windows Server 2019

This article provides a workaround to an issue in which a printer drive cannot be installed from Windows Update in Windows Server 2016 and Windows Server 2019.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4033208

## Symptoms

Consider the following scenario:

- You install a printer by using the **Add a printer using the TCP/IP address or hostname**  option in the **Add Printer Wizard**.
- On the **Type a printer hostname or IP address**  page, you select **TCP/IP device**  as the **Device type**, and then you enter the hostname or IP address for the printer.
- You select the **Query the printer and automatically select the driver to use** check box.

In this scenario, the printer driver that is provided through Windows Update does not install automatically. Instead, one of the following actions occurs:

- You are prompted to use an inbox Class Driver.
- If no inbox Class Driver exists, you are prompted to select the driver to be used.

## Cause

Windows searches for driver .inf files through Windows Update only for printers that are installed by using a USB or WSD (Web Services Device) connection. Windows searches in the local INF folder only for printers that are installed as a TCP/IP device.

## Workaround

On the **Printer Driver Selection**  page, click the **Windows Update** button to download the list of drivers that are available on Windows Update, and then select the make and model of your printer.

## More Information

For enterprises that use the **TCP/IP device** option, the desired drivers can be stored on a network location, and that location can be appended to the **DevicePath** value. To do this, follow these steps:

1. In **Registry Editor**, locate the following subkey:  
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\DevicePath`
2. Update the subkey to add value data for the local path for the driver installation.

For example, change the value data from the default entry (%systemroot%\\inf) to the following path:  
%systemroot%\\inf;\\\\server\\DriverShare

In addition, the .inf file must have an entry that lists only the HWID of the printer. For example:

```inf
[Manufacturer] "Contoso"=Model,NTamd64 [Model.NTamd64] "Contoso Model 1 V4 PS" = INSTALL_SECTION_1,usbprint\Contoso_Laser_1 "Contoso Model 1 V4 PS" = INSTALL_SECTION_1,wsdprint\Contoso_Laser_1 "Contoso Model 1 V4 PS" = INSTALL_SECTION_1,Contoso_Laser_1 // this line is needed for "TCP/IP device"-installed printers.
```

You must contact the printer manufacturer for an updated driver that has an updated .inf file. After you obtain and store the correct file, the Add Printer Wizard can preselect the driver that is associated with the printer's HWID.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
