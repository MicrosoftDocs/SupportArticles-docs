---
title: Windows Activation fails with error 0x8007267C
description: Provides solutions to an issue where Windows Activation fails with the error code 0x8007267C.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, deepaksr, kledman
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Windows Activation fails with error code: 0x8007267C

This article provides solutions to an issue where Windows Activation fails with the error code 0x8007267C.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009462

## Symptoms

Windows Activation fails with the error code 0x8007267C.

## Cause

This issue will occur if the machine attempting to activate does not have a DNS server registered in its network properties.

> Error code 0x8007267C definition:  
No DNS servers configured for local system  
DNS_ERROR_NO_DNS_SERVERS

## Resolution 1:  Register DNS server in the network properties and test name resolution

To resolve this problem, client connectivity to a DNS server must be resolved. The following steps may help to expose the problem:

1. On the client getting the error, open a command prompt and run `IPCONFIG /all`.
2. Verify the assigned IP address, subnet mask, DNS server and default gateway are set with the correct values for your environment.
3. Verify basic IP connectivity to the DNS Server using the PING command using the address of the DNS server from step 1.  

    `ping <DNS Server IP address>`

If connectivity to the DNS server is failing, consider using the following as a guide to troubleshoot further:

[Troubleshooting TCP/IP](/previous-versions/tn-archive/bb727023(v=technet.10))

After resolving the connectivity issues to the DNS server, reattempt activation using the following command from an Elevated Command prompt

```console
cscript \windows\system32\slmgr.vbs -ato
```

## Resolution 2:  Use a MAK (multiple activation key) and phone based activation

If you do not have a DNS server connected to the network, you can switch to a MAK product key to activate your volume license installation. If you are using MSDN media or TechNet media, you must change the product key to the product key provided. The MSDN product key or the TechNet product key for Windows Server 2008 or for Windows Vista Enterprise is the MAK product key.  

Use the following command to change the product key to the MAK product key:

`slmgr -ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx`

Then, launch the phone activation wizard to complete the activation of the machine *slui 04*.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
