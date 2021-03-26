---
title: Running an.exe file starts different program
description: Describes a problem in which you run an .exe file and the file starts a different program. A resolution is provided.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Applications
ms.technology: windows-client-performance
---
# The file may start a different program when you run an .exe file in Windows 7

This article provides a solution to an issue where the file may start a different program when you run an .exe file in Windows 7.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 950505

## Symptoms

When you run an .exe file in Windows 7, the file may start a different program. Additionally, the icon for the .exe file may not appear as expected. You may also receive additional errors from the .exe file or from the program that starts.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, reset the registry subkey for the file association of the .exe file back to the default setting. To do this, follow these steps:

1. To open the Task Manager, press CTRL + SHIFT + ESC.
2. Click **File**, press CTRL and click **New Task (Run...)** at the same time. A command prompt opens.

    :::image type="content" source="./media/running-exe-starts-another-program/select-new-task-run-option.png" alt-text="Screenshot of New Task (Run...) option.":::

3. At the command prompt, type *notepad*, and then press ENTER.

    :::image type="content" source="./media/running-exe-starts-another-program/enter-notepad.png" alt-text="Screenshot of entering notepad in command prompt.":::

4. Paste the following text into Notepad:

    ```console
    Windows Registry Editor Version 5.00

    [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe][HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe][HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe\OpenWithList][HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe\OpenWithProgids] "exefile"=hex(0):
    ```

5. On the **File** menu, click **Save as**.

    :::image type="content" source="./media/running-exe-starts-another-program/save-file.png" alt-text="Screenshot of saving the notepad file as exe.reg format.":::

6. Select **All Files** in the **Save as type** list, and then type *Exe.reg* in the **File name** box.
7. Select **Unicode** in the **Encoding** list. Save it and remember the file location.

    ![Screenshot of saving the notepad file as Exe.reg file format.](./media/running-exe-starts-another-program/save-exe-reg-file.png)

8. Return to the Command Prompt window, type `REG IMPORT <filepath> Exe.reg`, and then press ENTER.

    :::image type="content" source="./media/running-exe-starts-another-program/enter-reg-import-exe-reg-file.png" alt-text="Screenshot of importing the saved Exe.reg file.":::

    > [!NOTE]
    > \<filepath> is a placeholder which is to input your Exe.reg file location (for example, C:\Exe.reg).

9. Click **Yes**, and then click **OK** in response to the registry prompts.

10. Log off from your account. Then, log back on to your account.

> [!NOTE]
>
> - You may have to restart the computer to restore the program icons to their original appearance.
> - After the problem is resolved, delete the Exe.reg file so that it is not mistakenly added back to the registry at a later date.
