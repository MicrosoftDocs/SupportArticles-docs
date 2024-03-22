---
title: No mouse cursor during an OSD task sequence
description: Fixes an issue in which no mouse cursor appears during a Configuration Manager OSD task sequence. This issue is caused by a design change in Windows 10 in which the mouse cursor is suppressed during Windows Setup.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Operating Systems Deployment (OSD)\Driver Management and Installation
---
# No mouse cursor appears during a Configuration Manager OSD task sequence

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4494800

This article fixes an issue in which no mouse cursor appears during a Configuration Manager OS deployment (OSD) task sequence.

## Symptoms

You're running a Configuration Manager OSD task sequence that deploys Windows 10. During the **Setup Windows and ConfigMgr** task, the device restarts out of Windows PE and into the newly installed Windows system. If you then open a Command Prompt window by pressing F8, no mouse cursor appears. This issue continues to occur for the rest of the task sequence. After the task sequence finishes, the mouse cursor appears.

## Cause

This issue is caused by a design change in Windows 10 in which the mouse cursor is suppressed during Windows Setup. Because Configuration Manager OSD task sequences run entirely within Windows Setup in the newly installed Windows system, the mouse cursor is suppressed during this phase of the task sequence.

## Resolution

To resolve this issue, change the policy that suppresses the mouse cursor during Windows Setup by default. This is easily accomplished by changing the registry key value that's associated with the policy. The registry key value is located in the following subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`

|Value name|Value type|Values|
|---|---|---|
|`EnableCursorSuppression`|REG_DWORD| **1** = Enabled: Mouse cursor is suppressed (default)<br/><br/> **0** = Disabled: Mouse cursor is not suppressed|
  
To make sure that the mouse cursor is available throughout the task sequence, set this registry key during the Windows PE portion of the task sequence to the offline Windows system. This can be done at any point between the **Apply Operating System** and **Setup Windows and ConfigMgr** tasks.

To make this change, use the following method to manually set the task sequence:

1. In the Configuration Manager console under **Software Library** > **Operating Systems** > **Task Sequences**, navigate to the affected task sequence.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/affected-task-sequence.png" alt-text="Screenshot shows the steps to locate the affected task sequence.":::

2. Right-click the affected task sequence, and select **Edit**.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/edit.png" alt-text="Screenshot shows the right-click menu to edit the task sequence.":::
3. In the affected task sequence, select the **Apply Operating System** task.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/apply-operating-system-task.png" alt-text="Screenshot shows the Apply Operating System task properties.":::

4. Add a new group immediately after the **Apply Operating System** task. To do this, open the **Add** menu, and select **New Group**.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/new-group.png" alt-text="Screenshot shows the right-click menu to add a new group for Apply Operating System task.":::

5. Select the newly created group, and rename it to **Correct Missing Mouse Cursor**.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/rename.png" alt-text="Screenshot shows the Correct Missing Mouse Cursor group properties where you can rename it.":::

6. Under the **Correct Missing Mouse Cursor** group, add a **Run Command Line** task. To do this, open the **Add** menu, and then select **General** > **Run Command Line**.

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/add-task.png" alt-text="Screenshot shows the right-click menu to add a Run Command Line task for Correct Missing Mouse Cursor group.":::

7. Select the newly created **Run Command Line** task, and specify the following values:

   - Name: **Load Registry SOFTWARE Hive**
   - Command line command:

     `reg.exe load HKLM\Temp %OSDTargetSystemDrive%\Windows\system32\config\software`

   :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/specify-values.png" alt-text="Screenshot shows the Load Registry SOFTWARE Hive task properties where you can specify the name and Command line.":::

8. Immediately after the **Load Registry SOFTWARE Hive** task, add another **Run Command Line** task. To do this, open the **Add** menu, and select **General** > **Run Command Line**.

     :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/add-another-task.png" alt-text="Screenshot shows the right-click menu to add Run Command Line task for Load Registry SOFTWARE Hive.":::

9. Select the newly created **Run Command Line** task, and specify the following values:

   - Name: **Disable Suppressed Mouse Cursor**
   - Command line command:

     `reg.exe add "HKLM\Temp\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableCursorSuppression /t REG_DWORD /d 0 /f`

     :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/name-and-command-line.png" alt-text="Screenshot shows the Disable Suppressed Mouse Cursor task properties where you can specify the name and command line for it.":::

10. Immediately after the **Disable Suppressed Mouse Cursor** task, add another **Run Command Line** task. To do this, open the **Add** menu, and select **General** > **Run Command Line**.

     :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/another-run-command-line-task.png" alt-text="Screenshot shows the right-click menu to add Run Command Line task for Disable Suppressed Mouse Cursor.":::

11. Select the newly created **Run Command Line** task, and specify the following values:

    - Name: **Unmount Registry SOFTWARE Hive**
    - Command line command:

      `reg.exe unload HKLM\Temp`
  
    :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/unmount-registry-software-hive.png" alt-text="Screenshot shows the Unmount Registry SOFTWARE Hive properties where you can specify the name and command line for it.":::

12. Select the last task in the task sequence.

    The last task in the task sequence may differ from the one that's shown in the screenshot.

    :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/last-task.png" alt-text="Screenshot shows the Setup Windows and Configuration Manager task.":::

13. Add a **Run Command Line** task. To do this, open the **Add** menu, and then select **General** > **Run Command Line**. This should add the **Run Command Line** task as the last task in the task sequence.

    :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/add-last-task.png" alt-text="Screenshot shows the right-click menu to add a Run Command Line task for Setup Windows and Configuration Manager.":::

14. Select the newly created **Run Command Line** task and specify the following values:

    - Name: **Reset Mouse Suppression to Default**
    - Command Line:

      `reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableCursorSuppression /t REG_DWORD /d 1 /f`

    :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/reset-mouse-suppression-to-default.png" alt-text="Screenshot shows the Reset Mouse Suppression to Default properties where you can specify the name and Command line for it.":::

15. Select the **OK** or **Apply** button to save the task sequence.

    :::image type="content" source="media/no-mouse-cursor-during-osd-task-sequence/apply-to-save.png" alt-text="Screenshot shows the OK and Apply button to save the task sequence.":::

> [!NOTE]
>
> - For step 13, the last task that's selected does not necessarily have to be the absolute last task in the task sequence. However, it should be located toward the end of the task sequence.
> - For MDT task sequences, steps 13-15 should be performed two times: One time at the end of the **State Restore** group, and again at the end of the **Gather Logs and StateStore on Failure** group. Additionally, on the **Options** tab of the the **Reset Mouse Suppression to Default** task that's added to the end of the **Gather Logs and StateStore on Failure** group, the **Continue on error** option should be selected.
> - Steps 12-14 restore the `EnableCursorSuppression` policy to its default value in Windows. Although it's not required for the solution to work, we recommend that you reset the `EnableCursorSuppression` policy to its default value. This will make sure that there are no unusual consequences in Windows after the task sequence finishes changing the policy from its default value.
