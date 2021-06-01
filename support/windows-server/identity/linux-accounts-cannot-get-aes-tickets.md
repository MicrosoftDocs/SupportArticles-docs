---
title: Linux accounts cannot get AES tickets
description: Works around an issue that Linux integrated accounts can't get AES encrypted tickets in AD DS, but get RC4 tickets instead.
ms.date: 06/01/2021
author: v-lianna
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User, computer, group, and object management
ms.technology: windows-server-active-directory
---
# Linux accounts can't get AES encrypted tickets in AD DS

_Applies to:_ &nbsp; Windows Server 2019, all editions, Windows Server 2016  

## Symptoms

In an Active Directory Domain Services (AD DS) environment, Linux integrated accounts cannot get Advanced Encryption Standard (AES) encrypted tickets through the Kerberos authentication. Instead, the RC4 tickets are received, and you can verify this issue in the Key Distribution Center (KDC). In the log of Event ID 4769, the value of **Ticket Encryption Type** is **0x17** for the affected computer, which means the encryption type is RC4.

```output
Source: Microsoft-Windows-Security-Auditing 
Event ID: 4769 
Task Category: Kerberos Service Ticket Operations 
Level: Information 
Computer: MyDC.contoso.com 
Description: 
A Kerberos service ticket was requested. 
… 
Service Information: 
Service Name: MYLINUX 
Service ID: CONTOSO\MYLINUX 
Network Information: 
Client Address: ::ffff:10.20.30.40 
Client Port: 57499 
Additional Information: 
Ticket Options: 0x40810000 
Ticket Encryption Type: 0x17 
Failure Code: 0x0 
Transited Services: -
```

> [!NOTE]
> This issue persists when you set the **msDS-SupportedEncryptionTypes** attribute value to *24 (0x18)* to force AES256/AES128 encryption, or use the **Network security: Configure encryption types allowed for Kerberos** GPO to disable the RC4 encryption and enable the AES encryption type.

## Cause

This issue occurs because the **operatingSystemVersion** attribute value of Linux is set to *3.10.0x*. If the first character of the value is a numeric digit and is less than six, the system will be considered as an operating system prior to Windows Vista/Windows Server 2008, which does not support the **msDS-SupportedEncryptionTypes** attribute and the AES encryption type. Therefore, the KDC returns an RC4 encrypted ticket.

## Workaround

To work around this issue, use one of the following workarounds:

- Remove the **operatingSystemVersion** attribute.
- Set the attribute value not start with a numeric digit, such as *Linux 3.10.0x* instead of *3.10.0x*.

For more information about how the KDC selects encryption type, see [Encryption Type Selection in Kerberos Exchanges](/archive/blogs/openspecification/encryption-type-selection-in-kerberos-exchanges).
