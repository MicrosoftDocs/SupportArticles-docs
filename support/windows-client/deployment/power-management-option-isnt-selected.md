---
title: Power management option isn't selected
description: Provides a solution to an issue that the **Allow the computer to turn off this device to save power** option doesn't remain selected after you restart the computer.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:power-management, csstroubleshoot
---
# The Allow the computer to turn off this device to save power option doesn't remain selected after you restart Windows Vista

This article provides a solution to an issue that the **Allow the computer to turn off this device to save power** option doesn't remain selected after you restart the computer.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 930312

## Symptoms

In Windows Vista, you click to select the **Allow the computer to turn off this device to save power** check box. However, when you restart the computer, this check box is cleared.

> [!NOTE]
> This check box appears on the **Power Management** tab of a **USB Root Hub Properties** dialog box. For more information about how to find this check box, see the [More information](#more-information) section.

## Workaround

To work around this problem, enable the **USB selective suspend** option. To do it, follow these steps:

1. Select **Start**, type power options in the **Start Search** box, and then select **Power Options** in the **Programs** list.

    If you're prompted for an administrator password or confirmation, type your password or select **Continue**.
1. Under the selected power plan, select **Change plan settings**.
1. Select **Change advanced power settings**.
1. In the **Power Options** dialog box, expand **USB settings**, and then expand **USB selective suspend setting**.
1. If you want to enable Windows Vista to turn off the USB root hub when the computer is running on battery power, select **Enabled** in the **On battery** list.
1. If you want to enable Windows Vista to turn off the USB root hub when the computer is plugged in to a power outlet, select **Enabled** in the **Plugged in** list, and then select **OK**.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

## More information

To view the **Allow the computer to turn off this device to save power** check box, follow these steps:

1. Select **Start**, type device manager in the **Start Search** box, and then select **Device Manager** in the **Programs** list.

    If you're prompted for an administrator password or confirmation, type your password or select **Continue**.
2. In the **Device Manager** dialog box, expand **Universal Serial Bus controllers**, right-click **USB Root Hub**, and then select **Properties**.
3. In the **USB Root Hub Properties** dialog box, select the **Power Management** tab. The **Allow the computer to turn off this device to save power** check box is displayed.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
