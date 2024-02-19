---
title: How to disable the SAN for UPN mapping
description: Describes how to disable the Subject Alternative Name for UPN mapping through Registry Editor.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, clfish, jories, jtierney, stsyfuhs, waynmc, v-lianna
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# How to disable the Subject Alternative Name for UPN mapping

_Original KB number:_ &nbsp; 4043463  
_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

User principal name (UPN) mapping is a special case of one-to-one mapping used in Active Directory. This article describes how to use an explicit mapping instead of UPN mapping by disabling the subject alternative name (SAN) through **Registry Editor**. Performing the following steps will allow the use of an explicit mapping by ignoring the SAN extension of a deployed client certificate.

## Server-side

1. Open **Registry Editor**.
2. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Kdc\UseSubjectAltName`.
3. Right-click **UseSubjectAltName**, select **Modify Binary data**, and then set the **Value data** to *0*.

> [!NOTE]
> The value of the **UseSubjectAltName** registry key must be set to *0* on all key distribution centers (KDC) for the domain.

## Client-side

> [!NOTE]
> You must also perform steps on the client-side if the following conditions are met:
>
> - Client certificate mapping (AltSecID) is used.
> - A UPN is used in the SAN extension of a client certificate.
> - No domain hint is used.

Here's how to disable the SAN for the UPN mapping on the client-side:

1. Open **Registry Editor**.
2. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`.
3. Press and hold (right-click) **Parameters**, select **New** > **DWORD (32-bit) Value**, and then name it *UseSubjectAltName*. Double-click it, set the **Value data** to *0*, and then press Enter.

## Reference

For more information about SAN or UPN mapping, see smart card logon flow in [Certificate Enumeration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff404289(v=ws.10)).
