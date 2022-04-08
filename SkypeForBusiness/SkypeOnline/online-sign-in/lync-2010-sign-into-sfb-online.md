---
title: Lync 2010 requires additional software to sign into Skype for Business Online
description: The Skype for Business Online sign in page prompts with the message To sign in, additional software is required. When you click Download and and install now, you are taken to www.msn.com. This occurs if you are using Skype for Business Online on an operating system that doesn't have the Microsoft Online Services Sign-In Assistant.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CI 150322
  - CSSTroubleshoot
ms.reviewer: dahans
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Lync 2010 requires additional software to sign into Skype for Business Online

## Problem

When you try to sign in to Skype for Business Online (formerly Lync Online) by using Lync 2010, you receive the following message:

> To sign in, additional software is required.

When you click **Download and install now?**, you're prompted to download and install the Microsoft Online Services Sign-In Assistant.

:::image type="content" source="./media/lync-2010-sign-into-sfb-online/additional-software-required.png" alt-text="Screenshot that shows the Lync sign in page, including error message Download and install now? link.":::

## Solution

Make sure that **Microsoft Online Services Sign-in Assistant** is running on Windows Services by following these steps:  
(These steps are for Windows 10)

1. Right-click the **Start** button and select **Run**.
2. Type `services.msc` and select **OK**.
3. In the **Services** window, check whether the **Status** of **Microsoft Online Services Sign-in Assistant** is listed as **Running**.

## More Information

This issue occurs if you try to sign in to Skype for Business Online by using Lync 2010 on an operating system that doesn't have the Microsoft Online Services Sign-In Assistant.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
