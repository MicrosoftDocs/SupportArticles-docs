---
title: Teams meeting organizer can't start meeting
description: Explains why a meeting organizer might not be able to start the meeting or be stuck in the virtual lobby.
ms.author: meerak
author: Cloud-Writer
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Meetings\Meeting Join
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: djball
ai-usage: ai-assisted
ms.date: 07/16/2026
---

# Organizer can't start Outlook meeting and is stuck in virtual lobby

## Summary

This article describes an issue in which a Microsoft Teams meeting organizer can join a meeting but can't start it or access organizer controls. The issue typically occurs when you use different accounts with Teams and Microsoft Outlook. To resolve the issue, verify the organizer account, align sign-in identities, and rejoin the meeting.

## Symptoms

A meeting organizer can join their Teams meeting but can't start it.

Typical signs include:

- The organizer is stuck in the lobby or virtual lobby and can't admit attendees.
- Teams doesn't show organizer controls, such as **Start meeting**, **Admit**, or meeting management options.
- Attendees wait while the organizer appears as a regular participant.

## Cause

This problem usually occurs when the identity that Teams uses doesn't match the identity that scheduled the meeting in Outlook.

Common scenarios include:

- Outlook is signed in with one account, but Teams is signed in with another.
- The meeting was created from a shared mailbox or delegated mailbox, but Teams is running under the user's primary account.
- Cached credentials or stale sign-in tokens cause Teams and Outlook to use different identities.

## Resolution

Complete the following steps:

 1. Confirm the meeting organizer account.

    a. Open the meeting in Outlook and identify which account and calendar created the meeting.

 1. Match account identity in both apps.

    a. In Outlook, confirm the signed-in account used to create the meeting.<br/>
    b. In Teams, select your profile picture and confirm your account and tenant.<br/>
    c. Ensure both apps are signed in with the same account and tenant.

 1. Sign out and sign back in.

    a. Sign out of both Teams and Outlook.<br/>
    b. Close both apps completely.<br/>
    c. Reopen Outlook first, then Teams, and sign in by using the organizer's account.

 1. Rejoin the meeting.

    a. Rejoin from the Teams calendar or the Teams join link after sign-in is aligned.<br/>
    b. Verify organizer controls are now available.

If the meeting was created with a delegate or shared mailbox context, use the following steps:

1. Start the meeting by using the same organizer and delegate identity that scheduled it.
1. If needed, recreate the meeting from the intended organizer account and resend invites.

If the issue continues, use the following steps:

1. Test by joining from Teams on the web (InPrivate/Incognito modes) by using the organizer account.
1. If the web experience works but desktop doesn't, clear the desktop sign-in and the cache, and then retry.
