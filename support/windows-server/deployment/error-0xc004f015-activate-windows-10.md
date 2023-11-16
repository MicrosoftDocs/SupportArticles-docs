---
title: Error 0xC004F015 when you activate Windows 10
description: Discusses that you cannot activate Windows 10 Enterprise on a Windows Server 2012 R2 and Windows Server 2008 R2 KMS host and Error 0xC004F015 is logged. Provides a resolution.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, squin, scottmca
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
---
# Error 0xC004F015 when you activate Windows 10 Enterprise on a Windows Server 2012 R2 KMS host

This article provides a solution to a 0xC004F015 error that occurs when you activate Windows 10 Enterprise on a Microsoft Windows Server 2012 R2 and Windows Server 2008 R2 KMS host.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3086418

## Symptoms

On a computer that is running a volume-licensed installation of Windows 10 Enterprise, you cannot activate Windows if you are using a Customer Support Volume License Key (CSLVK). Additionally, the following error entry is logged in the event log as Event ID 12290:

> 0xC004F015
>
> Error details  
0xc004f042 - SL_E_VL_KEY_MANAGEMENT_SERVICE_ID_MISMATCH
>
> The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used.

## Cause

This problem can occur if you use the Windows 10 KMS host product key in a Windows Server 2012 R2 and Windows Server 2008 R2 environment. You must use the updated WS2012R2+Win10 KMS host product key if the following conditions are true.

- Client CSVLKs are installed on client computers.
- Server CSVLKs are installed on server computers.

## Prerequisites to activate Windows 10 Enterprise

To activate Windows 10 Enterprise in a Windows Server 2012 R2 environment, the following prerequisites apply:

- You must have Windows Server 2012 R2 with the Volume Activation role installed.
- You must have [update 3172614](https://support.microsoft.com/help/3172614) installed.

To activate Windows 10 Enterprise in a Windows Server 2008 R2 environment, the following prerequisites apply:

- You must have Windows Server 2008 R2 with the Volume Activation role installed.
- You must have update [3079821](https://support.microsoft.com/help/3079821) installed.

## Resolution

To resolve this problem, follow these steps:

1. Log on to the Volume Licensing Service Center (VLSC).
2. Click **License**.
3. Click **Relationship Summary**.
4. Click License ID of their current Active License.
5. After the page loads, click **Product Keys**.
6. In the list of keys, locate **Windows Srv 2012R2 DataCtr/Std KMS for Windows 10**.
7. Install this key on the KMS host.

## More information

For the client KMS host, this problem should not occur on a client KMS host server.

Activation of Windows 10 is not supported if you are running a KMS host on any of the following operating systems:

- Windows Vista
- Windows Server 2008
- Windows Server 2003

The Generic Volume License Key (GVLK) for Windows 10 editions can be located at [Appendix A: KMS Client Setup Keys](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj612867(v=ws.11)).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
