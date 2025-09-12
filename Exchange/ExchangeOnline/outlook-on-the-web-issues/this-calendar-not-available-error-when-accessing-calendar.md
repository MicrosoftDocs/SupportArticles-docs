---
title: This calendar isn't available error
description: Describes an issue in which a user receives a This calendar isn't available error when trying to access the Calendar in Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# This calendar isn't available error when a user tries to access the Calendar in Outlook on the web

_Original KB number:_ &nbsp; 3152066

## Symptoms

When a user tries to access the Calendar by using Outlook on the web (formerly known as Outlook Web App), that user receives the following error message:

> This calendar isn't available. Please try again later.

Additionally, other users in your organization may be unable to see that user's free/busy information.

## Cause

This problem can occur for one or more of the following reasons:

- Corrupted items in the user's Calendar
- Corrupted custom views
- Corrupted navigation pane settings

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> Before you perform these steps, make sure that the user has an Outlook profile set up.

1. Run the Calendar Checking Tool for Outlook (CalCheck). To do this, follow these steps:

   1. Download and install [Calendar Checking Tool for Outlook](https://www.microsoft.com/download/details.aspx?id=28786).
   2. Open a Command Prompt window, and then run the following command at the command prompt:

        ```console
        calcheck -f -r
        ```

        > [!NOTE]
        > This command creates a CalCheck folder, moves error items that it flags to the folder, generates a report, and then sends the report to the Inbox.

   3. Review the items that are flagged by CalCheck. If they are no longer necessary, remove them.

2. Exit Outlook (if it's running), and then do the following.

    > [!NOTE]
    > If you don't have access to an Outlook for Windows client, contact Microsoft 365 Support.

    1. Select **Start**, type *outlook /resetnavpane* in the search box, and then press Enter.

        > [!NOTE]
        > After you run this command, you must restore any previously shared calendars to the user's Outlook profile.

    2. Select **Start**, type *outlook /cleanviews* in the search box, and then press Enter.

3. Start Outlook on the web, and then try to access the Calendar again.

## More information

For more information about how to install and run CalCheck, see [Information about the Calendar Checking Tool for Outlook (CalCheck)](https://support.microsoft.com/help/2678030).

For more information about command-line switches for Outlook, see [Command-line switches for Outlook for Windows](https://support.microsoft.com/office/command-line-switches-for-microsoft-office-products-079164cd-4ef5-4178-b235-441737deb3a6).

If you run an F12 developer tools trace in Internet Explorer, you may see one or more of the following error messages:

- Error when users can't view free/busy information for a specific user:

  > GetCalendarFolderConfigurationAction returns a 200 with errorcode 31  
{"ErrorCode":31,"WasSuccessful":false,"CalendarFolder":null,"MasterList":null}  
ResponseCode":"ErrorNoFreeBusyAccess

- Error if the Calendar contains one or more corrupted items:

  > S:ErrInfo=Microsoft.Exchange.Services.Core.Types.CalendarExceptionInvalidPropertyValue: The property has an invalid value. --->  
Microsoft.Exchange.Data.Storage.CorruptDataException: Invalid global object ID:  
"ResponseCode":"ErrorCalendarInvalidPropertyValue"  
X-OWA-Error: Microsoft.Exchange.Services.Core.Types.CalendarExceptionInvalidPropertyValue

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
