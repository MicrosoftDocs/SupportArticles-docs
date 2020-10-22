---
title: Configure Kerberos Constrained Delegation
description: Discusses how to implement S4U2Proxy and Constrained Delegation on a custom service account for Web Enrollment proxy pages.
ms.date: 09/18/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jarrettr, wincicadsec, Jitesh.Thakur
ms.prod-support-area-path: Active Directory domain or forest functional level updates
ms.technology: ActiveDirectory
---
# How to configure Kerberos Constrained Delegation (S4U2Proxy or Kerberos Only) on a custom service account for Web Enrollment proxy pages

The article provides step-by-step instructions to implement Service for User to Proxy (S4U2Proxy) or Kerberos Only Constrained Delegation on a custom service account for Web Enrollment proxy pages.

_Original product version:_ &nbsp; Window Server 2016, Window Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4494313

## Summary

> [!NOTE]
> The workflow that's included in this article is specific to a particular scenario. The same workflow may not work for a different situation. However, the principles remain the same.

## Configuring the Delegation in Active Directory

1. See the following image for guidance to configure the HTTP SPNs on the service account for the front-end web server.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/active-directory-users-computers.png" alt-text="Guidance to configure the HTTP SPNs.":::

    **Note** You can also run the **setspn -s SPN Accountname**  command. For example, run the following command:

    ```console
    setspn -s HTTP/webenroll2016.contoso.com web_svc
    ```

2. Configure S4U2Proxy (Kerberos Only) Constrained Delegation on the service account.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/web-svc-settings.png" alt-text="Configure web_svc properties":::

3. On the Machine Account, set S4U2Self (Protocol Transition) Constrained Delegation.‎

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/set-s4u2self-contained-delegation.png" alt-text="Set up delegation":::

## Configuring web enrollment for HTTPS

To enable web enrollment pages to work, create a domain certificate for the website, and then bind it to the default first site. To do this, follow these steps:

1. Click \<HOSTNAME>, and select **Server Certificates**.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/select-server-certificate.png" alt-text="Add certificate":::

2. In the actions pane on the right, select **Create a Domain Certificate**.
3. After the certificate is created, select **Default Web Site** on the left side, and then select **Bindings** on the right side.
4. Add the certificate that you enrolled earlier, and bind it to port 443.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/add-site-binding.png" alt-text="Add certificate and bind it to port 443":::

## Configuring the service account on the front end (web server)

Make sure that the service account is part of either the **local administrators** or **IIS_Users** group on the web server.
:::image type="content" source="./media/configure-kerberos-constrained-delegation/local-users-groups.png" alt-text="Service account":::

‎After you install the web enrollment role on the server, start IIS Manager, and then configure the service account for the default App Pool.

1. Right-click **DefaultAppPool**, and then click **Advanced Settings**.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/advanced-settings.png" alt-text="Configure Application pools":::

2. In the **Process Model** > **Identity** section of the setting, add the service account.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/add-custom-account.png" alt-text="Application Pool Identity":::

3. Set the **Load User Profile** setting to **True**.

    :::image type="content" source="./media/configure-kerberos-constrained-delegation/load-user-profile.png" alt-text="Set Load User Profile setting to True":::

4. Restart the computer.

## References

For more information, see the following articles:

[Authenticating Web Application Users](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc759501%28v%3dws.10%29)

For more information about Depth S4U protocol, see the following articles:

[[MS-SFU]: Kerberos Protocol Extensions: Service for User and Constrained Delegation Protocol](https://docs.microsoft.com/openspecs/windows_protocols/ms-sfu/3bff5864-8135-400e-bdd9-33b552051d94)  
[4.1 S4U2self Single Realm Example](https://docs.microsoft.com/openspecs/windows_protocols/ms-sfu/6a8dfc0c-2d32-478a-929f-5f9b1b18a169)  
[4.3 S4U2Proxy Example](https://docs.microsoft.com/openspecs/windows_protocols/ms-sfu/c920c148-8a9c-42e9-b8e9-db5755cd281b)
