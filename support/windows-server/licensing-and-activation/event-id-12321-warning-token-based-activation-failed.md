---
title: Event ID 12321 Warning Token Based Activation failed
description: Provides a resolution for Event ID 12321 Warning Token Based Activation failed
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joscon
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Event ID 12321 Warning Token Based Activation failed

This article provides a resolution for Event ID 12321 Warning Token Based Activation failed.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2020644

## Symptoms

The Application Event log may log an event ID 12321 warning event from the source Microsoft-Windows-Security-Licensing-SLC.
The description field will state Token Based Activation failed.  
HR=0xC004F011

## Cause

This event will occur when the Token Issuance License is not installed inside Windows or the certificates on the Smartcard are not present and activation is attempted.  

>0xC004F011 = SL_E_LICENSE_FILE_NOT_INSTALLED 
 
Windows Software Licensing is checking whether Token Activation is available on this volume license system and reporting that the license or certificate is not available so Token Based licensing will not work.

## Resolution

This issuance license file or Smartcard certificates are only needed when Token Based activation is being attempted.  

If you are not using Token-Based Activation, this warning message can be safely ignored. And it will not affect the ability, which activates Windows using KMS host machines or MAK keys.  

If you are using Token Based Activation, you need to reinstall the Token Issuance license acquired from Microsoft.  

SLMGR /ILC \<token-based-license-filename>

## More information

Token-Based activation functionality was enabled in Service Pack 2 for Windows Vista and Windows Server 2008.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
