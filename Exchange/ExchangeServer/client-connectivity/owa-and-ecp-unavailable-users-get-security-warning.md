---
title: Security warning when accessing OWA or ECP
description: Users get a security error when they try to connect to Outlook on the Web (OWA) or Exchange Control Panel (ECP).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: balinger, v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# Users get a security warning when trying to connect OWA and ECP

_Original KB number:_ &nbsp; 4469384

## Symptom

Users can't connect to OWA or ECP. The browser generates an error message that states that the session can't be secured due to inadequate security settings.

## Cause

This is a known issue with Exchange 2019 RTM. The cryptography cipher suites that are configured by Exchange setup are incorrect and don't include HTTP/2 support on all supported browsers.

## Resolution

Run the following PowerShell commands on each server after Exchange Server is installed.

```powershell
# Copyright Microsoft Corporation 2018, All rights reserved

$script:cipherSuite = @( 'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384',
                          'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256',
                          'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384',
                          'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
                          'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384',
                          'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256',
                          'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384',
                          'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256' );
 # Vacate current list of suites
 $suites = Get-TLSCipherSuite;
 foreach ($suite in $suites)
 {
     if (Get-TlsCipherSuite -Name $suite.Name)
     {
         Disable-TlsCipherSuite -Name $suite.Name;
     }
 }
 # Enable Cipher Suites
 foreach($suite in $cipherSuite)
 {
     if ($suite -ne $null)
     {
        Enable-TlsCipherSuite -Name $suite;
     }
 }
 #Configure Elliptic Curve Preference
 Disable-TlsEccCurve "curve25519";
 Enable-TlsEccCurve "NistP384" -Position 0
```

## More information

This issue is expected to be resolved in Exchange Server 2019 Cumulative Update 1. New servers that are deployed with Cumulative Update 1 will not experience this issue. Customers who deploy a server by using the RTM version of Exchange Server 2019 or who upgrade an RTM-based server to Cumulative Update 1 (or a later version) will need to apply the workaround to each Exchange Server.
