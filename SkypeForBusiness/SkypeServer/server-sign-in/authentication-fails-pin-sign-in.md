---
title: Authentication fails during PIN sign-in
description: Describes an issue that prevents the Lync Phone Edition PIN authentication process from working correctly. Occurs when a mismatched Trusted Root Certificate Authorities certificate chain is installed on the Lync Server front-end server role.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: jefzhang
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Phone Edition
ms.date: 03/31/2022
---

# Authentication fails during Lync Phone Edition PIN sign-in

## Symptoms

A user tries to sign in to a Lync Phone Edition (PE) device by correctly entering the PIN. However, the user is repeatedly prompted to enter the correct PIN. Therefore, the user can't sign in to the Lync PE device.

Additionally, the Lync Server event log on the Lync Server Front End (FE) server that's the registrar for the Lync PE device displays the following error events:

```output
Log Name: Lync Server
Source: LS UserPin Service
Date: mm/dd/yyyy hh:mm:ss AM|PM
Event ID: 47067
Task Category: (1044)
Level: Error
Keywords: Classic
User: N/A
Computer: server01.contoso.com
Description:
A server did not respond to HTTP request
Server Pool1.domain.com did not respond to HTTP request GetEncryptionKeyRequest targeted at [https://Pool1.contoso.com:444/LiveServer/UserPinService](https://pool1.domain.com:444/liveserver/userpinservice)
Cause:
Server might be down or the network path between servers might not be properly configured.
Resolution:
Please ensure that the server can be connected on the target port using telnet and then re-try.
```

```output
Log Name: Lync Server
Source: LS UserPin Service
Date: mm/dd/yyyy hh:mm:ss AM|PM
Event ID: 47067
Task Category: (1044)
Level: Error
Keywords: Classic
User: N/A
Computer: server01.contoso.com
Description:
A server did not respond to HTTP request
Server Pool1.domain.com did not respond to HTTP request GetPublishedCertRequest targeted at [https://Pool1.contoso.com:444/LiveServer/UserPinService](https://pool1.domain.com:444/liveserver/userpinservice).
Cause: 
Server might be down or the network path between servers might not be properly configured.
Resolution:
Please ensure that the server can be connected on the target port using telnet and then re-try.
```

## Cause

This problem occurs if the Windows server that's hosting the Lync Server FE services has an additional Trusted Root Certification Authorities certificate chain installed that does not match the Server certificate that's assigned to the Lync Server FE services. This certificate chain may consist of Trusted Root Certification Authorities certificates and Intermediate Certification Authorities certificates.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for the operating system that you're running.

**Windows Server 2012**

1. Press the Windows function key to open the Start screen.   
2. Double-click the Lync Server Deployment Wizard icon to start it.   
3. Type mmc.exe into the desktop search feature, and then press Enter.   
4. Right-click the mmc.exe shortcut to open a new instance of Microsoft Management Console as an administrator.   

**Windows Server 2008**

1. Click **Start**, point to **All Programs**, and then click the **Lync Server Deployment Wizard** option.   
2. Click **Start**, and then type mmc.exe.   
3. Right-click the mmc.exe shortcut to open a new instance of Microsoft Management Console as an administrator.   

**Using the Lync Server Deployment Wizard**

To locate the matched Trusted Root Certification Authorities certificate and each Intermediate Certification Authorities certificate, follow these steps:

1. Click the **Install or Update Lync Server System** link.   
2. Locate the **Request, Install, or Assign Certificates** link, and then click **Run Again**.   
3. Select the Lync Server certificate that's assigned to the Lync Server FE server.   
4. Click the **View certificate details** link.   
5. Click the **Certificate Path** tab to view the Trusted Root Certification Authorities certificate chain.   
6. Select the Trusted Root Certification Authorities certificate at the top of the chain.   
7. Click **View certificate**, and then click the **Details** tab:
   - Locate the certificate's Issuer attribute, and note the certificate's Issuer name for future reference.   
   - Locate the certificate's Serial Number attribute, and note the certificate's serial number for future reference.   
   
8. Click **OK** to return to the **Certificate Path** tab   

Separately select each Intermediate Certification Authorities certificate that's listed under the Trusted Root Certification Authorities certificate, and repeat steps 7–8.

> [!NOTE]
> The Server certificate is the last certificate that's displayed on the certificate path. Do not perform either the preceding steps or the following steps on the Server certificate.

**Using Microsoft Management Console**

To export and remove any mismatched Trusted Root Certification Authorities certificates, follow these steps:

1. On the **File** menu, click **Add/Remove Snap-In**.   
2. In the **Available Snap-Ins** list, click **Certificates**, and then click **Add**.   
3. Select the **Computer account** option, and then click **Next**.   
4. Select the **Local computer** option, click **Finish**, and then click **OK**.   
5. Expand the **Certificates (Local Computer)** node.   
6. Expand the **Trusted Root Certification Authorities** node.   
7. Select the Certificates folder to view the list of Trusted Root Certification Authorities certificates in the details pane.   
8. In the **Issued by** column in the **Details** pane, locate the Trusted Root Certification Authorities certificate (or certificates) that you noted in step 7 of the "Using the Lync Server Deployment Wizard" section. 

    > [!NOTE]
    > If the specified Trusted Root Certification Authorities certificate is listed two or more times in the **Issued By** column in the **Details** pane, continue with the remaining steps in this section. However, if the Trusted Root Certification Authorities certificate is listed just one time in the Issued By column, the remaining steps in this section will not resolve the issue that's described in the "Symptoms" section. Therefore, do not continue with the following steps.

9. Double-click the Trusted Root Certification Authorities certificate to open it.   
10. Click the **Details** tab.   
11. Compare the **Serial number** and **Valid from** attributes to the information that you noted in step 7 of the "Using the Lync Server Deployment Wizard" section.

    > [!NOTE]
    > If the **Serial number** and **Valid from** attributes match the recorded values, this certificate should not be removed from the local computer's Trusted Root Certification Authorities certificate store. Use steps 9–11 listed in the current section to locate a certificate that has mismatched **Serial number** and **Valid from** attributes. If the **Serial number** and **Valid from** attributes do not match the recorded values, this certificate will have to be first exported to a folder and then deleted from the local computer's Trusted Root Certification Authorities certificates store.

12. Right-click the mismatched certificate, click **All Tasks**, and then click **Export**.   
13. Click **Next** in the Certificates Export Wizard.   
14. Use the default DER-encoded binary X.509 (.cer) option, and then click **Next**.   
15. Browse to the folder that contains the copy of the certificate, and then type a meaningful name for the .cer file.   
16. Click **Save**, and then confirm the file save information.   
17. Click **Next**, and then click **Finish** to complete the export of the certificate file.   
18. Right-click the mismatched certificate, and then click **Delete**.   
19. Read the warning information, make sure that you're deleting the intended certificate, and then click **OK**.   
20. Repeat steps 9–20 to delete all the mismatched Trusted Root Certification Authorities certificates.   

To export and remove any mismatched Intermediate Certification Authorities certificates, follow these steps:

1. On the **File** menu, click **Add/Remove Snap-In**.   
2. In the **Available Snap-Ins** list, click **Certificates**, and then click **Add**.   
3. Select the **Computer account** option, and then click **Next**.   
4. Select the **Local computer** option, click **Finish**, and then click **OK**.   
5. Expand the **Certificates (Local Computer)** node.   
6. Expand the **Intermediate Certification Authorities** node.   
7. Select the Certificates folder to view the list of the Intermediate Certification Authorities certificates in the details pane.   
8. In the **Issued By** column in the **Details** pane, locate the Intermediate Certification Authorities certificate (or certificates) that you noted in step 7 of the "Using the Lync Server Deployment Wizard section.

    > [!NOTE]
    > If the specified Intermediate Certification Authorities certificate is listed two or more times in the **Issued By** column in the **Details** pane, continue with the following steps. However, if the Intermediate Certification Authorities certificate is listed just one time in the **Issued By** column, the following steps will not resolve the issue that's described in the "Symptoms" section. Therefore, do not continue with the following steps.

9. Double-click the Intermediate Certification Authorities certificate to open it.   
10. Click the **Details** tab.   
11. Compare the **Serial number** and **Valid from** attributes to the information that you noted in steps 7 of the "Using the Lync Server Deployment Wizard" section.

    > [!NOTE]
    > If the **Serial number** and **Valid from** attributes match the recorded values, this certificate should not be removed from the local computer's Trusted Root Certification Authorities certificate store. Use steps 9–11 listed in the current section to locate a certificate that has mismatched **Serial number** and **Valid from** attributes. If the **Serial number** and **Valid from** attributes do not match the recorded values, this certificate will have to be first exported to a folder and then deleted from the local computer's Trusted Root Certification Authorities certificates store.

12. Right-click the mismatched certificate, click **All Tasks**, and then click **Export**.   
13. Click **Next** in the Certificates Export Wizard.   
14. Use the default DER-encoded binary X.509 (.CER) option, and then click **Next**..   
15. Browse to the folder that contains the copy of the certificate, and then type a meaningful name for the certificate file.   
16. Click **Save**, and then confirm the file save information.   
17. Click **Next**, and then click **Finish** to complete the export of the certificate file.   
18. Right-click the mismatched certificate, and then click **Delete**.   
19. Read the warning information, make sure that you're deleting the intended certificate, and then click **OK**.   
20. Repeat steps 9–20 listed delete all the mismatched Intermediate Certification Authorities certificates.   

## More Information

For more information about Lync Server certificate requirements, see the following Microsoft TechNet resources:

[Certificate requirements for internal servers in Lync Server 2013](/lyncserver/lync-server-2013-certificate-requirements-for-internal-servers)

[Certificate requirements for external user access in Lync Server 2013](/lyncserver/lync-server-2013-certificate-requirements-for-external-user-access)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
