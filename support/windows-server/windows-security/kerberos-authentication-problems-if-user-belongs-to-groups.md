---
title: Kerberos authentication problems
description: Describes an issue in which a user who has too many group memberships cannot authenticate successfully. Describes the factors that cause the behavior, and workarounds.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, wincicadsec, mohak
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Problems with Kerberos authentication when a user belongs to many groups

This article helps you solve the problems of Kerberos authentication failure when a user belongs to many groups.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 327825

## Symptoms

A user who belongs to a large number of security groups has problems authenticating. When authenticating, the user may see a message such as **HTTP 400 - Bad Request (Request Header too long)**. The user also has problems accessing resources, and the user's Group Policy settings may not update correctly.

For more information about the context of the error, see [HTTP 400 Bad Request (Request Header too long) responses to HTTP requests](/troubleshoot/iis/http-bad-request-response-kerberos).

> [!NOTE]
> Under similar conditions, Windows NTLM authentication works as expected. You may not see the Kerberos authentication problem unless you analyze the Windows behavior. However, in such scenarios, Windows may not be able to update Group Policy settings.

This behavior occurs in any of the currently supported Windows versions. For information about the currently supported versions of Windows, see [Windows lifecycle fact sheet](https://support.microsoft.com/help/13853).

## Cause

The user cannot authenticate because the ticket that Kerberos builds to represent the user is not large enough to contain all of the user's group memberships.

As part of the [Authentication Service Exchange](/windows/win32/secauthn/authentication-service-exchange), Windows builds a token to represent the user for purposes of authorization. This token (also called an authorization context) includes the security identifiers (SID) of the user, and the SIDs of all of the groups that the user belongs to. It also includes any SIDs that are stored in the user account's `sIDHistory` attribute. Kerberos stores this token in the Privilege Attribute Certificate (PAC) data structure in the Kerberos Ticket-Getting Ticket (TGT). Starting with Windows Server 2012, Kerberos also stores the token in the Active Directory Claims information (Dynamic Access Control) data structure in the Kerberos ticket. If the user is a member of a large number of groups, and if there are many claims for the user or the device that is being used, these fields can occupy lots of spaces in the ticket.

The token has a fixed maximum size (`MaxTokenSize`). Transport protocols such as remote procedure call (RPC) and HTTP rely on the `MaxTokenSize` value when they allocate buffers for authentication operations. `MaxTokenSize` has the following default value, depending on the version of Windows that builds the token:

- Windows Server 2008 R2 and earlier versions, and Windows 7 and earlier versions: 12,000 bytes
- Windows Server 2012 and later versions, and Windows 8 and later versions: 48,000 bytes

Generally, if the user belongs to more than 120 universal groups, the default `MaxTokenSize` value does not create a large enough buffer to hold the information. The user cannot authenticate and may receive an **out of memory** message. Additionally, Windows may not be able to apply Group Policy settings for the user.

> [!NOTE]
> Other factors also affect the maximum number of groups. For example, SIDs for global and domain-local groups have smaller space requirements. Windows Server 2012 and later versions add claim information to the Kerberos ticket, and also compress resource SIDs. Both features change the space requirements.

## Resolution

To resolve this problem, update the registry on each computer that participates in the Kerberos authentication process, including the client computers. We recommend that you update all of your Windows-based systems, especially if your users have to log on across multiple domains or forests.

> [!IMPORTANT]
> Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756), in case problems occur.

On each of these computers, set the `MaxTokenSize` registry entry to a larger value. You can find this entry in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters` subkey. The computers have to restart after you make this change.

For more information about determining a new value for `MaxTokenSize`, see the [Calculating the maximum token size](#calculating-the-maximum-token-size) section of this article.

For example, consider a user who is using a web application that relies on a SQL Server client. As part of the authentication process, the SQL Server client passes the user's token to a back-end SQL Server database. In this case, you would need to configure the `MaxTokenSize` registry entry on each of the following computers:

- The client computer that is running Internet Explorer
- The web server running that is running IIS
- The SQL Server client computer
- The SQL Server database computer

In Windows Server 2012 (and later versions), Windows can log an event (Event ID 31) if the token size passes a certain threshold. To enable this behavior, you have to configure the Group Policy setting **Computer Configuration\Administrative Templates\System\KDC\Warning for large Kerberos tickets**.

## Calculating the maximum token size

Use the following formula to calculate the size of the token that Windows generates for a particular user. This calculation helps you determine whether you need to change `MaxTokenSize`.

TokenSize = 1200 + 40d + 8s

For Windows Server 2012 (and later versions), this formula defines its components as follows:

- **1200**. The estimated overhead value for a Kerberos ticket. This value can vary, depending on factors such as the length of the DNS domain name and the length of the client name.
- **d**. The sum of the following values:
  - The number of memberships in universal groups that are outside the user's account domain.
  - The number of SIDs stored in the account's `sIDHistory` attribute. This value counts group memberships and user SIDs.
- **s**. The sum of the following values:
  - The number of memberships in universal groups that are inside the user's account domain.
  - The number of memberships in domain-local groups.
  - The number of memberships in global groups.

Windows Server 2008 R2 and earlier versions use the same formula. However, these versions consider the number of domain-local group memberships to be part of the **d** value instead of the **s** value.

If you have a `MaxTokenSize` value of **0x0000FFFF (64K)**, you may be able to buffer approximately 1600 **d**-class SIDs or approximately 8000 **s**-class SIDs. However, a number of other factors influence the value that you can safely use for `MaxTokenSize`, including the following:

- If you use **trusted for delegation** accounts, each SID requires twice as much space.
- If you have multiple trusts, configure the trusts to filter SIDs. This configuration reduces the impact of the Kerberos ticket size.
- If you are using Windows Server 2012 or a later version, the following factors also affect the SID space requirements:
  - There is a new scheme for compressing the SIDs in the PAC. For more information, see [KDC Resource SID Compression](https://social.technet.microsoft.com/wiki/contents/articles/20886.kdc-resource-sid-compression.aspx). This feature reduces the size needed for SIDs in the ticket.
  - Dynamic Access Control adds Active Directory claims to the ticket, increasing the size requirements. However, after you deploy claims with Windows Server 2012 file servers, you can expect to phase out a significant number of groups that control file access. This reduction can in turn reduce the size needed in the ticket. For more information, see [Dynamic Access Control: Scenario Overview](/windows-server/identity/solution-guides/dynamic-access-control--scenario-overview).
- If you have configured Kerberos to use unconstrained delegation, you have to double the `TokenSize` value from the formula in order to obtain a valid estimate of `MaxTokenSize`.

  > [!IMPORTANT]
  > In 2019, Microsoft shipped updates to Windows that changed the default configuration of unconstrained delegation for Kerberos to disabled. For more information, see [Updates to TGT delegation across incoming trusts in Windows Server](https://support.microsoft.com/help/4490425).
  >
  > As resource SID compression is widely used and unconstrained delegation is deprecated, `MaxTokenSize` of 48000 or larger should become sufficient for all scenarios.

## Known issues that affect MaxTokenSize

A `MaxTokenSize` value of 48,000 bytes should be sufficient for most implementations. This is the default value in Windows Server 2012 and later versions. However, if you decide to use a larger value, review the known issues in this section.

- Size limit of 1,010 group SIDs for the LSA access token

  This issue is similar in that a user who has too many group memberships cannot authenticate, but the calculations and conditions that govern the issue are different. For example, the user may encounter this issue while using either Kerberos authentication or Windows NTLM authentication. For more information, see [Logging on a user account that is a member of more than 1,010 groups may fail on a Windows Server-based computer](https://support.microsoft.com/help/328889).

- Known issue when using values of MaxTokenSize larger than 48,000

  To mitigate a denial of service attack vector, Internet Information Server (IIS) uses a limited HTTP request buffer size of 64 KB. A Kerberos ticket that is part of an HTTP request is encoded as Base64 (6 bits expanded to 8 bits). Therefore, the Kerberos ticket is using 133 percent of its original size. Therefore, when the maximum buffer size is 64 KB in IIS, the Kerberos ticket can use 48,000 bytes.

  If you set the `MaxTokenSize` registry entry to a value that is larger than 48000 bytes, and the buffer space is used for SIDs, an IIS error may occur. However, if you set the `MaxTokenSize` registry entry to 48,000 bytes, and you use the space for SIDs and claims, a Kerberos error occurs.

  For more information about IIS buffer sizes, see [How to limit the header size of the HTTP transmission that IIS accepts from a client in Windows 2000](https://support.microsoft.com/help/310156).

- Known issues when using values of MaxTokenSize larger than 65,535

  Previous versions of this article discussed values of up to 100,000 bytes for `MaxTokenSize`. However, we have found that versions of SMS Administrator have problems when the `MaxTokenSize` is 100,000 bytes or larger.

  We have also identified that the IPSEC IKE protocol does not allow a security BLOB to become larger than 66,536 bytes, and it would also fail when `MaxTokenSize` is set to a larger value.
