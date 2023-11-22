---
title: Kerberos double-hop authentication with Microsoft Edge (Chromium)
description: This article introduces extra steps to set up integrated Windows authentication with Microsoft Edge (Chromium).
ms.date: 11/22/2023
ms.custom: sap:WWW authentication and authorization
ms.reviewer: aartigoyle, dili
author: HaiyingYu
ms.author: haiyingyu
ms.technology: iis-www-authentication-authorization
---
# Kerberos unconstrained double-hop authentication with Microsoft Edge (Chromium)

_Applies to:_ &nbsp; Internet Information Services

## Introduction

Setting up Windows Authentication based on the Kerberos authentication protocol can be a complex endeavor, especially when dealing with scenarios such as delegation of identity from a front-end site to a back-end service in the context of IIS and ASP.NET. Follow this article's steps to set up the delegation of authentication tickets and use services with a modern browser such as Microsoft Edge version 87 or above.

This article assumes that you are setting up an architecture similar to the one represented in the diagram below:

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/architecture-windows-authentication-protocol.png" alt-text="Diagram showing the architecture of Windows Authentication based on the Kerberos authentication protocol.":::

- The **Workstation-Client1** computer is part of the same active directory as primary Web-Server, called **Primary-IIS-SRV** and the backend web server, called **Backend-Web-SRV**.
- Users of the computer **Workstation-Client1** will log on to the machine using the Windows Active Directory account.
- Then they will launch a browser (Microsoft Edge), navigate to a website located on Web-Server, which is the alias name used for **Primary-IIS-SRV**, and authenticate via integrated Windows authentication using Kerberos.
- The website located on Web-Server will make HTTP calls using authenticated user's credentials to API-Server (which is the alias for **Backend-Web-SRV**) to retrieve application data on behalf of users, using Kerberos credential delegation.

The steps below will help you troubleshoot this scenario: The setup works with Internet Explorer, but when users adopt Microsoft Edge, they can no longer use the credential delegation feature. To use Kerberos credential delegation, refer to [Troubleshoot Kerberos failures in Internet Explorer](troubleshoot-kerberos-failures-ie.md) first.

## Constrained or unconstrained delegation

In the scenario above, both configurations allow users to delegate credentials from their user session on machine **Workstation-Client1** to the back-end API server while connecting through the front-end Web-Server.

In an unconstrained Kerberos delegation configuration, the application pool identity runs on Web-Server and is configured in Active Directory to be trusted for delegation to any service. The application pool's account running on Web-Server can delegate the credentials of authenticated users of the website hosted on that server to any other service in the active directory. For example, an SMTP server, a file server, a database server, another web server, etc. This is called unconstrained delegation because the application pool account has the permission (it's unconstrained) to delegate credentials to any service it contacts.

In a constrained delegation configuration, the active directory account that is used as an application pool identity can delegate the credentials of authenticated users only to a list of services that have been authorized to delegate. If the web-application residing on the server called Web-Server must also contact a database and authenticate on behalf of the user, this service principal name (SPN) must be added to the list of authorized services.  

Constrained delegation is more secure than unconstrained delegation based on the principle of least privilege. An application is granted the rights it needs to function and nothing more, whereas unconstrained delegation allows an application to contact resources it shouldn't contact on behalf of the user.

## How to know whether the Kerberos ticket obtained on the client to send to the Web-Server uses constrained or unconstrained delegation?

Use the klist command tool present in Windows to list the cache of Kerberos tickets from the client machine (**Workstation-Client1** in the diagram above). Look for a ticket named HTTP/\<Name of Web-Server>. **Note**: \<Name of Web-Server> is the SPN of the service you wish to contact and authenticate to via Kerberos. The ticket also contains a few flags. Two of them are of interest: `forwardable` and `ok_as_delegate`.

- The first flag, `forwardable`, indicates that the KDC (key distribution center) can issue a new ticket with a new network mask if necessary. This allows for a user to log into a remote system and for the remote system to obtain a new ticket on behalf of the user to log into another backend system as if the user had logged into the remote system locally.

- The second flag, `ok_as_delegate` indicates that the service account of the service the user is trying to authenticate to (in the case of the above diagram, the application pool account of the IIS application pool hosting the web-application) is trusted for unconstrained delegation.

If these services are using unconstrained delegation, the tickets on the client machine contain the `ok_as_delegate` and `forwardable` flags. In most cases, when constrained delegation is configured, the tickets don't contain the `ok_as_delegate` flag but contain the `forwardable` flag.

## Why does unconstrained delegation work in Internet Explorer and not in Microsoft Edge?

When an attempt is made to authenticate to a website using Kerberos based authentication, the browser calls a Windows API to set up the authentication context. The API in question is `InitializeSecurityContext`. This API might receive a series of flags to indicate whether the browser allows the `delegatable` ticket the user has received. The ticket is marked as `delegatable` because the service the user is trying to authenticate to has the right to delegate credentials in an unconstrained manner. However, that doesn't mean that the application trying to authenticate (in this case the browser) should use this capacity.

By default, Internet Explorer passes the flag to `InitializeSecurityContext`, indicating that if the ticket can be delegated, then it should be. Microsoft Edge from version 87 and above doesn't pass the flag to `InitializeSecurityContext` just because the ticket is marked with the `ok_as_delegate` flag. We don't recommend using unconstrained delegation in applications because it gives applications more privileges than required. Applications could delegate the user's identity to any other service on the domain and authenticate as the user, which isn't necessary for most applications using credential delegation. Applications should contact only the services on the list that was specified when setting up constrained delegation.

By default, Microsoft Edge works with constrained delegation, where the IIS website running on Web-Server only has the right to contact the backend API site hosted on API-Server, as shown in the application pool identity account configuration from Active Directory listed below:

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/application-pool-identity-account-configuration.png" alt-text="Screenshot of application pool identity account configuration." border="false":::

## Enable Edge-Chromium to work with unconstrained delegation in Active Directory

For compatibility purposes, if you must maintain an application using unconstrained delegation via Kerberos, enable Microsoft Edge to allow tickets delegation. The steps below are detailed in the following sections of this article:

1. [Install the Administrative Templates for Group Policy Central Store in Active Directory (if not already present)](#step-1-install-the-administrative-templates-for-active-directory).
1. [Install the Microsoft Edge Administrative templates](#step-2-install-the-microsoft-edge-administrative-templates).
1. [Create a new Group Policy object](#step-3-create-a-new-group-policy-object).
1. [Edit the configuration of the Group Policy to allow for unconstrained delegation when authenticating to servers](#step-4-edit-the-configuration-of-the-group-policy-to-allow-for-unconstrained-delegation-when-authenticating-to-servers).
1. [(Optional) Check if Microsoft Edge is using the correct delegation flags](#step-5-optional-check-if-microsoft-edge-is-using-the-correct-delegation-flags).

### Step 1: Install the Administrative Templates for Active Directory

1. Download the templates from [Administrative Templates (.admx)](https://www.microsoft.com/download/details.aspx?id=57576) (for Windows Server 2019).

1. Download the installer and extract the contents to a folder of your choice. You can simply extract it to the default specified location of the package, which is *C:\Program Files (x86)\Microsoft Group Policy\Windows 10 October 2018 Update (1809) v2\PolicyDefinitions*.

1. Once the package is unzipped, locate the *Sysvol* folder on your domain controller. The path to the folder is *C:\Windows\SYSVOL\sysvol\\*. Inside the *Sysvol* folder is a folder with the same name as your Active Directory name (in the sample here, **Oddessy.local**). From there, navigate to the **Policies** folder. If it doesn't exist, create a folder called **Policy Definitions** as shown below:

    :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/policy-definitions-folder.png" alt-text="Screenshot of the policy definitions folder under Policies folder.":::

1. Copy the content of the *PolicyDefinitions* folder (which was extracted from the installer to the *PolicyDefinitions* folder) you created inside your domain in the *sysvol* folder on the domain controller.

    > [!NOTE]
    > The files that were extracted by the installer also contain localized content. To save space, transfer the localized files only for the desired languages. For example, the folder named fr-FR contains all localized content in French.

1. When the transfer is complete, verify that the templates are available in Active Directory. To do this, open the **Group Policy Management** snap-in of the Microsoft Management Console (press Windows+R and then type *gpmc.msc* to launch). Inside the **Group Policy Management**, find a group policy object and edit it.

    :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/group-policy-object.png" alt-text="Screenshot of the group policy object in Group Policy Management Editor.":::

    As shown in the screenshot above, under the **Computer Configuration** node, is a **Policies** node and **Administrative templates** node.

### Step 2: Install the Microsoft Edge Administrative templates

While you may have the **Policy Administrative Templates** on the domain controller to start with, you will still have to install the Microsoft Edge Policy files to have access to the policy meant for enabling double-hop unconstrained delegation through this browser. To install the Microsoft Edge Policy files, follow the steps:

1. Go to the Microsoft Edge for [business download site](https://www.microsoft.com/edge/business/download).

1. Select the version you wish to download from the **channel/version** dropdown. The latest stable version is recommended.
1. Select the build you want from the **build** dropdown and finally the target operating system from the **platform** dropdown. Once the selection is made, two more buttons (a button and a link) will appear.

    :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/download-deploy-microsoft-edge-for-business-page.png" alt-text="Screenshot of download and deploy Microsoft Edge for business page.":::

1. Click **GET POLICY FILES** and accept the license agreement to download the file called *MicrosoftEdgePolicyTemplates.cab*. This file contains the policy definition files for Microsoft Edge.
1. Double click the file to explore the content (a zip archive with the same name).
1. Extract the content of the zip archive to a folder on your local disk. The extracted content will contain a folder called *Windows* in which you will find a subfolder called *Admx*. This will contain the administrative templates as well as their localized versions (You should need them in a language other than English).

    :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/admx-folder.png" alt-text="Screenshot of the admx folder.":::

1. Transfer the *.admx* files inside the same folder under the *Sysvol* directory where the *Administrative Templates* from the previous were transferred to (in the example above: *C:\Windows\SYSVOL\sysvol\odessy.local\Policies\PolicyDefinitions*).

1. Open the Active Directory Group Policy Editor and select an existing group policy object for editing to check the presence of the newly transferred Microsoft Edge templates. These will be located in a folder called **Microsoft Edge** located underneath the **Administrative Templates** folder in the tree view:

    :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/microsoft-edge-item.png" alt-text="Screenshot of the Microsoft Edge item in Group Policy Management Editor.":::

### Step 3: Create a new Group Policy object

Here's how to create a new Group Policy object using the Active Directory Group Policy Manager MMC snap-in:

1. Press the Windows+R key to open the **Run** menu on your Domain controller.
1. Type *Gpmc.msc* to open the Microsoft Management Console and load the Active Directory Group Policy Manager snap-in.
1. Locate the **Group Policy Objects** node in the tree view of the console and right click the node to open the context menu.
1. Select the **New** menu item, fill in the name of the group policy you wish to create, and then click **OK**.

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/create-policy.png" alt-text="Screenshot of the new menu item in Group Policy Management Editor." border="false":::

### Step 4: Edit the configuration of the Group Policy to allow for unconstrained delegation when authenticating to servers

The final step is to enable the policy that allows the Microsoft Edge browser to pass the `ok_as_delegate` flag to the `InitializeSecurityContext` api call when performing authentication using Kerberos to a Windows Integrated enabled website. If you don't know whether your Microsoft Edge browser is using Kerberos to authenticate (and not NTLM), refer to [Troubleshoot Kerberos failures in Internet Explorer](troubleshoot-kerberos-failures-ie.md).

In the Active Directory Group Policy Editor, select the group policy object that will be applied to the computers inside your Active Directory from which you intend to allow end users to authenticate via Kerberos authentication and have their credentials delegated to backend services through unconstrained delegation. The policy that will enable unconstrained delegation from Microsoft Edge is located under the **Http authentication** folder of the **Microsoft Edge** templates as shown below:

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/http-authentication.png" alt-text="Screenshot of the H T T P authentication folder in Group Policy Management Editor." border="false":::

Use this setting to configure a list of servers for which delegation of Kerberos tickets is allowed.

> [!NOTE]
> A list of servers must be provided. In the example used at the beginning of this article, you would have to add the Web-Server server name to the list to allow the front-end Web-Server web-application to delegate credentials to the backend API-Server.

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/credentials-servers.png" alt-text="Screenshot of a list of servers." border="false":::

After the newly editing group policy object is applied to the client computers inside the domain, go to the test authentication page in [Diagnostic pages for Windows Integrated Authentication Troubleshooting](diagnostics-pages-windows-integrated-authentication.md) and download the whoami.aspx page from the [ASP.net Samples Repository](https://github.com/aspnet/samples/tree/main/samples/aspnet/Identity/CurrentUserInfoRetrieval) on GitHub. It will yield a **ImpersonationLevel** setting of Delegate instead of **Impersonate** signaling that the delegation of credentials is now allowed.

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/authpage-delegation.png" alt-text="Screenshot of ImpersonationLevel setting page.":::

To test if the policy was applied correctly on the client workstation, open a new Microsoft Edge tab and type *edge://policy*.

:::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/policies-page.png" alt-text="Screenshot of edge://policy page.":::

The `AuthNegotiateDelegateAllowlist` policy should be set to indicate the values of the server names for which Microsoft Edge is allowed to perform delegation of Kerberos tickets. If the policy doesn't appear in the list, it hasn't been deployed or was deployed on the wrong computers.

### Step 5 (Optional): Check if Microsoft Edge is using the correct delegation flags

Here is the troubleshooting/optional check step.

Once the policy has been configured and deployed, the following steps must be taken to verify whether Microsoft Edge is passing the correct delegation flags to `IntializeSecurityContext`. The steps use tools that are already built into Microsoft Edge or that are available as online services.

1. Use the logging feature available in Microsoft Edge to log what the browser is doing when requesting a website. To enable logging:

    1. Open a new Microsoft Edge window and type *edge://net-export/*.
    1. Use the **Include cookies and credentials** option when tracing. Without this option authentication trace level data will be omitted.

        :::image type="content" source="./media/kerberos-double-hop-authentication-edge-chromium/net-export-page.png" alt-text="Screenshot of edge://net-export/ page.":::
    1. Click the **Start Logging to Disk** button and provide the file name under which you want to save the trace.
    1. Open another Microsoft Edge tab, navigate to the website against which you wish to perform integrated Windows authentication using Microsoft Edge.
    1. Once you have tried to authenticate, go back to the previous tab where the tracing was enabled and click the **Stop Logging** button. The tracing interface will indicate where the file containing the trace has been written to.

1. Use the JSON file containing the trace to see what parameters the browser has passed to the `InitializeSecurityContext` function when attempting to authenticate. To analyze the trace, use the [netlog_viewer](https://netlog-viewer.appspot.com/#import).

1. Inside the parsed trace is an event log that resembles the following:

    ```output
    t=3076 [st=12]       +AUTH_LIBRARY_INIT_SEC_CTX  [dt=3]
                          --> flags = {"delegated":false,"mutual":false,"value":"0x00000000"}
                          --> spn = "HTTP/web-server.odessy.local"
    ```
  
    This log shows that:
  
    - `AUTH_LIBRARY_INIT_SEC_CTX` means the browser is calling the `InitializeSecurityContext` function.
    - `"delegated":false` means that the ticket shouldn't be delegated even if the ticket is marked as `delegatable`.
    - `"mutual":false` means that the client (browser) doesn't require the server to also authenticate to the client and prove its identity. Only the client should authenticate to the server to prove its identity.
    - `HTTP/web-server.odessy.local` is the SPN used by the browser when making the authentication call.

## More information

[Diagnostic pages for Windows Integrated Authentication troubleshooting](diagnostics-pages-windows-integrated-authentication.md)
