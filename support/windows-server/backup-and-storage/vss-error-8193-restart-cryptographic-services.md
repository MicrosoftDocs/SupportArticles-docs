---
title: VSS event 8193 when you restart the Cryptographic Services service after you install the DHCP role
description: Describes an issue where event ID 8193 occurs when you restart the Cryptographic Services service if the DHCP role has installed on a computer that is running Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: makat, kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
ms.subservice: backup-and-storage
---
# VSS event ID 8193 is logged when you restart the Cryptographic Services service after you install the DHCP role on a computer

This article describes an issue where you receive event ID 8193 when you restart the Cryptographic Services service if the DHCP role has installed.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2298620

## Symptoms

You install the DHCP role on a computer. When you restart the Cryptographic Services service, the following event is logged in the Application log:

> Log Name: Application  
Source: VSS  
Date: Date/Time  
Event ID: 8193  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer:  
Description:  
Volume Shadow Copy Service error: Unexpected error calling routine RegOpenKeyExW(-147483646,SYSTEM\CurrentControlSet\Services\VSS\Diag,...). hr = 0x80070005, Access is denied.
>
> Operation:  
Initializing Writer
>
> Context:  
Writer Class Id: {e8132975-6f93-4464-a53e-1050253ae220}  
Writer Name: System Writer  
Writer Instance ID: {7bb41431-3960-44bc-a29c-3b42d2301fc3}

> [!NOTE]
> Although this event is recorded, Volume Shadow Copy and DHCP Server continue to function as expected. Although this event is logged as an error, the event should not be considered a critical failure that affects the correct functioning of VSS. The registry key is mentioned for diagnostic purposes.

## Cause

When the DHCP server role is installed, the permissions of the following registry key (and all subkeys) are overwritten when the DHCP Service account is added:

`HKLM\CurrentControlSet\Services\VSS\Diag`

When this occurs, the Network Service account is removed.

Every time that the Cryptographic Services service is started, it initializes "System Writer" under the Network Service account and verifies read/write permission for the following registry key:

`HKLM\CurrentControlSet\Services\VSS\Diag`

Because the Network Service account is used to obtain access to this key, there's no permission for the Network Service. Therefore, VSS logs an "Access denied" event.

## Resolution

Volume shadow copy and DHCP server continue to function as expected, so you can ignore the event.

If you need to avoid the event, do following steps:

1. Run **PowerShell** as an administrator.
2. Run the following command. Be careful not to include a new line in the middle of

    ```powershell
    $path = 'HKLM:\System\CurrentControlSet\Services\VSS\Diag\'

    $sddl = 'D:PAI(A;;KA;;;BA)(A;;KA;;;SY)(A;;CCDCLCSWRPSDRC;;;BO)(A;;CCDCLCSWRPSDRC;;;LS)(A;;CCDCLCSWRPSDRC;;;NS)(A;CIIO;RC;;;OW)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;CIIO;GA;;;BA)(A;CIIO;GA;;;BO)(A;CIIO;GA;;;LS)(A;CIIO;GA;;;NS)(A;CIIO;GA;;;SY)(A;CI;CCDCLCSW;;;S-1-5-80-3273805168-4048181553-3172130058-210131473-390205191)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)S:ARAI'

    $acl = Get-Acl -Path $Path

    $acl.SetSecurityDescriptorSddlForm($sddl)

    Set-Acl -Path $Path -AclObject $acl
    ```
