---
title: Performance issues if UseLowPriorityConfiguration is 0
description: This article introduces the way to resolve some possible computer performance issues that are caused by modifying the UseLowPriorityConfiguration value in the registry.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Possible computer performance issues if UseLowPriorityConfiguration is set to 0 in the registry

_Original KB number:_ &nbsp; 2903548

## Symptoms

Under some configurations and situations, you may experience random computer performance problems when you have modified the `UseLowPriorityConfiguration` value in the registry.

## Cause

This problem can occur if the following registry data is configured on your computer:

Key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search`  
DWORD: **UseLowPriorityConfiguration**  
Value: **0**

## Resolution

Set the value of `UseLowPriorityConfiguration` to **1** (default value) to see whether there is an improvement in performance.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Start Registry Editor.

   1. Open the Run box.
       - Windows 8

         Press the Windows key+R

       - Windows 7, Windows Vista, or Windows XP

         On the Start menu, select **Run**.

   2. Type *Regedit.exe* and then select **OK**.
2. Locate the following key in the registry:

   `HKEY_LOCAL_MACHINE\ SOFTWARE\Microsoft\Windows Search`

3. Right-click `UseLowPriorityConfiguration` and then select **Modify**.
4. Change the Value data to **1** and then select **OK**.
5. Close Registry Editor.
6. Restart the Windows Search service.
   1. Open the Run box.
      - Windows 8

        Press the Windows key+R

      - Windows 7, Windows Vista, or Windows XP

        On the **Start** menu, select **Run**.

   2. Type *Services.msc* and then select **OK**.
   3. Right-click the Windows Search service and then select **Stop**.
   4. Right-click the Windows Search service and then select **Start**.

## More information

The `UseLowPriorityConfiguration` registry value can be configured to use either of the following two data values:

1 = (Default) Use low-priority input/output mode for search processes. You do this to keep overall computer performance at an optimum.

0 = Do not use low-priority input/output mode for search processes. There are many factors involved, but using a value of **0** may affect overall computer performance.

We recommend that you do not change the value from the default unless you are provided this guidance from a Microsoft Support Engineer.

There is a different registry value, `DisableBackoff`, that also controls the way Windows Search indexes items. It can also cause random performance issues if changed from its default value.
