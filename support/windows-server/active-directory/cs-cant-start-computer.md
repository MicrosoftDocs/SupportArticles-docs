---
title: CS can't start on a computer
description: Explains how to troubleshoot an issue when Certificate Services doesn't start on a computer that is running Windows Server 2003 or Windows 2000.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, shawnrab, v-jomcc
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# Certificate Services may not start on a computer that is running Windows Server 2003 or Windows 2000

This article provides a solution to an issue where Certificate Services(CS) may not start on a computer that is running Windows Server 2003 or Windows 2000.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 842210

## Symptoms

On a computer that is running Microsoft Windows Server 2003 or Microsoft Windows 2000 Server, Certificate Services may not start.

Additionally, the following error message may be logged in the Application log in Event Viewer.

## Cause

Before Certificate Services starts, it enumerates all the keys and certificates that have been issued to the certification authority (CA), even if the keys and the certificates have expired. Certificate Services won't start if any one of these certificates has been removed from the local computer Personal certificate store.

## Resolution

To resolve this issue, verify that the number of certificate thumbprints in the registry is equal to the number of certificates that have been issued to the CA. If any certificates are missing, import the missing certificates into the local computer Personal certificate store. After you've imported the missing certificates, use the `certutil -repairstore` command to repair the link between the imported certificates and the associated private key store.

To do it, use one of the following methods, depending on which version of the operating system your computer is running.

## Method 1: Windows Server 2003

To resolve this issue on a Windows Server 2003-based computer, follow these steps.

### Step 1: Look for missing certificates

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The certificate thumbprints indicate all the certificates that have been issued to this CA. Every time that a certificate is renewed, a new certificate thumbprint is added to the CaCertHash list in the registry. The number of entries in this list must equal the number of certificates that are issued to the CA and that are listed in the local computer Personal certificate store.

To look for missing certificates, follow these steps:

1. Select **Start**, select **Run**, type regedit, and then select **OK**.
2. Locate and then select the following subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\**Your_Certificate_Authority_Name`*  

3. In the right pane, double-click **CaCertHash**.
4. Make a note of the number of certificate thumbprints that the **Value data** list contains.
5. Start Command Prompt.
6. Type the following command, and then press **ENTER**:
    `certutil -store`

    Compare the number of certificates that are listed in the local computer Personal certificate store to the number of certificate thumbprints that are listed in the CaCertHash registry entry. If the numbers are different, go to [Step 2: Import the missing certificates](#step-2-import-the-missing-certificates). If the numbers are the same, go to [Step 3: Install the Windows Server 2003 Administration Tools Pack](#step-3-install-the-windows-server-2003-administration-tools-pack).

### Step 2: Import the missing certificates

1. Select **Start**, point to **All Programs**, point to **Administrative Tools**, and then select **Certificates**.

    If **Certificates** doesn't appear in the list, follow these steps:
      1. Select **Start**, select **Run**, type mmc, and then select **OK**.
      2. On the **File** menu, select **Add/Remove Snap-in**.
      3. Select **Add**.
      4. In the **Snap-in** list, select **Certificates**, and then select **Add**.

          If the **Certificates snap-in** dialog box appears, select **My user account**, and then select **Finish**.
      5. Select **Close**, and then select **OK**.

          The Certificates directory is now added to Microsoft Management Console (MMC).
      6. On the **File** menu, select **Save as**, type Certificates in the **File name** box, and then select **Save**.

          To open Certificates in the future, select **Start**, point to **All Programs**, point to **Administrative Tools**, and then select **Certificates**.
2. Expand **Certificates**, expand **Personal**, right-click **Certificates**, point to **All Tasks**, and then select **Import**.
3. On the **Welcome** page, select **Next**.
4. On the **File to Import** page, type the full path of the certificate file that you want to import in the **File name** box, and then select **Next**. Instead, select **Browse**, search for the file, and then select **Next**.
5. If the file that you want to import is a Personal Information Exchange - PKCS #12 (*.PFX) file, you'll be prompted for the password. Type the password, and then select **Next**.
6. On the **Certificate Store** page, select **Next**.
7. On the **Completing the Certificate Import Wizard** page, select **Finish**.

> [!NOTE]
> The CA always publishes its CA certificates to the `%systemroot%\System32\CertSvc\CertEnroll` folder. You may find the missing certificates in that folder.

### Step 3: Install the Windows Server 2003 Administration Tools Pack

After you import the certificates, you must use the Certutil tool to repair the link between the imported certificates and the associated private key store. The Certutil tool is included in the CA Certificate Tools. The Windows Server 2003 CA Certificate Tools are located in the Windows Server 2003 Administration Tools Pack. If the CA Certificate Tools aren't installed on your computer, install them now.

### Step 4: Repair the links

After you install the Windows Server 2003 Administration Tools Pack, follow these steps:

1. Start Command Prompt.
2. Type the following, and then press **ENTER**:  
    `cd %systemroot%\system32\certsrv\certenroll`

3. Make a note of the certificate in the Certenroll folder that looks similar to the following:
    **Your_Server**. **Your_Domain**.com_rootca.crt

4. Type the following commands, and then press **ENTER** after each command:
    `%systemroot%\system32\certutil -addstore my %systemroot%\system32\certsrv\certenroll\Your_Server.Your_Domain.com_rootca.crt`
    `%systemroot%\System32\certutil -dump %systemroot%\system32\certsrv\certenroll\Your_Server.Your_Domain.com_rootca.crt`
    **Your_Server.Your_Domain**.com_rootca.crt is the name of the certificate in the Certenroll folder that you noted in step 3.
5. In the output from the last command, near the end, you'll see a line that is similar to the following:  
    Key Id Hash(sha1): ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b  
    The Key Id Hash data is specific to your computer. Make a note of this line.
6. Type the following command including the quotation marks, and then press **ENTER**:  
    %systemroot%\system32\certutil -repairstore my "**Key_Id_Hash_Data**"

    In this command, `Key_Id_Hash_Data` is the line that you noted in step 4. For example, type the following:  
    %systemroot%\system32\certutil -repairstore my "**ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b**"

    You'll then receive the following output:
    > CertUtil: -repairstore command completed successfully.

7. To verify the certificates, type the following, and then press **ENTER**:  
    `%systemroot%\system32\certutil -verifykeys`
    After this command runs, you'll receive the following output:
    > CertUtil: -verifykeys command completed successfully.

### Step 5: Start the Certificate Services service

1. Select **Start**, point to **Administrative Tools**, and then select **Services**.
2. Right-click **Certificate Services**, and then select **Start**.

## Method 2: Windows 2000

To resolve this issue on a Windows 2000-based computer, follow these steps.

### Step 1: Looking for missing certificates

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The certificate thumbprints indicate all the certificates that have been issued to this CA. Every time that a certificate is renewed, a new certificate thumbprint is added to the CaCertHash list in the registry. The number of entries in this list must equal the number of certificates that are issued to the CA and that are listed in the local computer Personal certificate store.

To look for missing certificates, follow these steps:

1. Select **Start**, select **Run**, type regedit, and then select **OK**.
2. Locate and then select the following subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\**Your_Certificate_Authority_Name`*  

3. In the right pane, double-click **CaCertHash**.
4. Make a note of the number of certificate thumbprints that the **Value data** list contains.
5. Start Command Prompt.
6. Type the following, and then press **ENTER**:
    `certutil -store`

Compare the number of certificates that are listed in the local computer Personal certificate store to the number of certificate thumbprints that are listed in the CaCertHash registry entry. If the numbers are different, go to [Step 2: Import the missing certificates](#step-2-import-the-missing-certificates). If the numbers are the same, go to [Step 3: Install the Windows Server 2003 Administration Tools Pack](#step-3-install-the-windows-server-2003-administration-tools-pack).

### Step 2: Importing the missing certificates

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Certificates**.

    If Certificates doesn't appear in the list, follow these steps:
    1. Select **Start**, select **Run**, type mmc, and then select **OK**.
    2. On the **Console** menu, select **Add/Remove Snap-in**.
    3. Select **Add**  
    4. In the **Snap-in** list, select **Certificates**, and then select **Add**.

    If the **Certificates snap-in** dialog box appears, select **My user account**, and then select **Finish**.
    5. Select **Close**.
    6. Select **OK**.
    7. The Certificates directory is now added to Microsoft Management Console (MMC).
    8. On the **Console** menu, select **Save as**, type Certificates as the file name, and then select **Save**.

    To open Certificates in the future, select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Certificates**.
2. Expand **Certificates**, expand **Personal**, right-click **Certificates**, point to **All Tasks**, and then select **Import**.
3. On the **Welcome** page, select **Next**.
4. On the **File to Import** page, type the full path of the certificate file that you want to import in the **File name** box, and then select **Next**. Instead, select **Browse**, search for the file, and then select **Next**.
5. If the file that you want to import is a Personal Information Exchange - PKCS #12 (*.PFX), you'll be prompted for the password. Type the password, and then select **Next**.
6. On the **Certificate Store** page, select **Next**.
7. On the **Completing the Certificate Import Wizard** page, select **Finish**.

> [!NOTE]
> The CA always publishes its CA certificates to the `%systemroot%\System32\CertSvc\CertEnroll` folder. You may find the missing certificates in that folder.

### Step 3: Install the Windows Server 2003 Certutil tools

After you import the certificates, you must use the Windows Server 2003 CA Certificate Tools to repair the link between the imported certificates and the associated private key store.

The Windows Server 2003 versions of Certutil.exe and Certreq.exe are included in the Windows Server 2003 Administration Tools Pack. To install the tools on a Windows 2000-based computer, you must first install the Windows Server 2003 Administration Tools Pack on a computer that is running Windows Server 2003 or Microsoft Windows XP with Service Pack 1 (SP1) or with a later service pack. The Windows Server 2003 Administration Tools Pack cannot be installed directly on a Windows 2000-based computer.

> [!IMPORTANT]
> After you copy the Windows Server 2003 CA Certificate Tools to the Windows 2000-based computer, two versions of the Certutil tool will reside on the Windows 2000-based computer. Don't remove the Windows 2000 Certutil tool. Other programs depend on the Windows 2000 version of this tool. For example, the Certificates MMC snap-in requires the Windows 2000 Certutil tool. Additionally, don't register the Windows Server 2003 Certcli.dll and Certadm.dll files on the Windows 2000-based computer.

To use the Windows Server 2003 CA Certificate Tools on a Windows 2000-based computer, follow these steps:

1. Download the Windows Server 2003 Administration Tools Pack

2. Sign in to a computer that is running Windows Server 2003 or Windows XP with SP1 or with a later service pack.
3. Install the Windows Server 2003 Administration Tools Pack.
4. In the Windows Server 2003 Administration Tools Pack, locate the following files, and then copy them to a removable storage medium, such as a 3.5-inch disk:  
    Certreq.exe  
    Certutil.exe  
    Certcli.dll  
    Certadm.dll
5. Sign in to the Windows 2000-based computer as an administrator.
6. Insert the removable storage medium that you used in step 4 into the appropriate drive of the Windows 2000-based computer.
7. Start Command Prompt.
8. Make a new folder, and then copy the files on the removable storage medium to the new folder. To do it, type the following commands, and then press **ENTER** after each command:  
    cd\  
    md W2k3tool  
    cd w2k3tool  
    copy **Removable_Media_Drive_Letter**:\cert*

    > [!NOTE]
    > To avoid conflicts with the Windows 2000 versions of the Certutil tool that is already on the computer, do not include the W2k3tool folder in your system search path.

### Step 4: Repairing the links

After you've copied the Windows Server 2003 CA Certificate Tools files to the Windows 2000-based computer, follow these steps:

1. Start Command Prompt.
2. Type the following, and then press **ENTER**:  
    `cd %systemroot\system32\certsrv\certenroll`

3. Make a note of the certificate in the Certenroll folder that looks similar to the following:  
    **Your_Server.Your_Domain.com_rootca.crt**  
4. Type the following commands, and then press **ENTER** after each command:  
    **Root_Drive_Letter**:\\**w2k3tool**\certutil -addstore my %systemroot%\system32\certsrv\certenroll\ **Your_Server.Your_Domain**.com_rootca.crt  
    **Root_Drive_Letter**:\\**w2k3tool**\certutil -dump %systemroot%\system32\certsrv\certenroll\ **Your_Server.Your_Domain**.com_rootca.crt

    **Root_Drive_Letter** is the letter of the root directory.

    **Your_Server.Your_Domain**.com_rootca.crt is the name of the certificate in the Certenroll folder that you noted in step 3.
5. In the output from the last command, near the end, you'll see a line that is similar to the following:
    Key Id Hash(sha1): ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b  
    The Key Id Hash data is specific to your computer. Make a note of this line.
6. Type the following command, including the quotation marks, and then press **ENTER**:  
    **Root_Drive_Letter**:\\**w2k3tool**\certutil -repairstore my "**Key_Id_Hash_Data**"  
    In this command, `Key_Id_Hash_Data` is the line that you noted in step 5. For example, type the following:  
    c:\w2k3tool\certutil -repairstore my "**ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b**"

    After you've completed this command, you'll receive the following output:
    > CertUtil: -repairstore command completed successfully.

7. To verify the certificates, type the following command, and then press **ENTER**:  
    **Root_Drive_Letter**:\\**w2k3tool**\certutil -verifykeys

    After this command runs, you'll receive the following output:
    > CertUtil: -verifykeys command completed successfully.

### Step 5: Starting the Certificate Services service

1. Select **Start**, point to **Administrative Tools**, and then select **Services**.
2. Right-click **Certificate Services**, and then select **Start**.

## More information

You must decommission and replace the CA if one of the following conditions is true:

- You can't locate the missing certificates.
- The certificates can't be reinstalled.
- The `certutil -repairstore` command can't be completed because the private keys have been removed. To decommission and to replace the CA, follow these steps:

    1. Revoke the certificates for the CA that has stopped working correctly. To do it, follow these steps:
        1. Sign in as an administrator to the computer that issued the certificates that you want to revoke.
        2. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Certification Authority**.
        3. Expand **CA_Name**, and then select **Issued Certificates**.
        4. In the right-pane, select the certificate that you want to revoke.
        5. On the **Action** menu, point to **All Tasks**, and then select **Revoke Certificate**.
        6. In the **Reason code** list, select the reason for revoking the certificate, and then select **Yes**.

        This will revoke all the certificates that were issued by the CA that has stopped working correctly.

    2. Publish the certificate revocation list (CRL) on the next-highest CA. To do it, follow these steps:
        1. Sign in as an administrator to the computer that is running the next highest CA.
        2. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Certification Authority**.
        3. Expand **CA_Name**, and then select **Revoked Certificates**.
        4. On the **Action** menu, point to **All Tasks**, and then select **Publish**.
        5. Select **Yes** to overwrite the previously published CRL.

    3. If the CA that has stopped working correctly has been published to Active Directory directory services, remove it. To remove the CA from Active Directory, follow these steps:
        1. Start Command Prompt.
        2. Type the following, and then press **ENTER**:  
            certutil -dsdel **CA_Name**  

    4. Remove Certificate Services from the server where the CA has stopped working correctly. To do it, follow these steps:
        1. Select **Start**, point to **Settings**, and then select **Control Panel**.
        2. Double-click **Add/Remove Programs**, and then select **Add/Remove Windows Components**.
        3. In the **Components** list, click to clear the **Certificate Services** check box, select **Next**, and then select **Finish**.
    5. Install Certificate Services. To do it, follow these steps:
        1. Select **Add/Remove Windows Components**.
        2. In the **Components** list, select to select the **Certificate Services** check box, select **Next**, and then select **Finish**.
    6. All the users, the computers, or the services with certificates that were issued by the CA that has stopped working correctly must enroll for certificates from the new CA.

> [!NOTE]
> If this issue occurs on the Root CA of the public key infrastructure (PKI) hierarchy and if the issue cannot be repaired, you will have to replace the whole PKI hierarchy. For more information about how to remove the PKI hierarchy, see [How to decommission a Windows enterprise certification authority and remove all related objects](../windows-security/decommission-enterprise-certification-authority-and-remove-objects.md).
