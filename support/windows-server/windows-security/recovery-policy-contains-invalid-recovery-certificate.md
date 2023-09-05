---
title: Client computers can't encrypt files in a domain
description: Describes a problem in which client computers receive an error message when the clients try to encrypt a file on a remote computer. This problem occurs if a valid recovery agent certificate is not available on the client computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, Rajsin
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# Error when client computers encrypt a file in a Windows Server 2003 domain: Recovery policy configured for this system contains invalid recovery certificate

This article provides a solution to an error that occurs when client computers encrypt a file in a Microsoft Windows Server 2003 domain.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 937536

## Symptoms

When a client computer uses the Encrypting File System (EFS) to encrypt a file that is stored on a remote computer in a Microsoft Windows Server 2003 domain, you may receive an error message on the computer that resembles the following:

> Recovery policy configured for this system contains invalid recovery certificate.

## Cause

This problem occurs if the EFS recovery policy that is implemented on the client computer contains one or more EFS recovery agent certificates that have expired. Client computers cannot encrypt any new documents until a valid recovery agent certificate is available.

## Resolution

To resolve this problem, follow these steps:

1. Log on to a domain controller by using the user account under which you want the EFS recovery agent to run.

2. Use the Windows Server 2003 version of the Cipher tool together with the `/r` switch to create a new self-signed file recovery certificate and a private key. The Cipher tool generates a new public file recovery certificate (a .cer file) and a .pfx file. Make copies of these files, and then save them to a safe location. To generate the new file recovery certificate, follow these steps:
    1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `cipher /r: file_name`, and then press ENTER.

        > [!NOTE]
        > **file_name** represents the file name that you want to use. Use a file name that is meaningful to you. Do not add an extension to the file name. Make sure that the new .cer and .pfx files are created in the same folder.
    3. When you are prompted for a password to protect the .pfx file, type a password that you will easily remember.

3. Export the old EFS recovery agent certificate. To do this, follow these steps:

    1. Log on to the domain controller by using an account that has Domain administrative credentials. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
    2. Right-click ****Domain_name****, and then click **Properties**.
    3. Click the **Group Policy** tab, click the **Default Domain Policy** Group Policy object (GPO), and then click **Edit**.
    4. Expand **Computer Configuration**, expand **Windows Settings**, Expand **Security Settings**, expand **Public Key Policies**, and then click **Encrypting File System**.
    5. Right-click the current EFS recovery agent certificate, point to **All Tasks**, and then click **Export**.
    6. Follow the instructions in the Certificate Export Wizard to export the old EFS recovery agent certificate.

        > [!NOTE]
        > Make sure that you export the old EFS recovery agent certificate together with the private key to a .cer file. Keep the new EFS recovery agent .pfx file and the old EFS recovery agent .pfx file in a safe location.

4. Right-click the old EFS recovery agent certificate, click **Delete**, and then click **Yes**.

5. Log on to the domain controller by using an account that has Domain administrative credentials, and then import the new EFS recovery agent certificate. To do this, follow these steps:
    1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
    2. Right-click **Domain_name**, and then click **Properties**.
    3. Click the **Group Policy** tab, click the **Default Domain Policy** GPO, and then click **Edit**.
    4. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Public Key Policies**, and then click **Encrypting File System**.
    5. Right-click the **Encrypting File System** folder, and then click **Add**.
    6. Click **Next** on the Add Recovery Agent Wizard, and then click **Browse Folders**.
    7. Import the new .cer file that you created in step 2b, and then click **Open**.
      > [!NOTE]
      > When you open the .cer file, you see USER_UNKNOWN in the Recovery Agents field. This message is expected. Also, you receive a warning message from the Add Recovery Agent Wizard that the certificate is not trusted.

6. Import the new .cer file that you created in step 2b to the folder: `Computer Configuration\Windows Settings\Security Settings\Public Key Policies\Trusted Root Certification Authorities`.

7. If you have multiple domain controllers, type `gpupdate /force` at a command prompt to update the Group Policy.

8. Verify that client computers can successfully encrypt files.
