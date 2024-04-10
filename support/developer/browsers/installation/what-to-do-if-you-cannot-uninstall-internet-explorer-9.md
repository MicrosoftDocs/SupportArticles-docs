---
title: Cannot uninstall Internet Explorer 9
description: Describes how to uninstall Internet Explorer 9 when the standard program removal methods aren't working for you.
ms.date: 10/15/2020
ms.reviewer: ramakoni
---
# What to do if you can't uninstall Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

If the Uninstall a Program feature doesn't uninstall Internet Explorer 9 correctly, try these solutions in the order in which they're presented.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2579295

## Solution 1 - Run a command-line command

1. Sign in to the computer by using an administrator account or an account that has administrative rights.
2. Close all Internet Explorer browser windows.
3. Select **Start**, type *cmd* in the **Search** box, and then select **cmd** under **Programs**.
4. Copy the following command:

   ```console
   FORFILES /P %WINDIR%\servicing\Packages /M Microsoft-Windows-InternetExplorer-*9.*.mum /c "cmd /c echo Uninstalling package @fname && start /w pkgmgr /up:@fname /norestart"
   ```

5. Paste the command into the **Command Prompt** window, and then press Enter.
6. Restart the computer.

## Solution 2 - Use System Restore

1. Sign in to the computer by using an administrator account or an account that has administrative rights.
2. Select **Start**, and then type *system restore*.
3. Right-click **System Restore**, and then select **Run as administrator**. Select **Continue** if you are prompted.
4. In the **System Restore** dialog box, select **Next**.
5. In the list that appears, select a restore point that's earlier than when you installed Internet Explorer 9, and then select **Next**.
6. In the **Confirm your restore point** dialog box, select **Finish**.

Find more tips, tricks, and learning opportunities at [Microsoft Business Center](https://smallbusiness.support.microsoft.com/).
