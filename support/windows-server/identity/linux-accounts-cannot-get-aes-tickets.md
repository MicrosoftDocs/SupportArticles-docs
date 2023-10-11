---
title: Linux accounts cannot get AES tickets
description: Provides methods to resolve an issue where Linux-integrated accounts in AD DS can't get AES-encrypted Kerberos tickets but get RC4-encrypted tickets instead.
ms.date: 01/22/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Linux accounts can't get AES-encrypted tickets in AD DS

## Symptoms

In an Active Directory Domain Services (AD DS) environment, Linux-integrated accounts receive RC4-encrypted tickets instead of Advanced Encryption Standard (AES)-encrypted tickets when they use Kerberos authentication. To troubleshoot this issue, go to the Key Distribution Center (KDC).

- In the log of Event ID 4769, the value of **Ticket Encryption Type** is **0x17** for the affected computer. That corresponds to an RC4 encryption type.

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

- After you run the [`klist`](/windows-server/administration/windows-commands/klist) command, the value of **KerbTicket Encryption Type** is **RSADSI RC4-HMAC(NT)**. That indicates that the encryption type is RC4.

    ```output
    C:\> Klist get MYLINUX@CONTOSO.COM  
    Current LogonId is 0:0xb532bccf  
    A ticket to MYLINUX@CONTOSO.COM has been retrieved successfully.  
    Cached Tickets: (2)  
    …  
    #1> Client: MyUser@CONTOSO.COM  
    Server: MYLINUX@CONTOSO.COM  
    KerbTicket Encryption Type: RSADSI RC4-HMAC(NT)  
    Ticket Flags 0x40a50000 -> forwardable renewable pre_authent ok_as_delegate name_canonicalize  
    Start Time: <DateTime> (local)  
    End Time: <DateTime> (local)  
    Renew Time: <DateTime> (local)  
    Session Key Type: AES-256-CTS-HMAC-SHA1-96  
    Cache Flags: 0  
    Kdc Called: MyDC.Contoso.com  
    ```

> [!NOTE]  
> Setting the **msDS-SupportedEncryptionTypes** attribute value to *24 (0x18)* to force AES256 or AES128 encryption doesn't solve the issue. Similarly, disabling RC4 encryption and enabling AES encryption by using the **Network security: Configure encryption types allowed for Kerberos** Group Policy Object (GPO) doesn't resolve the issue.

## Cause

This issue occurs because the **operatingSystemVersion** attribute value of Linux is set to *3.10.0x*. AD DS reads the attribute value from left to right, stopping at the first decimal point (.) If the first character of the value is a digit and the value is less than six, the KDC determines that the requesting operating system might not support newer encryption types. In this case, the value is 3. Therefore, the KDC ignores **msDS-SupportedEncryptionTypes** and uses RC4 to encrypt the ticket.

This behavior is by design. It accommodates older versions of Windows (including Windows 2000 Server, Windows Server 2003, and Windows XP) that do not support the **msDS-SupportedEncryptionTypes** attribute or the AES encryption type. The following specifications describe this design:<a id="1"></a>

- If the server or [service](/openspecs/windows_protocols/ms-kile/e720dd17-0703-4ce4-ab66-7ccf2d72c579#gt_2dc07ca2-2b40-437e-a5ec-ed28ebfb116a) has a **KerbSupportedEncryptionTypes** attribute that's populated by using supported encryption types[<58>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_58), then the KDC should[<59>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_59) return in the encrypted part ([[Referrals-11]](https://tools.ietf.org/internet-drafts/draft-ietf-krb-wg-kerberos-referrals-11) Appendix A) of **TGS-REP** message, a **PA-DATA** structure that has **padata-type** set to **PA-SUPPORTED-ENCTYPES** [165] to indicate which encryption types (section [2.2.7](/openspecs/windows_protocols/ms-kile/6cfc7b50-11ed-4b4d-846d-6f08f0812919)) are supported by the server or service. If it doesn't, the KDC should[<60>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_60) check the server or service account's **UseDESOnly** flag.

- <58> Section 3.3.5.7: If the account is for a computer object, and the value of **OperatingSystemVersion** ([[MS-ADA3]](/openspecs/windows_protocols/ms-ada3/4517e835-3ee6-44d4-bb95-a94b6966bfb0) section 2.56) is less than 6, **KerbSupportedEncryptionTypes** is treated as if it's not populated. This approach makes sure that newer encryption types aren't attempted if the requesting computer runs Windows 2000, Windows XP, or Windows Server 2003. These systems don't support setting **KerbSupportedEncryptionTypes**.

For more information, see the specifications in [TGS Exchange](/openspecs/windows_protocols/ms-kile/2e5dcf34-4b51-44a0-b45a-277ed616ca39#:~:text=if%20the%20server%20or%20service,usedesonly%20flag) and [Appendix A <58>](/openspecs/windows_protocols/ms-kile/1163bb03-7035-433e-b5a4-802247262d18#Appendix_A_58) of Kerberos protocol extensions.

## Solution

To resolve this issue, use one of the following methods:

- Remove the **operatingSystemVersion** attribute.
- Set the attribute value so that the first character isn't a numeric digit. For example, set the value to *Linux 3.10.0x* instead of *3.10.0x*.
- Upgrade to an updated system version that complies with the [specifications](#1). Obtain the update from the third-party vendor (for example, Linux).

For more information about how the KDC selects the encryption type, see [Encryption Type Selection in Kerberos Exchanges](/archive/blogs/openspecification/encryption-type-selection-in-kerberos-exchanges).
