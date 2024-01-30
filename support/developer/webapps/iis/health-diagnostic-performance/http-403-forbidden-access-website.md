---
title: HTTP Error 403.16 when you access a website
description: This article describes the problem where an HTTP 403.16 error occurs when you try to access a website that's hosted by IIS 7.0.
ms.date: 03/26/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.reviewer: mlaing
ms.subservice: health-diagnostic-performance
---
# HTTP Error 403.16 when you try to access a website that's hosted on IIS 7.0

This article helps you resolve the **HTTP 403.16 - Forbidden** error that occurs when you access a website that's hosted on Internet Information Services (IIS) 7.0.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 942061

## Symptoms

You have a website that's hosted on IIS 7.0. When you try to access the site through a web browser, you receive an error message that resembles one of the following examples.

- Error message 1

    > Server Error in Application "**application name**"  
    > HTTP Error 403.16 - Forbidden  
    > HRESULT: 0x800b0109  
    > Description of HRESULT  
    > Your client certificate is either not trusted or is invalid.

- Error message 2

    > HTTP 403.16 Client certificate is untrusted or invalid. Smart Card Users Cannot Authenticate.403 Forbidden

## Cause 1: Root certificate isn't in Trusted Root Certification Authorities Certificate store

This problem occurs because the root certificate of the certification authority isn't in the Trusted Root Certification Authorities Certificate store on the IIS Web server.

> [!NOTE]
> The root certificate of the certification authority is used to issue the client certificate.

## Cause 2: Non-self-signed certificates are in Trusted Root Certification Authorities Certificate store

There are one or more non-self-signed certificates in the Trusted Root Certification Authorities Certificate store. A non-self-signed certificate is any certificate for which the `Issued To` and `Issued By` values aren't an exact match.

## Resolution for cause 1

1. On the IIS Web server, select **Start**, type *mmc.exe* in the **Start Search** box, right-click mmc.exe, and then select **Run as administrator**.

    > [!NOTE]
    > If you are prompted for an administrator password or for a confirmation, type the password, or select **Continue**.

2. On the **File** menu, select **Add/Remove Snap-in**.
3. Under **Available snap-ins**, select **Certificates**, and then select **Add**.
4. Select **Computer account**, and then select **Next**.
5. Select **Local computer**, select **Finish**, and then select **Close**.
6. To exit the wizard, select **OK**.
7. Expand **Certificates**, expand **Trusted Root Certification Authorities**, right-click **Certificates**, point to **All Tasks**, and then select **Import**.
8. In the Certificate Import Wizard, select **Next**.
9. In the **File name** box, type the location of the root certificate of the certification authority, and then select **Next**.
10. Select **Next**, and then select **Finish**.

## Resolution for cause 2

Move any non-self-signed certificated out of the Trusted Root Certification Authorities Certificate store and into the Intermediate Certification Authorities Certificate store.

## More information

To identify all non-self-signed certificates in the Trusted Root Certification Authorities Certificate store, run the following PowerShell command:

```powershell
Get-Childitem cert:\LocalMachine\root -Recurse |
Where-Object {$_.Issuer -ne $_.Subject} | Format-List * | Out-File "c:\computer_filtered.txt"
```
