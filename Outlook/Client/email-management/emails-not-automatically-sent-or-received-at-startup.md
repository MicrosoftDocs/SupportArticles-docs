---
title: Emails not automatically sent or received at startup
description: Describes that Outlook 2003 and Outlook 2002 do not send and receive messages automatically at startup. The behavior occurs when there is a damaged Send/Receive group within Outlook. Requires you to create a new Send/Receive group to resolve the issue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: STEPHGIL
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# E-mail messages are not automatically sent or received at startup in Outlook

_Original KB number:_ &nbsp; 312336

## Symptoms

When you start Microsoft Outlook, Outlook does not automatically perform a send and receive operation to download messages from the server.

## Cause

This behavior can occur because of a damaged Send/Receive group within Outlook.

## Resolution for Outlook 2007 and earlier versions

To resolve this behavior, create a new Send/Receive group in Outlook:

1. On the **Tools** menu, point to **Send/Receive Settings**, and then select **Define Send/Receive Groups**.
2. Under **Group Name**, select the group, and then select **Copy**.
3. Under **Send/Receive Group Name**, type the new group name, and then select **OK**.
4. Under **Group Name**, select the old group name.
5. Under both **When Outlook is Online** and **When Outlook is Offline**, clear the check box for **Include this group in Send/Receive (F9)**.
6. Select **Close**.
7. Quit Outlook, and then restart Outlook.

## Resolution for Outlook 2010 and later versions

To resolve this behavior, create a new Send/Receive group in Outlook:

1. Select **File**, and then select **Options**.
2. Select the **Advanced** tab.
3. In the **Find Send and Receive** section, select **Send/Receive**.
4. Under **Group Name**, select the group, and then select **Copy**.
5. Under **Send/Receive Group Name**, type the new group name, and then select **OK**.
6. Under **Group Name**, select the old group name.
7. Under both **When Outlook is Online** and **When Outlook is Offline**, clear the check box for **Include this group in Send/Receive (F9)**.
8. Select **Close**.
9. Quit Outlook, and then restart Outlook.
