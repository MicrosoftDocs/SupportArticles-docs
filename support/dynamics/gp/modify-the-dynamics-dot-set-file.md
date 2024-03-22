---
title: Modify the Dynamics set file
description: Provides steps to modify the Dynamics.set file so that all users can use the same Reports.dic file that is shared on a computer that is running Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to modify the Dynamics.set file so that all users can share the Reports.dic file in Microsoft Dynamics GP

This article discusses how to modify the Dynamics.set file. You can modify this file so that all users can share the Reports.dic file that is on the computer that is running Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858327

## More information

To modify the Dynamics.set file so that all users can use the same Reports.dic file, follow these steps:

1. Make a backup of the Dynamics.set file in the appropriate program folder.

   - Microsoft Dynamics GP

     The default location of the program folder is `C:\Program Files\Microsoft Dynamics\GP`.

      > [!NOTE]
      > The Dynamics.set file is specific to each client computer. Therefore, you must perform the backup on each client computer.

2. Locate the Dynamics.set file in the local Microsoft Dynamics GP program folder, right-click the Dynamics.set file, and then select **Edit**.

    > [!NOTE]
    >
    > - The file opens in Notepad.
    > - If the **Edit** command is unavailable, point to **Open With**, and then select **Notepad**.

3. The following example is a Dynamics.set file that also has SmartList registered.

    > 2  
    0  
    Dynamics  
    1493  
    SmartList  
    Windows  
    :C:Program Files/Microsoft Dynamics/GP/Dynamics.dic  
    :C:Program Files/Microsoft Dynamics/GP/Forms.dic  
    :C:Program Files/Microsoft Dynamics/GP/Reports.dic  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493.DIC  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493F.DIC  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493R.DIC

4. In the example in step 3, if the Reports.dic file is in a folder that is named **Reports on shared drive S**, the path of the Reports.dic file is `S:\Reports\Reports.dic`. In this example, modify the Dynamics.set file as follows:

    > 2  
    0  
    Dynamics  
    1493  
    SmartList  
    Windows  
    :C:Program Files/Microsoft Dynamics/GP/Dynamics.dic  
    :C:Program Files/Microsoft Dynamics/GP/Forms.dic  
    :S:Reports/Reports.dic  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493.DIC  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493F.DIC  
    :C:Program Files/Microsoft Dynamics/GP/EXP1493R.DIC

5. In Notepad, select **File**, and then select **Save**.
6. Select **File**, and then select **Exit**.
7. Start Microsoft Dynamics GP.
8. Make sure that you can see the modified reports. To do it, use the following method:

   On the **Microsoft Dynamics GP** menu, point to **Tools** > **Customize**, and then select **Report Writer**. Verify that the modified reports appear in the **Modified Reports** list.
