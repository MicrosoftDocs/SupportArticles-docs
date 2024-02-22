---
title: Outlook not responding when connecting to Online mailbox
description: Describes a problem that causes Outlook to hang immediately after startup, and a Not Responding message is displayed on the title bar. Occurs only in mailboxes that were migrated from the on-premises environment to Exchange Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: gregmans, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook not responding  when it connects to an Exchange Online mailbox that was migrated from on-premises Exchange Server

_Original KB number:_ &nbsp; 3012603

## Symptoms

Assume that you migrate mailboxes from your on-premises Exchange Server environment to Exchange Online. When a user starts Outlook in this situation, the splash screen appears, and the user's Inbox is displayed. However, if the user takes any other action in the Outlook window, the title bar changes to **Not Responding** and remains like this for several minutes.

## Cause

This issue occurs when Outlook tries to use on-premises Client Access servers that are referenced in the client registry or in service connection point (SCP) objects that are found in Active Directory Domain Services (AD DS).

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, set the value of the `ExcludeSCPLookup` DWORD value in the `HKEY_CURRENT_USER\Software\Microsoft\Office\<x>\Outlook\Autodiscover` registry key to **1**. To do this, follow these steps:

1. Exit Outlook.
2. Select **Start**, type *regedit* in the search box, and then press Enter to open Registry Editor.
3. Locate and then select the following registry key:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\<x>\Outlook\AutoDiscover`

    > [!NOTE]
    > In the registry key path, \<x> corresponds to the version of Outlook that's installed:
       - For Outlook 2013, \<x> is 15.0
       - For Outlook 2010, \<x> is 14.0
       - For Outlook 2007, \<x> is 12.0
4. Do one of the following:
   - If the `ExcludeSCPLookup` DWORD value already exists, go to step 5.
   - If the `ExcludeSCPLookup` DWORD value doesn't exist, create it. To do this, follow these steps:
     1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
     2. Type *ExcludeSCPLookup*, and then press Enter.
5. Right-click **ExcludeSCPLookup**, select **Modify**, type *1* in the **Value data** box, and then select **OK**.
6. Exit Registry Editor, and then restart Outlook.

## More information

For more information about Outlook Autodiscover registry values and how Outlook searches for Autodiscover settings, see [Unexpected Autodiscover behavior when you have registry settings under the \Autodiscover key](/outlook/troubleshoot/profiles-and-accounts/unexpected-autodiscover-behavior).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
