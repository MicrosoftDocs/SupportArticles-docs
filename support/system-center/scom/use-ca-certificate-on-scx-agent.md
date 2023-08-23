---
title: Convert self-signed SCX certificates to CA certificates
description: Introduces how to convert a self-signed certificate on an SCX agent to a Certificate Authority (CA) signed certificate.
ms.date: 08/23/2023
ms.reviewer: alexkre, blakedrumm, edpaca, stparker, udmudiar, v-weizhu
ms.topic: how-to
---

# How to use a CA certificate on an SCX agent

This article introduces how to convert a self-signed certificate on a System Center Operations Manager (SCOM) Unix/Linux (SCX) agent to a Certificate Authority (CA) signed certificate.

## Create a CA certificate template

On a CA server in your SCOM environment, follow these steps to create a certificate template:

1. Open **Certification Authority** from **Server Manager**.
1. Right-click **Certificate Templates** and select **Manage**.
1. Select the template **Computer** and select **Duplicate Template**.
1. On the **General** tab, set a name for the template and change the **Validity period** as per standards.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/change-template-display-name-validity-period.png" alt-text="Screenshot that shows how to change the display name and validity period of a template.":::

1. On the **Request Handling** tab, check the **Allow private key to be exported** option.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/allow-private-key-to-be-exported.png" alt-text="Screenshot that shows how to select the 'Allow private key to be exported' option.":::

1. On the **Extensions** tab, select **Application Policies** > **Edit**. Remove **Client Authentication** from the **Application Policies** extension. Make sure that the **Application Policies** extension has only **Server Authentication**.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/remove-client-authentication.png" alt-text="Screenshot that shows how to remove 'Client Authentication' from the 'Application Policies' extension.":::

1. On the **Subject Name** tab, select **Supply in the request**. Accept the prompt. There's no risk.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/select-supply-in-the-request.png" alt-text="Screenshot that shows how to select the 'Supply in the request' option.":::

1. Select **OK**.
1. Select the created template and go to **Properties**.
1. Select **Security**. Add the computer object of the server where the certificate will be enrolled.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/add-server.png" alt-text="Screenshot that shows how to add the computer object.":::

1. Select the permissions as **Read**, **Write**, and **Enroll**.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/select-permissions.png" alt-text="Screenshot that shows the 'Read', 'Write' and 'Enroll' permissions are selected.":::

1. Right-click **Certificate templates**. Select **New** > **Certificate Template to Issue**.
1. Select the created template and select **OK**.

## Issue a CA certificate from the template

1. On the Windows Server that has been given the permission to the template, open the computer certificate store.
1. Under **Personal**, right-click **Certificates** and select **All Tasks** > **Request New Certificate...**

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/request-new-certificate.png" alt-text="Screenshot that shows how to request a new certificate.":::

1. Select **Next** > **Next**.
1. Find the template.
1. Select **More information is required to enroll for this certificate. Click here to configure settings.**

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/select-certificate-to-enroll.png" alt-text="Screenshot of the warning that requests more information for enrollment.":::

1. Add the following details, preferably in the order:
    1. CN=\<Server Name FQDN>
    2. CN=\<Server Name>
    3. DC=\<domain component>, for example, `Contoso`
    4. DC=\<domain component>, for example, `com`

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/set-subject-name.png" alt-text="Screenshot that shows adding 'Subject name' details.":::

    If you have other domain components, make sure they are in the certificate.

1. Select **Finish** after the successful enrollment.
1. Right-click the certificate and export it with a private key. Finally, there should be a .pfx file.
1. Export the CA and Intermediate CA certificate (if applicable) to the *root* store of all the management servers/gateways in the UNIX/Linux resource pool.

## Copy and edit the certificate on the Unix/Linux server

1. Copy the certificate to the Unix/Linux server for which the certificate was issued.
1. Export the private key by using the following command:

    ```console
    openssl pkcs12 -in <FileName>.pfx -nocerts -out key.pem
    ```

    While exporting the private key from the certificate store, a new password has to be set for the new key file.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-export-private-key.png" alt-text="Screenshot that shows the command to export the private key.":::

    After the export is completed, you should see a *key.pem* file:

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-get-key-dot-pem-file.png" alt-text="Screenshot that shows the command to get the private key file.":::

1. Export the certificate by using the following command:

    ```console
    openssl pkcs12 -in <FileName>.pfx -clcerts -nokeys -out omi.pem
    ```

    While exporting the certificate from the certificate store, you have to enter the password for the *\<FileName>.pfx* file.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-export-certificate.png" alt-text="Screenshot that shows the command to export the certificate.":::

    After the export is completed, you should see an *omi.pem* file:

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-get-omi-dot-pem-file.png" alt-text="Screenshot that shows the command to get the certificate file.":::

1. Remove the password from the private key by using the following command:

    ```console
    openssl rsa -in key.pem -out omikey.pem 
    ```

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-remove-password-from-private-key.png" alt-text="Screenshot that shows the command to remove password from the private key.":::

    This action is needed since the Linux agent doesn't know the password for the file.

1. Move the *omikey.pem* file to the Open Management Infrastructure (OMI) directory by using the following command:

    ```console
    mv omikey.pem /etc/opt/omi/ssl/omikey.pem 
    ```

1. Restart the SCX agent by using the following command:

    ```console
    scxadmin -restart
    ```

1. Make sure the *omi* processes are running after restarting the agent:

    ```console
    ps -ef | grep omi | grep -v grep
    ```

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/command-validate-omi-processes.png" alt-text="Screenshot that shows the command to validate omi processes running." lightbox="media/use-ca-certificate-on-scom-linux-agent/command-validate-omi-processes.png":::

## Validate that the certificate is signed by the CA

1. Run the following command on the agent to verify that the certificate is signed by the CA:

    ```console
    openssl x509 -noout -in /etc/opt/microsoft/scx/ssl/scx.pem -subject -issuer -dates
    
    subject= /DC=lab/DC=nfs/CN=RHEL7-02/CN=RHEL7-02.nfs.lab
    issuer= /DC=lab/DC=nfs/CN=nfs-DC-CA
    notBefore=Aug  1 13:16:47 2023 GMT
    notAfter=Jul 31 13:16:47 2024 GMT
    ```

    In typical scenarios, the `issuer` will be a management server/gateway in the UNIX/Linux resource pool, as follows:

    ```console
    openssl x509 -noout -in /etc/opt/microsoft/scx/ssl/scx.pem -subject -issuer -dates
    
    subject=CN = rhel8-01.nfs.lab, CN = rhel8-01.nfs.lab
    issuer=CN = SCX-Certificate, title = SCX55a8126f-c88a-4701-9754-8625324426ff, DC = SCOM2022MS3
    notBefore=Jul 25 11:36:44 2022 GMT
    notAfter=Jul 25 12:12:14 2033 GMT
    ```

1. Run a network trace on one of the management servers/gateways in the UNIX/Linux resource pool.
1. Run the following `WinRM` command against the agent and make sure you get the instance output:

    ```console
    winrm enumerate http://schemas.microsoft.com/wbem/wscim/1/cim-schema/2/SCX_Agent?__cimnamespace=root/scx -auth:basic -remote:https://<server name>:1270 -username:<username> -encoding:utf-8
    ```

1. On the network trace, filter with the IP of the agent.
1. In the *Certificate, Server Hello Done* packet, you should see the CA-signed certificate rather than the self-signed certificate used.

    :::image type="content" source="media/use-ca-certificate-on-scom-linux-agent/validate-ca-signed-certificate-used.png" alt-text="Screenshot that shows the CA signed certificate." lightbox="media/use-ca-certificate-on-scom-linux-agent/validate-ca-signed-certificate-used.png":::


