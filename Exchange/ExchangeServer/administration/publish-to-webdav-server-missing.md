---
title: Missing the Publish to WebDAV Server option
description: You cannot find the Publish to WebDAV Server option when sharing a Calendar folder in Exchange Server 2016, 2013 or 2010. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: gregmans, alinastr, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
  - Exchange Online
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# The Publish to WebDAV Server option is missing from the Calendar folder shortcut menu

_Original KB number:_ &nbsp; 3034267

## Symptoms

When you try to share a Calendar folder in an Exchange mailbox or an Exchange Online mailbox, the **Publish to WebDAV Server** option is missing.

The following screenshot shows the option that you expect to see on the menu when you right-click **Calendar** and then point to **Share**.

:::image type="content" source="media/publish-to-webdav-server-missing/publish-to-webdav-server-option.png" alt-text="Screenshot of Publish to WebDAV Server option.":::

> [!NOTE]
> This issue doesn't occur if you try to share a calendar that's not located in the mailbox. For example, if you try to share a Calendar folder from your local personal folders file (.pst), the **Publish to WebDAV Server** option is available.

## Cause

This issue occurs if both the following conditions are true:

- The sharing policy that's set for the Exchange organization or the mailbox has the Anonymous domain specified in the Domains parameter.
- You try to publish a Calendar folder in an Exchange mailbox or an Exchange Online mailbox. For example, the following Exchange PowerShell command and results shows a default sharing policy that uses this configuration.

Command:

```powershell
Get-SharingPolicy | FL domains
```

Results:

```console
Domains : {Anonymous:CalendarSharingFreeBusySimple}
```

## Resolution

In this configuration, share the Exchange calendar folder together with users in domains that are allowed by the Exchange administrator. To do this, follow these steps:

1. Right-click the Calendar folder, select **Share**, and then select **Publish This Calendar**.

    > [!NOTE]
    >
    > - If you're prompted to do this, enter your credentials.
    > - Your default browser opens, and the **Calendar Publishing - Calendar** page is displayed.
    >
    >:::image type="content" source="media/publish-to-webdav-server-missing/calendar-publishing.png" alt-text="Screenshot of the Calendar Publishing - Calendar page.":::

2. Set the publishing options for your calendar, and then select **Start publishing**.

3. Note the URLs that are provided in the link for subscribing to this calendar and for viewing the calendar in a web browser.

    :::image type="content" source="media/publish-to-webdav-server-missing/screenshot-of-step-3.png" alt-text="Screenshot for links of subscribing to this calendar and for viewing the calendar in a web browser.":::

    These are the links that you share together with other users who view your calendar.

4. To stop publishing your calendar, select **stop publishing**.

## More information

For more information about the Internet calendar publishing feature in Exchange, see these topics:

- [Enable Internet calendar publishing for Exchange 2013](/exchange/enable-internet-calendar-publishing-exchange-2013-help)
- [Enable Internet calendar publishing for Exchange 2010](/previous-versions/office/exchange-server-2010/ff607475(v=exchg.141))
