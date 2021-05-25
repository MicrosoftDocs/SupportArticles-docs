---
title: Client does not start when click a meeting link if default browser is Chrome
description: Discusses that users who try to join Lync or Skype for Business online meetings are directed to Lync Web App, and their local client does not start. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Skype for Business Online
- Skype for Business Server 2015
- Lync Server 2013
- Microsoft Lync Online
- Lync Server 2010 Enterprise Edition
- Lync Server 2010 Standard Edition
---

# Lync or Skype for Business client does not start when you click a meeting link if the default browser is Google Chrome

## Symptoms

Consider the following scenario:

- Google Chrome is configured as your default browser.
- Your Google Chrome installation is upgraded to version 42 or a later version.
- You try to join a meeting by clicking a "Join Lync Meeting" or "Join Skype Meeting" link, and any one of the following criteria are true:
  - You click the link within any application other than Microsoft Outlook 2013.
  - The meeting organizer did not create the meeting by using the Outlook Lync or Skype for Business meeting plugin.
  - The meeting organizer is from another organization that has not configured the option to preserve the Transport Neutral Encapsulation Format (TNEF) for outgoing email messages. For more information, go to the following Outlook website:

    > [Manage TNEF Message Formatting with Remote Domains](https://help.outlook.com/140/gg263346.aspx)

In this scenario, when you click the "Join Lync Meeting" or "Join Skype Meeting" link, you expect the locally installed Lync or Skype for Business client to start. Instead, the default web browser starts and you are directed to the Lync Web App or Skype for Business Web App webpage. Then, you are prompted to install a plugin or you are joined to the meeting by using the web experience.

## Cause

This problem occurs because, by default, the updated version of Google Chrome deprecates and disables support for the Netscape Plugin API (NPAPI). NPAPI is currently used as part of the client detection process for the Lync or Skype for Business client when you join a meeting by clicking a link. When NPAPI is disabled, the webpage cannot determine whether you have the client installed.

## Resolution

[May 2015 cumulative update (5.0.8308.887)](https://support.microsoft.com/help/2809243) for Microsoft Lync Server 2013 that enables Mac users and Windows users to join a meeting by using Lync Web App in any default browser that you set. It does not require to use NPAPI to join a meeting if Chrome is the default browser. See the following article for more information:

> [Cumulative update for Lync Server 2013 that provide full Lync Web App experience](https://support.microsoft.com/help/3038437)

## Workaround

To work around this problem, use one of the following methods.

### Option 1: Change the default browser

Set the [Microsoft Edge browser](https://www.microsoft.com/edge) or another supported browser as the user's default browser.

### Option 2: Set GPO settings

Use the Chrome ADMX template to set GPO settings that apply configurations to domain-joined computers. To do this, follow these steps:

1. Download the following Google Chrome GPO policy templates:

   > [Policy_templates.zip](https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip)

2. Install the GPO policy templates by using the following directions:

   > [Scenario 2: Editing Domain-Based GPOs Using ADMX Files](/previous-versions/windows/it-pro/windows-vista/cc748955(v=ws.10))

3. Configure the "Computer Configuration\Administrative Templates\Google\Google Chrome\Content Settings\Allow plugins on these sites" setting by enabling the policy and by configuring the list of meeting join domain URLs that should be trusted.

    > [!NOTE]
    > This list should contain the following items:
    > - The meeting join URL of the user's organization.
    > - The URLs of any business partners that members of the user's organization frequently join in meetings.
    > - The default Lync and Skype for Business [online meeting URL](https://meet.lync.com).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).