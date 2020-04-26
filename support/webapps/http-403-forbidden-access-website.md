---
title: HTTP Error 403.16 when accessing a website
description: Describes a problem that triggers an HTTP 403.16 error when you try to access a website that's hosted by IIS 7.0.
ms.date: 03/26/2020
ms.prod-support-area-path: 
ms.reviewer: mlaing
---
# HTTP Error 403.16 when you try to access a website that's hosted on IIS 7.0

This article provides information about resolving an **HTTP 403.16 - Forbidden** error when you access a website that's hosted by Internet Information Services (IIS) 7.0.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 942061

## Symptoms

You have a website that's hosted on IIS 7.0. When you try to access the site through a web browser, you receive an error message that resembles one of the following examples.

Error message 1

> Server Error in Application "**application name**"  
> HTTP Error 403.16 - Forbidden  
> HRESULT: 0x800b0109  
> Description of HRESULT  
> Your client certificate is either not trusted or is invalid.

Error message 2

> HTTP 403.16 Client certificate is untrusted or invalid. Smart Card Users Cannot Authenticate.403 Forbidden

## Cause 1: Root certificate isn't in Trusted Root Certification Authorities Certificate store

This problem occurs because the root certificate of the certification authority isn't in the Trusted Root Certification Authorities Certificate store on the IIS Web server.

> [!NOTE]
> The root certificate of the certification authority is used to issue the client certificate.

## Cause 2: Non-self-signed certificates are in Trusted Root Certification Authorities Certificate store

There are one or more non-self-signed certificates in the Trusted Root Certification Authorities Certificate store. A non-self-signed certificate is any certificate for which the `Issued To` and `Issued By` values aren't an exact match.

## Resolution for cause 1

1. On the IIS Web server, click **Start**, type *mmc.exe* in the **Start Search** box, right-click mmc.exe, and then click **Run as administrator**.

    > [!NOTE]
    > If you are prompted for an administrator password or for a confirmation, type the password, or click **Continue**.

2. On the **File** menu, click **Add/Remove Snap-in**.
3. Under **Available snap-ins**, click **Certificates**, and then click **Add**.
4. Click **Computer account**, and then click **Next**.
5. Click **Local computer**, click **Finish**, and then click **Close**.
6. To exit the wizard, click **OK**.
7. Expand **Certificates**, expand **Trusted Root Certification Authorities**, right-click **Certificates**, point to **All Tasks**, and then click **Import**.
8. In the Certificate Import Wizard, click **Next**.
9. In the **File name** box, type the location of the root certificate of the certification authority, and then click **Next**.
10. Click **Next**, and then click **Finish**.

## Resolution for cause 2

Move any non-self-signed certificated out of the Trusted Root Certification Authorities Certificate store and into the Intermediate Certification Authorities Certificate store.

## More information

To identify all non-self-signed certificates in the Trusted Root Certification Authorities Certificate store, run the following PowerShell command:

```powershell
Get-Childitem cert:\LocalMachine\root -Recurse |
Where-Object {$_.Issuer -ne $_.Subject} | Format-List * | Out-File "c:\computer_filtered.txt"
```
