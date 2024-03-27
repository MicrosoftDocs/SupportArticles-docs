---
title: Security certificate validation fails
description: Works around an issue where security certificate that's presented by a website isn't issued when it has multiple trusted certification paths to root CAs.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Credential Roaming and Certificate-based authentication, csstroubleshoot
---
# Certificate validation fails when a certificate has multiple trusted certification paths to root CAs

This article provides workarounds for an issue where security certificate that's presented by a website isn't issued when it has multiple trusted certification paths to root CAs.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2831004

## Symptoms

When a user tries to access a secured website, the user receives the following warning message in the web browser:

> There is a problem with this website's security certificate.
>
> The security certificate presented by this website was not issued by a trusted certificate authority.

After the user clicks **Continue to this website (not recommended)**, the user can access the secured website.

## Cause

This issue occurs because the website certificate has multiple trusted certification paths on the web server.

For example, assume that the client computer that you're using trusts *Root certification authority (CA) certificate (2)*. And the web server trusts *Root CA certificate (1)* and *Root CA certificate (2)*. Additionally, the certificate has the following two certification paths to the trusted root CAs on the web server:

1. Certification path 1: Website certificate - Intermediate CA certificate - Root CA certificate (1)
2. Certification path 2: Website certificate - Intermediate CA certificate - Cross root CA certificate - Root CA certificate (2)

When the computer finds multiple trusted certification paths during the certificate validation process, Microsoft CryptoAPI selects the best certification path by calculating the score of each chain. A score is calculated based on the quality and quantity of the information that a certificate path can provide. If the scores for the multiple certification paths are the same, the shortest chain is selected.

When Certification path 1 and Certification path 2 have the same quality score, CryptoAPI selects the shorter path (Certification path 1) and sends the path to the client. However, the client computer can verify the certificate only by using the longer certification path that links to Root CA certificate (2). So the certificate validation fails.

## Workaround

To work around this issue, delete or disable the certificate from the certification path that you don't want to use by following these steps:

1. Log on to the web server as a system administrator.
2. Add the Certificate snap-in to Microsoft Management Console by following these steps:

    1. Click **Start** > **Run**, type **mmc**, and then press Enter.
    2. On the **File** menu, click **Add/Remove Snap-in**.
    3. Select **Certificates**, click **Add**, select **Computer account**, and then click **Next**.
    4. Select **Local computer (the computer this console is running on)**, and then click **Finish**.
    5. Click **OK**.

3. Expand **Certificates (Local Computer)** in the management console, and then locate the certificate on the certificate path that you don't want to use.

    > [!NOTE]
    > If the certificate is a root CA certificate, it is contained in **Trusted Root Certification Authorities**. If the certificate is an intermediate CA certificate, it is contained in **Intermediate Certification Authorities**.

4. Delete or disable the certificate by using one of the following methods:

   - To delete a certificate, right-click the certificate, and then click **Delete**.
   - To disable a certificate, right-click the certificate, click **Properties**, select **Disable all purposes for this certificate**, and then click **OK**.

5. Restart the server if the issue is still occurring.

Additionally, if the **Turn off Automatic Root Certificates Update** Group Policy setting is disabled or not configured on the server, the certificate from the certification path that you don't want to use may be enabled or installed when the next chain building occurs. To change the Group Policy setting, follow these steps:

1. Click **Start** > **Run**, type **gpedit.msc**, and then press Enter.

1. Expand **Computer Configuration** > **Administrative Templates** > **System** > **Internet Communication Management**, and then click **Internet Communication settings**.

1. Double-click **Turn off Automatic Root Certificates Update**, select **Enabled**, and then click **OK**.

1. Close the Local Group Policy Editor.

## Status

This behavior is by design.
