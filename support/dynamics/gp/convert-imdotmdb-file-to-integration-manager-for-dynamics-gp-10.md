---
title: Convert IM.mdb file from an earlier version of Integration Manager to Integration Manager for Microsoft Dynamics GP 10.0
description: This article gives steps on how to convert the IM.mdb file from an earlier version to Integration Manager for Microsoft Dynamics GP 10.0.
ms.topic: how-to
ms.reviewer: theley, kvogel
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to convert the IM.mdb file from an earlier version of Integration Manager to Integration Manager for Microsoft Dynamics GP 10.0

This article contains step-by-step instructions to convert the IM.mdb file from an earlier version of Integration Manager to Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939372

To convert an IM.mbd file from an earlier version to Integration Manager for Microsoft Dynamics GP 10.0, follow these steps.

> [!NOTE]
> You must install the latest Integration Manager service pack because it contains fixes for this process.

1. Start Integration Manager.
2. On the **Tools** menu, click **Convert Database**. The Database Conversion window opens.
3. Click **Select Database**.
4. Locate the IM.mdb file that you want to convert.
5. Click **Open**.
6. Click **Convert Database**.

    You receive a new Converted_IM.imd file and a new Converted_IM.Mdb.log file in the same folder location as the original IM.mdb file.
7. Review the log file to determine whether the data was converted.
8. Double-click the **Converted_IM.imd** file to open Integration Manager.

    > [!NOTE]
    > You can rename this file. Additionally, you can change the file name extension back to the .mdb file name extension.
9. Change the path of the converted IM.mdb file. To do this, click **Options** on the **Tools** menu, and then change the path in the **Default Integration Manager Database** field.

> [!NOTE]
>
> - Both the Project Accounting and Fixed Assets destinations are not part of the release version of Integration Manager 10.0. Both destinations are available with Integration Manager 10.0 Service Pack 1.
> - The XML Source adapter will not convert. The new XML Source adapter is available with Integration Manager 10.0 Service Pack 2.
