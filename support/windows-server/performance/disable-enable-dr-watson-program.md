---
title: Disable or enable Dr. Watson program
description: Describes how to disable and re-enable the Dr. Watson program for Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Disable or enable Dr. Watson for Windows

This article describes how to disable and re-enable the Dr. Watson program for Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 188296

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

## Disable Dr. Watson

1. Click **Start**, click **Run**, type *regedit.exe* in the **Open** box, and then click **OK**.

2. Locate and then click the registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\AeDebug`.

    > [!NOTE]
    > Steps three and four are optional. However, they are necessary if you want to restore the default use of Dr. Watson.

3. Click the **AeDebug** key, and then click **Export Registry File** on the **Registry** menu.

4. Type a name and location for the saved registry file, and then click **Save**.

5. Delete the **AeDebug** key.

Registry entries for debugger programs are located in the **AeDebug** key in Windows. The Dr. Watson program is installed by default in Windows, and is configured to run when an application error occurs (with a data value of 1 for the Auto value). The default values are as follows:

- Value Name = Auto
  - Type = String (REG_SZ)
  - Data Value = 1 or 0. (Default is 1)

- Value Name = Debugger
  - Type = String (REG_SZ)
  - Data Value = drwtsn32 -p %ld -e %ld -g

> [!NOTE]
> This data value (drwtsn32 -p %ld -e %ld -g) is specific to Dr. Watson. Alternative debuggers will have their own values and parameters.

## Enable Dr. Watson

1. At a command prompt, type the `drwtsn32 -i` command, and then press ENTER.

2. Double-click the .reg file that you created in steps three and four that were discussed earlier.

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/).
