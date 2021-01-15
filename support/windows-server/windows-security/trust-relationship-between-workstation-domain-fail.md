---
title: Unable to log on to a domain in Windows 7 or Windows Server 2008 R2
description: Fixes an error that occurs when you try to log on to your domain in Windows 7 or Windows Server 2008 R2.
ms.date: 10/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: lindakup, kaushika
ms.prod-support-area-path: Kerberos authentication
ms.technology: WindowsSecurity
---
# Error on a computer that's running Windows 7 or Windows Server 2008 R2: Trust relationship between this workstation and the primary domain failed

This article provides a solution to an error that occurs when you try to log on to your domain in Windows 7 or Windows Server 2008 R2.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2914474

## Symptoms

You may be intermittently unable to log on to your domain in Windows 7 or Windows Server 2008 R2. In this situation, you receive the following error message:

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
