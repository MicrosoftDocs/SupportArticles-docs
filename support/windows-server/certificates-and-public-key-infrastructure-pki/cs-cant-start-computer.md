---
title: CS can't start on a computer
description: Explains how to troubleshoot an issue when the Certificate Services service doesn't start on a computer that is running Windows Server.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shawnrab, v-jomcc, flbelea, jtierney
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Active Directory Certificate Services (ADCS), csstroubleshoot
---
# Certificate Services may not start on a computer that is running Windows Server

This article provides a solution to an issue where the Certificate Services(CS) service may not start on a computer that is running Windows Server.

_Original KB number:_ &nbsp; 842210

## Symptoms

On a computer that is running Windows Server, the Certificate Services service may not start.

Additionally, the following error message may be logged in the Application log in Event Viewer.

> Active Directory Certificate Services did not start: Could not load or verify the current CA certificate.  Contoso CA Keyset does not exist 0x80090016 (-2146893802 NTE_BAD_KEYSET).

## Cause

Before the Certificate Services service starts, it enumerates all the keys and certificates that have been issued to the certification authority (CA), even if the keys and the certificates have expired. The Certificate Services service won't start if any one of these certificates has been removed from the local computer Personal certificate store.

## Resolution

To resolve this issue, verify that the number of certificate thumbprints in the registry is equal to the number of certificates that have been issued to the CA. If any certificates are missing, import the missing certificates into the local computer Personal certificate store. After you've imported the missing certificates, use the `certutil -repairstore` command to repair the link between the imported certificates and the associated private key store.

To resolve this issue, follow these steps.

### Step 1: Look for missing certificates

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The certificate thumbprints indicate all the certificates that have been issued to this CA. Every time that a certificate is renewed, a new certificate thumbprint is added to the CaCertHash list in the registry. The number of entries in this list must equal the number of certificates that are issued to the CA and that are listed in the local computer Personal certificate store.

To look for missing certificates, follow these steps:

1. Select **Start**, type *regedit*, and then press <kbd>Enter</kbd>.
2. Locate and then select the following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\<Your_Certificate_Authority_Name>`  

3. In the right pane, double-click **CaCertHash**.
4. Make a note of the number of certificate thumbprints that the **Value data** list contains.
5. Start a command prompt.
6. Type the following command, and then press <kbd>Enter</kbd>:

   ```console
   certutil -store
   ```

    Compare the number of certificates that are listed in the local computer Personal certificate store to the number of certificate thumbprints that are listed in the CaCertHash registry entry. If the numbers are different, go to [Step 2: Import the missing certificates](#step-2-import-the-missing-certificates). If the numbers are the same, go to [Step 3: Repair the links](#step-3-repair-the-links).

### Step 2: Import the missing certificates

1. Select **Start**, type *mmc*, and then press <kbd>Enter</kbd>.
2. On the **File** menu, select **Add/Remove Snap-in**.
3. In the **Snap-in** list, select **Certificates**, and then select **Add**.
4. When the **Certificates snap-in** dialog box appears, select **Computer account**, and then select **Next** > **Finish**.
5. Select **OK**. The Certificates directory is now added to Microsoft Management Console (MMC).
6. Expand **Certificates** > **Personal**, right-click **Certificates**, point to **All Tasks**, and then select **Import**.
7. On the **Welcome** page, select **Next**.
8. On the **File to Import** page, type the full path of the certificate file that you want to import in the **File name** box, and then select **Next**. Instead, select **Browse**, search for the file, and then select **Next**.
9. If the file that you want to import is a Personal Information Exchange-PKCS #12 (*.PFX) file, you'll be prompted for the password. Type the password, select the **Mark this key as exportable** import option and then select **Next**.
10. On the **Certificate Store** page, select **Next**.
11. On the **Completing the Certificate Import Wizard** page, select **Finish**.

> [!NOTE]
> The CA publishes its CA certificates to the *%systemroot%\\System32\\CertSvc\\CertEnroll* folder by default. You may find the missing certificates in that folder.

### Step 3: Repair the links

To repair the links, follow these steps:

1. Open a command prompt.
2. Type the following command, and then press <kbd>Enter</kbd>:
  
    ```console
    cd %systemroot%\system32\certsrv\certenroll
    ```

3. Make a note of the certificate in the *certenroll* folder that looks similar to the following:

    `<Your_Server>. <Your_Domain>.com_rootca.crt`

4. Type the following commands, and then press <kbd>Enter</kbd> after each command:
   
   ```console
   certutil -addstore my %systemroot%\system32\certsrv\certenroll\Your_Server.Your_Domain.com_rootca.crt
   ```

   ```console
   certutil -dump %systemroot%\system32\certsrv\certenroll\Your_Server.Your_Domain.com_rootca.crt
   ```
   
    `<Your_Server>.<Your_Domain>.com_rootca.crt` is the name of the certificate in the *certenroll* folder that you noted in step 3.
   
5. In the output from the last command, near the end, you'll see a line that is similar to the following:
  
    `Key Id Hash(sha1): ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b`

    The `Key Id Hash` data is specific to your computer. Make a note of this line.
6. Type the following command including the quotation marks, and then press <kbd>Enter</kbd>:

    ```console 
    %systemroot%\system32\certutil -repairstore my "<Key_Id_Hash_Data>"
    ```

    In this command, `Key_Id_Hash_Data` is the line that you noted in step 5. For example, type the following:  
     `certutil -repairstore my "ea c7 7d 7e e8 cd 84 9b e8 aa 71 6d f4 b7 e5 09 d9 b6 32 1b"`

    You'll then receive the following output:

    ```output
    CertUtil: -repairstore command completed successfully.
    ```

7. To verify the certificates, type the following commands, and then press <kbd>Enter</kbd>:
  
   ```console
   certutil -verifykeys
   ```

   After this command runs, you'll receive the following output:

   ```output
   CertUtil: -verifykeys command completed successfully.
   ```

### Step 4: Start the Certificate Services service

1. Select **Start**, point to **Administrative Tools**, and then select **Services**.
2. Right-click **Certificate Services**, and then select **Start**.

## More information

You must decommission and replace the CA if one of the following conditions is true:

- You can't locate the missing certificates.
- The certificates can't be reinstalled.
- The `certutil -repairstore` command can't be completed because the private keys have been removed.

> [!NOTE]
> If this issue occurs on the Root CA of the public key infrastructure (PKI) hierarchy and if the issue cannot be repaired, you will have to replace the whole PKI hierarchy. For more information about how to remove the PKI hierarchy, see [How to decommission a Windows enterprise certification authority and remove all related objects](../windows-security/decommission-enterprise-certification-authority-and-remove-objects.md).
