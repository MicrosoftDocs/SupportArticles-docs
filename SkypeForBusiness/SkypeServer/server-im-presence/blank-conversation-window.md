---
title: Lync client has a blank conversation window
description: The Lync client may not display the first set of instant messages for a conference to all the participants.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: tyryan
ms.custom: 
  - CSSTroubleshoot
appleisto: 
  - Lync 2010
  - Lync 2013
ms.date: 03/31/2022
---

# Lync client has a blank conversation window after joining an instant messaging conference

## Summary

After joining an active Lync conference the Lync conversation window does not contain any instant messages (IM).

## Cause

The design of the Lync Instant Messaging Conferencing Unit (ImMcu) limits the amount of IM information that will be submitted to the Lync conference participants. The ImMcu message history component records each IM sent by the conference participants for the first 40 seconds after the first IM is added to an IM conference. Within the beginning 40 seconds the ImMcu message history component can manage a maximum limit of 50 IM at a time in its buffer. When the limit of 50 IM is met then the first IM for the conference will be removed from the ImMcu message history component as the last IM for the conference is added to the ImMcu message history component. After the ImMcu message history component's 40-second timer expires, the ImMcu message history component will clear all IMs from its buffer. These design features of the ImMcu message history component provide conference participants with the following experiences when joining a Lync IM conference:

- Participants that join the IM conference within the first 40 seconds of the IM conference will receive all of the IM that is current with the ImMcu message history component in their Lync conversation window   
- Participants that join the IM conference after the first 40 seconds of the IM conference will not receive any IM and their Lync conversation window   

## Workaround

To optimize the number of conference participants that will be able to view a Lync IM conversation window that includes the IMs that are buffered by the ImMcu message history component within its initial 40-second interval, use the following steps to sort the Lync contacts by availability:


1. Select the Lync Display contacts by groups (Groups) feature of the Lync contact window   
2. From the View more layouts drop down list choose Sort by Availability   
3. Select the available contacts that will be conference participants from the sorted contact list. 

These steps will help ensure that the IM conference invitations will primarily be sent to conference participants that will be available to respond to the IM conference invitations. 

> [!NOTE]
> IM conference invitations that are sent to non-responsive IM conference participants will hold for 15 seconds after receiving the toast notification for the IM conference invitation then they will join the conference by default.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
