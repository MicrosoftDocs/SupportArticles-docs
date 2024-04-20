---
title: Back up recovery agent EFS private key
description: Describes how to back up the recovery agent Encrypting File System (EFS) private key in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Active Directory Certificate Services (ADCS), csstroubleshoot
---
# Back up the recovery agent Encrypting File System (EFS) private key in Windows

This article describes how to back up the recovery agent Encrypting File System (EFS) private key on a computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 241201

## Summary

Use the recovery agent's private key to recover data in situations when the copy of the EFS private key that is located on the local computer is lost. This article contains information about how to use the Certificate Export Wizard to export the recover agent's private key from a computer that is a member of a workgroup, and from a Windows Server 2003-based, Windows 2000-based, Windows Server 2008-based or Windows Server 2008 R2-based domain controller.

## Introduction

This article describes how to back up the recovery agent Encrypting File System (EFS) private key in Windows Server 2003, in Windows 2000, in Windows XP, in Windows Vista, in Windows 7, in Windows Server 2008, and in Windows Server 2008 R2. You can use the recovery agent's private key to recover data in situations when the copy of the EFS private key that is located on the local computer is lost.

You can use EFS to encrypt data files to prevent unauthorized access. EFS uses an encryption key that is dynamically generated to encrypt the file. The File Encryption Key (FEK) is encrypted with the EFS public key and is added to the file as an EFS attribute that is named Data Decryption Field (DDF). To decrypt the FEK, you must have the corresponding EFS private key from the public-private key pair. After you decrypt the FEK, you can use the FEK to decrypt the file.

If your EFS private key is lost, you can use a recovery agent to recover encrypted files. Every time that a file is encrypted, the FEK is also encrypted with the Recovery Agent's public key. The encrypted FEK is attached to the file with the copy that is encrypted with your EFS public key in the Data Recovery Field (DRF). If you use the recovery agent's private key, you can decrypt the FEK, and then decrypt the file.

By default, if a computer that is running Microsoft Windows 2000 Professional is a member of a workgroup or is a member of a Microsoft Windows NT 4.0 domain, the local administrator who first logs on to the computer is designated as the default recovery agent. By default, if a computer that is running Windows XP or Windows 2000 is a member of a Windows Server 2003 domain or a Windows 2000 domain, the built-in Administrator account on the first domain controller in the domain is designated as the default recovery agent.

A computer that is running Windows XP and that is a member of a workgroup does not have a default recovery agent. You have to manually create a local recovery agent.

> [!IMPORTANT]
> After you export the private key to a floppy disk or other removable media , store the floppy disk or media in a secure location. If someone gains access to your EFS private key, that person can gain access to your encrypted data.

### Export the recovery agent's private key from a computer that is a member of a workgroup

To export the recovery agent's private key from a computer that is a member of a workgroup, follow these steps:

1. Log on to the computer by using the recovery agent's local user account.
2. Click Start, click Run, type mmc, and then click OK.
3. On the **File** menu, click **Add/Remove Snap-in**. Then click **Add** in Windows Server 2003, in Windows XP or in Windows 2000. Or click **OK** in Windows Vista, in Windows 7, in Windows Server 2008 or in Windows Server 2008 R2.
4. Under **Available Standalone Snap-ins**, click
 **Certificates**, and then click **Add**.
5. Click **My user account**, and then click
 **Finish**.
6. Click **Close**, and then click **OK** in Windows Server 2003, in Windows XP or in Windows 2000. Or click **OK** in Windows Vista, in Windows 7, in Windows Server 2008 or in Windows Server 2008 R2.

7. Double-click **Certificates - Current User**, double-click **Personal**, and then double-click
 **Certificates**.
8. Locate the certificate that displays the words "File Recovery" (without the quotation marks) in the **Intended Purposes** column.
9. Right-click the certificate that you located in step 8, point to **All Tasks**, and then click **Export**. The Certificate Export Wizard starts.
10. Click **Next**.
11. Click **Yes, export the private key**, and then click **Next**.
12. Click **Personal Information Exchange - PKCS #12 (.PFX).**  

    > [!NOTE]
    > We strongly recommend that you also click to select the
     **Enable strong protection (requires IE 5.0, NT 4.0 SP4 or above** check box to protect your private key from unauthorized access.

    If you click to select the **Delete the private key if the export is successful** check box, the private key is removed from the computer and you will not be able to decrypt any encrypted files.  
13. Click **Next**.  
14. Specify a password, and then click **Next**.
15. Specify a file name and location where you want to export the certificate and the private key, and then click
 **Next**.

    > [!NOTE]
    > We recommend that you back up the file to a disk or to a removable media device, and then store the backup in a location where you can confirm the physical security of the backup.  

16. Verify the settings that are displayed on the Completing the Certificate Export Wizard page, and then click **Finish**.

### Export the domain recovery agent's private key

The first domain controller in a domain contains the built-in Administrator profile that contains the public certificate and the private key for the default recovery agent of the domain. The public certificate is imported to the Default Domain Policy and is applied to domain clients by using Group Policy. If the Administrator profile or if the first domain controller is no longer available, the private key that is used to decrypt the encrypted files is lost, and files cannot be recovered through that recovery agent.

To locate the Encrypted Data Recovery policy, open the Default Domain Policy in the Group Policy Object Editor snap-in, expand **Computer Configuration**, expand **Windows Settings**, expand
 **Security Settings**, and then expand **Public Key Policies**.

To export the domain recovery agent's private key, follow these steps:

1. Locate the first domain controller that was promoted in the domain.
2. Log on to the domain controller by using the built-in Administrator account.
3. Click Start, click Run, type mmc, and then click OK.
4. On the **File** menu, click **Add/Remove Snap-in**. Then click **Add** in Windows Server 2003 or in Windows 2000. Or click **OK** in Windows Server 2008 or in Windows Server 2008 R2.
5. Under **Available Standalone Snap-ins**, click
 **Certificates**, and then click **Add**.
6. Click **My user account**, and then click
 **Finish**.
7. Click **Close**, and then click **OK** in Windows Server 2003 or in Windows 2000. Or click **OK** in Windows Server 2008 or in Windows Server 2008 R2.
8. Double-click **Certificates - Current User**, double-click **Personal**, and then double-click
 **Certificates**.
9. Locate the certificate that displays the words "File Recovery" (without the quotation marks) in the **Intended Purposes** column.
10. Right-click the certificate that you located in step 9, point to **All Tasks**, and then click **Export**. The Certificate Export Wizard starts.
11. Click **Next**.
12. Click **Yes, export the private key**, and then click **Next**.
13. Click **Personal Information Exchange - PKCS #12 (.PFX).**  

    > [!NOTE]
    > We strongly recommend that you click to select the **Enable strong protection (requires IE 5.0, NT 4.0 SP4 or above** check box to protect your private key from unauthorized access.

    If you click to select the **Delete the private key if the export is successful** check box, the private key is removed from the domain controller. As a best practice, we recommend that you use this option. Install the recovery agent's private key only in situations when you need it to recover files. At all other times, export, and then store the recovery agent's private key offline to help maintain its security.  
14. Click **Next**.
15. Specify a password, and then click **Next**.

16. Specify a file name and location where you want to export the certificate and the private key, and then click
 **Next**.

    > [!NOTE]
    > We recommend that you back up the file to a disk or to a removable media device, and then store the backup in a location where you can confirm the physical security of the backup.  
17. Verify the settings that are displayed on the Completing the Certificate Export Wizard page, and then click **Finish**.
