---
title: Proxy server causes errors with Free/Busy OOF and Mailtips
description: Provides a resolution for the errors that occur due to a wrong WinHTTP Proxy is set for Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: meshel, tasitae
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Proxy server causing issues in Outlook with Free/Busy, OOF, and Mailtips

_Original KB number:_ &nbsp; 2847833

## Symptoms

Consider the following scenario:

- You run Microsoft Outlook 2007, Microsoft 2010, or Microsoft 2013.
- When enabling your Out of Office message, you receive an error:

  > Your automatic reply settings cannot be displayed because the server is currently unavailable. Try again later.

  :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/automatic-reply-settings-error.png" alt-text="Screenshot of automatic reply settings error details." border="false":::

- You do not see MailTips, instead you receive a warning:

  > We can't show MailTips right now.

  :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/mailtips-error.png" alt-text="Screenshot of MailTips error details.":::

- Free/busy information cannot be displayed, you receive an error:

  > No information. No free/busy information could be retrieved. Your server location could not be determined. Contact your administrator.

  :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/free-busy-information-error.png" alt-text="Screenshot of Free/busy information error details.":::

## Cause

An incorrect WinHTTP Proxy is configured.

## Resolution

1. Open an elevated command prompt.

   1. Press the Start key or select the **Start** button.
   2. Type *Command Prompt*.
   3. Right-click **Command Prompt**, and then select **Run as administrator**.
   4. If you are prompted for an administrator password or for confirmation, enter the password, or select **Allow**.

2. If you are running either of the following combinations of Windows and Office:

    A 32-bit version of Office on a 32-bit version of Windows, or
    A 64-bit version of Office on a 64-bit version of Windows

    1. At the command prompt, type the following command and press ENTER:

        ```console
        netsh winhttp show proxy
        ```

        :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/command-1.png" alt-text="Screenshot of command output 1 after you type the command.":::

    2. The current WinHTTP proxy settings will be displayed.
    3. If the Proxy Servers shown are not correct, remove them using the following command:

        ```console
        netsh winhttp reset proxy
        ```

        :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/command-2.png" alt-text="Screenshot of command output 2 after you type the command.":::

3. If you are running a 32-bit version of Office on a 64-bit version of Windows:

    1. At the command prompt, change folders to the \Windows\SysWow64 folder by typing the following command containing the path to your SysWow64 folder:

        ```console
        cd C:\Windows\SysWow64
        ```

    2. Type the following command and press ENTER:

       ```console
       netsh winhttp show proxy
       ```

       :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/command-3.png" alt-text="Screenshot of command output 3 after you type the command.":::

    3. The current WinHTTP proxy settings will be displayed.
    4. If the Proxy Servers shown are not correct, remove them using the following command:

       ```console
        netsh winhttp reset proxy
       ```

        :::image type="content" source="media/proxy-server-causes-issues-with-freebusy-oof-mailtips/command-4.png" alt-text="Screenshot of command output 4 after you type the command.":::

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Instead of using the Command Line method, you can also view and remove the `WinHttpSettings` registry value.

1. Depending on your Windows and Office bitness, browse to and select the appropriate registry key:

    `HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\Connection`  `HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connection`

    > [!NOTE]
    > The Wow6432Node hive is used when a 32-bit version of Office is installed on 64-bit version of Windows.

2. Find the `WinHttpSettings` value. You can double-click the `WinHttpSettings` value to view the Value data if you choose.
3. Right-click the `WinHttpSettings` value, and then select **Delete**.
