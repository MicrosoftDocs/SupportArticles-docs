---
title: Azure Storage Explorer troubleshooting guide
description: Provides debugging techniques for Azure Storage Explorer.
services: storage
ms.service: azure-storage
ms.custom: sap:Alerts, Metrics, Logging and Monitoring, linux-related-content
ms.date: 12/23/2024
ms.reviewer: azurestocic, jarrettr, v-weizhu
---

# Azure Storage Explorer troubleshooting guide

[!INCLUDE [Feedback](../../../../includes/feedback.md)]

Microsoft Azure Storage Explorer is a standalone app that makes it easy to work with Azure Storage data on Windows, macOS, and Linux. The app can connect to storage accounts hosted on Azure, national clouds, and Azure Stack.

This guide summarizes solutions for issues that are commonly seen in Storage Explorer.

## Azure RBAC permissions issues

Azure role-based access control [(Azure RBAC)](/azure/role-based-access-control/overview) enables highly granular access management of Azure resources by combining sets of permissions into roles. Here are some strategies to get Azure RBAC working optimally in Storage Explorer.

### How do I access my resources in Storage Explorer?

If you're having problems accessing storage resources through Azure RBAC, you might not have been assigned the appropriate roles. The following sections describe the permissions Storage Explorer currently requires for access to your storage resources. Contact your Azure account admin if you're not sure you have the appropriate roles or permissions.

#### "Read: List/Get Storage Account(s)" permissions issue

You must have permission to list storage accounts. To get this permission, you must be assigned the Reader role.

#### List storage account keys

Storage Explorer can also use account keys to authenticate requests. You can get access to account keys through more powerful roles, such as the Contributor role.

> [!NOTE]
> Access keys grant unrestricted permissions to anyone who holds them. As a result, we don't recommend that you hand out these keys to account users. If you need to revoke access keys, you can regenerate them from the [Azure portal](https://portal.azure.com/).

#### Data roles

You must be assigned at least one role that grants access to read data from resources. For example, if you want to list or download blobs, you need, at the least, the Storage Blob Data Reader role.

### Why do I need a management layer role to see my resources in Storage Explorer?

Azure Storage has two layers of access: management and data. Subscriptions and storage accounts are accessed through the management layer. Containers, blobs, and other data resources are accessed through the data layer. For example, if you want to get a list of your storage accounts from Azure, you send a request to the management endpoint. If you want a list of blob containers in an account, you send a request to the appropriate service endpoint.

Azure roles can grant you permissions for management or data layer access. The Reader role, for example, grants read-only access to management layer resources.

Strictly speaking, the Reader role provides no data layer permissions and isn't necessary for accessing the data layer.

Storage Explorer makes it easy to access your resources by gathering the necessary information to connect to your Azure resources. For example, to display your blob containers, Storage Explorer sends a "list containers" request to the blob service endpoint. To get that endpoint, Storage Explorer searches the list of subscriptions and storage accounts you have access to. To find your subscriptions and storage accounts, Storage Explorer also needs access to the management layer.

If you don't have a role that grants any management layer permissions, Storage Explorer can't get the information it needs to connect to the data layer.

### What if I can't get the management layer permissions I need from my admin?

If you want to access blob containers, Azure Data Lake Storage Gen2 containers or directories, or queues, you can attach to those resources by using your Azure credentials.

1. Open the **Connect** dialog box.
1. Select the resource type you want to connect to.
1. Select **Sign in using Microsoft Entra ID** > **Next**.
1. Select the user account and tenant associated with the resource you're attaching to, and then select **Next**.
1. Type the URL to the resource and then type a unique display name for the connection. Select **Next** > **Connect**.

Currently, there isn't an Azure RBAC-related solution for other resource types. As a workaround, you can request a shared access signature URL and then attach it to your resource:

1. Open the **Connect** dialog box.
1. Select the resource type you want to connect to.
1. Select **Shared access signature (SAS)** > **Next**.
1. Type the shared access signature URL you received and enter a unique display name for the connection. Select **Next** > **Connect**.

For more information on how to attach to resources, see [Attach to an individual resource](/azure/vs-azure-tools-storage-manage-with-storage-explorer#attach-to-an-individual-resource).

### Recommended Azure built-in roles

Several Azure built-in roles can provide the permissions needed to use Storage Explorer. Some of those roles are:

- [Owner](/azure/role-based-access-control/built-in-roles#owner): Manage everything, including access to resources.
- [Contributor](/azure/role-based-access-control/built-in-roles#contributor): Manage everything, excluding access to resources.
- [Reader](/azure/role-based-access-control/built-in-roles#reader): Read and list resources.
- [Storage Account Contributor](/azure/role-based-access-control/built-in-roles#storage-account-contributor): Full management of storage accounts.
- [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner): Full access to Azure Storage blob containers and data.
- [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor): Read, write, and delete Azure Storage containers and blobs.
- [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader): Read and list Azure Storage containers and blobs.

> [!NOTE]
> The Owner, Contributor, and Storage Account Contributor roles grant account key access.

## SSL certificate issues

This section discusses SSL certificate issues.

### Understand SSL certificate issues

Make sure you've read the [SSL certificates section](/azure/storage/common/storage-explorer-network#ssl-certificates) in the Storage Explorer networking documentation before you continue.

### Use system proxy

If you're only using features that support the **use system proxy** setting, try using that setting. To read more about the **system proxy** setting, see [Network connections in Storage Explorer](/azure/storage/common/storage-explorer-network#use-system-proxy-preview).

### Import SSL certificates

If you have a copy of the self-signed certificates, you can instruct Storage Explorer to trust them:

1. Obtain a Base-64 encoded X.509 (.cer) copy of the certificate.
1. Go to **Edit** > **SSL Certificates** > **Import Certificates**. Then use the file picker to find, select, and open the .cer file.

This issue might also occur if there are multiple certificates (root and intermediate). To fix this error, you must import all certificates.

### Find SSL certificates

If you don't have a copy of the self-signed certificates, ask your IT admin for help.

Follow these steps to find them:

1. Install OpenSSL:

    - [Windows](https://slproweb.com/products/Win32OpenSSL.html): Any of the light versions should be sufficient.
    - Mac: OpenSSL should be included with your operating system.
    - Linux: OpenSSL should be included with your operating system.

1. Run OpenSSL:

    - Windows: Open the installation directory, select */bin/*, and then double-click openssl.exe.
    - Mac: Run `openssl` from a terminal.
    - Linux: Run `openssl` from a terminal.

1. Run the command `openssl s_client -showcerts -connect <hostname>:443` for any of the Microsoft or Azure host names that your storage resources are behind. For more information, see this [list of host names that are frequently accessed by Storage Explorer](/azure/storage/common/storage-explorer-network).

1. Look for self-signed certificates. If the subject `("s:")` and issuer `("i:")` are the same, the certificate is most likely self-signed.

1. When you find the self-signed certificates, for each one, copy and paste everything from `-----BEGIN CERTIFICATE-----` to `-----END CERTIFICATE-----` into a new .cer file.

1. Open Storage Explorer and go to **Edit** > **SSL Certificates** > **Import Certificates**. Then use the file picker to find, select, and open the .cer files you created.

### Disable SSL certificate validation

If you can't find any self-signed certificates by following these steps, contact us through the feedback tool. You can also open Storage Explorer from the command line with the `--ignore-certificate-errors` flag. When opened with this flag, Storage Explorer ignores certificate errors. *This flag isn't recommended.*

## Sign-in issues

This section discusses sign-in issues you might encounter.

### Understand sign-in

Make sure you've read the [Sign in to Storage Explorer](/azure/storage/common/storage-explorer-sign-in) documentation before you continue.

### Frequently having to reenter credentials

Having to reenter credentials is most likely the result of Conditional Access policies set by your Microsoft Entra admin. When Storage Explorer asks you to reenter credentials from the account panel, you should see an **Error details** link. Select it to see why Storage Explorer is asking you to reenter credentials. Conditional Access policy errors that require reentering of credentials might look something like these:

- The refresh token has expired.
- You must use multifactor authentication to access.
- Your admin made a configuration change.

To reduce the frequency of having to reenter credentials because of errors like the preceding ones, talk to your Microsoft Entra admin.

### Other conditional access policy issues

If you have other conditional access policies that need to be satisfied for your account, try using either the **Authentication Broker** or **Default Web Browser** value for the **Sign in with** setting. For information on that setting, see [Changing where sign-in happens](/azure/storage/common/storage-explorer-sign-in#changing-where-sign-in-happens).

### Issues with authentication broker on Windows

The Windows operating system uses the Web Account Manager (WAM) as its authentication broker. If you're using the **Authentication Broker** sign-in method on Windows and experience issues, see [this guide](/entra/msal/dotnet/advanced/exceptions/wam-errors) for steps to resolve common errors.

### Browser complains about HTTP redirect or insecure connection during sign-in

When Storage Explorer performs sign-in in your web browser, a redirect to localhost is done at the end of the sign-in process. Browsers sometimes raise a warning or error that the redirect is being performed with HTTP instead of HTTPS. Some browsers might also try to force the redirect to be performed with HTTPS. If either of these issues happens, depending on your browser, you have options:

- Ignore the warning.
- Add an exception for localhost.
- Disable force HTTPS, either globally or just for localhost.

If you can't do any of those options, you can also [change where sign-in happens](/azure/storage/common/storage-explorer-sign-in#changing-where-sign-in-happens) to integrated sign-in to avoid using your browser altogether.

### Unable to acquire token, tenant is filtered out

Sometimes you may see an error message that says a token can't be acquired because a tenant is filtered out. This means you're trying to access a resource that's in a tenant you filtered out. To include the tenant, go to the **Account Panel**. Make sure the checkbox for the tenant specified in the error is selected. For more information on filtering tenants in Storage Explorer, see [Managing accounts](/azure/storage/common/storage-explorer-sign-in#managing-accounts).

### Authentication library failed to start properly

If, on startup, you see an error message that says Storage Explorer's authentication library failed to start properly, make sure your installation environment meets all [prerequisites](/azure/vs-azure-tools-storage-manage-with-storage-explorer#prerequisites). Not meeting prerequisites is the most likely cause of this error message.

If you believe that your installation environment meets all prerequisites, [open an issue on GitHub](https://github.com/Microsoft/AzureStorageExplorer/issues/new). When you open your issue, make sure to include:

- Your OS.
- What version of Storage Explorer you're trying to use.
- Whether you checked the prerequisites.
- [Authentication logs](#authentication-logs) from an unsuccessful launch of Storage Explorer. Verbose authentication logging is automatically enabled after this type of error occurs.

### Blank window when you use integrated sign-in

If you choose to use **Integrated Sign-in** and you see a blank sign-in window, you likely need to switch to a different sign-in method. Blank sign-in dialog boxes most often occur when an Active Directory Federation Services server prompts Storage Explorer to perform a redirect that's unsupported by Electron.

To change to a different sign-in method, change the **Sign in with** setting under **Settings** > **Application** > **Sign-in**. For information on the different types of sign-in methods, see [Changing where sign in happens](/azure/storage/common/storage-explorer-sign-in#changing-where-sign-in-happens).

### Reauthentication loop or UPN change

If you're in a reauthentication loop or have changed the UPN of one of your accounts, try these steps:

1. Open Storage Explorer.
1. Go to **Help** > **Reset**.
1. Make sure at least **Authentication** is selected. Clear other items you don't want to reset.
1. Select **Reset**.
1. Restart Storage Explorer and try to sign in again.

If you continue to have issues after you do a reset, try these steps:

1. Open Storage Explorer.
1. Remove all accounts and then close Storage Explorer.
1. Delete the *.IdentityService* folder from your machine. On Windows, the folder is located at *C:\users\\<username\>\AppData\Local*. For Mac and Linux, you can find the folder at the root of your user directory.
1. If you're running Mac or Linux, you also need to delete the `Microsoft.Developer.IdentityService` entry from your operating system's keystore. On the Mac, the keystore is the Gnome Keychain application. In Linux, the application is typically called *Keyring*, but the name might differ depending on your distribution.
1. Restart Storage Explorer and try to sign in again.

### macOS: Keychain errors or no sign-in window

macOS Keychain can sometimes enter a state that causes issues for the Storage Explorer authentication library. To get Keychain out of this state, follow these steps:

1. Close Storage Explorer.
1. Open Keychain by selecting <kbd>Command</kbd> + <kbd>Spacebar</kbd>, type *keychain*, and select <kbd>Enter</kbd>.
1. Select the **login** keychain.
1. Select the **padlock** to lock the keychain. After the process is finished, the **padlock** appears locked. It might take a few seconds, depending on what apps you have open.

    :::image type="content" source="media/storage-explorer-troubleshooting/unlockingkeychain.png" alt-text="Screenshot that shows the padlock.":::

1. Open Storage Explorer.
1. You're prompted with a message like "Service hub wants to access the Keychain." Type your Mac admin account password and select **Always Allow**. Or select **Allow** if **Always Allow** isn't available.
1. Try to sign in.

### Linux: No application window or password manager errors at startup

If you start Storage Explorer on a Linux system, you may encounter one of the following issues:

- No application window appears.
- Errors about the system's password manager occur.

Storage Explorer uses the system's credential manager to protect your data, including sign-in credentials and SAS connections. If no compatible credential manager application is detected, Storage Explorer won't start. If your system doesn't have a local credential management tool installed, install a third-party tool compatible with `libsecret`. For example, on Linux systems that use the GNOME desktop environment, you can install [Seahorse](https://wiki.gnome.org/Apps/Seahorse/).

Storage Explorer usually creates a default keyring if it doesn't exist at startup. However, in some cases, this might not occur, resulting in no application window or password manager service errors. To resolve the issues, manually set a default keyring.

If you're using Seahorse and there are no existing keyrings, or you want to create a new one, follow these steps to create a default keyring:

1. Start the "Passwords and Keys" application.
2. Select the "+" button, and then select **Password keyring**.
3. Set a name and a password for the new keyring.
4. Right-click the new keyring and select **Set as default**.

If you use the Storage Explorer snap, you must also make sure Storage Explorer is connected to your system's password manager. To do this, run the following command:

```bash
snap connect storage-explorer:password-manager-service :password-manager-service
```

### Default browser doesn't open

If your default browser doesn't open when you try to sign in, try all of the following techniques:

- Restart Storage Explorer.
- Open your browser manually before you start to sign in.
- Try using **Integrated Sign-In**. For instructions, see [Changing where sign-in happens](/azure/storage/common/storage-explorer-sign-in#changing-where-sign-in-happens).

### Other sign-in issues

If none of the preceding instructions apply to your sign-in issue or if they fail to resolve your sign-in issue, [open an issue on GitHub](https://github.com/Microsoft/AzureStorageExplorer/issues).

### Missing subscriptions and broken tenants

If you can't retrieve your subscriptions after you successfully sign in, try the following troubleshooting methods:

- Verify that your account has access to the subscriptions you expect. You can verify your access by signing in to the portal for the Azure environment you're trying to use.
- Make sure you've signed in through the correct Azure environment like Azure, Azure China 21Vianet, Azure Germany, Azure US Government, or Custom Environment.
- If you're behind a proxy server, make sure you configured the Storage Explorer proxy correctly.
- Try removing and adding back the account.
- If there's a "More information" or "Error details" link, check which error messages are being reported for the tenants that are failing. If you aren't sure how to respond to the error messages, [open an issue in GitHub](https://github.com/Microsoft/AzureStorageExplorer/issues).

## Problem interacting with your OS credential store during an AzCopy transfer

If you see this message on Windows, the Windows Credential Manager is most likely full. To make room in the Windows Credential Manager, follow these steps:

1. Close Storage Explorer.
1. On the **Start** menu, search for **Credential Manager** and open it.
1. Go to **Windows Credentials**.
1. Under **Generic Credentials**, look for entries associated with programs you no longer use and delete them. You can also look for entries like `azcopy/aadtoken/<some number>` and delete those entries.

If the message continues to appear after completing the above steps, or if you encounter this message on platforms other than Windows, you can [open an issue on GitHub](https://github.com/Microsoft/AzureStorageExplorer/issues).

## Can't remove an attached storage account or resource

If you can't remove an attached account or storage resource through the UI, you can manually delete all attached resources by deleting the following folders:

- Windows: *%AppData%/StorageExplorer*
- macOS: */Users/<your_name>/Library/Application Support/StorageExplorer*
- Linux: *~/.config/StorageExplorer*

Close Storage Explorer before you delete these folders.

> [!NOTE]
> If you've ever imported any SSL certificates, back up the contents of the *certs* directory. Later, you can use the backup to reimport your SSL certificates.

## Proxy issues

Storage Explorer supports connecting to Azure Storage resources via a proxy server. If you experience any issues when you connect to Azure via proxy, here are some suggestions.

Storage Explorer only supports basic authentication with proxy servers. Other authentication methods, such as NTLM, aren't supported.

> [!NOTE]
> Storage Explorer doesn't support proxy autoconfig files for configuring proxy settings.

### Verify Storage Explorer proxy settings

The **Application** > **Proxy** > **Proxy configuration** setting determines which source Storage Explorer gets the proxy configuration from.

If you select **Use environment variables**, make sure to set the `HTTPS_PROXY` or `HTTP_PROXY` environment variables. Environment variables are case-sensitive, so be sure to set the correct variables. If these variables are undefined or invalid, Storage Explorer won't use a proxy. Restart Storage Explorer after you modify any environment variables.

If you select **Use app proxy settings**, make sure the in-app proxy settings are correct.

### Steps for diagnosing issues

If you're still experiencing issues, try these troubleshooting methods:

1. If you can connect to the internet without using your proxy, verify that Storage Explorer works without proxy settings enabled. If Storage Explorer connects successfully, there might be an issue with your proxy server. Work with your admin to identify the problems.
1. Verify that other applications that use the proxy server work as expected.
1. Verify that you can connect to the portal for the Azure environment you're trying to use.
1. Verify that you can receive responses from your service endpoints. Enter one of your endpoint URLs into your browser. If you can connect, you should receive an `InvalidQueryParameterValue` or a similar XML response.
1. Check whether someone else using Storage Explorer with the same proxy server can connect. If they can, you might have to contact your proxy server admin.

### Tools for diagnosing issues

A networking tool, such as Fiddler, can help you diagnose problems.

1. Configure your networking tool as a proxy server running on the local host. If you have to continue working behind an actual proxy, you might have to configure your networking tool to connect through the proxy.
1. Check the port number used by your networking tool.
1. Configure Storage Explorer proxy settings to use the local host and the networking tool's port number, such as `localhost:8888`.

When set correctly, your networking tool logs network requests made by Storage Explorer to management and service endpoints.

If your networking tool doesn't appear to be logging Storage Explorer traffic, try testing your tool with a different application. For example, enter the endpoint URL for one of your storage resources, such as `https://contoso.blob.core.windows.net/` in a web browser. You'll receive a response similar to this code sample：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Error>
    <Code>InvalidQueryParameterValue</Code>
    <Message>Value for one of the query parameters specified in the request URI is invalid.
        RequestId:<RequestId> Time:2017-04-10T21:42:17.3863214Z</Message>
    <QueryParameterName>comp</QueryParameterName>
    <QueryParameterValue/>
    <Reason/>
</Error>
```

The response suggests the resource exists, even though you can't access it.

If your networking tool only shows traffic from other applications, you might need to adjust the proxy settings in Storage Explorer. Otherwise, you might need to adjust your tool's settings.

### Contact proxy server admin

If your proxy settings are correct, you might have to contact your proxy server admin to:

- Make sure your proxy doesn't block traffic to Azure management or resource endpoints.
- Verify the authentication protocol used by your proxy server. Storage Explorer only supports basic authentication protocols. Storage Explorer doesn't support NTLM proxies.

## "Unable to Retrieve Children" error message

If you're connected to Azure through a proxy, verify that your proxy settings are correct.

If the owner of a subscription or account has granted you access to a resource, verify that you have read or listed permissions for that resource.

## Connection string doesn't have complete configuration settings

If you receive this error message, it's possible that you don't have the necessary permissions to obtain the keys for your storage account. To confirm, go to the portal and locate your storage account. Right-click the node for your storage account and select **Open in Portal**. Then, go to the **Access Keys** pane. If you don't have permission to view keys, you'll see a "You don't have access" message. To work around this issue, you can obtain either an account name and key or an account shared access signature and use it to attach the storage account.

If you do see the account keys, file an issue in GitHub so we can help you resolve the issue.

## "Error occurred while adding new connection: TypeError: Cannot read property 'version' of undefined"

If you receive this error message when you try to add a custom connection, the connection data that are stored in the local credential manager might be corrupted. To work around this issue, try deleting and adding back your corrupted local connections:

1. Start Storage Explorer. From the menu, go to **Help** > **Toggle Developer Tools**.
1. In the opened window, on the **Application** tab, go to **Local Storage** > **file://** on the left side.
1. Depending on the type of connection you're having an issue with, look for its key. Then copy its value into a text editor. The value is an array of your custom connection names, such as:

    - Storage accounts
        - `StorageExplorer_CustomConnections_Accounts_v1`
    - Blob containers
        - `StorageExplorer_CustomConnections_Blobs_v1`
        - `StorageExplorer_CustomConnections_Blobs_v2`
    - File shares
        - `StorageExplorer_CustomConnections_Files_v1`
    - Queues
        - `StorageExplorer_CustomConnections_Queues_v1`
    - Tables
        - `StorageExplorer_CustomConnections_Tables_v1`

1. After you save your current connection names, set the value in **Developer Tools** to `[]`.

To preserve the connections that aren't corrupted, use the following steps to locate the corrupted connections. If you don't mind losing all existing connections, skip these steps and follow the platform-specific instructions to clear your connection data.

1. From a text editor, add back each connection name to **Developer Tools**. Then check whether the connection is still working.
1. If a connection is working correctly, it's not corrupted; you can safely leave it there. If a connection isn't working, remove its value from **Developer Tools**, and record it so you can add it back later.
1. Repeat until you've examined all your connections.

After removing connection names, you must clear their corrupted data. Then you can add the connections back by using the standard connect steps in Storage Explorer.

## [Windows](#tab/Windows)

1. On the **Start** menu, search for **Credential Manager** and open it.
1. Go to **Windows Credentials**.
1. Under **Generic Credentials**, look for entries that have the `<connection_type_key>/<corrupted_connection_name>` key. An example is `StorageExplorer_CustomConnections_Accounts_v1/account1`.
1. Delete and add back these connections.

## [macOS](#tab/macOS)

1. Open Spotlight by selecting <kbd>Command</kbd> + <kbd>Space</kbd> and search for **Keychain access**.
1. Look for entries that have the `<connection_type_key>/<corrupted_connection_name>` key. An example is `StorageExplorer_CustomConnections_Accounts_v1/account1`.
1. Delete and add back these connections.

## [Ubuntu](#tab/linux-ubuntu)

Local credential management varies depending on your system configuration. If your system doesn't have a tool for local credential management installed, you may install a third-party tool compatible with `libsecret` to manage your local credentials. For example, on systems using GNOME, you can install [Seahorse](https://wiki.gnome.org/Apps/Seahorse/).

1. Open your local credential management tool. Find your saved credentials.
1. Look for entries that have the `<connection_type_key>/<corrupted_connection_name>` key (for example `StorageExplorer_CustomConnections_Accounts_v1/account1`).
1. Delete and add back these connections.

## [Red Hat Enterprise Linux](#tab/linux-rhel)

Local credential management varies depending on your system configuration. If your system doesn't have a tool for local credential management installed, you may install a third-party tool compatible with `libsecret` to manage your local credentials. For example, on systems using GNOME, you can install [Seahorse](https://wiki.gnome.org/Apps/Seahorse/).

1. Open your local credential management tool. Find your saved credentials.
1. Look for entries that have the `<connection_type_key>/<corrupted_connection_name>` key (for example `StorageExplorer_CustomConnections_Accounts_v1/account1`).
1. Delete and add back these connections.

## [SUSE Linux Enterprise Server](#tab/linux-sles)

> [!NOTE]
> Storage Explorer has not been tested for SLES. You may try using Storage Explorer on your system, but we cannot guarantee that Storage Explorer will work as expected.

Local credential management varies depending on your system configuration. If your system doesn't have a tool for local credential management installed, you may install a third-party tool compatible with `libsecret` to manage your local credentials. For example, on systems using GNOME, you can install [Seahorse](https://wiki.gnome.org/Apps/Seahorse/).

1. Open your local credential management tool. Find your saved credentials.
1. Look for entries that have the `<connection_type_key>/<corrupted_connection_name>` key (for example `StorageExplorer_CustomConnections_Accounts_v1/account1`).
1. Delete and add back these connections.

---

If you still encounter this error after you run these steps, or if you want to share what you suspect has corrupted the connections, [open an issue](https://github.com/microsoft/AzureStorageExplorer/issues) on our GitHub page.

## Issues with a shared access signature URL

If you connect to a service through a shared access signature URL and experience an error:

- Verify that the URL provides the necessary permissions to read or list resources.
- Verify that the URL hasn't expired.
- If the shared access signature URL is based on an access policy, verify that the access policy hasn't been revoked.

If you accidentally attached by using an invalid shared access signature URL and now can't detach, follow these steps:

1. When you're running Storage Explorer, select <kbd> F12 </kbd> to open the **Developer Tools** window.
1. On the **Application** tab, select **Local Storage** > **file://** on the left side.
1. Find the key associated with the service type of the shared access signature URI. For example, if the bad shared access signature URI is for a blob container, look for the key named `StorageExplorer_AddStorageServiceSAS_v1_blob`.
1. The value of the key should be a JSON array. Find the object associated with the bad URI, and delete it.
1. Select <kbd>Ctrl</kbd> +<kbd>R</kbd> to reload Storage Explorer.

## Storage Explorer dependencies

## [Windows](#tab/Windows)

Storage Explorer comes packaged with all dependencies it needs to run on Windows.

## [macOS](#tab/macOS)

Storage Explorer comes packaged with all dependencies it needs to run on macOS.

## [Ubuntu](#tab/linux-ubuntu)

### Snap

Storage Explorer 1.10.0 and later is available as a snap from the Snap Store. The Storage Explorer snap installs all its dependencies automatically. It's updated when a new version of the snap is available. Installing the Storage Explorer snap is the recommended method of installation.

Storage Explorer requires a password manager, which you might need to connect manually before Storage Explorer works correctly. You can connect Storage Explorer to your system's password manager by running the following command:

```bash
snap connect storage-explorer:password-manager-service :password-manager-service
```

### .tar.gz file

You can also download the application as a *.tar.gz* file, but you have to install dependencies manually.

Storage Explorer requires the [.NET 6 runtime](/dotnet/core/install/linux) to be installed on your system. The ASP.NET runtime isn't required.

> [!NOTE]
> Older versions of Storage Explorer may require a different version of .NET or .NET Core. Refer to release notes or in-app error messages to help determine the required version.

Many libraries needed by Storage Explorer come preinstalled with Canonical's standard installations of Ubuntu. Custom environments might be missing some of these libraries. If you have issues launching Storage Explorer, make sure the following packages are installed on your system:

- `iproute2`
- `libasound2`
- `libatm1`
- `libgconf-2-4`
- `libnspr4`
- `libnss3`
- `libpulse0`
- `libsecret-1-0`
- `libx11-xcb1`
- `libxss1`
- `libxtables11`
- `libxtst6`
- `xdg-utils`

## [Red Hat Enterprise Linux](#tab/linux-rhel)

### Snap

Storage Explorer 1.10.0 and later is available as a snap from the Snap Store. The Storage Explorer snap installs all its dependencies automatically. It's updated when a new version of the snap is available. Installing the Storage Explorer snap is the recommended method of installation.

Storage Explorer requires a password manager, which you might need to connect manually before Storage Explorer works correctly. You can connect Storage Explorer to your system's password manager by running the following command:

```bash
snap connect storage-explorer:password-manager-service :password-manager-service
```

### .tar.gz file

> [!NOTE]
> Storage Explorer, as provided in the *.tar.gz* download, is supported for Ubuntu only. Storage Explorer might work on RHEL, but it's not officially supported.

You can also download the application as a *.tar.gz* file, but you have to install dependencies manually.

Storage Explorer requires the [.NET 6 runtime](/dotnet/core/install/linux) to be installed on your system. The ASP.NET runtime is *not* required.

> [!NOTE]
> Older versions of Storage Explorer may require a different version of .NET or .NET Core. Refer to release notes or in-app error messages to help determine the required version.

Many libraries needed by Storage Explorer may be missing in RHEL environments. If you have issues launching Storage Explorer, make sure the following packages (or their RHEL equivalents) are installed on your system:

- `iproute2`
- `libasound2`
- `libatm1`
- `libgconf-2-4`
- `libnspr4`
- `libnss3`
- `libpulse0`
- `libsecret-1-0`
- `libx11-xcb1`
- `libxss1`
- `libxtables11`
- `libxtst6`
- `xdg-utils`

## [SUSE Linux Enterprise Server](#tab/linux-sles)

> [!NOTE]
> Storage Explorer hasn't been tested for SLES. You may try using Storage Explorer on your system, but we can't guarantee that Storage Explorer will work as expected.

### Snap

Storage Explorer 1.10.0 and later is available as a snap from the Snap Store. The Storage Explorer snap installs all its dependencies automatically. It's updated when a new version of the snap is available. Installing the Storage Explorer snap is the recommended method of installation.

Storage Explorer requires a password manager, which you might need to connect manually before Storage Explorer works correctly. You can connect Storage Explorer to your system's password manager by running the following command:

```bash
snap connect storage-explorer:password-manager-service :password-manager-service
```

### .tar.gz file

You can also download the application as a *.tar.gz* file, but you have to install dependencies manually.

Storage Explorer requires the [.NET 6 runtime](/dotnet/core/install/linux) to be installed on your system. The ASP.NET runtime is *not* required.

> [!NOTE]
> Older versions of Storage Explorer may require a different version of .NET or .NET Core. Refer to release notes or in-app error messages to help determine the required version.

Many libraries needed by Storage Explorer may be missing in SLES environments. If you have issues launching Storage Explorer, make sure the following packages (or their SLES equivalents) are installed on your system:

- `iproute2`
- `libasound2`
- `libatm1`
- `libgconf-2-4`
- `libnspr4`
- `libnss3`
- `libpulse0`
- `libsecret-1-0`
- `libx11-xcb1`
- `libxss1`
- `libxtables11`
- `libxtst6`
- `xdg-utils`

---

### Patch Storage Explorer for newer versions of .NET Core

For Storage Explorer 1.7.0 or earlier versions, you might have to patch the version of .NET Core used by Storage Explorer:

1. Go to the [NuGet](https://www.nuget.org/packages/StreamJsonRpc/1.5.43) page and download version 1.5.43 of StreamJsonRpc from the **Download package** link on the right side.
1. After you download the package, change its file extension from .nupkg to .zip.
1. Unzip the package.
1. Open the *streamjsonrpc.1.5.43/lib/netstandard1.1/* folder.
1. Copy *StreamJsonRpc.dll* to the following locations in the Storage Explorer folder:

   - *StorageExplorer/resources/app/ServiceHub/Services/Microsoft.Developer.IdentityService/*
   - *StorageExplorer/resources/app/ServiceHub/Hosts/ServiceHub.Host.Core.CLR.x64/*

## "Open In Explorer" button in the Azure portal doesn't work

If the **Open In Explorer** button in the Azure portal doesn't work, make sure you're using a compatible browser. The following browsers were tested for compatibility:

- Microsoft Edge
- Mozilla Firefox
- Google Chrome
- Microsoft Internet Explorer

## Gather logs

When you report an issue to GitHub, you might be asked to gather certain logs to help diagnose your issue.

### Storage Explorer logs

Storage Explorer logs various things to its own application logs. You can easily get to these logs by selecting **Help** > **Open Logs Directory**. By default, Storage Explorer logs at a low level of verbosity. To change the verbosity level, go to **Settings** (the **gear** symbol on the left) > **Application** > **Logging** > **Log Level**. You can then set the log level as needed. For troubleshooting, the **Trace** log level is recommended as it's the most verbose level. After changing the log level, restart Storage Explorer and reproduce the issue you're having.

Logs are split into folders for each session of Storage Explorer that you run. For whatever log files you need to share, place them in a zip archive, with files from different sessions in different folders.

### Authentication logs

For issues related to sign-in or Storage Explorer's authentication library, you most likely need to gather authentication logs. Authentication logs are stored at:

- Windows: *C:\Users\\<your username\>\AppData\Local\Temp\servicehub\logs*
- macOS: *~/.ServiceHub/logs*
- Linux: *~/.ServiceHub/logs*

Generally, you can follow these steps to gather the logs:

1. Go to **Settings** (the **gear** symbol on the left) > **Application** > **Sign-in**. Select **Verbose Authentication Logging**. If Storage Explorer fails to start because of an issue with its authentication library, this step is done for you.
1. Close Storage Explorer.
1. Optional/recommended: Clear out existing logs from the *logs* folder. This step reduces the amount of information you have to send us.
1. Open Storage Explorer and reproduce your issue.
1. Close Storage Explorer.
1. Zip the contents of the *logs* folder.

### AzCopy logs

If you're having trouble transferring data, you might need to get the AzCopy logs. By default, AzCopy logs at a low level of verbosity. To change the verbosity level, go to **Settings** (the **gear** symbol on the left) > **Transfers** > **AzCopy** > **Log Level**. You can then set the log level as needed. For troubleshooting, the **Debug** log level is recommended as it's the most verbose level. After changing the log level, restart Storage Explorer and reproduce the issue you're having.

AzCopy logs can be found easily via two different methods:

- For failed transfers still in the Activity Log, select **Go to AzCopy Log File**.
- For transfers that failed in the past, go to the AzCopy logs folder. This folder can be found at:
  - Windows: *C:\Users\\<your username\>\\.azcopy*
  - macOS: *~/.azcopy*
  - Linux: *~/.azcopy*

### Network logs

For some issues, you need to provide logs of the network calls made by Storage Explorer. On Windows, you can get network logs by using Fiddler.

> [!NOTE]
> Fiddler traces might contain passwords you entered or sent in your browser during the gathering of the trace. Make sure to read the instructions on how to sanitize a Fiddler trace. Don't upload Fiddler traces to GitHub. You'll be told where you can securely send your Fiddler trace.

#### Part 1: Install and configure Fiddler

1. Install Fiddler.
1. Start Fiddler.
1. Go to **Tools** > **Options**.
1. Select the **HTTPS** tab.
1. Make sure **Capture CONNECTs** and **Decrypt HTTPS traffic** are selected.
1. Select **Actions**.
1. Select **Trust Root Certificate** and then select **Yes** in the next dialog box.
1. Start Storage Explorer.
1. Go to **Settings** (the **gear** symbol on the left) > **Application** > **Proxy**.
1. Change the proxy source dropdown to **Use system proxy (preview)**.
1. Restart Storage Explorer.
1. You should start seeing network calls from a `storageexplorer:` process show up in Fiddler.

#### Part 2: Reproduce the issue

1. Close all apps other than Fiddler.
1. Clear the Fiddler log by using the **X** in the top left corner, near the **View** menu.
1. Optional/recommended: Let Fiddler set for a few minutes. If you see network calls appear that aren't related to Storage Explorer, right-click them and select **Filter Now** > **Hide \<process name\>**.
1. Start/restart Storage Explorer.
1. Reproduce the issue.
1. Select **File** > **Save** > **All Sessions**. Save it somewhere you won't forget.
1. Close Fiddler and Storage Explorer.

#### Part 3: Sanitize the Fiddler trace

1. Double-click the Fiddler trace (.saz file).
1. Select <kbd>Ctrl</kbd> + <kbd>F</kbd>.
1. In the dialog box that appears, make sure the following options are set: **Search** = **Requests and responses** and **Examine** = **Headers and bodies**.
1. Search for any passwords you used while you collected the Fiddler trace and any entries that are highlighted. Right-click and select **Remove** > **Selected sessions**.
1. If you definitely entered passwords into your browser while you collected the trace, but you don't find any entries when you use <kbd>Ctrl</kbd> + <kbd>F</kbd>, you don't want to change your passwords, or if the passwords you used are used for other accounts, skip sending us the .saz file.
1. Save the trace again with a new name.
1. Optional: Delete the original trace.

## Next steps

If none of these solutions work for you, use one of the following methods:

- [Create a support ticket](https://aka.ms/storageexplorer/servicerequest).
- [Open an issue on GitHub](https://github.com/Microsoft/AzureStorageExplorer/issues) by selecting the **Report issue to GitHub** button in the lower-left corner.

    :::image type="content" source="media/storage-explorer-troubleshooting/feedback-button.png" alt-text="Screenshot that shows the feedback button.":::

[!INCLUDE [Third-party information disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
