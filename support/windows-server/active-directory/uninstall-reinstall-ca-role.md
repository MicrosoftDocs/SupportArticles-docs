---
title: How to reinstall CA role
description: Describes how to uninstall and then reinstall the Certificate Authority (CA) role in Windows Server 2012 Essentials.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, AshishSu, luche, LavinK, v-jesits
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# Reinstall the CA role in Windows Server 2012 Essentials

This article describes how to uninstall and then reinstall the Certificate Authority (CA) role in Windows Server 2012 Essentials.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2795825

## Uninstall the CA server role

1. In Server Manager, click **Manage**, and then click **Remove Roles and Features**.
2. On the **Before You Begin** page, click **Next**.
3. On the **Select destination server** page, select the server in the server pool, and then click **Next**.
4. On the **Remove server roles** page, expand **Active Directory Certificate Services**, clear the **Certification Authority Web Enrollment** check box, and then click **Next**.
5. On the **Remove features** page, click **Next**.
6. On the **Confirm removal selections** page, verify the information, and then click **Remove**.
7. Click **Close** after the removal is complete.
8. Repeat steps 1 through 3.
9. On the **Remove server roles** page, click to clear the **Active Directory Certificate Services** check box.

    > [!NOTE]
    > When you are prompted to remove **Remote Server Administration Tools**, click **Remove Features**, and then click **Next**.
10. On the **Remove features** page, click **Next**.
11. On the **Confirm removal selections** page, verify the information, and then click **Remove**.
12. After the removal is complete, click **Close**, and then restart the server.

## Reinstall the CA server role

1. In Server Manager, click **Manage**, and then click **Add Roles and Features**.
2. On the **Before you begin** page, click **Next**.
3. On the **Select installation type** page, click **Role-based or feature-based installation**, and then click **Next**.
4. On the **Select destination server** page, select the server in the server pool, and then click **Next**.
5. On the **Select server roles** page, click the **Active Directory Certificate Services** role.
6. When you are prompted to install **Remote Server Administration Tools**, click **Add Features**, and then click **Next**.
7. On the **Select features** page, click **Next**.
8. On the **Active Directory Certificate Services** page, click **Next**.
9. On the **Select role services** page, select **Certification Authority** and **Certification Authority Web Enrollment**, and then click **Next**.
10. On the **Confirm installation selections** page, verify the information, and then click **Install**.
11. Wait for the installation to finish. After the installation is complete, click the **Configure Active Directory Certificate Services on the destination server** link.
12. On the **Credentials** page, click **Next**.

    > [!NOTE]
    > You can change the credentials if it is necessary.
13. On the **Role Services** page, select **Certification Authority** and **Certification Authority Web Enrollment**, and then click **Next**.
14. On the **Setup Type** page, click **Enterprise CA**, and then click **Next**.
15. On the **CA Type** page, click **Root CA**, and then click **Next**.
16. On the **Private Key** page, click **Use existing private key**, click **Select a certificate and use its associated private key**, and then click **Next**.
17. On the **Existing Certificate** page, select the **\<Server_Name>-CA** certificate, and then click **Next**.

    > [!NOTE]
    > **\<Server_Name>** is the name of the destination server.
18. On the **CA Database** page, accept the default locations, and then click **Next**.
19. On the **Confirmation** page, confirm your selections, and then click **Configure**.
20. When configuration is complete, click **Close**.

## Verify the installation

1. In Server Manager, click **Tools**, and then click **Certification Authority**.
2. Right-click the name of the CA, and then click **Properties**.
3. In the **Properties** dialog box, click the **Extensions** tab.
4. In the list that is displayed, click `http://<ServerDNSName>/CertEnroll/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`.
5. Make sure that the following options are selected:
   - **Include in CRLs. Clients use this to find Delta CRL locations.**  
   - **Include in the CDP extension of issued certificates.**  
6. Click **OK** to save your changes.
7. When you are prompted to restart Active Directory Certificate Services, click **Yes**.
8. Close the **Certification Authority** console.

## Add a certificate template to the CA

1. In Server Manager, click **Tools**, and then click **Certification Authority**.
2. Double-click the name of the CA to expand the item.
3. Right-Click **Certificate Templates**, click **New**, and then click **Certificate Template to Issue**.
4. In the list, click **Windows Server Solutions Computer Certificate Template**, and then click **OK**.
5. Close the **Certification Authority**  console.

## Add the server and clients to the Dashboard

1. Open a Command Prompt window as an administrator.
2. Type cd "\Program Files\Windows Server\Bin", and press the Enter key.
3. Type WssPowerShell.exe, and then press the Enter key.
4. Type Add-WssLocalMachineCert, and then press the Enter key.
5. Reboot the server.
6. Re-run the connector installation on all client computers.

### Bind the certificate to the Internet Information Services (IIS) websites

1. Open IIS Manager.
2. Choose all the websites that use the old machine certificates, and then replace them by using the new certificates.
