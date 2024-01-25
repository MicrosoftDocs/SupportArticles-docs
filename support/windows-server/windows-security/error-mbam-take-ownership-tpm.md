---
title: MBAM fails to take ownership of TPM
description: Describes an issue where an error occurs when MBAM tries to initialize TPM.
ms.date: 11/22/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: manojse, yitzhaks, avicar, kaushika
ms.custom: sap:bitlocker, csstroubleshoot
ms.subservice: windows-security
---
# MBAM fails to take ownership of TPM

This article provides a solution to an error that occurs when MBAM tries to initialize TPM.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 – all editions  
_Original KB number:_ &nbsp; 2640178

## Symptoms

When Microsoft BitLocker Administration and Monitoring (MBAM) tries to initialize TPM, on some machines you may see the below error message.

> Error  
BitLocker drive encryption has a problem and must close.  
BitLocker will close now. Contact the help desk of your company if you need additional help.
>
> Details  
Error taking ownership of the TPM.

:::image type="content" source="media/error-mbam-take-ownership-tpm/bitlocker-encrypt-error.png" alt-text="Details of the BitLocker drive encryption has a problem and must close error.":::

## Cause

Microsoft BitLocker Administration and Monitoring (MBAM) fails to take ownership if Endorsement Key (EK) pair is missing on the TPM.

The Endorsement Key (EK) is an encryption key that is permanently embedded in the Trusted Platform Module (TPM) security hardware, generally at the time of manufacture.

You may see this error message if the TPM manufacturer didn't create the Endorsement Key (EK) pair.

Enabling verbose logging on Microsoft BitLocker Administration and Monitoring (MBAM) client should show the error as below:

> TPM_E_NO_ENDORSEMENT - 0x80280023- The TPM does not have an Endorsement Key (EK) installed.

## Resolution

To resolve this issue, follow below steps:

1. Copy the below mentioned script text to a notepad file and save it as "*tpm-ek.txt*" (without quotes).
2. Rename the extension of the above mentioned text file to "*tpm-ek.vbs*" (without quotes).
3. Execute the vbs script on the machine to generate the Endorsement Key (EK) pair.
4. Now, when MBAM tries to take ownership of TPM it will work correctly. This will happen when MBAM agent will hit the next client wake-up frequency, which is 90 minutes by default.

```vb
=============== Script Text ===============

Set objWMIService = GetObject("WinMgmts:{impersonationLevel=impersonate,AuthenticationLevel=pktprivacy}//" & "." & "\root\CIMV2\Security\MicrosoftTpm")

Set objItems = objWMIService.InstancesOf("Win32_Tpm")

For Each objItem In objItems

'rvaluea = objItem.IsEnabled(A)'rvalueb = objItem.IsActivated(B)'rvaluec = objItem.IsOwned(C)

rvalued = objItem.IsEndorsementKeyPairPresent(D)'If A Then

'WScript.Echo "TPM Is Enabled: " & A

'Else

'WScript.Echo "TPM Is Enabled: " & A

'End If

'If B Then

'WScript.Echo "TPM Is Activated: " & B

'Else

'WScript.Echo "TPM Is Activated: " & B

'End If

'If C Then

'WScript.Echo "TPM Is Owned: " & C

'Else

'WScript.Echo "TPM Is Owned: " & C

'End If

'If D Then

'WScript.Echo "TPM Is EndorsementKeyPairPresent: " & D

'Else

If Not D Then

'WScript.Echo "TPM Is EndorsementKeyPairPresent: " & D

'WScript.Echo "CreateEndorsementKeyPair... Please Wait"

rvaluee = objItem.CreateEndorsementKeyPair(E)'WScript.Echo "CreateEndorsementKeyPair... Returns:" & rvaluee & " and E=" & E

If (rvaluee <> 0) Then

WScript.Quit -1

End If

End If

Next
WScript.Quit 0

=============== Script Text ===============
```

## References

- [Understand the TPM Endorsement Key](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770443(v=ws.11))

- [BitLocker Sample Deployment Script](https://gallery.technet.microsoft.com/scriptcenter/780d167f-2d57-4eb7-bd18-84c5293d93e3/)

- [TPM Error Codes](/windows/win32/com/com-error-codes-6)
