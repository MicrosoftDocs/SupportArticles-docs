---
title: Troubleshoot LDAP over SSL connection problems
description: Describes how to troubleshoot connection problems that involve LDAP over SSL (LDAPS).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# Troubleshoot LDAP over SSL connection problems

This article discusses steps about how to troubleshoot LDAP over SSL (LDAPS) connection problems.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 938703

## Step 1: Verify the Server Authentication certificate

Make sure that the Server Authentication certificate that you use meets the following requirements:

- The Active Directory fully qualified domain name of the domain controller appears in one of the following locations:
  
  - The common name (CN) in the **Subject** field.
  - The Subject Alternative Name (SAN) extension in the DNS entry.

- The enhanced key usage extension includes the Server Authentication object identifier (1.3.6.1.5.5.7.3.1).

- The associated private key is available on the domain controller. To verify that the key is available, use the `certutil -verifykeys` command.

- The certificate chain is valid on the client computer. To determine whether the certificate is valid, follow these steps:

    1. On the domain controller, use the Certificates snap-in to export the SSL certificate to a file that is named *Serverssl.cer*.
    2. Copy the Serverssl.cer file to the client computer.
    3. On the client computer, open a Command Prompt window.
    4. At the command prompt, type the following command to send the command output to a file that is named *Output.txt*:

        ```console
        certutil -v -urlfetch -verify serverssl.cer > output.txt
        ```

       > [!NOTE]
       > To follow this step, you must have the Certutil command-line tool installed.

    5. Open the Output.txt file, and then search for errors.

## Step 2: Verify the Client Authentication certificate

In some cases, LDAPS uses a Client Authentication certificate if it is available on the client computer. If such a certificate is available, make sure that the certificate meets the following requirements:

- The enhanced key usage extension includes the Client Authentication object identifier (1.3.6.1.5.5.7.3.2).

- The associated private key is available on the client computer. To verify that the key is available, use the `certutil -verifykeys` command.

- The certificate chain is valid on the domain controller. To determine whether the certificate is valid, follow these steps:

  1. On the client computer, use the Certificates snap-in to export the SSL certificate to a file that is named *Clientssl.cer*.
  2. Copy the Clientssl.cer file to the server.
  3. On the server, open a Command Prompt window.
  4. At the command prompt, type the following command to send the command output to a file that is named *Outputclient.txt*:

     ```console
     certutil -v -urlfetch -verify serverssl.cer > outputclient.txt
     ```

  5. Open the Outputclient.txt file, and then search for errors.

## Step 3: Check for multiple SSL certificates

Determine whether multiple SSL certificates meet the requirements that are described in [step 1](#step-1-verify-the-server-authentication-certificate). Schannel (the Microsoft SSL provider) selects the first valid certificate that Schannel finds in the Local Computer store. If multiple valid certificates are available in the Local Computer store, Schannel may not select the correct certificate. A conflict with a certification authority (CA) certificate may occur if the CA is installed on a domain controller that you are trying to access through LDAPS.

## Step 4: Verify the LDAPS connection on the server

Use the Ldp.exe tool on the domain controller to try to connect to the server by using port 636. If you cannot connect to the server by using port 636, see the errors that Ldp.exe generates. Also, view the Event Viewer logs to find errors. For more information about how to use Ldp.exe to connect to port 636, see [How to enable LDAP over SSL with a third-party certification authority](https://support.microsoft.com/help/321051).

## Step 5: Enable Schannel logging

Enable Schannel event logging on the server and on the client computer. For more information about how to enable Schannel event logging, see [How to enable Schannel event logging in Windows and Windows Server](https://support.microsoft.com/help/260729).

> [!NOTE]
> If you have to perform SSL debugging on a computer that is running Microsoft Windows NT 4.0, you must use a Schannel.dll file for the installed Windows NT 4.0 service pack and then connect a debugger to the computer. Schannel logging only sends output to a debugger in Windows NT 4.0.
