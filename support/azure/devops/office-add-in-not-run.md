---
title: Office Integration add-in does not run
description: This article provides resolutions for the error that occurs where the Team Foundation Server 2015 Office add-in doesn't work.
ms.date: 08/18/2020
ms.custom: sap:Client Connectivity
ms.reviewer: beccam
ms.service: azure-devops
ms.subservice: ts-client-connectivity
---
# Team Foundation Server Office Integration add-in doesn't run

This article helps you resolve the error that occurs where the Team Foundation Server 2015 Office add-in doesn't work.

_Original product version:_ &nbsp; Team Foundation Server  
_Original KB number:_ &nbsp; 3192409

## Symptoms

You discover that the Team Foundation Server 2015 Office add-in doesn't work because it's not signed by a trusted publisher. This issue occurs when the following conditions are true:

- You're running a 32-bit version of Office on a 64-bit computer.

- You have a version of Team Foundation Server that's earlier than Team Foundation Server 2015 Update 3.

- In your Office settings, the **Required Application Add-ins to be signed by a Trusted Publisher** check box is selected under **File** -> **Options** -> **Trust Center** -> **Options**.

## Cause

This issue occurs if there are quotation marks in the add-in's **Location** field. This prevents Office from verifying the publisher. To confirm that this is the cause of your problem, go to **File** -> **Options** -> **Add-ins**, select the Team Foundation Add-in, and then view the **Location** field to see whether the location path is inside quotation marks.

:::image type="content" source="media/office-add-in-not-run/office-add-in.png" alt-text="Screenshot shows an example to check the add-in's Location field." border="false":::

## Resolution

A fix for this issue is included in Team Foundation Server 2015 Update 3 and later versions of Team Foundation Server. Consider updating to Update 3 resolve this problem.

If you have an earlier build, you can delete the quotation marks from the applicable registry key. Make sure that you create a backup copy before you edit a registry key.

To do this, you can use a _.reg_ script file or manually edit the string in Registry Editor. To manually edit the string, follow these steps:

1. Click **Start**, click **Run**, and then type _regedit_.
2. Navigate to the following Team Foundation Server 2015 subkey:

    `[HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{04986E13-556D-463F-ADBD-9D8CAD03707B}\InprocServer32]`

3. Right-click the **(Default)** entry, click **Modify**, and then delete the quotation marks at the beginning and end of the value in the **Data** column.

## More information

If you still encounter errors after you delete the quotation marks, make sure that Microsoft Corporation is listed as a trusted publisher on your computer. If it's not, you must install the Microsoft certificate.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
