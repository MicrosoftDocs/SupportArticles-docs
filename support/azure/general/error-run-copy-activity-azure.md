---
title: Error when you try to copy content to Azure
description: This article provides a resolution for the problem that occurs when you try to copy content to Microsoft Azure by using a Java-based tool or program.
ms.date: 10/22/2020
ms.custom: sap:Data Factory, V2 - Azure-SSIS Integration Runtime
ms.service: azure-common-issues-support
---
# UserErrorJreNotFound error message when you run a copy activity to Azure

This article provides a resolution for the problem that occurs when you try to copy content to Microsoft Azure by using a Java-based tool or program.

_Original product version:_ &nbsp; Data Factory  
_Original KB number:_ &nbsp; 4497239

## Symptoms

When you try to copy content to Microsoft Azure by using a Java-based tool or program (for example, copying ORC or Parquet format files), you receive an error message that resembles the following:

> ErrorCode=UserErrorJreNotFound,'Type=Microsoft.DataTransfer.Common.Shared.HybridDeliveryException,Message=Java Runtime Environment is not found. Go to `http://go.microsoft.com/fwlink/?LinkId=808605` to download and install on your Integration Runtime (Self-hosted) node machine. Note 64-bit Integration Runtime requires 64-bit JRE and 32-bit Integration Runtime requires 32-bit JRE.,Source=Microsoft.DataTransfer.Common,''Type=System.DllNotFoundException,Message=Unable to load DLL &apos;jvm.dll&apos;: The specified module could not be found. (Exception from HRESULT: 0x8007007E),Source=Microsoft.DataTransfer.Richfile.HiveOrcBridge

## Cause

This issue occurs for either of the following reasons:

- Java Runtime Environment (JRE) isn't installed correctly on your Integration Runtime server.

- Your Integration Runtime server lacks the required dependency for JRE.

By default, Integration Runtime resolves the JRE path by using registry entries. Those entries should be automatically set during JRE installation.

## Resolution

Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To fix this issue, follow these steps to verify the status of the JRE installation:

1. Make sure that Integration Runtime (Diahost.exe) and JRE are installed on the same platform. Check the following conditions:
   - 64-bit JRE for 64-bit ADF Integration Runtime should be installed in the folder: `C:\Program Files\Java\`

     > [!NOTE]
     > The folder is not `C:\Program Files (x86)\Java\`

   - JRE 7 and JRE 8 are both compatible for this copy activity. JRE 6 and versions that are earlier than JRE 6 have not been validated for this use.

2. Check the registry for the appropriate settings. To do this, follow these steps:

   1. In the **Run** menu, type **Regedit**, and then press Enter.
   1. In the navigation pane, locate the following subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment`.

      In the **Details** pane, there should be a Current Version entry that shows the JRE version (for example, 1.8).

      :::image type="content" source="media/error-run-copy-activity-azure/java-runtime-environment-image.png" alt-text="Screenshot of the Java Runtime Environment version in the registry.":::

   1. In the navigation pane, locate a subkey that is an exact match for the version (for example 1.8) under the JRE folder. In the details pane, there should be a **JavaHome** entry. The value of this entry is the JRE installation path.

      :::image type="content" source="media/error-run-copy-activity-azure/java-home-entry-image.png" alt-text="Screenshot of the JavaHome entry in the details pane.":::

3. Locate the bin\server folder in the following path:

    `C:\Program Files\Java\jre1.8.0_74`

    :::image type="content" source="media/error-run-copy-activity-azure/folder-of-jre.png" alt-text="Screenshot shows the location of the bin folder.":::

4. Check whether this folder contains a jvm.dll file. If it does not, check for the file in the `bin\client` folder.

   :::image type="content" source="media/error-run-copy-activity-azure/file-location-image.png" alt-text="Screenshot to check the jvm.dll file in the bin folder.":::
  
> [!NOTE]
>
> - If any of these configurations are not as described in these steps, use the [JRE windows installer](https://go.microsoft.com/fwlink/?LinkId=808605) to fix the problems.
> - If all the configurations in these steps are correct as described, there may be a VC++ runtime library missing in the system. You can fix this problem by installing the VC++ 2010 Redistributable Package.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
