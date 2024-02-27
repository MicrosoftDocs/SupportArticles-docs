---
title: SMS_EXECUTIVE service crashes
description: Fixes an issue in which the SMS_EXECUTIVE service crashes when a SQL Server certificate can't be found in the certificate store.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# SMS_EXECUTIVE service crashes when a SQL Server certificate can't be found

This article helps you work around an issue in which the SMS_EXECUTIVE service crashes when the SQL Server certificate can't be found in the certificate store.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1602), Configuration Manager (current branch - version 1606)  
_Original KB number:_ &nbsp; 3205787

## Symptoms

The SMS_EXECUTIVE service silently crashes when the SQL Server certificate can't be found in the certificate store. This issue occurs repeatedly and affects Configuration Manager current branch versions 1602 and 1606. The issue is fixed in Configuration Manager current branch versions 1610.

## Workaround

To work around this issue, use the following PowerShell cmdlet to create a self-signed certificate. Then, specify the provider to import the certificate into the local computer store of the Configuration Manager server.

```powershell
New-SelfSignedCertificate -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -Subject "CN=AUCOLO-SCCM.contoso.com" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1") -KeyAlgorithm RSA -KeyLength 2048 -DnsName "AUCOLO-SCCM.contoso.com" -CertStoreLocation "Cert:\LocalMachine\My" -NotAfter (Get-Date).AddMonths(120) -KeyExportPolicy "Exportable"
certutil -csp "Microsoft Enhanced RSA and AES Cryptographic Provider" -importpfx Self-signed-new5.pfx-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -Subject "CN=AUCOLO-SCCM.contoso.com" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1") -KeyAlgorithm RSA -KeyLength 2048 -DnsName "AUCOLO-SCCM.contoso.com" -CertStoreLocation "Cert:\LocalMachine\My" -NotAfter (Get-Date).AddMonths(120) -KeyExportPolicy "Exportable"
certutil -csp "Microsoft Enhanced RSA and AES Cryptographic Provider" -importpfx Self-signed-new5.pfx
```

Replace the `Subject` and `DnsName` parameters with the right values in the cmdlet.

> [!NOTE]
> This cmdlet must be run on a Windows 10-based computer, as the parameters are supported only in Windows 10.
