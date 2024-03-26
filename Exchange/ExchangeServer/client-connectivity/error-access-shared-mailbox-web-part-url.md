---
title: Error when you access a shared mailbox folder by using an OWA web part URL
description: Discusses an issue that you receive an error when you try to access a shared mailbox folder by using a specially crafted web part URL for OWA.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 162524
appliesto: 
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.reviewer: djball, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# "Custom error module does not recognize this error" error when you use an OWA web part URL

## Symptoms

When you try to access a shared mailbox folder by using a specially crafted web part URL for Microsoft Outlook Web App (OWA), you receive the following error message:

> The Custom error module does not recognize this error

Consider the following example scenario:

- The OWA URL points to Microsoft Exchange 2013 front-end servers.
- UserA and UserB mailboxes are located on Exchange 2010 mailbox servers.
- UserB is granted delegate access to UserA's calendar folder.
- UserB generates an explicit OWA logon address that is combined with the Uniform Resource Identifier (URI) for the calendar web part of UserA's mailbox. This address resembles the following:

    `https://exchange2013.fabrikam.com/owa/userA@fabrikam.com/?cmd=contents&module=calendar`

- On the logon screen, UserB enters credentials.

In this scenario, UserB receives the error message that is mentioned in this section.

## Cause

This problem occurs because the Exchange 2013 server tries to proxy the request to the Exchange 2010 server that has the Client Access server (CAS) role. During the proxy request, the "?cmd=contents&module=calendar" line in the URI is not preserved. Therefore, the proxy request is directed to the inbox of the shared mailbox instead of to the specific shared folder, as expected.

## Workaround

To work around this problem, have users log on to their own mailbox in OWA, and then add the shared calendar as a secondary calendar to their own calendar view.

To do this, have UserA grant delegate access to their calendar for UserB. Then, have UserB follow these steps:

1. Log on to OWA as usual.
2. In the upper-left corner, select the **My apps** button to open the calendar.
3. Right-click **My Calendar**, and then select **Open Calendar**.
4. In the dialog box, specify UserA by entering either the appropriate list alias or Internet address, and then select **OK**.

OWA now displays UserA's calendar as a secondary calendar. UserB can enable and disable the secondary calendar display by clearing the check box for UserA.
