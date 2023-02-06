---
title: Reinstall the Intune Certificate Connector
description: Learn how to reinstall the Microsoft Intune Certificate Connector if there is an error or version update.
author: helenclu
ms.author: luche
ms.reviewer: jesantae
ms.date: 02/06/2023
---
# How to reinstall the Intune Certificate Connector

> [!IMPORTANT]  
> The details in this article apply only to the **PFX Certificate Connector for Microsoft Intune** and **Microsoft Intune Connector**. Support for both connectors ends in July 2021, when they are both replaced by the **Certificate Connector for Microsoft Intune**.
>
> If you use the new connector, see [Certificate Connector for Microsoft Intune](/mem/intune/protect/certificate-connector-overview) for more information about capabilities, connector status, and log details including a list of Log Event IDs for the newer connector.

This article describes how to uninstall and reinstall the Intune Certificate Connector. You might need to reinstall the connector in one of these scenarios:

- The connector displays an **Error** status in Intune.
- The connector certificate is expired.
- The connector version has to be updated.

## Before you uninstall the connector

To make sure that the connector will reinstall correctly, follow these steps before you uninstall it:

1. Verify the certificate's thumbprint. On the Windows server that hosts the connector, open Registry Editor, locate the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\NDESPolicy` subkey, and then check the value of `NDESCertThumbprint`.
2. Open the connector user interface (UI) from *%ProgramFiles%\Microsoft Intune\NDESConnectorUI\NDESConnectorUI.exe*.
    - On the **Enrollment** tab, check whether proxy server is used. If it is, note the proxy server configuration.
    - On the **Advanced** tab, check the account that you use, and note the account information.

      :::image type="content" source="media/reinstall-the-intune-connector/ca-account.png" alt-text="Screenshot of the CA account specified under Advanced tab.":::

## Uninstall the connector

1. On the Windows server that hosts the connector, use **Windows Apps and Features** to uninstall the connector.
2. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Tenant administration** > **Connectors and tokens** > **Certificate connectors**, and then delete the connector.

## Download and install the new connector

If you select the **PFX Distribution** option during connector setup, follow the steps in [Download, install, and configure the Certificate Connector for Microsoft Intune](/mem/intune/protect/certificates-pfx-configure#download-install-and-configure-the-certificate-connector-for-microsoft-intune) to reinstall it.

If you select the **SCEP and PFX Profile Distribution** during connector setup, use the following steps:

1. Complete the steps in [Install the Microsoft Intune Connector](/mem/intune/protect/certificates-scep-configure#install-the-microsoft-intune-connector).

    > [!NOTE]
    >  
    > - After you select the client certificate for the Certificate Connector, view the properties of that certificate, verify that the certificate's thumbprint matches the value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\NDESPolicy\NDESCertThumbprint`.
    > - In the Certificate Connector UI, specify the proxy server and account by using the information that you noted in step 2 in the [Before you uninstall the connector](#before-you-uninstall-the-connector) section.
    > - After you close the Certificate Connector UI and restart the **Intune Connector Service**, also restart the **World Wide Web Publishing Service**.

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Tenant administration** > **Connectors and tokens** > **Certificate connectors**, and then verify that the connector is **Active**.

1. To verify that the **Intune Connector Service** is running, open a web browser, and enter the URL `https://<FQDN_of_your_NDES_server>/certsrv/mscep/mscep.dll`. It should return a 403 error.

:::image type="content" source="media/reinstall-the-intune-connector/403-error.png" alt-text="Screenshot of HTTP error 403 forbidden access is denied.":::
