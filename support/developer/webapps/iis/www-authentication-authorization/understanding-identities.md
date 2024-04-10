---
title: Understanding identities in IIS
description: This article provides background information about identities in Internet Information Services.
ms.date: 10/09/2020
ms.custom: sap:WWW Authentication and Authorization
ms.reviewer: prchanda, jarrettr
---
# Understanding identities in IIS

This article provides background information about identities in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 4466942

## Application pool identities

To understand application pool identities, you have to understand what an identity is. In simple terms, an identity is a Windows account. Every process that runs in Windows runs under an identity. The applications are run by the worker process by using a Windows identity. The Windows identity that is used is dependent on the application pool identity, which can be any of the following accounts:

:::image type="content" source="media/understanding-identities/accounts.png" alt-text="Windows identity accounts.":::

- **Local System:** Trusted account that has high privileges and also has access to network resources.
- **Network Service:** Restricted or limited service account that is used to run standard, least-privileged services. This account has fewer privileges than a Local System account. This account has access to network resources.
- **Local Service:** Restricted or limited service account that is similar to Network Service and is intended to run standard, least-privileged services. This account does not have access to network resources.
- **ApplicationPoolIdentity:** When a new application pool is created, IIS creates a virtual account that has the name of the new application pool and that runs the application pool worker process under this account. This is also a least-privileged account.
- **Custom account:** In addition to these built-in accounts, you can also use a custom account by specifying the user name and password.

### Differences between application pool identities

- **Scenario 1: Event log access**  

    In this scenario, you have one web application that creates a custom event log (**MyWebAppZone**) and an event log source (**MyWebAppZone.com**) at runtime. Applications that run by using any of the identities can write to the event log by using existing event sources. However, if they are running under an identity other than Local System, they cannot create new event sources because of insufficient registry permissions.

    :::image type="content" source="media/understanding-identities/custom-event-log.png" alt-text="My Web App Zone.":::

    For example, if you run the application under Network Service, you receive the following security exception:

    :::image type="content" source="media/understanding-identities/security-exception.png" alt-text="Screenshot of the Server error.":::

    When you run the ProcMon trace simultaneously, you often find that NT AUTHORITY\NETWORK SERVICE does not have the required Read and Write access privileges to the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\`

    This is the location in the registry where all the settings of an event log are stored.

    :::image type="content" source="media/understanding-identities/process-monitor-1.png" alt-text="Screenshot of Process Monitor 1." border="false":::

- **Scenario 2: Registry access**  

    Apart from Local System, no other application pool identities have Write access to the registry. In this scenario, you have developed a simple web application that can change and display the name of the Internet time server that Windows is automatically synchronized with. If you run this application under Local Service, you  get an exception. If you check the ProcMon trace, you find that the "NT AUTHORITY\LOCAL SERVICE" application pool identity doesn't have Read and Write access in the following registry subkey:

    `HKEY_LOCAL_MACHINE** **\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers`

    :::image type="content" source="media/understanding-identities/process-monitor-2.png" alt-text="Screenshot of Process Monitor 2." border="false":::

    If you check the **MyWebAppZone** event log (from scenario 1), you find the following error event logged. It contains a `Requested registry access is not allowed` error message.

    ```output
    Exception Type: SecurityException  
    Message: Requested registry access is not allowed.  
    Stack Trace  
    at Microsoft.Win32.RegistryKey.OpenSubKey(String name, Boolean writable)  
    at Identities.ChangeTimeServer.Page_Load(Object sender, EventArgs e)  
    at System.Web.UI.Control.LoadRecursive()  
    at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
    at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
    at System.Web.UI.Page.ProcessRequest()  
    at System.Web.UI.Page.ProcessRequest(HttpContext context)  
    at ASP.changetimeserver_aspx.ProcessRequest(HttpContext context) in c:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files\root\fd06117a\f8c94323\App_Web_ysqbhk00.2.cs:line 0  
    at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
    at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)
    ```

- **Scenario 3: Custom account in Kerberos authentication and load-balanced environment**  

    You have already seen in scenarios 1 and 2 some of the differences among the built-in accounts. Now, let's discuss what a custom account is and how it has advantages over built-in accounts when you work with Kerberos authentication in a load balanced-environment.

    By using this approach, you run your application in an application pool that is configured to run by using a specific Windows identity. Consider the following diagram, in which an application is hosted in a load-balanced environment that includes two servers and uses Kerberos authentication to identify the client.

    :::image type="content" source="media/understanding-identities/kerberos-with-load-balancer.png" alt-text="Screenshot of Kerberos authentication in a load balanced-environment.":::

    For Kerberos authentication to work, you have to set up SPN for both servers by using their machine account. If the application pool is running under a built-in account, it presents the computer credentials on the network. For example, if the computer name is _Server1_, it presents itself as 'Server1$'. This machine account automatically gets created when a computer joins a domain. Therefore, if there are N servers, you must set N number of SPNs that correspond to their respective machine account.

    Registering an SPN to a machine account:

    ```console
    setspn -a HTTP/HOSTNAME MachineAccount$
    ```

    Example:

    ```console
    setspn -a HTTP/MyWebAppZone.com Server1$
    ```

    To overcome this disadvantage, you can run the application under a custom Windows (domain) identity, and then set the SPN to only that specific domain account in the domain controller.

    Registering an SPN to a domain account:

    ```console
    setspn -a HTTP/HOSTNAME domain\account
    ```

    Example:

    ```console
    setspn -a HTTP/MyWebAppZone.com contoso.com\account_alias
    ```

## Default permissions and user rights in wwwroot

IIS 7.0 and later versions also make it easier to configure an application pool identity and make all necessary changes. When IIS starts a worker process, it must create a token that the process will use. When this token is created, IIS automatically adds the `IIS_IUSRS` membership to the worker processes token at runtime. The accounts that run as _application pool identities_ no longer have to be an explicit part of the `IIS_IUSRS` group. If you create a website, and then point the physical location to `C:\inetpub\wwwroot`, the following users, and groups are automatically added to the site's access control lists.

| **Users / groups**| **Allowed permissions** |
|---|---|
| **CREATOR OWNER**| Special permissions |
| **SYSTEM**| Full control |
| **Administrators**| Full control |
| **Users**| Read & execute, List folder contents, Read |
| **IIS_USRS**| Read & execute |
| **TrustedInstaller**| Full control |
  
If you want to disable this feature and manually add accounts to the `IIS_IUSRS` group, set the **manualGroupMembership** value to **true**  in the _ApplicationHost.config_ file. The following example shows how this can be done to the default application pool:

```xml
<applicationPools> 
    <add name="DefaultAppPool"> 
        <processModel manualGroupMembership="true" />
    </add>
</applicationPools>
```

## Understanding configuration isolation

IIS worker processes do not have Read access to the _ApplicationHost.config_ file. So, you might wonder how they can read any of the configurations sets in this file.

The answer is by using the configuration isolation feature in IIS 7.0 and later versions. Instead of enabling the IIS worker processes to read _ApplicationHost.config_ directly when they read the configuration file hierarchy, the Windows Process Activation Service (WAS) generates filtered copies of this file. Each IIS worker process uses these copies as a replacement of *ApplicationHost.config* when configuration is read inside the IIS worker process. These files are generated by default in the `%SystemDrive%\inetpub\Temp\appPools` directory, and are named _{AppPoolName}.config_. These files are configured to allow access to only the IIS worker processes in the corresponding application pool by using the `IIS APPPOOL\AppPoolName` application pool Security Identifier (SID).

> [!NOTE]
> To learn more about SID, see [Security Identifiers](/windows/win32/secauthz/security-identifiers).

:::image type="content" source="media/understanding-identities/application-pool.png" alt-text="Screenshot of using  application pool for configuration isolation.":::

This is done to prevent IIS worker processes from application pool A from being able to read configuration information in the _ApplicationHost.config_ file that is intended for application pool B.

_ApplicationHost.config_ may contain sensitive personal information, such as the user name and password for custom application pool identities, or the user name and password for virtual directories. Therefore, allowing all application pools to access *ApplicationHost.config* would break application pool isolation. If each application pool was given direct access to the *ApplicationHost.config* file, those pools could easily hack sensitive information out of other application pools by running the following command:

```console
appcmd list APPPOOL "DefaultAppPool" /text:*
```

:::image type="content" source="media/understanding-identities/appcmd.png" alt-text="Screenshot of using the appcmd command.":::

## IUSR - anonymous authentication

Anonymous authentication allows users to access public areas of the website without being prompted for a user name or password. In IIS 7.0 and later versions, a built-in account, `IUSR`,  is used for providing anonymous access. This built-in account does not require a password. It will be the default identity that is used when anonymous authentication is enabled. In the _ApplicationHost.config_ file, you can see the following definition:

```xml
<authentication>
     <anonymousAuthentication enabled="true" userName="IUSR" />
 </authentication>
```

This tells IIS to use the new built-in account for all anonymous authentication requests. The biggest advantages to doing this are the following:

- You no longer have to worry about passwords expiring for this account.
- You can use **xcopy /o** to copy files together with their ownership and ACL information to different computers seamlessly.

You can also provide anonymous authentication to your website by using a specific Windows account or application pool identity instead of  an `IUSR` account.

### IUSR versus Connect as

**Connect as** is an option in IIS that enables you to decide which credentials you want to use to access the website. You can use either the authenticated user credentials or specific user credentials. To understand the difference, consider the following scenario:

You have a default website that is configured to use anonymous authentication. However, your website contents are on another server, and you are using the **Connect as** section to access that resource through a `Test` domain user. When the user logs in, he is authenticated by using an IUSR account. However, the website content is accessed through the user credentials that are mentioned in **Connect as**  section.

To put it more simply, anonymous authentication is the mechanism that is used by the website to identify a user. But when you use this feature, the user does not have to provide any credentials. However, there might be a similar scenario in which the contents are on a network share. In such cases, you cannot use built-in accounts to access network share. Instead, you must use a specific account (domain) to do this.

## ASP.NET impersonation

Literally, impersonation means the act of pretending to be another person. In technical terms, it is an ASP.NET security feature that provides the ability to control the identity under which application code is run. Impersonation occurs when ASP.NET runs code in the context of an authenticated and authorized client. IIS provides anonymous access to resources by using an `IUSR` account. After the request is passed along to ASP.NET, the application code is run by using the application pool identity.

Impersonation can be enabled both through IIS and ASP.NET code if the application uses anonymous authentication, and if one of the following conditions is true:

- If `IMPERSONATION` is disabled, the application pool identity is used to run the application code.
- If `IMPERSONATION` is enabled, `NT AUTHORITY\IUSR` is used to run the application code.

When `impersonation` is enabled through IIS, it adds the following tag in the Web.config file of the application to impersonate the IIS Authenticated Account or User: \<identity impersonate="true" />

To impersonate a specific user for all requests on all pages of an ASP.NET application, you can specify the user name and password attributes in the `<identity>` tag of the Web.config file for that application.

```xml
<identity impersonate="true" userName="accountname" password="password" />
```

To implement impersonation through ASP.NET code, see [Implement impersonation in an ASP.NET application](../../aspnet/development/implement-impersonation.md)

Open the IIS worker process of a test website that is impersonating a `Test` local user, and check whether you can find the impersonation account under which the application code is run.

The application pool identity of the application is set to _ApplicationPoolIdentity_, and anonymous authentication is provided by using `IUSR` account. You can easily trace the impersonating identity using ProcMon. For example, if you examine one of the CreateFile events that corresponds to the w3wp.exe process that you are examining, you can find the impersonating account, as shown in the following screenshot.

:::image type="content" source="media/understanding-identities/impersonating.png" alt-text="Details of the impersonating in Event Properties.":::
