---
title: How to run the Fiddler Trace after installing SaRA
description: Describes how to install Microsoft Support and Recovery Assistant (SaRA) and run the Fiddler Trace.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 109036
  - CSSTroubleshoot
  - SaRA-Assisted
ms.reviewer: akit
appliesto: 
  - Microsoft 365
search.appverid: 
  - MET150
ms.date: 03/31/2022
---

# How to run (SaRA) Fiddler Trace

## Summary

Fiddler is a third-party (non-Microsoft) web debugging proxy that logs all HTTP(S) traffic between a user's computer and the Internet. It includes a powerful, event-based scripting subsystem (Fiddler Tracer) and can be extended by using any Microsoft .NET language.

## More information

> [!NOTE]
> The Fiddler Trace scenario in SaRA can only be run with the assistance of [Microsoft Support](https://support.microsoft.com/contactus).

To install and run the Fiddler Trace scenario in Microsoft Support and Recovery Assistant (SaRA), follow these steps:

1. Go to the [SaRA Assisted Setup](https://aka.ms/SaRA-Assisted).
2. When prompted by your browser, select **Run**.
3. In the "Do you want to install this application?" window, select **Install**.

   :::image type="content" source="media/run-fiddler-trace/install-sara.png" alt-text="Select to install Microsoft Support and Recovery Assistant.":::

4. Wait for the download to finish.

   :::image type="content" source="media/run-fiddler-trace/install-process-of-sara.png" alt-text="Microsoft Support and Recovery Assistant installation status.":::

5. Read the **Microsoft Services Agreement**, then at the bottom of the window, select **I agree**.

   :::image type="content" source="media/run-fiddler-trace/microsoft-services-agreement.png" alt-text="Select to agree with Microsoft Services Agreement.":::

6. Enter the passcode provided by Microsoft Support in the box, and then select **Next**.

   :::image type="content" source="media/run-fiddler-trace/input-passcode.png" alt-text="Enter the passcode in Microsoft Support and Recovery Assistant for Microsoft 365 page." border="false":::

7. In the **Security Warning** window, select **Yes** and then select **Next**.

   :::image type="content" source="media/run-fiddler-trace/security-warning.png" alt-text="The Security warning window that occurs when ensuring system requirements are met." border="false":::

8. Select **Start** to capture the log.

   > [!NOTE]
   > The log may contain personal information. Review the logs before you send them to Microsoft. You can decide whether or not to send the logs.

   :::image type="content" source="media/run-fiddler-trace/record-log.png" alt-text="Select Start to capture a diagnostic log of your problem." border="false":::

9. Reproduce the issue that you are having, and then return to the Recovery Assistant and select **Stop**. The Recover Assistant stops recording, creates the log files, and then restarts your applications.

   :::image type="content" source="media/run-fiddler-trace/record-step.png" alt-text="Reproduce the issue and create log files." border="false":::

10. To help secure the network capture, enter a password. Note the password so that you can provide it to support technicians if they request it. When finished, select **Next**.

    :::image type="content" source="media/run-fiddler-trace/secure-network.png" alt-text="Enter a password to secure the network capture." border="false":::

11. If you're satisfied with the information that the Recovery Assistant has collected, select **Next**. If you want to discard the information and repeat this procedure to collect new information, select **Start over**.

    :::image type="content" source="media/run-fiddler-trace/diagnostic-logs-collection-complete.png" alt-text="Logging collection by the Recovery Assistant is complete." border="false":::

12. On the **Thanks for collecting diagnostic logs** page, follow the instructions to upload the log files and then select **Next**.

    :::image type="content" source="media/run-fiddler-trace/upload-log-files-instructions.png" alt-text="Steps to upload log files." border="false":::

    > [!NOTE]
    >
    > - Selecting the "Microsoft Support Site" link opens the file transfer workspace.
    > - Selecting the "here" link opens the folder that holds the recorded log files.
    > - The log files in Windows are available as %localappdata%\Temp\\<random characters\>\Fiddler_*.saz.  
    > - If the user account that ran the scenario is different from the user account that's logged into Windows, you may receive an error when you select the "here" link. This error indicates that the folder isn't available, because %localappdata% is different in the two accounts. If you receive an error, look in the %localappdata%\Temp\\<random characters\>\ folder for the user account that ran the scenario.

13. On the Microsoft Support Secure File Exchange website, select **Add files** to upload the log files.

    :::image type="content" source="media/run-fiddler-trace/add-file.png" alt-text="Add the log files in the file transfer page." border="false":::
