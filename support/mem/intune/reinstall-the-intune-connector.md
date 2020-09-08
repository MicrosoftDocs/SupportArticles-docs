---
title: Reinstall the Intune Certificate Connector
description: Describes how to reinstall the Microsoft Intune Connector.
author: helenclu
ms.author: luche
ms.reviewer: 
ms.date: 09/08/2020
ms.prod-support-area-path: 
---
# How to reinstall the Intune Certificate Connector

In some circumstances, you may need to reinstall the Intune Certificate Connector. For example:

- The connector displays an **Error** status in Intune
- The connector certificate has expired
- The connector version needs to be updated

This article describes how to reinstall the connector when the **SCEP and PFX Profile Distribution** option is selected during setup of the connector. If the **PFX Distribution** option is selected during setup, uninstall the connector, then follow the steps in [Download, install, and configure the PFX Certificate Connector for Microsoft Intune](/mem/intune/protect/certficates-pfx-configure#download-install-and-configure-the-pfx-certificate-connector) to reinstall it.

## Before you uninstall the connector

To make sure the connector is reinstalled correctly, follow these steps before you uninstall it:

1. Verify the certificate's thumbprint. On the Windows server that hosts the connector, open Registry Editor, locate the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\NDESPolicy` subkey, and then check the value of `NDESCertThumbprint`.
2. Open the connector user interface (UI) from %ProgramFiles%\Microsoft Intune\NDESConnectorUI\NDESConnectorUI.exe.
    - On the **Enrollment** tab, check whether proxy server is used. If so, note down the proxy server configuration.
    - On the **Advanced** tab, check the account that you use. Note down the account information.

      :::image type="content" source="./media/reinstall-the-intune-connector/ca-account.png" alt-text="Check the CA account specified":::

## Uninstall the connector

1. On the Windows server that hosts the connector, use **Windows Apps and Features** to uninstall the connector.
2. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Tenant administration** > **Connectors and tokens** > **Certificate connectors**, delete the connector.

## Download and install the new connector

To install the new connector, follow the steps in [Install the Microsoft Intune Connector](/mem/intune/protect/certificates-scep-configure#install-the-microsoft-intune-connector).

> [!NOTE]
>  
> - After you select the client certificate for the Certificate Connector, view the properties of that certificate, verify that the certificate's thumbprint matches the value of `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\Modules\NDESPolicy\NDESCertThumbprint`.
> - In the Certificate Connector UI, specify the proxy server and account by using the information you note down in step 2 in the [Before you uninstall the connector](#before-you-uninstall-the-connector) section.
> - After you close the Certificate Connector UI and restart the **Intune Connector Service**, also restart the **World Wide Web Publishing Service**.

In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Tenant administration** > **Connectors and tokens** > **Certificate connectors**, verify that the connector is **Active**.

To verify that the **Intune Connector Service** is running, open a browser, and enter the URL `https://<FQDN_of_your_NDES_server>/certsrv/mscep/mscep.dll`. It should return a 403 error.

:::image type="content" source="./media/reinstall-the-intune-connector/403error.png" alt-text="HTTP error 403":::
