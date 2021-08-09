---
title: Preview/form region displays no data in Outlook
description: Microsoft Dynamics CRM preview/form region displays no data in Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM preview/form region displays no data in Outlook

This article provides a resolution for the issue that Microsoft Dynamics CRM preview/form region at the bottom of the window shows no information.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2617456

## Symptoms

When you use Microsoft Office Outlook, and you have the Microsoft Dynamics CRM for Outlook client installed, the Microsoft Dynamics CRM preview/form region at the bottom of the window displays no information.

## Cause

This issue may be caused by one of the following conditions.

### Cause 1

An earlier version of Microsoft Office left behind references to an older Object Library (OLB) file. This typically includes earlier versions of the Primary Interop Assemblies.

### Cause 2

The user profile temp directory contains more than 65,535 files. Outlook uses temporary files for form region storage. However, if the user's temp directory contains more than 65,535 files, Outlook cannot initialize the form region.

## Resolution for Cause 1

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see: [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, select **All Programs**, select **Accessories**, and then select **Run**.
2. In the **Run** dialog box, enter *regedit*, and then select **OK**.
3. In Registry Editor, locate the following hive:

    `HKEY_CLASSES_ROOT\TypeLib\{00062FFF-0000-0000-C000-000000000046}\9.3`

4. Locate the **PrimaryInteropAssemblyName** string value, and then determine the version, as seen in the bolded element in the following example:

   PrimaryInteropAssemblyName"="Microsoft.Office.Interop.Outlook, **Version=12.0.0.0**, Culture=neutral, PublicKeyToken=71E9BCE111E9429C

If the version is 12.0.0.0, you must delete the 9.3 folder hive, as this corresponds to the 2007 Microsoft Office system.

## Resolution for Cause 2

1. Select **Start**, select **All Programs**, select **Accessories**, and then select **Run**.
2. In the **Run** dialog box, enter *%localappdata%*, and then select **OK**.
3. Open the Temp folder.
4. Delete any .tmp files that begin with `Olk`.
