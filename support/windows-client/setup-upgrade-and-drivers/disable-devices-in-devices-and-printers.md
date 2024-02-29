---
title: Disable Devices in Devices and Printers
description: Describes how to hide or disable **Devices** in **Devices and Printers**.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Hide or disable Devices in Devices and Printers

This article describes how to hide or disable **Devices** in **Devices and Printers**.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2018577

## Symptoms

There is no way in the Windows interface to hide **Devices** within the **Devices and Printers** GUI.

## Resolution

You can hide **Devices and Printers** from Control Panel using the supported GPO and then create a folder to view **Printers** only.
To do this, use the policy "Hide specified control panel items" to remove the **Devices and Printers**  item from the Control Panel window:

1. Edit a GPO.
2. Navigate to **User Configuration\Policies\Administrative Templates\Control Panel**.
3. Double-click **Hide specified control panel items** in the right pane, select **Enable**, click **Show** button, and type *Microsoft.DevicesAndPrinters*.

Once this policy is in place, go to Regedit and create this following Entry:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\`

Create a new key **{2227a280-3aea-1069-a2de-08002b30309d}**  

On the right hand Pane **Edit** the **Default** Key and give it the value **Printers**.

This will create a folder on the Desktop as Printers which when opened gives only the Printer listing.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
