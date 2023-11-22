---
title: How to use Problem Steps Recorder
description: Describes how to use Problem Steps Recorder (PSR) to automatically capture steps in Microsoft 365.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: kerbo
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 11/21/2023
---
# How to use the Problem Steps Recorder in Microsoft 365

This article describes how to use Problem Steps Recorder (PSR) to automatically capture steps on a computer. These steps include a picture of the screen during each select and a text description of the selected areas. You can use the tool to save performed actions, such as repro steps, that can be provided to Microsoft 365 technical support to troubleshoot or diagnose an issue.

> [!IMPORTANT]
>
> - These instructions apply to Windows 7 and later versions.
> - Recorded steps don't capture anything that's typed during the recording. If customer input is important to re-create the issue, you can use the comment feature that's described later in this article to record these kinds of details.
> - Some programs may not be captured accurately or may not provide details that are useful to Microsoft Support.
> - If you use a computer that's not running Windows, provide screen shots instead.
> - The tool only collects the last 25 screen shots. If you see the following in your capture, refer to the **To adjust settings** in the section below to increase this value if you need to capture longer than 25 screen shots.  
    Step 1: <date/time> user left-click on **Text Editor (edit)** in **Untitled - Notepad**.

## To open the PSR tool 

Select **Start**, type *psr* in the **Start search** box, and then select **psr.exe** in the search results.

## To record and save steps on the computer

1. Select **Start Record**. Perform the steps on your computer to reproduce the problem. You can pause the recording at any time and resume it later.
2. Select **Stop Record**.
3. In the **Save As** dialog box, type a name for the file, and then select **Save**.

    > [!NOTE]
    > The file is saved as a compressed file that uses the .zip file name extension.

To view the recording, open the compressed file that you just saved, and then double-click the file. The file opens in your browser.

## To annotate problem steps

1. Select **Start Record**.
2. When you want to add a comment, select **Add Comment**.
3. Use your mouse to highlight the part of the screen that you want to comment about, type your text in the **Highlight Problem and Comment** box, and then select **OK**.
4. Select **Stop Record**.
5. In the **Save As** dialog box, type a name for the file, and then select **Save**.

To view the recording, open the compressed file that you just saved, and then double-click the file. The file opens in your browser.

## To adjust settings

When you adjust settings for PSR, the settings are saved for only your current session. After you close and reopen PSR, the program returns to the regular settings.

1. Select the Help down arrow or perform Alt+G, and then select **Settings**.
2. Change any of the following settings for PSR:

   - Output Location: If you don't want to be prompted to save a file after recording, select the **Browse** button to set a default output file name.
   - Enable screen capture: If you don't want to capture the screenshots together with the select information, select **No**. This may be a consideration if you take screenshots of a program that contains personal information, such as bank statements, and if you share the screenshots with someone else.
   - Number of recent screen captures to store:  The default number of saved screen captures is 25. You can increase or decrease this value. PSR records only up through the set number of screenshots. For example, if this option setting is 25 but you take 30 screenshots during a recording, the first five screenshots will be overwritten. Increase this value if you need to capture more screenshots.
