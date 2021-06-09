---
title: Linux accounts cannot get AES tickets
description: Provides some methods to an issue that Linux integrated accounts can't get AES encrypted tickets in AD DS, but get RC4 tickets instead.
ms.date: 06/09/2021
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

This issue occurs because the **operatingSystemVersion** attribute value of Linux is set to *3.10.0x*. If the first character of the value is a numeric digit and is less than six, the system will be considered as an operating system prior to Windows Vista/Windows Server 2008, which does not support the **msDS-SupportedEncryptionTypes** attribute and the AES encryption type. Therefore, the KDC returns an RC4 encrypted ticket. This is by design for Windows and noted in the specifications as follows:<a id="1"></a>

- If the server or [service](/openspecs/windows_protocols/ms-kile/e720dd17-0703-4ce4-ab66-7ccf2d72c579#gt_2dc07ca2-2b40-437e-a5ec-ed28ebfb116a) has a **KerbSupportedEncryptionTypes** populated with supported encryption types,[<58>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_58) then the KDC SHOULD[<59>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_59) return in the encrypted part ([[Referrals-11]](https://tools.ietf.org/internet-drafts/draft-ietf-krb-wg-kerberos-referrals-11) Appendix A) of **TGS-REP** message, a **PA-DATA** structure with padata-type set to **PA-SUPPORTED-ENCTYPES** [165] to indicate what encryption types (section [2.2.7](/openspecs/windows_protocols/ms-kile/6cfc7b50-11ed-4b4d-846d-6f08f0812919)) are supported by the server or service. If not, the KDC SHOULD[<60>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_60) check the server or service account's UseDESOnly flag.

- <58> Section 3.3.5.7: When the account is for a computer object and the value of **OperatingSystemVersion** ([[MS-ADA3]](/openspecs/windows_protocols/ms-ada3/4517e835-3ee6-44d4-bb95-a94b6966bfb0) section 2.56) is less than 6, **KerbSupportedEncryptionTypes** is treated as if it were not populated to ensure that newer encryption types are not attempted with Windows 2000, Windows XP, and Windows Server 2003, which do not support setting **KerbSupportedEncryptionTypes**.

For more information, see the specifications in [TGS Exchange](/openspecs/windows_protocols/ms-kile/2e5dcf34-4b51-44a0-b45a-277ed616ca39#:~:text=if%20the%20server%20or%20service,usedesonly%20flag) and [Appendix A <58>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_58) of Kerberos protocol extensions.

## Solution

To solve this issue, use one of the following methods:

- Remove the **operatingSystemVersion** attribute.
- Set the attribute value not start with a numeric digit, such as *Linux 3.10.0x* instead of *3.10.0x*.
- Obtain and upgrade to an updated system version from the third party vendor (for example, Linux) to comply with the [specifications](#1).

For more information about how the KDC selects encryption type, see [Encryption Type Selection in Kerberos Exchanges](/archive/blogs/openspecification/encryption-type-selection-in-kerberos-exchanges).
