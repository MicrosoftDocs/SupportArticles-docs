---
title: Operation to Change a Personal Folder Location Fails
description: Provides a workaround to an issue in which you fail the operation to change the location of a personal folder.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:windows desktop and shell experience\desktop (shell,explorer.exe init,themes,colors,icons,recycle bin)
- pcy:WinComm User Experience
---
# Operation to change a personal folder location fails in Windows

## Symptoms

Assume that you changed the location of a personal folder in Windows, such as **Documents** or **Downloads**, and mapped the folder to another personal folder. When you try to change the location of the folder again, the operation fails.

For example:

If the personal folder was mapped to a personal folder in the OneDrive folder on the computer, the following error message is received:

> Can't move the folder because there is a folder in the same location that can't be redirected. Access is denied.

If the personal folder was mapped to a local personal folder, for example, **Documents** was mapped to **Videos**, no error message is displayed. However, after the operation, the two folders' locations aren't separated.

For more information about how to change the location of a personal folder and map it to another folder, see the [More Information](#more-information) section.

## Workaround

> [!IMPORTANT]
> Essential information required for user success: Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

To work around this issue, follow these steps:

1. Right-click the Windows logo at the lower-left corner of the screen, and then select **Run**.
2. Type **regedit.exe** and press <kbd>Enter</kbd>. If **User Account Control** window pops up, select **Yes**.
3. In Registry Editor, browse to the following path:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`

4. Refer to the following table to find the registry key for the folder that encounters this issue, and change it to the default value.

    |Folder  |Registry key  |Default value  |
    |---------|---------|---------|
    |**Downloads**     |`{374DE290-123F-4565-9164-39C4925E467B}`         |`%USERPROFILE%\Downloads`         |
    |**Desktop**     |`Desktop`         |`%USERPROFILE%\Desktop`         |
    |**Favorites**     |`Favorites`         |`%USERPROFILE%\Favorites`         |
    |**Music**     |`My Music`         |`%USERPROFILE%\Music`         |
    |**Pictures**     |`My Pictures`         |`%USERPROFILE%\Pictures`         |
    |**Videos**     |`My Video`         |`%USERPROFILE%\Videos`         |
    |**Documents**     |`Personal`         |`%USERPROFILE%\Documents`         |

5. Restart the **Explorer.exe** process to make the changes take effect. To do this, you can use either of the following steps:

    - Restart the process in Task Manager.
    - Sign out, and then sign in.
    - Restart the computer.

## More Information

To change the location of a personal folder, follow these steps:

1. Right-click the personal folder, and then select **Properties**.
2. Switch to the **Location** tab in the dialog box.
3. Select **Move...**.
4. Select the destination folder path and then select **OK**.
