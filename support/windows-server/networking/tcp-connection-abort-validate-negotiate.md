---
title: TCP connection is aborted during Validate Negotiate
description: Introduces how to troubleshoot the SMB issue when the TCP connection is aborted during Validate Negotiate.
ms.date: 10/19/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:smb, csstroubleshoot
ms.technology: networking
---
# TCP connection is aborted during Validate Negotiate

In the network trace for the SMB issue, you notice that a TCP Reset abort occurred during the Validate Negotiate process. This article describes how to troubleshoot the situation.

## Cause

This issue can be caused by a failed negotiation validation. This typically occurs because a WAN accelerator modifies the original SMB Negotiate packet.

Microsoft no longer allows modification of the Validate Negotiate packet for any reason. This is because this behavior creates a serious security risk.

The following requirements apply to the Validate Negotiate packet:

- The Validate Negotiate process uses the `FSCTL_VALIDATE_NEGOTIATE_INFO` command.
- The Validate Negotiate response must be signed. Otherwise, the connection is aborted.
- You should compare the `FSCTL_VALIDATE_NEGOTIATE_INFO` messages to the Negotiate messages to make sure that nothing was changed.

## Workaround

You can temporarily disable the Validate Negotiate process. To do this, locate the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters`

Under the **Parameters** key, set **RequireSecureNegotiate** to **0**.

In Windows PowerShell, you can run the following cmdlet to set this value:

```PowerShell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
```

> [!NOTE]
> The Validate Negotiate process can't be disabled in Windows 10, Windows Server 2016, or later versions of Windows.

If either the client or server can't support the Validate Negotiate command, you can work around this issue by setting SMB signing to be required. SMB signing is considered more secure than Validate Negotiate. However, there can also be performance degradation if signing is required.

## Reference

- [3.3.5.15.12 Handling a Validate Negotiate Info Request](/openspecs/windows_protocols/ms-smb2/0b7803eb-d561-48a4-8654-327803f59ec6)
- [3.2.5.14.12 Handling a Validate Negotiate Info Response](/openspecs/windows_protocols/ms-smb2/6a5bc90d-3c08-4498-905b-e7dab30b2e0e)
