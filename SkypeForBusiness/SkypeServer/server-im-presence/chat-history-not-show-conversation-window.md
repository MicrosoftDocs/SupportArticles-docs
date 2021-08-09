---
title: Conversation history doesn't show in conversation window
description: Describes an issue in which you can't see the chat history in Skype for Business. Provide a workaround.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
ms.prod: skype-for-business-itpro
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro 
ms.topic: troubleshooting
ms.reviewer: meerak, randyto, scapero
ms.custom: 
- CI 153765
- CSSTroubleshoot
appliesto:
- Skype for Business 2019
- Skype for Business 2016
- Skype for Business 2015
---

# Chat history doesn't show in conversation window in Skype for Business 

## Symptoms

Consider the following scenario:

- You receive a toast notification of an instant message (IM) from a user in Microsoft Skype for Business.
- You respond to the IM, and then immediately close the conversation window.
- The user sends another IM, and you open the IM from the toast notification.

In this scenario, you see only the current IM. Any previous chat sessions with that user aren't displayed in the conversation window.

## Cause

Chat history is created by the **Conversation History** folder in Microsoft Outlook. If the **Conversation History** folder isn't synchronized with the history, the Skype for Business client can't show the chat history.

## Workaround

Don't close the conversation window immediately after you end a conversation. Leave the window open for a short while in case you receive a new IM.
