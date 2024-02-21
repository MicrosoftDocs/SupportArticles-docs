---
title: Decommission a Windows enterprise CA
description: Provides step-by-step instructions for removing a CA from Windows Server 2012 R2.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lanaef, alrad, ckinder
ms.custom: sap:active-directory-certificate-services-adcs, csstroubleshoot
---
# How to decommission a Windows enterprise certification authority and remove all related objects

This step-by-step article describes how to decommission a Microsoft Windows enterprise CA, and how to remove all related objects from the Active Directory directory service.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 889250

## Summary

When you uninstall a certification authority (CA), the certificates that were issued by the CA are typically still outstanding. If the outstanding certificates are processed by the various Public Key Infrastructure client computers, validation will fail, and those certificates will not be used.

This article describes how to revoke outstanding certificates and how to complete various other tasks that are required to successfully uninstall a CA. Additionally, this article describes several utilities that you can use to help you remove CA objects from your domain.

## Step 1 - Revoke all active certificates that are issued by the enterprise CA

1. Select **Start**, point to **Administrative Tools**, and then select **Certification Authority**.
2. Expand your CA, and then select the Issued Certificates folder.
3. In the right pane, select one of the issued certificates, and then press CTRL+A to select all issued certificates.
4. Right-click the selected certificates, select **All Tasks**, and then select **Revoke Certificate**.
5. In the **Certificate Revocation** dialog box, select **Cease of Operation** as the reason for revocation, and then select **OK**.

## Step 2 - Increase the CRL publication interval

1. In the Certification Authority Microsoft Management Console (MMC) snap-in, right-click the **Revoked Certificates** folder, and then select **Properties**.
2. In the **CRL Publication Interval** box, type a suitably long value, and then select **OK**.

> [!NOTE]
> The lifetime of the Certificate Revocation List (CRL) should be longer than the lifetime that remains for certificates that have been revoked.

## Step 3 - Publish a new CRL

1. In the Certification Authority MMC snap-in, right-click the Revoked Certificates folder.
2. Select **All Tasks**, and then select **Publish**.
3. In the **Publish CRL** dialog box, select **New CRL**, and then select **OK**.

## Step 4 - Deny any pending requests

By default, an enterprise CA does not store certificate requests. However, an administrator can change this default behavior. To deny any pending certificate requests, follow these steps:

1. In the Certification Authority MMC snap-in, select the Pending Requests folder.
2. In the right pane, select one of the pending requests, and then press CTRL+A to select all pending certificates.
3. Right-click the selected requests, select **All Tasks**, and then select **Deny Request**.

## Step 5 - Uninstall Certificate Services from the server

1. To stop Certificate Services, select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. At the command prompt, type *certutil -shutdown*, and then press Enter.
3. At the command prompt, type *certutil -getreg CA\CSP\Provider*, and then press Enter. Note the **Provider** value in the output. For example:

   ```output
   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\Fabrikam Root CA1 G2\csp:

     Provider REG_SZ = Microsoft Software Key Storage Provider
   CertUtil: -getreg command completed successfully.
   ```
  
   If the value is **Microsoft Strong Cryptographic Provider**, or **Microsoft Enhanced Cryptographic Provider v1.0**, type *CertUtil -Key* and press Enter.  
   If the value is **Microsoft Software Key Storage Provider**, type *CertUtil -CSP KSP -Key* and press Enter.  
   If the value is something else, type *CertUtil -CSP \<PROVIDER NAME\> -Key* and press Enter.

   This command will display the names of all the installed cryptographic service providers (CSP) and the key stores that are associated with each provider. Listed among the listed key stores will be the name of your CA. The name will be listed several times, as shown in the following example:

    > (1)Microsoft Base Cryptographic Provider v1.0:  
     1a3b2f44-2540-408b-8867-51bd6b6ed413  
     MS IIS DCOM ClientSYSTEMS-1-5-18  
     MS IIS DCOM Server  
     Windows2000 Enterprise Root CA  
     MS IIS DCOM  ClientAdministratorS-1-5-21-436374069-839522115-1060284298-500
    >
    > afd1bc0a-a93c-4a31-8056-c0b9ca632896  
     Microsoft Internet Information Server  
     NetMon  
     MS IIS DCOM   ClientAdministratorS-1-5-21-842925246-1715567821-839522115-500
    >
    > (5)Microsoft Enhanced Cryptographic Provider v1.0:  
     1a3b2f44-2540-408b-8867-51bd6b6ed413  
     MS IIS DCOM ClientSYSTEMS-1-5-18  
     MS IIS DCOM Server  
     Windows2000 Enterprise Root CA  
     MS IIS DCOM   ClientAdministratorS-1-5-21-436374069-839522115-1060284298-500
    >
    > afd1bc0a-a93c-4a31-8056-c0b9ca632896  
     Microsoft Internet Information Server  
     NetMon  
     MS IIS DCOM ClientAdministratorS-1-5-21-842925246-1715567821-839522115-500

4. Delete the private key that is associated with the CA. To do this, at a command prompt, type the following command, and then press Enter:

    ```console
    certutil -delkey CertificateAuthorityName
    ```

    > [!NOTE]
    > If your CA name contains spaces, enclose the name in quotation marks.

    In this example, the certificate authority name is **Windows2000 Enterprise Root CA**. Therefore, the command line in this example is as follows:

    ```console
    certutil -delkey "Windows2000 Enterprise Root CA"
    ```

5. List the key stores again to verify that the private key for your CA was deleted.
6. After you delete the private key for your CA, uninstall Certificate Services. To do this, follow these steps, depending on the version of Windows Server that you are running.

   If you are uninstalling an enterprise CA, membership in Enterprise Admins, or the equivalent, is the minimum that is required to complete this procedure. For more information, see [Implement Role-Based Administration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732590(v=ws.11)).

   To uninstall a CA, follow these steps:

   1. Select **Start**, point to **Administrative Tools**, and then select **Server Manager**.
   2. Under **Roles Summary**, select **Remove Roles** to start the Remove Roles Wizard, and then select **Next**.
   3. Select to clear the **Active Directory Certificate Services** check box, and then select **Next**.
   4. On the **Confirm Removal Options** page, review the information, and then select **Remove**.
   5. If Internet Information Services (IIS) is running and you are prompted to stop the service before you continue with the uninstall process, select **OK**.
   6. After the Remove Roles Wizard is finished, restart the server. This completes the uninstall process.

   The procedure is slightly different if you have multiple Active Directory Certificate Services (AD CS) role services installed on a single server. To uninstall a CA but keep other AD CS role services, follow these steps.

    > [!NOTE]
    > You must log on with the same permissions as the user who installed the CA to complete this procedure. If you are uninstalling an enterprise CA, membership in Enterprise Admins, or the equivalent, is the minimum that is required to complete this procedure. For more information, see [Implement Role-Based Administration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732590(v=ws.11)).

    1. Select **Start**, point to **Administrative Tools**, and then select **Server Manager**.
    2. Under **Roles Summary**, select **Active Directory Certificate Services**.
    3. Under **Roles Services**, select **Remove Role Services**.
    4. Select to clear the **Certification Authority** check box, and then select **Next**.
    5. On the **Confirm Removal Options** page, review the information, and then select **Remove**.
    6. If IIS is running and you are prompted to stop the service before you continue with the uninstall process, select **OK**.
    7. After the Remove Roles Wizard is finished, you must restart the server. This completes the uninstall process.

    If the remaining role services, such as the Online Responder service, were configured to use data from the uninstalled CA, you must reconfigure these services to support a different CA. After a CA is uninstalled, the following information is left on the server:

      - The CA database.
      - The CA public and private keys.
      - The CA's certificates in the Personal store.
      - The CA's certificates in the shared folder, if a shared folder was specified during AD CS setup.
      - The CA chain's root certificate in the Trusted Root Certification Authorities store.
      - The CA chain's intermediate certificates in the Intermediate Certification Authorities store.
      - The CA's CRL.

    By default, this information is kept on the server in case you are uninstalling and then reinstalling the CA. For example, you might uninstall and reinstall the CA if you want to change a stand-alone CA to an enterprise CA.

## Step 6 - Remove CA objects from Active Directory

When Microsoft Certificate Services is installed on a server that is a member of a domain, several objects are created in the configuration container in Active Directory.

These objects are as follows:

- certificateAuthority object
  - Located in CN=AIA,CN=Public Key Services,CN=Services,CN=Configuration,DC=ForestRootDomain.
  - Contains the CA certificate for the CA.
  - Published Authority Information Access (AIA) location.

- crlDistributionPoint object
  - Located in CN=ServerName,CN=CDP,CN=Public Key Service,CN=Services,CN=Configuration,DC=ForestRoot,DC=com.
  - Contains the CRL periodically published by the CA.
  - Published CRL Distribution Point (CDP) location.

- certificationAuthority object
  - Located in CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=ForestRoot,DC=com.
  - Contains the CA certificate for the CA.

- pKIEnrollmentService object
  - Located in CN=Enrollment Services,CN=Public Key Services,CN=Services,CN=Configuration,DC=ForestRoot,DC=com.
  - Created by the enterprise CA.
  - Contains information about the types of certificates the CA has been configured to issue. Permissions on this object can control which security principals can enroll against this CA.

When the CA is uninstalled, only the pKIEnrollmentService object is removed. This prevents clients from trying to enroll against the decommissioned CA. The other objects are retained because certificates that are issued by the CA are probably still outstanding. These certificates must be revoked by following the procedure in the [Step 1 - Revoke all active certificates that are issued by the enterprise CA](#step-1---revoke-all-active-certificates-that-are-issued-by-the-enterprise-ca) section.

For Public Key Infrastructure (PKI) client computers to successfully process these outstanding certificates, the computers must locate the Authority Information Access (AIA) and CRL distribution point paths in Active Directory. It is a good idea to revoke all outstanding certificates, extend the lifetime of the CRL, and publish the CRL in Active Directory. If the outstanding certificates are processed by the various PKI clients, validation will fail, and those certificates will not be used.

If it is not a priority to maintain the CRL distribution point and AIA in Active Directory, you can remove these objects. Do not remove these objects if you expect to process one or more of the formerly active digital certificates.

### Remove all Certification Services objects from Active Directory

> [!NOTE]
> You should not remove certificate templates from Active Directory until after you remove all CA objects in the Active Directory forest.

To remove all Certification Services objects from Active Directory, follow these steps:

1. Determine the CACommonName of the CA. To do this, follow these steps:
    1. Select **Start**, select **Run**, type *cmd* in the **Open** box, and then select **OK**.
    2. Type *certutil*, and then press ENTER.
    3. Make a note of the **Name** value that belongs to your CA. You will need the CACommonName for later steps in this procedure.

2. Select **Start**, point to **Administrative Tools**, and then select **Active Directory Sites and Services**.
3. On the **View** menu, select **Show Services Node**.
4. Expand **Services**, expand **Public Key Services**, and then select the AIA folder.
5. In the right pane, right-click the **CertificationAuthority** object for your CA, select **Delete**, and then select **Yes**.
6. In the left pane of the Active Directory Sites and Services MMC snap-in, select the CDP folder.
7. In the right pane, locate the container object for the server where Certificate Services is installed. Right-click the container, select **Delete**, and then select **Yes** two times.
8. In the left pane of the Active Directory Sites and Services MMC snap-in, select the **Certification Authorities** node.
9. In the right pane, right-click the **CertificationAuthority** object for your CA, select **Delete**, and then select **Yes**.
10. In the left pane of the Active Directory Sites and Services MMC snap-in, select the **Enrollment Services** node.

11. In the right pane, verify that the **pKIEnrollmentService** object for your CA was removed when Certificate Services was uninstalled. If the object is not deleted, right-click the object, select **Delete**, and then select **Yes**.

12. If you did not locate all the objects, some objects may be left in the Active Directory after you perform these steps. To clean up after a CA that may have left objects in Active Directory, follow these steps to determine whether any AD objects remain:
    1. Type the following command at a command line, and then press ENTER:

        ```console
        ldifde -r "cn= CACommonName" -d "CN=Public Key Services,CN=Services,CN=Configuration,DC= ForestRoot,DC=com" -f output.ldf
        ```

        In this command, **CACommonName** represents the **Name** value that you determined in step 1. For example, if the **Name** value is CA1 Contoso, type the following:

        ```console
        ldifde -r "cn=CA1 Contoso" -d "cn=public key services,cn=services,cn=configuration,dc=contoso,dc=com" -f remainingCAobjects.ldf
        ```

    2. Open the *remainingCAobjects.ldf* file in Notepad. Replace the term **changetype: add** with **changetype: delete**. Then, verify whether the Active Directory objects that you will delete are legitimate.

    3. At a command prompt, type the following command, and then press ENTER to delete the remaining CA objects from Active Directory:

        ```console
        ldifde -i -f remainingCAobjects.ldf
        ```

13. Delete the certificate templates if you are sure that all of the certificate authorities have been deleted. Repeat step 12 to determine whether any AD objects remain.

    > [!IMPORTANT]
    > You must not delete the certificate templates unless all the certificate authorities have been deleted. If the templates are accidentally deleted, follow these steps:

    1. Make sure that you are logged on to a server that is running Certificate Services as Enterprise administrator.
    2. At a command prompt, type the following command, and then press ENTER:

        ```console
        cd %windir%\system32
        ```

    3. Type the following command, and then press ENTER:

        ```console
        regsvr32 /i:i /n /s certcli.dll
        ```

        This action re-creates the certificate templates in Active Directory.

    To delete the certificate templates, follow these steps.
    1. In the left pane of the **Active Directory Sites and Services** MMC snap-in, select the Certificate Templates folder.
    2. In the right pane, select a certificate template, and then press Ctrl+A to select all templates. Right-click the selected templates, select **Delete**, and then select **Yes**.

## Step 7 - Delete certificates published to the NtAuthCertificates object

After you delete the CA objects, you have to delete the CA certificates that are published to the `NtAuthCertificates` object. Use either of the following commands to delete certificates from within the `NTAuthCertificates` store:

```console
certutil -viewdelstore " ldap:///CN=NtAuthCertificates,CN=Public Key
Services,...,DC=ForestRoot,DC=com?cACertificate?base?objectclass=certificationAuthority"
```

```console
certutil -viewdelstore " ldap:///CN=NtAuthCertificates,CN=Public Key
Services,...,DC=ForestRoot,DC=com?cACertificate?base?objectclass=pKIEnrollmentService"
```

> [!NOTE]
> You must have Enterprise Administrator permissions to perform this task.

The `-viewdelstore` action invokes the certificate selection UI on the set of certificates in the specified attribute. You can view the certificate details. You can cancel out of the selection dialog to make no changes. If you select a certificate, that certificate is deleted when the UI closes and the command is fully executed.

Use the following command to see the full LDAP path to the NtAuthCertificates object in your Active Directory:

```console
certutil -viewdelstore -? | findstr "CN=NTAuth"
```

## Step 8 - Delete the CA database

When Certification Services is uninstalled, the CA database is left intact so that the CA can be re-created on another server.

To remove the CA database, delete the *%systemroot%\System32\Certlog* folder.

## Step 9 - Clean up domain controllers

After the CA is uninstalled, the certificates that were issued to domain controllers must be removed.

To remove certificates that were issued to the Windows Server 2000 domain controllers, use the Dsstore.exe utility from the Microsoft Windows 2000 Resource Kit.

To remove certificates that have been issued to the Windows Server 2000 domain controllers, follow these steps:

1. Select **Start**, select **Run**, type *cmd*, and then press ENTER.
2. On a domain controller, type *dsstore -dcmon* at the command prompt, and then press ENTER.
3. Type *3*, and then press ENTER. This action deletes all certificates on all domain controllers.

    > [!NOTE]
    > The Dsstore.exe utility will try to validate domain controller certificates that are issued to each domain controller. Certificates that do not validate are removed from their respective domain controller.

To remove certificates that were issued to the Windows Server 2003 domain controllers, follow these steps.

> [!IMPORTANT]
> Do not use this procedure if you are using certificates that are based on version 1 domain controller templates.

1. Select **Start**, select **Run**, type *cmd*, and then press ENTER.
2. At the command prompt on a domain controller, type *certutil -dcinfo deleteBad*.

    Certutil.exe tries to validate all the DC certificates that are issued to the domain controllers. Certificates that do not validate are removed.

To force application of the security policy, follow these steps:

1. Select **Start**, select **Run**, type *cmd* in the **Open** box, and then press ENTER.
2. At a command prompt, type the appropriate command for the corresponding version of the operating system, and then press ENTER:
   - For Windows Server 2000:

     ```console
     secedit /refreshpolicy machine_policy /enforce
     ```

   - For Windows Server 2003:

     ```console
     gpupdate /force
     ```
