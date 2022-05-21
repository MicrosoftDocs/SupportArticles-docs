---
title: How to correct negative FMLA hours in Microsoft Dynamics GP
description: Discusses how to correct negative FMLA hours in Microsoft Dynamics GP.
ms.reviewer: jaredha, lmuelle, cswaswick
ms.topic: how-to
ms.date: 03/31/2021
---
# How to correct negative FMLA hours in Microsoft Dynamics GP

This article describes how to correct negative FMLA hours in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866170

If an employee has negative FMLA hours and you verified the employee hasn't taken more than the maximum allowed hours for leave, you can resolve the issue by verifying your FMLA Calendar is set up to include only the desired days. You have the option to set up the **Company-wide Down Day** settings in the FMLA Calendar. If the setting is **None**, all calendar days count toward FMLA leave. If the date range for the employee's leave doesn't consider Saturdays or Sundays but they're counted anyway because of calendar settings, the employee's FMLA hours that are available become negative.

To change the **Company-wide Down Day** settings for the FMLA Calendar, follow these steps:

1. Open the FMLA Calendar window by using one of the following methods:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **Human Resources** > **Benefits and Deductions**, and then click **Benefit Preferences**.
    - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Human Resources** > **Benefits and Deductions**, and then click **Benefit Preferences**.
2. In the Benefit Preferences window, click **FMLA Calendar**.
3. In the FMLA Calendar window, under **Company-wide Down Day**, select **Sundays Only** if you want only Sundays not to count toward FMLA leave, or select **Saturdays and Sundays** if you want neither Saturdays nor Sundays to count toward FMLA leave.
