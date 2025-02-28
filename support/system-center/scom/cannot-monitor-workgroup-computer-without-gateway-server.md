---
title: Can't monitor a workgroup computer without a gateway server
description: Explains how to configure an Operations Manager server to monitor a remote, untrusted workgroup computer without using a gateway server.
ms.date: 04/15/2024
ms.reviewer: prakask
---
# Can't see a workgroup computer when installing an Operations Manager agent on it without using a gateway server

This article provides a solution for the issue that you can't configure a System Center Operations Manager server to monitor a remote, untrusted workgroup computer without using a gateway server.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 947691

## Symptoms

When you try to install a System Center Operations Manager agent on a workgroup computer without using a gateway server, Operations Manager can't see the workgroup computer.

Additionally, the following error message is logged in the Operations Manager event log:

> Event ID : 21007 The OpsMgr connector cannot create a mutually authenticated connection to <*Management server*> because it is not in a trusted domain.  
> Event ID : 21016 Opsmgr was unable to setup a communication channel to <*Management server*> and there is no failover hosts

## Cause

This problem usually occurs when the agent can't establish a security communication channel to the management server because the correct certificates are not available. This problem occurs because agents in the workgroup can't use the Kerberos protocol for mutual authentication. The certificates must be used in an environment in which the Kerberos protocol is not used.

## Resolution

To solve this problem, you can configure an Operations Manager server to monitor a remote, untrusted workgroup computer without using a gateway server. To do this, certificate authentication is required between the management server and the agent-managed workgroup computer. Presumably, this scenario will be common in a perimeter network (also known as DMZ, demilitarized zone, and screened subnet).

To configure an Operations Manager server to monitor a stand-alone, agent-managed workgroup computer, you must have these certificates:

- An imported certification authority (CA) root certificate for the management server and for the workgroup computer
- A certificate for the management server. The common name (CN) of the certificate must be a fully qualified domain name (FQDN).
- A certificate for the workgroup computer

If the workgroup computer is addressed by an FQDN, the computer should also use the FQDN format to request the certificate for this computer. Otherwise, you will receive this error message:

> The specified certificate could not be loaded because the Subject name on the certificate does not match the local computer name  
> Certificate Subject Name: \<Certificate Subject Name>  
> Computer Name: \<Computer Name>

### How to monitor a workgroup computer without using a gateway server

1. Import the root CA certificates for the management server and for the agent-managed workgroup computer. To do this, follow these steps:

    > [!NOTE]
    > You must follow these steps on the management server and on the workgroup computer. You must have a root certification authority (CA) installed, and you must be able to create another certificate by using object identifiers (OIDs). If you don't have a root certification authority installed, see the [How to install a root certification authority in a domain](#how-to-install-a-root-certification-authority-in-a-domain) section.

    1. From the server desktop, open a web browser, and then point it at the certification authority server. For example, type the address http://<*certification_authority_server*>/certsrv.

    2. Select **Download a CA certificate, certificate chain, or CRL**.
    3. Select **Download CA certificate chain**. A certificate that's named Certnew.p7b is downloaded. Save this certificate on the desktop.
    4. When the download is finished, select **Start**, select **Run**, type `mmc`, and then select **OK** to open a Microsoft Management Console (MMC) instance.
    5. On the **File** menu, select **Add/Remove Snap-in** > **Add** > **Certificates**.
    6. Select **Add** > **Computer account** > **Next**.
    7. Select **Local computer** > **Finish** > **Close** > **OK**.
    8. Under **Trusted Root Certificate Authorities**, right-click **Certificates**, point to **All Tasks**, and then select **Import**.
    9. Select **Import** > **Next**.
    10. When you're prompted for the certificate file, select **Browse**.
    11. Change **Files of type** to **PKCS #7 Certificates (\*.spc,*.p7b)**.
    12. Select the appropriate certificate file that you downloaded from the certification authority server, and then select **Open**.
    13. Select **Next** > **Finish**.

2. Configure the enterprise root certification authority server to support the Operations Manager certificates. To do this, follow these steps:

    1. Use domain administrator credentials to sign in to the enterprise subordinate certification authority server.
    1. Select **Start**, select **Run**, type `mmc`, and then press ENTER.
    1. On the **File** menu, select **Add/Remove Snap-in**.
    1. Select **Add**.
    1. Under **Add Standalone Snap-in**, select **Certificate templates**, and then select **Add**.
    1. Select **Certification Authority**, and then select **Add**.
    1. In the **Certification Authority** snap-in, select the **Local computer (the computer this console is running on)** option.
    1. Select **Finish**.
    1. Select **Close**, and then select **OK**.
    1. In the **Certification Authority** snap-in, verify that the **Certificate Templates** snap-in and the **Certification Authority** snap-in appear.
    1. Select **Certificate Templates**.
    1. In the details pane, right-click **Computer**, and then select **Duplicate Template**.
    1. On the **General** tab, change the template name to a meaningful name for your organization. For example, you can use OpsMgr2012 as the template name. Verify that the validity period meets your organization's requirements.
    1. Select the **Request Handling** tab, and then select **Allow private key to be exported**.
    1. Select the **Subject name** tab, and then select **Supply** in the **Request** option.
    1. Select the **Security** tab.
    1. Grant **Enroll and Auto enroll** permissions for the following groups in all domains:
        - Authenticated users
        - Domain admins
        - Domain computers
        - Enterprise admins
    1. Select **Apply**, and then select **OK**.
    1. To verify the settings, expand **Certificate Templates**.
    1. In the details pane, right-click the template that you configured, select **Properties**, verify your settings, and then select **OK**.
    1. Expand **Certification Authority (local)**, and then expand your certification authority.
    1. In the console tree, right-click **Certificate Templates**, point to **New**, and then select **Certificate Template to Issue**.
    1. Select the new template, and then select **OK**.
    1. Verify that the new template appears in the details pane, and then verify that the **Server Authentication** entry and the **Client Authentication** entry appear under **Intended Purpose**.
    1. Close the snap-in.
    1. Select **Start**, select **Run**, type `gpupdate /force` in the **Open** field, and then press ENTER.

        > [!NOTE]
        > This step forces a Group Policy update on the domain controller and a replication of these changes throughout the forest.

    1. Select **Start**, select **Run**, type **http://<*name_of_the_issuing_CA_Server*>/certsrv** in the **Open** field, and then press ENTER.

    1. If you're prompted, enter the domain administrator account name and the password.

    1. On the **Certificate Services** page, select **Request a certificate** under **Select a task**.

    1. Select **Advanced certificate request**.
    1. Select **Create and submit a request to this CA**.

    1. In the **Certificate template** list, verify that your new certificate template appears.

3. Submit the certificate request to the certification authority server. To do this, follow these steps on the management server and on the workgroup computer:

    1. Select **Start**, select **Run**, type **http://<*name_of_the_issuing_CA_Server*>/certsrv** in the **Open** field, and then press ENTER.
    2. If you're prompted, enter the domain administrator account name and password.
    3. On the **Certificate Services** page, select **Request a certificate** under **Select a task**.
    4. Select **Advanced certificate request**.
    5. Select **Create and submit a request to this CA**.
    6. In the **Certificate Template** field, select the template name that you configured in step 2. For example, select **OpsMgr2012**.
    7. In the **Name** field, type the FQDN of the management server.
    8. Select the **Mark key as exportable** check box. When you are using the Web certificate request UI, you must also check the **Store the certificate in the local compute certificate store** box.

        > [!NOTE]
        > The certificate will be unusable if this is not done.
    9. Select **Submit** to submit your request to the certification authority server, and then follow the instructions that appear on the screen.
    10. Depending on the security configuration on the CA, you have to wait for an administrator to manually approve the request. It's not guaranteed that the CA can be downloaded immediately.
    11. Verify the certificate. To do this, follow these steps:
        1. Select **Start**, select **Run**, type `mmc`, and then press ENTER.
        2. On the **File** menu, select **Add/Remove Snap-in**.
        3. Select **Add**.
        4. Select the **Certificates** snap-in, and then select **Add**.
        5. Select **My user account**, select **Finish**, select **Close** to close the snap-in list, and then select **OK** to close the **Add/remove snap-in** window.
        6. Expand **Certificates - Current User**, expand **Personal**, expand **Certificates**, and then select the server certificate.
        7. Double-click the certificate, and then select the **Details** tab.
        8. In the list, select **Enhanced Key Usage**. You should see the following entries:
             - **Client Authentication (1.3.6.1.5.5.7.3.2)**
             - **Server Authentication (1.3.6.1.5.5.7.3.1)**
4. Configure the Operations Manager 2012 server to use certificates that can be exported from the computer private store. To do this, follow these steps:

    1. Select **Start**, select **Run**, type `mmc`, and then press ENTER.
    2. On the **File** menu, select **Add/Remove Snap-in**.
    3. Select **Add**.
    4. Select **Certificates**, and then select **Add**.
    5. Select **Computer account**, and then select **Finish**.
    6. Select **Local computer**, select **Finish**, select **Close** to close the snap-in list, and then select **OK** to close the **Add/remove snap-in** window.
    7. Expand **Certificates (local computer)**, expand **Personal**, expand **Certificates**, and then select a suitable certificate.
    8. Right-click the certificate, point to **All tasks**, and then select **Export**.
    9. Select **Next**.
    10. Select **Yes, export private key**, and then select **Next**.
    11. Use the default setting for the file format.
    12. Type a password for the file.
    13. Type a file name, and then select **Next**.
    14. Select **Finish**.
    15. Repeat all these steps on the management server and on the workgroup computer.

5. Install the agent on the workgroup computer. To do this, follow these steps.

    > [!NOTE]
    > Because you are performing a manual installation of the agent, you must use the agent setup executable file that is available in the \Agent\i386 folder in the Operations Manager distribution location.

    1. Run the MOMAgent.msi file.
    2. On the **Welcome** screen, select **Next**.
    3. When you're prompted for a folder destination for the software, accept the default location, and then select **Next**.
    4. When you're prompted to configure the management group information, accept the default settings, and then select **Next**.
    5. Type the management group name, the management server name, and the port, and then select **Next**.
    6. Accept the default settings, and then select **Next**.
    7. Verify that all information that you have entered is correct, and then select **Install** to start the installation.
    8. When the installation is complete, select **Finished** to exit the installation.

6. Use the Momcertimport tool to import the certificate. To do this, follow these steps:

    > [!NOTE]
    > The Momcertimport tool is used to enter the serial number of the specific certificate in the registry. You must follow these steps on the management server and on the workgroup computer. Make sure that the Operations Manager agent is installed on the workgroup computer. Otherwise, you will receive an error when you run the Momcertimport tool.

    1. Select **Start**, and then select **Run**.
    2. In the **Open** field, type `cmd`, and then select **OK**.
    3. At the command prompt, type *drive_letter:* and then press ENTER.

        > [!NOTE]
        > *drive_letter* is the drive on which the Operations Manager installation media is located.

    4. Type `cd \SupportTools\i386`, and then press ENTER.
    5. Type the following command, and then press ENTER:

       ```console
       MOMCertImport path_of_the_certificate .pfx_file_that_is_exported_in_step_5m
       ```

    6. Restart the Operations Manager Health service.

7. Wait for the management server to see the manual installation and to request approval. This should take some time (five to ten minutes). When you're prompted, approve the agent. The workgroup agent can now communicate with the server.

### How to install a root certification authority in a domain

> [!NOTE]
> If your site already has a root certification authority, skip these steps.

To install certification authority services on a domain controller, follow these steps. This sample procedure uses a domain controller. However, you can install the root certification authority anywhere in your domain.

1. Sign in to a domain controller.
2. Select **Start**, select **Control Panel**, double-click **Add or Remove Programs**, and then select **Add/Remove Windows Components**.

3. Scroll down until you find **Certificate Services**, and then select it. Make sure that you select both the suboptions for the services. When you select these components, you receive a warning message. This message tells you not to change the name of the computer or its domain membership. After you read the warning, select **Yes** to continue, and then select **Next**.

4. When the wizard prompts you for the CA type, select **Stand-Alone Root CA**, and then select **Next**.

5. When the wizard prompts you for a common name for the certification authority, use the NetBIOS name or the Domain Name System (DNS) host name. For this example, type DC01, and then select **Next**.

6. Accept the default database settings, and then select **Next**.

Certification authority services are now installed on the server. To access the services, visit the web site http://<*server_name*>/certsrv. In this example, type `http://dc01/certsrv`.
