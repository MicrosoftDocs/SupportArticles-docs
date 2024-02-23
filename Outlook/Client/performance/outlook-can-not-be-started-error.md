---
title: Outlook can not be started error
description: Provides a resolution for the Microsoft Outlook can not be started error that occurs when you open Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, PhilClod
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# How to resolve the Microsoft Outlook can not be started error that occurs when opening Outlook 2010

_Original KB number:_ &nbsp; 2751236

## Symptoms

When I open Outlook 2010, why do I see error messages such as **Microsoft Outlook can not be started, cannot open the Outlook window, the set of folders cannot be opened, cannot access file, you do not have the permission required to access the file XXX** or **Cannot open your default e-mail folders. Cannot access file, you do not have the permission required to access the file XXX**? How can I resolve this problem?

:::image type="content" source="media/outlook-can-not-be-started-error/cannot-start-outlook-error.png" alt-text="Screenshot of Outlook can't start error message." border="false":::

## Resolution

1. Select **Start** > **Control Panel**.

2. Change **View By** to **Large Icon**, then select **Mail**.

   :::image type="content" source="media/outlook-can-not-be-started-error/open-mail-in-control-panel.png" alt-text="Screenshot of Control Panel window in Large icons view.":::

3. Select **Data File**.

   :::image type="content" source="media/outlook-can-not-be-started-error/open-data-file.png" alt-text="Screenshot of the Mail Setup dialog box." border="false":::

4. Select the data file you're currently using, and then select **Open file Location**.

   :::image type="content" source="media/outlook-can-not-be-started-error/open-file-location.png" alt-text="Screenshot of the Open File location option of Data Files.":::

5. Right-click on the data file, and select **Properties**.

   :::image type="content" source="media/outlook-can-not-be-started-error/properties-option.png" alt-text="Screenshot of the properties option on the right-click menu of the PST file.":::

6. Uncheck the **Read-only** box and select **OK**.

   :::image type="content" source="media/outlook-can-not-be-started-error/read-only.png" alt-text="Screenshot of the Read-only checkbox in the File Properties." border="false":::

Now you can open your Outlook 2010 without problems.

:::image type="content" source="media/outlook-can-not-be-started-error/reopen-outlook.png" alt-text="Outlook reopens correctly.":::

## Let us know

:::image type="icon" source="media/outlook-can-not-be-started-error/survey-male.png" border="false"::: Are you satisfied with our contents? Whether you think: Great! Problems solved or Problems aren't solved and I have a better idea. We would like you to provide us with your precious opinions. We welcome any encouragements you may have, and will be creating more useful technical articles for you.
