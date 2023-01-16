---
title: Troubleshoot IIS ABO Mapper errors
description: This article describes that how to create a log file to troubleshoot Admin Base Object (ABO) Mapper errors in IIS 7.5 and 7.0.
ms.date: 04/17/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.topic: how-to
ms.technology: iis-health-diagnostic-performance
---
# Create a log file to troubleshoot ABO Mapper errors in IIS

This article provides information about creating a log file to troubleshoot Admin Base Object (ABO) Mapper errors in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 931208

## ABO Mapper

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. So make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/kb/322756).

IIS 7.0 and later versions include a compatibility feature that enables scripts and programs that used ABO in earlier versions of IIS to work with IIS 7.0 and later versions. This compatibility feature is known as the ABO Mapper.

Changes that are made by the legacy scripts and code that use ABO are written to the *ApplicationHost.config* file in IIS. The ABO Mapper sub component maps the legacy metabase configuration settings to the new distributed configuration system in IIS. In some cases, this sub component may meet problems.

## Create a log file to troubleshoot ABO Mapper

To help troubleshoot these problems, you can configure the computer that is running IIS to create an error log file for the ABO Mapper feature. Follow these steps:

1. Select **Start**, type *regedit* in the **Start Search** box, and then press Enter.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password or select **Continue**.

2. In Registry Editor, locate the following registry key:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\IISADMIN`

3. Right-click **IISADMIN**, point to **New**, and then select **Key**.
4. Type parameters for the new key name, and then press Enter.
5. Right-click **Parameters**, point to **New**, and then select **DWORD (32-bit) Value**.
6. Type *EnableABOMapperLog* for the DWORD Value name, and then press Enter.
7. Right-click **EnableABOMapperLog**, and then select **Modify**.
8. Set the **Value data** value to **1** to enable the log file. A value of **0** turns off ABOMapper logging.
9. Close the registry.
10. Select **Start**, type *Services* in the **Start Search** box, and then select **Services**.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password or select **Continue**.

11. In **Services**, right-click **IIS Admin Service**, and then select **Restart**.

By default, all errors that occur during the ABOMapper process are written to the *Abomapper.log* file. This log file is located in the `%windir% \System32\` folder. Only members of the Administrators group can access the *Abomapper.log* file.
