---
title: Resource mailbox's calendar shows the organizer's name instead of the subject
description: Describes behavior in which the resource mailbox's calendar shows the organizer's name in place of the subject in an Exchange Server environment. Provides a resolution.
author: simonxjx
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
---

# Resource mailbox's calendar shows the organizer's name instead of the subject in an Exchange Server environment

## Symptoms

Consider the following scenario:

- A Resource mailbox is configured to AutoAcceptin an Microsoft Exchange Server environment.   
- You send a meeting request to the Resource mailbox.    
- The meeting request is accepted automatically, and the meeting subject is displayed correctly in the organizer’s mailbox.   

In this scenario, when you log on to the Resource mailbox, you see that the meeting subject is replaced with the organizer’s name.

## Cause

This is default behavior. It occurs because AddOrganizerToSubjectand DeleteSubjectare set to True.

To view these value for the Resource mailbox, run the one of the following cmdlets:

- For Exchange Server 2016,Exchange Server 2013 or Exchange Server 2010

    ```powershell
    Get-CalendarProcessing -Identity <RESOURCEMAILBOX> | FL
    ```    
- For Exchange Server 2007

    ```powrshell
    Get-MailboxCalendarSettings -identity <RESOURCEMAILBOX> |FL    
    ```

## Resolution

To resolve this issue, follow these steps:

1. Open the Exchange Management Shell.   
2. Run the one of following cmdlets:
   - For Exchange Server 2016, Exchange Server 2013 or Exchange Server 2010

        ```powershell
        Set-CalendarProcessing -Identity <RESOURCEMAILBOX> -DeleteSubject $False -AddOrganizerToSubject $False
        ```
   
   - For Exchange Server 2007

        ```powershell
        Set-MailboxCalendarSettings -Identity <RESOURCEMAILBOX> -AutomateProcessing AutoAccept -AddOrganizerToSubject $False -DeleteSubject $False    
        ```