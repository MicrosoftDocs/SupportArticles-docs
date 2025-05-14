---
title: Troubleshoot Failed Unattended Runs Using Screenshots
description: Provides troubleshooting steps to identify and resolve issues causing unattended runs to fail in Microsoft Power Automate.
ms.reviewer: alarnaud
ms.date: 05/14/2025
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# Troubleshoot failed unattended runs using screenshots

This article provides guidance on troubleshooting failed unattended runs of scripts, particularly focusing on capturing screenshots to diagnose issues.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5007976  

## Symptoms

A script that runs successfully in attended mode fails to execute properly in unattended mode. It might also fail with an error message like the following:

> There was a problem running the action 'Click'. The link could not be clicked on the web page.

## Cause

Unattended run failures might occur due to the following reasons:

- The script might be thoroughly tested in attended mode before being deployed in unattended mode.
- The unattended session might use a different configuration compared to the attended session, such as a different Windows account, screen resolution, or browser settings (for example, user profile, popup blocker settings, missing extensions, or disabled extensions.)
- Screens might not completely load due to insufficient delays or timing issues in the script.
- A User Account Control (UAC) prompt might block UI automation when the session begins.

## Resolution

As there might be different causes of this issue, the following solution describes a method of adding screenshots before and after a failing action to get some visual feedback. Analyzing the screenshots taken before and after the failure in unattended mode can help identify the root cause from the issues listed previously. The solution also describes how to compare display resolution and scale settings between attended and unattended run executions.

If you add screenshots in your flow and they fail to execute, you might have a UAC dialog interfering with automation of your flow. Sign in to the machine where the issue occurs using the same Windows account configured for the unattended flow execution, and check for any blocking dialogs. If you have such dialogs, adjust your startup configuration to prevent this issue.

### Add screenshots to troubleshoot

You can capture screenshots immediately before and after a failing step in unattended mode using the [Take screenshot](/power-automate/desktop-flows/actions-reference/workstation#takescreenshotbase) action. The screenshots can provide visual feedback to help diagnose the issue. You can configure the failing step to continue after the failure by modifying its "On error" behavior, allowing a screenshot to be captured after the failure occurs. Once the issue is resolved, revert the "On error" behavior of your flow to its original setting.

1. Sign in to the computer that reproduces the problem with the account you use in your connection. Verify that no UAC prompt blocks UI automation.

1. Locate the **Take screenshot** action.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/take-screenshot-action.png" alt-text="Screenshot of the Take screenshot action under the Workstation section on the Actions page.":::

1. Drag and drop the **Take screenshot** action into the script side.

1. Set the **Save screenshot to:** field to **File** and specify a file path and name for the image, ensuring "before" is included in the file name. Select **Save**.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/screenshot-parameters-before.png" alt-text="Screenshot of specifying a file name that includes before in the name.":::

1. Add another **Take screenshot** action and specify a file path and name for the image, ensuring "after" is included in the file name. Select **Save**.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/screenshot-parameters-after.png" alt-text="Screenshot of specifying a file name that includes after in the name.":::

1. Surround the failing action with the screenshot actions.

   In this example, the **Launch new Microsoft Edge** action is the failing action and is surrounded by the screenshot actions.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/failed-action-surrounded-by-screenshot-actions.png" alt-text="Screenshot that shows an example of a failed action surrounded by the screenshot actions." lightbox="media/troubleshoot-unattended-runs-with-screenshots/failed-action-surrounded-by-screenshot-actions.png":::

1. Change the "On error" behavior of the failing action:

   1. Edit the failing action and select the **On error** button at the bottom.

      :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/on-error-button.png" alt-text="Screenshot of the On error button on the failed action.":::

   1. Set the flow run to **Continue flow run** and **Go to next action**. Select **Save**.

      :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/continue-flow-run-go-to-next-action.png" alt-text="Screenshot of the Continue flow run and Go to next action buttons.":::

1. Run the flow locally to verify that screenshots are produced.
1. Launch the unattended run.
1. Check the screenshot files generated during the unattended run for clues to help identify the root cause of the issue.

### Check screen resolution and scale differences

Many UI automation issues arise due to screen resolution differences between the machines running the attended and unattended sessions. Compare the resolution settings between attended and unattended run executions to ensure they match in both modes.  

In some cases (for example, when using a virtual machine (VM) or Hyper-V), the display resolution settings might be unavailable or grayed out. As a workaround in such situations, you can add the following actions in your script before running in both modes.

1. Copy and paste the following code snippet into the [Power Automate desktop flow designer](/power-automate/desktop-flows/flow-designer).

    ```csharp
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

   The following screenshot illustrates the steps to capture resolution settings and output them in a timestamped file.

   :::image type="content" source="media/troubleshoot-unattended-runs-with-screenshots/script-action.png" alt-text="Screenshot of the created steps.":::

1. Review the output file path from the last action, check that local execution is successful, and select **Save**.

1. Run the script in both attended and unattended modes, and then compare the resolution and scale output to ensure they match in both modes.
