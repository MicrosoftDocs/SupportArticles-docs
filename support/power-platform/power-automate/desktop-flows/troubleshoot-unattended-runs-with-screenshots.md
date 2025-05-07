---
title: Troubleshoot failed unattended runs using screenshots
description: Troubleshoot failed unattended runs using screenshots
ms.reviewer: alarnaud
ms.date: 05/07/2025
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# Troubleshoot failed unattended runs using screenshots

This article helps troubleshoot failed unattended runs using screenshots.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5007976  

## Symptoms

A script that runs successfully in attended mode fails to execute properly in unattended mode. It may also fail with a message such as:

> There was a problem running the action 'Click'. The link could not be clicked on the web page.

## Cause

Failures in unattended runs are typically caused due to the following reasons:

- The script may not have been thoroughly tested in attended mode before being deployed in unattended mode.
- The unattended session may use a different configuration compared to the attended session, such as a different Windows account, screen resolution, or browser settings (e.g., user profile, popup blocker settings, or missing/disabled extensions).
- Screens may not load completely due to insufficient delays or timing issues in the script.
- A UAC prompt may block UI automation when the session begins.

## Resolution

As there could be different causes for this issue, the solution below describes a method of adding screenshots before and after a failing action to get some visual feedback. Analyzing the screenshots taken before and after the failure in unattended mode can help identify the root cause from the issues listed above. The solution also describes how to compare display resolution and scale settings between attended and unattended run executions.

If you've added screenshots in your flow and they fail to execute, you may have a User Account Control (UAC) dialog interfering with automation of your flow. Log in to the machine where the issue occurs using the same Windows account configured for the unattended flow execution, and check for any blocking dialogs. If you have such dialogs, adjust your startup configuration to prevent this issue.

### Add screenshots to troubleshoot

To troubleshoot the issue, you can capture screenshots immediately before and after a failing step in unattended mode using the [Take screenshot](https://learn.microsoft.com/en-us/power-automate/desktop-flows/actions-reference/workstation#takescreenshotbase) action.  The screenshots can provide visual feedback to help diagnose the issue. You can configure the failing step to continue on after the failure by modifying its 'On Error' behavior, allowing a screenshot to be captured after the failure occurs. After you identify and resolve the issue, revert the 'On Error' behavior of your flow to its original setting.

1. Log into the computer that reproduces the problem with the account you are using in your connection. Verify that there is no UAC prompt that may be blocking UI automation.

1. Find the "Take screenshot" action.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/take-screnshot-action.png" alt-text="Screenshot of the Take screenshot action under the Workstation section on the Actions page.":::

1. Drag and drop the "Take screenshot" action to the script side.
1. Edit the action to **Save screenshot to:** File and specify a file name for the image with "before" in the file name. Select Save.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/screenshot-parameters-before.png" alt-text="Screenshot of the Take screenshot action settings.":::

1. Add another "Take screenshot" action and specify a file name for the image (with "after" in the file name).   Select Save.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/screenshot-parameters-after.png" alt-text="Screenshot of the Take screenshot action settings.":::

1. Surround the failing action with the screenshot actions.

   In this example the “Launch new Microsoft Edge” action is the failing action and is surrounded with the screenshot actions.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/failed-action-surronded-by-screenshot-actions.png" alt-text="An example of a failed action surrounded by the screenshot actions.":::

1. Change the **onError** behavior of the failing action.

   1. Edit the failing action and click on **onError** at the bottom

      :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/on-error-button.png" alt-text="Screenshot of the On error button on the failed action.":::

   1. Set the flow run to **Continue flow run** and **Go to next action**. Select **Save**.

      :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/continue-flow-run-go-to-next-action.png" alt-text="Screenshot of the Continue flow run and Go to next action buttons.":::

1. Run the flow locally to verify that screenshots are produced.
1. Launch the unattended run.
1. Check screenshot files from the unattended run for clues to help identify the root cause of the issue.

### Check screen resolution and scale differences

Many UI automation issues are due to screen resolution differences between the machines running the attended and unattended sessions. Compare the resolution settings between attended and unattended run executions to ensure they match in both modes.  

In some instances (such as when using virtual machine (VM), hyper-V, etc.) the display resolution settings may not be visible or grayed out. As a workaround in such situations, you can add the following actions in your script before running in both modes.

1. Copy/Paste the following code snippet into the Power Automate for desktop designer.

    ```c#
    DateTime.GetCurrentDateTime.Local DateTimeFormat: DateTime.DateTimeFormat.DateAndTime CurrentDateTime=> CurrentDateTime
    Text.ConvertDateTimeToText.FromCustomDateTime DateTime: CurrentDateTime CustomFormat: $'''yyyy_MM_dd_hh_mm_ss''' Result=> FormattedDateTime
    Workstation.GetScreenResolution MonitorNumber: 1 MonitorWidth=> MonitorWidth MonitorHeight=> MonitorHeight MonitorBitCount=> MonitorBitCount MonitorFrequency=> MonitorFrequency
    @@copilotGeneratedAction: 'False'
    Scripting.RunPowershellScript.RunPowershellScript Script: $'''Add-Type @\'
    using System; 
    using System.Runtime.InteropServices;
    using System.Drawing;
    public class DPI {  
      [DllImport(\"gdi32.dll\")]
      static extern int GetDeviceCaps(IntPtr hdc, int nIndex);
      public enum DeviceCap {
      VERTRES = 10,
      DESKTOPVERTRES = 117
      }
      public static float scaling() {
      Graphics g = Graphics.FromHwnd(IntPtr.Zero);
      IntPtr desktop = g.GetHdc();
      int LogicalScreenHeight = GetDeviceCaps(desktop, (int)DeviceCap.VERTRES);
      int PhysicalScreenHeight = GetDeviceCaps(desktop, (int)DeviceCap.DESKTOPVERTRES);
      return (float)PhysicalScreenHeight / (float)LogicalScreenHeight;
      }
    }
    \'@ -ReferencedAssemblies \'System.Drawing.dll\' -ErrorAction Stop
    Return [DPI]::scaling() * 100''' ScriptOutput=> MonitorScaleOutput
    File.WriteText File: $'''c:\\test\\resolution_%FormattedDateTime%.txt''' TextToWrite: $'''height: %MonitorHeight% width: %MonitorWidth% frequency: %MonitorFrequency% bitCount: %MonitorBitCount% scale: %MonitorScaleOutput%''' AppendNewLine: True IfFileExists: File.IfFileExists.Overwrite Encoding: File.FileEncoding.Unicode
    ```

    This will create the following steps which will capture the resolution settings and output them in a timestamped file.

    :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/script-action.png" alt-text="Screenshot of the created steps.":::

1. Review the output file path from the last action, check that local execution is successful, and Save.

1. Run the script in both attended and unattended modes, then compare the resolution and scale output to ensure they match in both modes.
