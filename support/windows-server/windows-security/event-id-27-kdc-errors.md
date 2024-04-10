---
title: Event ID 27 KDC error on domain controllers
description: Fixes the Event ID 27 KDC error that occurs on Windows Server 2003 domain controllers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Security Technologies\Kerberos authentication, csstroubleshoot
---
# Event ID 27 KDC Errors on Windows Server 2003 Domain Controllers

This article provides help to fix the Event ID 27 KDC error that occurs on Windows Server 2003 domain controllers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002141

## Symptoms

In an environment containing both Windows Server 2003 domain controllers and Windows Vista and Windows Server 2008 or newer member servers, the Windows Server 2003 domain controllers may log the following error:

Type: Error
Event: 27
Source: KDC
Category: None
Computer:
Event Msg: While processing a TGS request for the target server krbtgt/, the account 
\<account name> did not have a suitable key for generating a Kerberos ticket (the missing key has an ID of 8). The requested etypes were 18. The accounts available etypes were 23 -133 -128 3 1.

## Cause

The Windows Vista or Server 2008 member server is sending a TGS request using the encryption type of 18 (AES). Windows Server 2003 does not support this encryption type for Kerberos.

## Resolution

The Event ID 27 error that is being logged on the Windows Server 2003 domain controller can safely be ignored as it is by design. The domain controller is just informing the client what encryption types it supports. The Windows Server 2008 servers are then falling back to one of the supported encryption types.
It is possible to modify the default encryption type that Windows Server 2008 uses. This will prevent the error from being logged on the Windows Server 2003 domain controller. You will have to add the following registry value to the Windows Server 2008 servers.

- Path: HKLM\System\CurrentControlSet\Control\LSA\Kerberos\Parameters
- Value Name:  DefaultEncryptionType
- Value Type:  Reg_DWORD
- Value Data:  0x17(23)
