---
title: Collect log files from Skype for Business Client
description: Describes how to collect log files from Microsoft Office Communicator, Lync, and Skype for Business Client.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-gregl, v-jastho
appliesto: 
  - Microsoft Office Communicator 2007 R2
  - Lync 2010
search.appverid: MET150
ms.date: 03/31/2022
---
# Collect log files from Office Communicator, Lync, and Skype for Business Client

_Original KB number:_ &nbsp; 2604292

This article describes how to collect log files from Microsoft Office Communicator, Lync, and Skype for Business Client.

## Collect log files

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To create and collect log files from Office Communicator, Lync 2010, Lync 2013 (Skype for Business), or Skype for Business 2016, follow these steps:

1. Make sure that logging is enabled. To do this, use one of the following methods, as appropriate for your situation:
   - In Communicator 2007 R2, click **Tools**, click **Options**, click **General**, and then select the **Turn on logging in Communicator** check box.
   - In Lync 2010, click **Tools**, click **Options**, click **General**, and then select the **Turn on logging in Lync** check box.
   - In Lync 2013 (Skype for Business), click **Tools**, click **Options**, click **General**, and then select **Full** in the **Logging in Lync** drop-down list.
   - In Skype for Business 2016, click **Tools**, click **Options** (or click the **Options** icon), click **General**, and then select **Full** in the **Logging in** Skype for Business drop-down list.

2. Exit the Office Communicator, Lync, or Skype for Business Client.
3. Start Windows Task Manager, and then make sure that the Communicator.exe process is no longer running.
4. Do one of the following:

   - For Office Communicator or Lync 2010, navigate to the following location:  
       `%userprofile%\tracing`

   - For Lync 2013 (Skype for Business), navigate to the following location:  
        `%userprofile%\AppData\Local\Microsoft\Office\15.0\Lync\Tracing`

   - For Skype for Business 2016, navigate to the following location:  
       `%userprofile%\AppData\Local\Microsoft\Office\16.0\Lync\Tracing`

    > [!NOTE]
    > %userprofile% is a windows wildcard string that you can enter from any Windows Explorer window or from the **Run** line on the **Start** menu.

5. Delete or move any file that begins with **Communicator** or **Lync**.
6. Restart the Office Communicator, Lync, or Skype for Business Client.
7. Reproduce the issue.
8. Exit the Office Communicator, Lync, or Skype for Business Client.
9. Start Windows Task Manager, and then make sure that the client is no longer running.
10. Copy the newly created log files that begin with **Communicator** or **Lync** to another folder.
11. Compress the log files into a single file. Use the following format to name the file:

    *mmddyy*_<*user_name*>.zip

    For example, you can name the file *071413*_*John*.zip.

## Enable logging using registry settings

If the **Turn on logging in Communicator** or **Turn on Windows Event Logging** option is unavailable, obtain a dump file of the following registry settings:

- For Office Communicator and Lync 2010, pull content from the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Communicator`

- For Lync 2013, pull content from the following registry subkey:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync`

- For Skype for Business 2016, pull content from the following registry subkey:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Lync`

Make sure that the `EnableLogCollecting` and `EnableTracing` registry key values are set to **1**.

Lync 2010 has only the `EnableLogCollecting` DWORD value. In Lync 2013 (Skype for Business) or Skype for Business 2016, there is a `Reg_SZ` value that's named `TracingLevel`. This `TracingLevel` value must be set to **FULL**.
