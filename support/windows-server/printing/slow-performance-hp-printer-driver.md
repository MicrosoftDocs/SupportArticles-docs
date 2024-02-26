---
title: Slow performance when you print
description: Describes an issue on a failover cluster in which cluster nodes may stop responding temporarily.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Slow performance when you try to print, when you open the printer properties, or when you open the printer preferences

This article provides a solution to an issue where you experience slow performance when you try to print, or open printer properties/preferences.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 979394

## Symptoms

Consider the following scenario:

- You install the Print Services role on a stand-alone computer or failover cluster that is running Windows Server 2008 or Windows Server 2008 R2.
- You install an inbox HP-based printer driver or an OEM HP-based printer driver.

In this scenario, you experience slow performance when you do one of the following operations:

- You try to print.
- You open the printer properties.
- You open the printing preferences.

Additionally, some cluster nodes might stop responding temporarily when you open the printer properties or the printing preferences.

## Cause

The following HP printer drivers are affected by this issue:
- OEM HP Universal Printing driver 4.5 PCL 5
- OEM HP Universal Printing driver 4.5 PCL 6
- OEM HP Universal Printing driver 4.5 PCL PS
- OEM HP Universal Printing driver 4.7 PCL 5
- OEM HP Universal Printing driver 4.7 PCL 6
- OEM HP Universal Printing driver 4.7 PCL PS
- OEM HP Universal Printing driver 4.7.2 PCL 5
- OEM HP Universal Printing driver 4.7.2 PCL 6
- OEM HP Universal Printing driver 4.7.2 PCL PS
- OEM HP Universal Printing driver 5.0 PCL 5
- OEM HP Universal Printing driver 5.0 PCL 6
- OEM HP Universal Printing driver 5.0 PCL PS
- OEM HP Universal Printing driver 5.0.1 PCL 5
- OEM HP Universal Printing driver 5.0.1 PCL 6
- OEM HP Universal Printing driver 5.0.1 PCL PS
- OEM HP Universal Printing driver 5.0.2 PCL 5
- OEM HP Universal Printing driver 5.0.2 PCL 6
- OEM HP Universal Printing driver 5.0.2 PCL PS
- OEM HP print drivers PCL 5 (that uses an UPD engine that is older than the UPD 5.0.3 engine)
- OEM HP print drivers PCL 5 (that uses UPD engine that is older than the UPD 5.0 engine)
- OEM HP print drivers PCL 6 (that uses UPD engine that is older than the UPD 5.0.3 engine)
- OEM HP print drivers PS (that uses UPD engine that is older than the UPD 5.0.3 engine)
- inbox HP PCL 5 print drivers *
- inbox HP PCL 6 print drivers *
- inbox HP PS print drivers *

> [!NOTE]
> The asterisk symbol (*) means that the drivers are included in Windows Vista, in Windows Server 2008, in Windows 7, and in Windows Server 2008 R2. A UPD engine that is older than the UPD 5.0.3 engine has these drivers.

## Resolution

To resolve this problem, install one of the following printer drivers:

- OEM HP Universal Printing Driver 5.0.3 or a later version PCL 5
- OEM HP Universal Printing Driver 5.0.3 or a later version PCL 6
- OEM HP Universal Printing Driver 5.0.3 or a later version PS

For more information about these printer drivers, visit [HP Universal Print Driver](https://www.hp.com/go/upd).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
