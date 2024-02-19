---
title: Printers are grouped as one
description: Provides a solution to an issue where printers installed using the same driver and port on Windows are grouped as one when viewed within Devices and Printers.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jdickson
ms.custom: sap:management-and-configuration:-installing-print-drivers, csstroubleshoot
---
# Printers installed using the same driver and port on Windows are grouped as one when viewed within Devices and Printers

This article provides a solution to an issue where printers installed using the same driver and port on Windows are grouped as one when viewed within Devices and Printers.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2015694

## Symptoms

Consider this scenario:

- A computer running a version of Windows listed in the Applies To section.
- Install two or more printers using the same printer driver and installed with the same printer port (that is, LPT1).
- View the installed printers within **Devices and Printers**.

In this scenario, when viewing the installed printers within **Devices and Printers**, you may notice that some of the printers are grouped together and are associated with the same printer icon.

## Cause

It's an expected behavior.

## Resolution

To work around this issue, you can use the following steps to create a Printers desktop icon that will list the installed printers separately:

1. Open the Registry Editor (Select the **Start** button > type REGEDIT.EXE without the quotes and press the enter key) When prompted with User Account Control select Yes.

2. Expand to and selected the following registry key:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace`

3. Right-click on the NameSpace registry key and choose **New Key**, enter the following GUID for the new registry key name (be sure to include the brackets)  
    {2227a280-3aea-1069-a2de-08002b30309d}

4. In the right pane, right-click the registry value (Default) and choose **Modify**, for the Value data enter **Printers** without the quotes

5. Close Registry Editor

6. Right-click on the **Desktop** and select **Refresh**

    > [!NOTE]
    > After selecting refresh of the desktop, a new desktop icon called **Printers** will appear. Double-clicking on the new **Printers** icon you will be able to see the installed printers separately. You can also Add, Remove, View, or Manage the print queues, change printer settings, and choose printer preferences from within this new Printers Desktop icon.

## More information

There are several factors that contribute to the printer grouping, and the type of device as with the more common Multi-Function Printers. The way that printers are grouped or not depends on the following factors:

1. Same driver.
2. Same Port.
3. Same HardwareID.

Typically it's identified that if the devices use the same HardwareID means same hardware printers, drivers may be different, PS, PCL, and so on. The determining factor is the port and the HardwareID.

For more information on Windows 7 Device Experience, see [Windows 7 device experience](/previous-versions/windows/hardware/device-stage/dn629506(v=vs.85)).
