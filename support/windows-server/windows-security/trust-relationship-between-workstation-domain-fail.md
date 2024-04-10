---
title: Unable to log on to a domain in Windows
description: Fixes an error that occurs when you try to log on to your domain in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: lindakup, kaushika
ms.custom: sap:Windows Security Technologies\Kerberos authentication, csstroubleshoot
---
# "Trust relationship between this workstation and the primary domain failed" error in Windows

This article provides a solution to an error that occurs when you try to log on to your domain in Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2914474

## Symptoms

You may be intermittently unable to log on to your domain in Windows. In this situation, you receive the following error message:

> The trust relationship between this workstation and the primary domain failed.

Additionally, when you check the machine account in Active Directory Domain Services (AD DS), it shows that the machine password was changed recently.

> [!NOTE]
> To work around this problem, restart the client computer.

## Cause

This problem is caused by the same problem that is fixed in hotfix [2545850](https://support.microsoft.com/help/2545850).

## Resolution

To resolve this problem, install hotfix [2545850](https://support.microsoft.com/help/2545850).

## More information

If you take a network trace during the failure, you find the following:

- A TGT request that resembles the following is sent from the client computer to the domain controller:

    > KerberosV5:AS Request Cname: machineAccount$ Realm: Contoso.com Sname: krbtgt/contoso.com

- A response request that resembles the following is sent from the domain controller to the client computer:

    > KerberosV5:KRB_ERROR - KDC_ERR_PREAUTH_FAILED (24)
