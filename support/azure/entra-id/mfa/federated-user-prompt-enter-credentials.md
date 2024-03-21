---
title: A federated user is prompted unexpectedly to enter their work or school account credentials
description: Describes a scenario in which a federated user is prompted unexpectedly to enter their work or school account credentials when they access Office 365, Azure, or Microsoft Intune. Provides resolutions.
ms.date: 06/21/2022
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
---
# Federated user is prompted unexpectedly to enter account credentials

This article describes a scenario in which a federated user is prompted unexpectedly to enter their work or school account credentials when accessing Office 365, Azure, or Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2535227

## Symptoms

When a federated user signs in Office 365, Microsoft Azure, or Microsoft Intune, the user is prompted unexpectedly to enter the work or school account credentials. After the user enters the credentials, the user is granted access to the cloud service.

> [!NOTE]
> Not all federated user authentication experiences are without a credential prompt. In certain scenarios, it's by design and expected that federated users are prompted to enter their credentials. Make sure that the credential prompt is unexpected before you continue.

## Cause

This issue may occur for internal domain clients if one or more of the following conditions are true:

- An internal client resolves the Active Directory Federation Services (AD FS) endpoint to the IP address of the AD FS proxy service instead of to the IP address of the AD FS federation service.
- The security settings in Internet Explorer are not configured for single sign-on to AD FS.
- The proxy server settings in Internet Explorer are not configured for single sign-on to AD FS.
- The web browser does not support integrated Windows authentication.
- The client computer cannot connect to the on-premises Active Directory domain.

## Resolution 1: Make sure that the DNS server has a host record for the AD FS endpoint

Make sure that the DNS server has a host record for the AD FS endpoint that is appropriate to the client computer that is experiencing this issue. For internal clients, this means that the internal DNS server should resolve the AD FS endpoint name to an internal IP address. For Internet clients, this means that the endpoint name should resolve to a public IP address. To test this on the client, follow these steps:

1. Select Start, select Run, type cmd, and then press Enter.
2. At the command prompt, type the following command, where the placeholder `sts.contoso.com` represents the AD FS endpoint name:

    ```console
    nslookup sts.contoso.com
    ```

3. If the output of the command shows an incorrect IP address, update the A record on the internal or external DNS server. For more information about how to do this, see [Internet browser can't display the AD FS sign-in webpage for federated users](/office365/troubleshoot/sign-in/ad-fs-sign-in-page-not-display)  Internet browser can't display the AD FS webpage when a federated user tries to sign in to Office 365, Azure, or Intune

## Resolution 2: Check the local intranet zone and proxy server settings in Internet Explorer

Use one of the following procedures, as appropriate for your situation.

### Procedure A

Check the local intranet zone and proxy server settings in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.
2. On the **Tools** menu, select **Internet Options**.
3. Select the **Security** tab, select the **Local intranet** zone, and then select **Sites**.
4. In the **Local intranet** dialog box, select **Advanced**. In the **Websites** list, make sure that an entry (such as `sts.contoso.com`) exists for the fully qualified DNS name of the AD FS service endpoint.
5. Select **Close**, and then select **OK**.

    > [!NOTE]
    > Use the following additional steps only if a network administrator configured a web proxy server in the on-premises environment:

6. Select the **Connections** tab, and then select **LAN Settings**.
7. Under **Automatic configuration**, select to clear the **Automatically detect settings** check box, and then select to clear the **Use automatic configuration script** check box.
8. Under **Proxy server**, select to select the **Use a proxy server for your LAN** check box, type the proxy server address and the port that it uses, and then select **Advanced**.
9. Under **Exceptions**, add your AD FS endpoint (such as `sts.contoso.com`).
10. Select **OK** three times.

### Procedure B

Manually configure the security settings for the security zone in Internet Explorer. The default security setting that causes the local intranet zone not to prompt for Windows authentication can be configured manually for any security zone in Internet Explorer. To customize the security zone of which the AD FS service name is already a part, follow these steps:

> [!WARNING]
> We highly discourage this configuration because it could result in the unintended submission of Integrated Windows Authentication traffic to websites.

1. Start Internet Explorer.
2. On the **Tools** menu, select **Internet options**.
3. Select the **Security** tab, select the security zone in which the AD FS service name is already contained, and then select **Custom level**.
4. In the **Security Settings** dialog box, scroll to the bottom to locate the **User Authentication** entry.
5. Under **Logon**, select **Automatic logon with current user name and password**.
6. select **OK** two times.

## Resolution 3: Use Internet Explorer or a third-party web browser

Use Internet Explorer or a third-party web browser that supports integrated Windows authentication.

## Resolution 4: Verify connectivity to Active Directory

Log off from the client computer and then log on as an Active Directory user. If logon is successful, verify the connectivity to Active Directory by using the Nltest command-line tool. Nltest.exe is included in the [Remote Server Administration Tools for Windows 10](https://www.microsoft.com/download/details.aspx?id=45520).

1. At a command prompt, type the following command, and then press Enter: `Nltest /dsgetdc:<FQDN Of Domain>`. If the settings are correct, you receive output that resembles the following:

    > DC: \\DC.contoso.com Address:\ \<IP Address> Dom Guid: \<GUID>
    Dom Name: contoso.com Forest Name: contoso.com Dc Site Name: Default-First-Site-Name
    Our Site Name: Default-First-Site-Name Flags: PDC GC DS LDAP KDC TIMESERV GTIMESERV WRITABLE
    DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE The command completed successfully

2. Check the computer's site membership. To do this, type the following command, and then press Enter: `nltest /dsgetsite`. A successful result resembles the following:

    > Default-First-Site-Name The command completed successfully

## More information

Accessing Office 365 resources by using a non-federated account or a federated account from a public Internet connection may not result in a single sign-on experience.

The experience for logging on to Microsoft Outlook connections is also not expected to be a single sign-on experience.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
