---
title: Scheduled Tasks Not Running
description: Troubleshoot issues where a scheduled task doesn't run as expected in Task Scheduler.
ms.date: 03/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jianyingtang, warrenw, v-lianna
ms.custom: sap:System Management Components\Task Scheduler, csstroubleshoot
---
# Troubleshoot issues with scheduled tasks not running

This article helps you troubleshoot issues where a scheduled task doesn't run as expected in Task Scheduler.

When you configure and schedule a task using Task Scheduler, you might encounter one of the following issues:

- The task doesn't start at the scheduled time.
- The task status remains in **Running** indefinitely.
- The task completes, but the expected actions don't occur.
- Errors appear in the **History** tab or the **Last Run Result** column in Task Scheduler.

To troubleshoot the issue, follow these steps:

1. [Test your script before putting it into a task](#step-1-test-your-script-before-putting-it-into-a-task)
2. [Use the Status column and the History tab to check task status](#step-2-use-the-status-column-and-the-history-tab-to-check-task-status)
3. [Verify errors in the task history](#step-3-verify-errors-in-the-task-history)

## Step 1: Test your script before putting it into a task

Task Scheduler is the trigger of a task. If you use a script, a complete script is the prerequisite to configure a scheduled task. To make sure that there's no error before putting it into a task, test your script directly with tools like PowerShell and Command Prompt.

## Step 2: Use the Status column and the History tab to check task status

Check the **History** tab for specific task events. This tab allows you to determine if the task is triggered and successfully completed. For example:

:::image type="content" source="./media/troubleshoot-scheduled-tasks-not-running/task-scheduler-history-tab.png" alt-text="Screenshot that shows the History tab of Task Scheduler.":::

If the task isn't triggered, try a manual trigger. Set the trigger start time at a future time if it's a **On a schedule** trigger, and save the task again (re-register the task). If it's still not triggered, collect the task configuration by right-clicking the task and exporting it to an `.xml` file for initial checking.

If it's already triggered, use the **Status** column and the **History** tab to check for any errors during the task execution.

Normally, the task should be in **Ready** status for it to be manually or automatically triggered. If it remains in the **Running** status for a long time, check the actions in your task. For example, if the task runs a customized application or a PowerShell script, locate the process in Task Manager. Then troubleshoot why the process keeps running and doesn't exit by collecting dumps or other traces of a specific process.

## Step 3: Verify errors in the task history

If there are any errors while completing the task or if the task completes successfully but doesn't show an expected output, use the following methods to further narrow down the issue:

- Use a simplified script to determine if the issue is related with the script or the application.
- [Enable transcripts](/powershell/module/microsoft.powershell.core/about/about_group_policy_settings#turn-on-powershell-transcription) to check for errors while running the PowerShell script. For batch script or others, add more output commands to trace the failure for a specific command.
- Change the **Security options** to **Run only when user is logged on** to determine if the issue is with security context.

## Logs to be collected

If the preceding steps don't resolve the issue, and you consider reaching out to Microsoft Support for further assistance, gather the following information beforehand:

- Task configuration (the exported `.xml` file)
- Task Scheduler event log (**Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **TaskScheduler** > **Operational**)
