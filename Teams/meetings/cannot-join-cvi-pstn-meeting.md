---
title: Can't join a Teams meeting through PSTN dial-in or CVI-enabled devices
description: Resolves an issue in which you can't join a Teams meeting by using a Public Switched Telephone Network (PSTN) dial-in number or Cloud Video Interop (CVI) coordinates.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meeting Join
  - CI 838
  - CSSTroubleshoot
ms.reviewer: revaldiv, mibi
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/23/2024
---
# Can't join a Teams meeting through PSTN dial-in or CVI-enabled devices

## Symptoms

You try to join a Teams meeting by using a Public Switched Telephone Network (PSTN) dial-in number or Cloud Video Interop (CVI) coordinates. However, you receive an error message which conveys that the meeting can't be found, is invalid, or has expired. The exact text of the error message varies depending on the CVI-enabled device being used.

## Cause

This issue occurs if the meeting organizer's Teams account is deprovisioned. As a result, the specific Teams license which is required to schedule meetings with PSTN dial-in and CVI capabilities is no longer available. For such meetings, Teams treats the affected dial-in numbers and CVI coordinates as invalid or expired.

## Resolution

To resolve the issue, an active user in the organization who has the required license needs to reschedule the meeting.
