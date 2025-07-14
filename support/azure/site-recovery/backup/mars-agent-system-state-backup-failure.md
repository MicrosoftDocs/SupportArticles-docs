---
title: Microsoft Azure Recovery Services Agent System State backup failure (error ID 8007007B)
description: Error when you back up System State by using the Microsoft Azure Recovery Services (MARS) Agent.
ms.date: 08/14/2020
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: jarrettr
ms.custom: sap:I need help with Azure Backup
---
# Microsoft Azure Recovery Services Agent System State backup failure (error ID 8007007B)

This article describes the symptoms and resolution for an error that occurs when you back up System State by using the Microsoft Azure Recovery Services (MARS) Agent.

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 4053355

## Symptoms

One of the following error messages appears on the **Errors**  tab of the **Job Details** dialog box that corresponds to a failed System State backup job on the Microsoft Azure Recovery Services Agent console.

> Unable to perform the operation as Windows Server Backup job failed with error message: None of the items included in backup were backed up. Detailed error : The filename, directory name or volume label syntax is incorrect HResult: 80780049 DetailedHResult: 8007007B Goto [https://go.microsoft.com/fwlink/?linkid=847810](https://go.microsoft.com/fwlink/?linkid=847810) to fix this. (0x1873D)

> Windows Server failed to take system state backup because a system writer reported an invalid path. Windows Server Backup error message: The filename, directory name or volume label syntax is incorrect HResult: 80780049 DetailedHResult: 8007007B Goto [https://go.microsoft.com/fwlink/?linkid=859092](https://go.microsoft.com/fwlink/?linkid=859092)  to fix this. (0x18770)

:::image type="content" source="media/mars-agent-system-state-backup-failure/job-failed-error.png" alt-text="Screenshot of the job failed error for System State backup.":::

When you click **WSB Failure Logs**, a file opens that contains an error message that resembles the following:

> Error in backup of Systemroot_pathduring enumerate: Error [0x8007007b] The filename, directory name, or volume label syntax is incorrect.

## Cause

This error occurs when the file specification that is required for enumerating files that must be backed up as part of the Windows Server System State is updated incorrectly.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To make sure that the file specification is updated, follow these steps:

1. In the file that opens when you click **WSB Failure Logs**, verify that the **Systemroot_path** is correct. For example, **Systemroot_path** in the following error message should resemble `C:\Windows\\systemroot\`:

    > Error in backup of c:\windows\\systemroot\  during enumerate: Error [0x8007007b] The filename, directory name, or volume label syntax is incorrect.

2. Run the following command at an elevated command prompt:

    ```console
    diskshadow /l Output_File_Path
    ```

    > [!NOTE]
    > The **Output_File_Path**  placeholder should resemble `C:\outputfilepath.txt`.

3. Type the following commands at a DISKSHADOW prompt, and then press Enter after each command:

    ```console
    list writers detailed

    exit  
    ```

4. Open the output file that you specified in step 2.
5. Locate the line that contains **Systemroot_path** (`C:\Windows\\systemroot\` in our example above). For example, the line should resemble the following: File List: Path = **Systemroot_path**\system32\drivers, Filespec = **File_Spec_Path**

    For Example:  

    File List: Path = `C:\windows\\systemroot\system32\drivers`, Filespec = winmad.sys

6. Start Registry Editor. To do this, right-click **Start**, click **Run**, type **regedit** in the **Open** box, and then click **OK**.
7. Locate the following subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`
8. Right-click **Services**, and then click **Find**.

    :::image type="content" source="media/mars-agent-system-state-backup-failure/registry-editor.png" alt-text="Screenshot of the find option under services in Registry Editor.":::

9. In the **Find what** box, type the **File_Spec_Path** path that you found in step 5, and then click **Find Next**.

    :::image type="content" source="media/mars-agent-system-state-backup-failure/find-box.png" alt-text="Screenshot of the File_Spec_Path path in find what box." border="false":::

    Example:

    :::image type="content" source="media/mars-agent-system-state-backup-failure/find-winmadsys.png" alt-text="Screenshot of the example in find what box." border="false":::

    The search results will feature a registry key that is named **ImagePath**. If its value has a leading backslash '\', then double-click that value and remove it. If the value does not start with a backslash, submit a support request from the [Azure portal](https://portal.azure.com/?).

    |Before change|After change|
    |---|---|
    |:::image type="content" source="media/mars-agent-system-state-backup-failure/imagepath-value-before.png" alt-text="Screenshot of the search results for the imagepath before change.":::<br/>|:::image type="content" source="media/mars-agent-system-state-backup-failure/imagepath-value-after.png" alt-text="Screenshot of the search results for the imagepath after change.":::<br/>|

10. Go back to the MARS Agent console and start a System State Backup by clicking **Back Up Now**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
