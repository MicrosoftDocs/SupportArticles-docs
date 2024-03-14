---
title: Calls to UM Auto Attendant fail
description: Discusses a problem in which calls to UM Auto Attendant fail when custom greetings are used. Provides several workarounds.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: seemarah; corbinm; mshaikh
appliesto: 
  - Exchange Online
ms.date: 03/31/2022
---

# Calls to UM Auto Attendant fail when custom greetings are used

## Symptoms

When you call a Microsoft Exchange UM Online Auto Attendant, you receive the following error message:

**Sorry a System Error Has Occurred, Goodbye**

This issue can affect any customer who uses Microsoft Exchange UM Online Integrated together with an on-premises Lync (Skype for Business) server or an on-premises PBX that uses session border control (SBC).

This issue is known to occur only if you have a UM Online Auto Attendant that's configured to have custom greetings.

## Cause

This issue occurs because of a condition that corrupts the uploaded custom greetings. The UM process can't fetch the corrupted greetings. Therefore, the call fails and returns the error message that's mentioned in the "Symptoms" section.

## Workaround

To work around this issue, use the following methods in the given order.

### Method 1

1. Delete all Custom Greetings (Welcome Greetings, Menu Navigation Greetings) from the UM Online Auto Attendants.

    > [!NOTE]
    > This enables the default Auto Attendant greeting, "Welcome to the Microsoft Exchange Auto Attendant."

2. Wait for replication to finish.   
3. Test calls to the Auto Attendant when it set to the default greeting.   
4. If the calls now work successfully, upload the custom greetings back to the UM Online Auto Attendant.   
5. Wait for replication to finish.   
6. Test calls to the Auto Attendant again.   
7. If the calls fail again, go to Method 2.   

### Method 2

1. Delete the UM online Auto Attendant completely from the O365 portal.   
2. Re-create the Auto Attendant, and then upload the custom greetings.   
3. Test calls to the Auto Attendant again.   

## Status

This is a known issue that affects the O365 Exchange UM service. Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
