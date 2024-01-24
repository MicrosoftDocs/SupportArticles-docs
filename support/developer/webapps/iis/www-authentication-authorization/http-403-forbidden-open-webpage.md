---
title: HTTP error 403.7 when you open an IIS webpage
description: This article describes an HTTP error 403 that occurs when you open an IIS webpage, and provides a resolution.
ms.date: 03/30/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: Anahith
ms.technology: www-authentication-authorization
---
# Error when you open an IIS webpage: 403.7 Forbidden: Client certificate required

This article helps you resolve the problem where an unexpected runtime error may be thrown when you open an Internet Information Services (IIS) webpage.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 186812

> [!NOTE]
> The target audience for this article is website administrators or web developers. If you are an end-user who has encountered this error, we recommend that you ask the site administrator for instructions on how to obtain the correct client certificate.

## Symptoms

You have a website that is hosted on IIS. When you go to the website in a web browser, you may receive an error message that resembles the following one:

> HTTP Error 403  
> 403.7 Forbidden: Client certificate required

## Cause

This error occurs when the website requests a client certificate, and then the client either doesn't provide one or the certificate supplied by the client browser is rejected. Client certificates are a kind of Secure Sockets Layer (SSL) certificate typically used to identify a user or computer to a website.

The following are several possible causes of this problem:

- The root certificate (certification authority certificate) of the client certificate isn't installed on the computer that is running IIS.
- The client certificate has expired, or the effective time hasn't been reached.
- The client certificate was revoked.
- No valid client certificate is available, or a potentially valid client certificate doesn't have an associated private key installed.

## Resolution

Depending on the cause of your problem, try one of the following resolutions:

- If you don't have a client certificate for the site, and you need one, contact the site administrator for instructions.
- Check the expiration date and time of the certificate. If your certificate has expired, contact the site administrator for instructions.

> [!NOTE]
> Client certificate authentication may be enabled where it is not required. If you intended only to require Transport Layer Security (TLS)/SSL communications, then you need only a server certificate. You can disable client certificate authentication by using the resolution in ["HTTP Error 403.7 - Forbidden" error when you run a Web application that is hosted on a server that is running IIS 7.0](https://support.microsoft.com/help/942067).

## Check whether the server running IIS considers the certificate valid

1. Export the certificate to a .CER file.
2. Copy the .CER file to the server that is running IIS.
3. Open the .CER file on the server that is running IIS.
4. Look at the **Certification Path** tab. If all certificates in the chain are displayed without a red cross, then the certificate chain is trusted by the computer. If the root certification authority has a red cross against it, continue to the next set of steps.

## Install the root certification authority certificate manually

To resolve this issue, install the root certification authority certificate manually. Follow the following steps:

1. Select **Start**, select **Run**, type **mmc**, and then select **OK**.
2. On the **File** menu, select **Add/Remove Snap-in**.
3. In the **Add or Remove Snap-ins dialog box**, select **Certificates** under **Available Snap-ins**, and then select **Add**.
4. In the **Certificates snap-in**, select **Computer account**, select **Finish** twice, and then select **OK**.
5. Under **Console Root**, expand **Certificates (Local Computer)**.
6. Expand **Trusted Root Certification Authorities**, and then right-click **Certificates**.
7. Select **All Tasks**, and then select **Import...**.
8. Select **Next**, and then navigate to the location where the Root CA certificate file is stored.
9. After the certificate has been selected, select **Next** two times, and then select **Finish**.

> [!NOTE]
> *Intermediate CA* certificates should be installed in the Intermediate Certification Authorities store rather than in the Trusted Roots store. Any certification authority certificate whose `Issued by` and `Issued to` values are not the same (and therefore the certificate is not at the top of the hierarchy) is known as an Intermediate CA.

## References

- [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983(v=ws.11))

- [Internet Information Services (IIS) 8 may reject client certificate requests with HTTP 403.7 or 403.16 errors](https://support.microsoft.com/help/2802568)

- [Trusted root certificates that are required by Windows](https://support.microsoft.com/help/293781)
