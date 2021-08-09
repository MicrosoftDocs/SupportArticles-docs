---
title: TLS 1.2 Protocol Support Deployment Guide for Microsoft Azure Pack
description: Describes how to deploy the TLS 1.2 protocol in Microsoft Azure Pack.
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.service: azure
ms.author: genli
author: genlin
ms.reviewer: waltero, sarathys, mtandon, mouradl, larsbe, vladimip, genli
---
# TLS 1.2 Protocol Support Deployment Guide for Microsoft Azure Pack

This article describes how to deploy the TLS 1.2 Protocol in Microsoft Azure Pack.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4043907

## Prerequisites

The following are prerequisites for supporting the TLS 1.2 protocol in Microsoft Azure Pack:

1. On Windows Server 2012 R2, do the following:  

    - Update the Microsoft .NET Framework 3.5 installation. To do this, go to the following article in the Microsoft Knowledge Base: [3154520](https://support.microsoft.com/help/3154520) Support for TLS System Default Versions included in the .NET Framework 3.5 on Windows 8.1 and Windows Server 2012 R2
    - Install all important updates for the .NET Framework version 4.5.x through Windows Update.

2. Install the required SQL Server TLS 1.2 protocol support update. To do this, go to the following article in the Microsoft Knowledge Base: [3135244](https://support.microsoft.com/help/3135244) TLS 1.2 support for Microsoft SQL Server

    > [!NOTE]
    > TLS 2 protocol supports only SHA1 and SHA2 certificates. Hence all certificates must be updated to be SHA1 or SHA2.

3. Configure the settings required for supporting the TLS 1.2 protocol. To do this, see the [Setting Microsoft Azure Pack to support the TLS 1.2 protocol](#setting-microsoft-azure-pack-to-support-the-tls-12-protocol) section.

    > [!NOTE]
    > These settings should be configured on the systems that run Windows Azure Pack. 

## Hardening the system to use the TLS 1.2 protocol

Use one of the following methods.

### Method 1: Manually modify the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756)  in case problems occur.

Use the following steps to enable/disable all SCHANNEL protocols system-wide. We recommend that you enable the TLS 1.2 protocol for incoming communications, and the TLS 1.2, TLS 1.1, and TLS 1.0 protocols for all outgoing communications.

> [!NOTE]
> Making these registry changes does not affect the use of Kerberos or NTLM protocols.

1. Start Registry Editor. To do this, right-click **Start**, type **regedit** in the **Run** box, and then click **OK**.
2. Locate the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

3. Right-click the **Protocol** key, point to **New**, and then click **Key**.

    :::image type="content" source="./media/tls-1.2-support-deployment-guide/4043980_en_2.png" alt-text="Screenshot of Registry key.":::

4. Type **SSL 3**, and then press Enter. 
5. Repeat steps 3 and 4 to create keys for TLS 0, TLS 1.1, and TLS 1.2. These keys resemble directories.
6. Create a **Client** key and a **Server** key under each of the **SSL 3**, **TLS 1.0**, **TLS 1.1**, and **TLS 1.2** keys.
7. To enable a protocol, create the DWORD value under each Client and Server key as follows:

    DisabledByDefault [Value = 0]  
    Enabled [Value = 1]

    To disable a protocol, change the DWORD value under each Client and Server key as follows:

    DisabledByDefault [Value = 1]  
    Enabled [Value = 0]

8. On the **File** menu, click **Exit**.

### Method 2: Automatically modify the registry

- On Windows Server 2012 R2, run the **Update-ComputerSchannelSettings.ps1** PowerShell script in Administrator mode.
- On Windows 10 and later versions, run the **SslProtocols.reg** and **SslCipherSuites4win10orlater.reg** registry files in Administrator mode.

> [!NOTE]
> These files are contained in the TLS1.2.zip file that is available from the [TechNet Gallery](https://gallery.technet.microsoft.com/TLS-12-Support-Deployment-15c3a47b).

## Setting Microsoft Azure Pack to support the TLS 1.2 protocol

Use one of the following methods.

### Method 1: Manually modify the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756)  in case problems occur.

To enable the installation of Microsoft Azure Pack on the system to support the TLS 1.2 protocol, follow these steps:

1. Start Registry Editor. To do this, right-click **Start**, type **regedit** in the **Run**  box, and then click **OK**.
2. Locate the following registry subkey:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319
3. Create the following DWORD value under this key: SchUseStrongCrypto [Value = 1]
4. Locate the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319`.
5. Create the following DWORD value under this key:SchUseStrongCrypto [Value = 1].
6. Restart the system.

### Method 2: Automatically modify the registry

Run the **SchUseStrongCrypto.reg** registry file in Administrator mode.
> [!NOTE]
> This file is contained in the TLS1.2.zip file that is available from the [TechNet Gallery](https://gallery.technet.microsoft.com/TLS-12-Support-Deployment-15c3a47b).
