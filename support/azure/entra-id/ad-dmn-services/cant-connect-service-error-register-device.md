---
title: Error (Can't connect to the service) when you try to register a device
description: Describes a problem that triggers an error when you try to register a device in a Windows 8.1 or Windows Server 2012 R2 environment.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: hybrid
---
# Error when you try to register a device: Can't connect to the service

_Original product version:_ &nbsp; Windows 8.1 Enterprise, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Microsoft Entra ID  
_Original KB number:_ &nbsp; 3045378

## Symptoms

When you try to perform a Workplace Join operation and register your device to your local Active Directory domain from a Windows 8.1 device, you receive the following error message:

> Can't connect to the service  
We can't connect to the service you need right now. Check your network connection or try this again later.

## Cause

This problem may occur for one of the following reasons:

- Although the Active Directory Federation Services (AD FS) proxy server can resolve the name of the federation server, the name resolves to an incorrect host.
- The AD FS service is not running on the AD FS proxy server.
- The WAP role is not installed.
- The WAP role is installed but is not configured.

## Resolution

To resolve this problem, follow these steps:

1. Sign in to your AD FS proxy server:
   1. Run the Services Management Console (services.msc).
   2. Locate the AD FS service.
   3. Verify that the service is in a Started state.

2. Verify name resolution of the Internal AD FS instance:
   1. From the AD FS proxy server, open a command prompt.
   2. Type `PING adfsserver.contoso.com`, and then press Enter.

    > [!NOTE]
    > The `adfsserver.contoso.com` placeholder represents the address of your AD FS server, such as `sts.contoso.com`.

3. Don't worry about whether the PING is successful or unsuccessful. Instead, notice whether the target address resolves to the IP address of the server.
4. If the address is incorrect, correct the resolution conflicts:
   - Check the Hosts file on the AD FS proxy server to see whether the correct entry is included and whether it targets your AD FS instance.
   - If you do not use a Hosts file, check internal DNS by using the `Nslookup` command to verify DNS records.

## More information

For more troubleshooting information, see the following article:

[Diagnostic logging for troubleshooting Workplace Join issues](https://support.microsoft.com/help/3045377)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
