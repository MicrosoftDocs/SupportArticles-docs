---
title: The value of WhenCreated is changed in Exchange Online
description: The user, mailbox, contact, or distribution group WhenCreated date is changed in Exchange Online
author: TobyTu
ms.author: namin
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- CI 111129
- CSSTroubleshoot
ms.reviewer: namin
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# The value of “WhenCreated” is changed in Exchange Online

## Symptoms

In Exchange Online, when you run the Get command to return objects such as user, mailbox, contact, or distribution group, you notice that the **WhenCreated** date is changed.

The following example returns a **WhenCreated** value about Mailbox01.

```
Get-Mailbox -Identity Mailbox01 | FL *WhenCreated

WhenCreated : 6/17/2018 5:16:56 AM
```

After you wait a while, you run this command again, and you notice that the value of WhenCreated is changed.  

```
Get-Mailbox -Identity Mailbox01 | FL *WhenCreated

WhenCreated : 10/4/2019 6:23:56 AM
```

## Cause

This behavior is by design. The **WhenCreated** date is not guaranteed to remain the same. One example of why it might change is after **Tenant Relocation** runs. This is because objects are re-created instead of moved during the process. Therefore, you should not rely on the **WhenCreated** value to do other operations that require that the value remains the same.
