---
title: How to run the Fiddler Trace after installing SaRA
description: Describes how to install Microsoft Support and Recovery Assistant (SaRA) and run the Fiddler Trace.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CI 109036
- CSSTroubleshoot
- SaRA-Assisted
ms.reviewer: akit
appliesto:
- Office 365
search.appverid: 
- MET150
---

# How to run (SaRA) Fiddler Trace

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

Fiddler is a third-party (non-Microsoft) web debugging proxy that logs all HTTP(S) traffic between a user's computer and the Internet. It includes a powerful, event-based scripting subsystem (Fiddler Tracer) and can be extended by using any Microsoft .NET language.

## More Information

> [!NOTE]
> The Fiddler Trace scenario in SaRA can only be run with the assistance of [Microsoft Support](https://support.microsoft.com/contactus).

To install and run the Fiddler Trace scenario in the Microsoft Support and Recovery Assistant (SaRA), follow these steps:

1. Go to the [SaRA Assisted Setup](https://aka.ms/SaRA-Assisted).
2. When prompted by your browser, select **Run**.
3. In the "Do you want to install this application?" window, select **Install**.

   ![Run SaRA to install file](./media/run-fiddler-trace/install.png)

4. Wait for the download to finish.

   ![Installation progress bar](./media/run-fiddler-trace/install-process.png)

5. Read the **Microsoft Services Agreement**, then at the bottom of the window, select **I agree**.

   ![Microsoft Services Agreement](./media/run-fiddler-trace/agreement.png)

6. Enter the passcode provided by Microsoft Support in the box, and then select **Next**.

   ![Enter the passcode](./media/run-fiddler-trace/passcode.png)

7. In the **Security Warning** window, select **Yes** and then select **Next**.

   ![Security warning window](./media/run-fiddler-trace/security-warning.png)

8. Select **Start** to capture the log.
   Note: The log may contain personal information. You can review the log before you send them to us. You decide whether or not to send us the logs.

   ![Select Start to capture log](./media/run-fiddler-trace/record-log.png)

9. Reproduce the issue that you are having, and then return to the Recovery Assistant and select **Stop**. The Recover Assistant stops recording, creates the log files, and then restarts your applications.

   ![Reproduce the issue and create log files](./media/run-fiddler-trace/record-step.png)

10. To help secure the network capture, enter a password. Note the password so that you can provide it to support technicians if they request it. When finished, select **Next**.<br/>
   ![Enter a password to secure the network capture](./media/run-fiddler-trace/secure-network.png)

11. If you are satisfied with the information that the Recovery Assistant has collected, select **Next**. If you want to discard the information and repeat this procedure to collect new information, select **Start over**.
   ![Logging is complete](./media/run-fiddler-trace/complete.png)

12. On the **Thanks for collecting diagnostic logs** page, follow the instructions to upload the log files and then select **Next**.
   ![Upload files following steps](./media/run-fiddler-trace/upload.png)

      > [!NOTE]
      > - Selecting the "Microsoft Support Site" link opens the file transfer workspace.
      > - Selecting the "here" link opens the folder that holds the recorded log files.

13. On the Microsoft Support Secure File Exchange website, select **Add files** to upload the log files.
   ![Add files in the file transfer page](./media/run-fiddler-trace/add-file.png)
