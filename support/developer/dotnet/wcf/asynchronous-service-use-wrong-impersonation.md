---
title: Async WCF service uses wrong impersonation
description: This article resolves the problem where a WCF service that is invoked asynchronously in ASP.NET uses the wrong impersonation.
ms.date: 03/23/2020
ms.reviewer: amymcel
---
# WCF service that is invoked asynchronously in ASP.NET uses the wrong impersonation

This article helps you resolve the problem where a Windows Communication Foundation (WCF) service that is invoked asynchronously in ASP.NET uses the wrong impersonation.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2890435

## Symptoms

Consider the following scenario:

- A WCF service uses impersonation and Windows authentication.
- A WCF client invokes the service asynchronously.
- The client code runs under the ASP.NET environment in Microsoft Internet Information Services (IIS).

In this scenario, you may encounter an issue in which the service operation doesn't run under the intended impersonation context. Instead, you may find the service operation running under the identity of the process, such as an IIS Application Pool.

> [!NOTE]
>
> - When this issue occurs, no exception is thrown, and no error is logged because of this loss of impersonation context.
> - An example of such a scenario is an ASP.NET application configured to delegate the incoming impersonation context to a separate WCF service asynchronously.

## Cause

This issue occurs because of the following factors:

- The host common language runtime (CLR) deliberately suppresses the impersonation context because ASP.NET hasn't been configured to flow `WindowsIdentity` across asynchronous operations.
- If the client code relies on auto-open and immediately invokes asynchronous operations on the WCF client proxy after it's created, the impersonation context may not flow correctly.

## Resolution

To resolve this issue, follow these steps:

1. Configure ASP.NET to flow `WindowsIdentity` across asynchronous operations. To do this, make sure that the *aspnet.config* file has the following elements set:

    ```xml
    <configuration>
        <runtime>
            <legacyImpersonationPolicy enabled="false"/> 
            <alwaysFlowImpersonationPolicy enabled="true"/>
        </runtime>
    </configuration>
    ```

    > [!NOTE]
    > - These settings must be made in the *aspnet.config* file, because these settings configure the CLR that will be used for the application pool. Settings made in *web.config* configure only the individual application, not the application pool.
    > - Make sure that you change the appropriate *aspnet.config* for the installed framework, such as the `%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\Aspnet.config` path.
    > - If you cannot change the *aspnet.config* file(s) for the server, starting with IIS 7, you can associate a custom *aspnet.config* with each Application Pool. For more information, go to the [More information](#more-information) section.

1. Add an explicit `Open()` call to the client code. After you create an instance of a WCF client, call the `Open()` method before you invoke any operations asynchronously. For example, do the following:

    ```csharp
    // Invoke a service operation asynchronously with impersonation.
    static async void Demo()
    {
       using (CalculatorClient client = new CalculatorClient())
       {
          // Enable the server to impersonate.
          client.ClientCredentials.Windows.AllowedImpersonationLevel = TokenImpersonationLevel.Impersonation;
          // Open the client before the first asynchronous request.
          client.Open();
          // Invoke the Add operation asynchronously and display the result.
          double result = await client.AddAsync(1.0, 2.0);
          Console.WriteLine("Add returned {0}", result); client.Close();
       }
    }
    ```

## More information

- [Run-time settings schema](/dotnet/framework/configure-apps/file-schema/runtime/)

- [\<legacyImpersonationPolicy> Element](/dotnet/framework/configure-apps/file-schema/runtime/legacyimpersonationpolicy-element)

- [\<alwaysFlowImpersonationPolicy> Element](/dotnet/framework/configure-apps/file-schema/runtime/alwaysflowimpersonationpolicy-element)

- [Adding Application Pools \<add>](/iis/configuration/system.applicationHost/applicationPools/add/)

- [add Element for applicationPools [IIS Settings Schema]](/previous-versions/iis/settings-schema/aa347554(v=vs.90))

- [ASP.NET Thread Usage on IIS 7.5, IIS 7.0, and IIS 6.0](/archive/blogs/tmarq/asp-net-thread-usage-on-iis-7-5-iis-7-0-and-iis-6-0)

- [Setting an aspnet.config File per Application Pool](https://weblogs.asp.net/owscott/setting-an-aspnet-config-file-per-application-pool)

Explicitly opening client proxies when they're shared or used asynchronously is considered as a best practice in WCF for several reasons. For more information, see [Best Practice: Always open WCF client proxy explicitly when it is shared](/archive/blogs/wenlong/best-practice-always-open-wcf-client-proxy-explicitly-when-it-is-shared).

For more information about a similar issue that is using shared client proxies and asynchronous communication, see [WCF service operations invoked asynchronously through shared client proxies by using impersonation may use the wrong impersonation context](https://support.microsoft.com/help/2856654).
