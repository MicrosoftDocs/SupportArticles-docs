---
title: Install imported certificates
description: Describes how to import a Web site certificate into the certificate store of the local computer and assign the certificate to the Web site.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# How to install imported certificates on a Windows-based Web server

This article describes how to import a Web site certificate into the certificate store of the local computer and assign the certificate to the Web site.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 816794

## Install the Certificates

The Windows Internet Information Server (IIS)supports Secure Sockets Layer (SSL) communications. A whole Web site, a folder on the Web site, or a particular file that is located in a folder on the site can require a secure SSL connection. However, before the Web server can support SSL sessions, a Web site certificate must be installed.

You can use one of the following methods to install a certificate in IIS:

- Make an online request by using the IIS Web Server Certificate Wizard and install the certificate at the time of the request.
- Make an offline request by using the IIS Web Server Certificate Wizard and obtain and install the certificate later.
- Request a certificate without using the IIS Web Server Certificate Wizard.

> [!NOTE]
> If you use the second or third method, you must install the certificate manually.

To install the Web site certificate, you must complete the following tasks:

- Import the certificate into the computer's certificate store.
- Assign the installed certificate to the Web site.

## Import the certificate into the local computer store

To import the certificate into the local computer store, follow these steps:

1. On the Web server, select **Start**, and then select **Run**.
2. In the **Open** box, type mmc, and then select **OK**.
3. On the **File** menu, select **Add/Remove snap-in**.
4. In the **Add/Remove Snap-in** dialog box, select **Add**.
5. In the **Add Standalone Snap-in** dialog box, select **Certificates**, and then select **Add**.
6. In the **Certificates snap-in** dialog box, select **Computer account**, and then select **Next**.
7. In the **Select Computer** dialog box, select **Local computer: (the computer this console is running on)**, and then select **Finish**.
8. In the **Add Standalone Snap-in** dialog box, select **Close**.
9. In the **Add/Remove Snap-in** dialog box, select **OK**.
10. In the left pane of the console, double-click **Certificates (Local Computer)**.
11. Right-click **Personal**, point to **All Tasks**, and then select **Import**.
12. On the **Welcome to the Certificate Import Wizard** page, select **Next**.
13. On the **File to Import** page, select **Browse**, locate your certificate file, and then select **Next**.
14. If the certificate has a password, type the password on the **Password** page, and then select **Next**.
15. On the **Certificate Store** page, select **Place all certificates in the following store**, and then select **Next**.
16. Select **Finish**, and then select **OK** to confirm that the import was successful.

## Assign the Imported Certificate to the Web Site

1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the left pane, select your server.
3. In the right pane, double-click **Web Sites**.
4. In the right pane, right-click the Web site you want to assign the certificate to, and then select **Properties**.
5. Select **Directory Security**, and then select **Server Certificate**.
6. On the **Welcome to the Web Certificate Wizard** page, select **Next**.
7. On the **Server Certificate** page, select **Assign an existing certificate**, and then select **Next**.
8. On the **Available Certificates** page, select the installed certificate you want to assign to this Web site, and then select **Next**.
9. On the **SSL Port** page, configure the SSL port number. The default port of 443 is appropriate for most situations.
10. Select **Next**.
11. On the **Certificate Summary** page, review the information about the certificate, and then select **Next**.
12. On the **Completing the Web Server Certificate Wizard** page, select **Finish**, and then select **OK**.

You can now configure Web site elements to use secure communications.
