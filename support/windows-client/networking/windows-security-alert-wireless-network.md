---
title: Security alert when connecting to wireless network
description: Fixes an issue where a Windows Security alert appears when you connect to a wireless network on a workgroup machine.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
ms.subservice: networking
---
# Windows Security Alert appears when connecting to a wireless network on a workgroup machine

This article helps fix an issue where a Windows Security alert appears when you connect to a wireless network on a workgroup machine.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2518158

## Symptoms

While connecting to a wireless network on a Windows system that is part of a workgroup, a Windows Security Alert dialog similar to the following may be displayed:  
> The server `<Authentication server>` presented a valid certificate issued by `<CA name>`, but `<CA name>` is not configured as a valid trust anchor for this profile. Further, the server `<Authentication server>` is not configured as a valid NPS server to connect to this profile.  

or  

> The server `<Authentication server>` presented a valid certificate issued by `<CA name>`, but `<CA name>` is not configured as a valid trust anchor for this profile.  

If you click the Connect button on the dialog box, the wireless connection will be established successfully.  

## Cause

To validate the server certificate, Windows will check if the second element in the chain, the Certification Authority (CA) that issued the end certificate, is a trusted CA for Windows NT Authentication. A CA is considered to be trusted if it exists in the `NTAuth` system registry store found in the `CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE` store location. If this verification fails, either of the warning messages in the Symptoms section could occur. By default, the CA certificate is not in the NTAuth store on a Windows system that is part of a workgroup.

## Resolution  

To work around the issue, you can export the certificate of the CA that issued the certificate to the authentication server to a file. Copy the file to the workgroup machine and then run the following command from an elevated Command Prompt:

`certutil -enterprise -addstore NTAuth CA_CertFilename.cer`

## More information

About How to import third-party certification authority (CA) certificates into the Enterprise NTAuth store, please refer to [https://support.microsoft.com/kb/295663](https://support.microsoft.com/kb/295663)
