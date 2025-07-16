---
title: Troubleshoot network or proxy errors
description: Find solutions for network- or proxy-related errors that you might encounter when you install, update, or use Visual Studio behind a firewall or a proxy server.
ms.date: 02/14/2025
author: aartig13
ms.author: aartigoyle
ms.reviewer: meghaanand, chrmann, jagbal
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---
# Troubleshoot network-related errors when you install, update, or use Visual Studio

_Applies to:_&nbsp;Visual Studio

You might encounter network or proxy related errors when you install, update, or use Visual Studio behind a firewall, a proxy server, or on a client machine that doesn't have access to the internet. This article provides resolutions for some common scenarios of these issues.

## Error "Proxy authorization required"

This error generally occurs when users connect to the internet through a proxy server. The proxy server then blocks the calls that Visual Studio makes to some network resources.

### Resolution

To resolve this issue, try these steps:

1. Restart Visual Studio. A proxy authentication dialog should appear. Enter your credentials when prompted in the dialog.
1. If restarting Visual Studio doesn't solve the problem, it might be because your proxy server doesn't prompt for credentials for `http://go.microsoft.com` addresses, but it does so for `*.visualStudio.microsoft.com` addresses. For these servers, add the following URLs to an allowlist to unblock all sign-in scenarios in Visual Studio:

   - `*.windows.net`
   - `*.microsoftonline.com`
   - `*.visualstudio.microsoft.com`
   - `*.microsoft.com`
   - `*.live.com`

1. We recommend that you remove the `http://go.microsoft.com` address from the allowlist. Removing the address allows the proxy authentication dialog to show up for both the `http://go.microsoft.com` address and the server endpoints when Visual Studio restarts.

## Configure proxy server

Visual Studio should pick up the proxy setting from Windows. However, you can set a specific proxy server in the following way.

- For Visual Studio 2022, follow steps 1, 2, and 3.
- For Visual Studio 2019, follow steps 1 and 2.

1. Find **devenv.exe.config** (the configuration file of **devenv.exe**) in:

    - Visual Studio 2019: **%ProgramFiles%\Microsoft Visual Studio\2019\Enterprise\Common7\IDE** or **%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\Common7\IDE**.
    - Visual Studio 2022: **%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE** or **%ProgramFiles(x86)%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE**.

1. In the configuration file, find the `<system.net>` block, and then add this code:

    ```xml
    <defaultProxy enabled="true">
        <proxy bypassonlocal="True" proxyaddress="http://<yourproxy:port#>"/>
    </defaultProxy>
    ```

    You must insert the correct proxy address for your network in `proxyaddress="<http://<yourproxy:port#>`.

    > [!NOTE]
    > For more information, see the [\<defaultProxy> Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/defaultproxy-element-network-settings/) and [\<proxy>  Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/proxy-element-network-settings) pages.

1. For Visual Studio 2022, set the proxy environment variables:

   - http_proxy: This variable is used on HTTP requests. **Note** This variable is lowercase because some tools expect the variable to be lowercase.
   - HTTPS_PROXY: This variable is used on HTTPS requests.
   - ALL_PROXY: This variable is used to specify a proxy server for HTTP or HTTPS requests if the `HTTP_PROXY` or `HTTPS_PROXY` variable isn't defined.
    
   > [!NOTE]
   > For more information, see [HttpClient.DefaultProxy](/dotnet/api/system.net.http.httpclient.defaultproxy/).

## Default user credentials

If you want to use the default credentials for the user account which is running Visual Studio with your proxy, follow these steps:

1. Find **devenv.exe.config** (the configuration file of **devenv.exe**) in:

   - Visual Studio 2019: **%ProgramFiles%\Microsoft Visual Studio\2019\Enterprise\Common7\IDE** or **%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\Common7\IDE**.
   - Visual Studio 2022: **%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE** or **%ProgramFiles(x86)%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE**.

1. In the configuration file, find the `<system.net>` block, and then add this code:

   ```xml
   <defaultProxy enabled="true" useDefaultCredentials="true">
      <proxy bypassonlocal="True" proxyaddress="http://<yourproxy:port#>"/>
   </defaultProxy>
   ```

   You must insert the correct proxy address for your network in `proxyaddress="<http://<yourproxy:port#>`.

   > [!NOTE]
   > For more information, see the [\<defaultProxy> Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/defaultproxy-element-network-settings/) and [\<proxy>  Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/proxy-element-network-settings) pages.

1. With [Visual Studio 17.8](/visualstudio/releases/2022/release-notes-v17.8) onwards, we've updated the configuration process for default proxy credentials in web requests. To enable default proxy credentials after this update, create a new environment variable named `VS_USE_DEFAULTPROXY`, set its value to `true`, and then restart Visual Studio. This variable tells Visual Studio and associated processes to attach the default credentials of the user running the process to proxy requests. It's similar to what `useDefaultCredentials` does in the exe config file in step 2.

## Debugging proxy errors

When trying to make network connections behind a proxy server, you might encounter many different kinds of failures. Some of the failures include "error on send", "connection refused", and "could not resolve address". There might be other kinds of failures, but what they have in common is that some configuration is incorrect on the local machine or network. To help diagnose what blocks the connection, using a tool outside of Visual Studio can be helpful. 

- If you encounter an error such as connection refused or error on send, try the following command line:

   ```cmd
   curl "https://resource" -v
   ```

   Running this command makes a network connection to the resource and might fail similarly to what is seen in Visual Studio. At that point, diagnosing this failure is required before attempting to make the connection by using Visual Studio. A failure here indicates a machine or network configuration problem rather than a product issue with Visual Studio. 

- If you know you're behind a proxy server that has a specific address, setting the `http_proxy` and `https_proxy` environment variables are necessary before running the `curl` command as it uses those environment variables for proxy settings. 

  You might also use the `help` switch in curl for other options. This command `curl --help proxy` displays a list of options and switches that you can use to set up and configure a proxy with `curl`.  

- If you have a sign-in problem with Visual Studio to debug, run the following commands:

  ```cmd
  curl "https://login.microsoftonline.com/common/discovery/instance?api-version=1.1&authorization_endpoint=https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize" -v
   
  curl "https://management.azure.com" -v
   
  curl "https://graph.microsoft.com" -v
  ```

  For the URLs required by sign-in, see [Install and use Visual Studio behind a firewall or proxy server](/visualstudio/install/install-and-use-visual-studio-behind-a-firewall-or-proxy-server).

## Error "Disconnected from Visual Studio" when attempting to report a problem

This error generally occurs when a user connects to the internet through a proxy server. The proxy server then blocks the calls that Visual Studio makes to some network resources.

### Resolution

To resolve this issue, follow these steps:

1. Find _feedback.exe.config_ (the configuration file of _feedback.exe_) in: _%ProgramFiles(x86)%\Microsoft Visual Studio\Installer_ or _%ProgramFiles%\Microsoft Visual Studio\Installer_.
1. In the configuration file, check whether the following code is present. If the code isn't present, add it before the last `</configuration>` line.

   ```xml
   <system.net>
       <defaultProxy useDefaultCredentials="true" />
   </system.net>
   ```

## Error "The underlying connection was closed"

If you're using Visual Studio in a private network that has a firewall, Visual Studio might not be able to connect to some network resources. These resources can include Azure DevOps Services for sign-in and licensing, NuGet, and Azure services. If Visual Studio fails to connect to one of these resources, you might see the following error message:

> The underlying connection was closed: An unexpected error occurred on send.

Visual Studio uses Transport Layer Security (TLS) 1.2 protocol to connect to network resources. Security appliances on some private networks block certain server connections when Visual Studio uses TLS 1.2.

### Resolution

Enable connections by adding [these domain URLs](/visualstudio/install/install-and-use-visual-studio-behind-a-firewall-or-proxy-server#urls-to-add-to-an-allowlist) to an allowlist.

## Error "Failed to parse ID from parent process"

You might encounter this error message when you use a Visual Studio bootstrapper and a **response.json** file on a network drive. The error's source is the User Account Control (UAC) in Windows.

Here's why this error can happen: A mapped network drive or [UNC](/dotnet/standard/io/file-path-formats#unc-paths) share is linked to a user's access token. When UAC is enabled, two user [access tokens](/windows/win32/secauthz/access-tokens) are created: one with administrator access, and one without administrator access. When a network drive or share is created, the user's current access token is linked to it. Since the bootstrapper must be run as an administrator, it can't access the network drive or share unless either the drive or share is linked to a user-access token that has administrator access.

### Resolution

To resolve this issue, use the `net use` command or change the **UAC Group Policy** setting. For more information about these workarounds and how to implement them, see:

- [Mapped drives aren't available from an elevated prompt when UAC is configured to "Prompt for credentials" in Windows](https://support.microsoft.com/help/3035277/mapped-drives-are-not-available-from-an-elevated-prompt-when-uac-is-co)
- [Programs may be unable to access some network locations after you turn on User Account Control in Windows operating systems](https://support.microsoft.com/en-us/help/937624/programs-may-be-unable-to-access-some-network-locations-after-you-turn)

## The product fails to install or update because network share permissions aren't configured correctly

Make sure that the account performing the installation or update has sufficient access to the network shares.

| Issue | Solution |
|---|---|
| User account can't access files. | If the user has administrator permissions on the machine and is going to install or update from a layout, you need to make sure that the network share permissions (ACLs) are configured to grant users read access before the network location is shared. |
| System account can't access files. | Sometimes the installation or update is run using the system account instead of a user account. This situation typically happens when Administrator updates are used to keep the machine updated and secure. You need to make sure that the client machines' system accounts have read permissions to the network file share. You can do this by creating an Active Directory group containing the machine accounts that need access to the share, and then granting that AD group access to the share. |

## Support or troubleshooting

If your Visual Studio installation fails, see [Troubleshoot Visual Studio installation and upgrade issues](./troubleshoot-installation-issues.md) for step-by-step guidance.

More support options:

- We offer an [installation chat](https://visualstudio.microsoft.com/vs/support/#talktous) (English only) support option for installation-related issues.
- Report product issues to us via the [Report a Problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE. If you're an IT Administrator and don't have Visual Studio installed, you can submit [IT Admin feedback here](https://aka.ms/vs/admin/feedback).
- Suggest a feature, track product issues, and find answers in the [Visual Studio Developer Community](https://aka.ms/feedback/suggest?space=8).

## References

- [Troubleshoot network layout or offline installation issues](troubleshoot-installation-issues.md#network-layout-or-offline-installations)
- [Install and use Visual Studio behind a firewall or proxy server](/visualstudio/install/install-and-use-visual-studio-behind-a-firewall-or-proxy-server)
- [Visual Studio administrator guide](/visualstudio/install/visual-studio-administrator-guide)
