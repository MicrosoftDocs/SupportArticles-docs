---
title: TLS 1.2 is required for connectivity in Microsoft Dynamics 365 Customer Engagement
description: Describes that TLS 1.2 is required in Microsoft Dynamics 365 to connect to customer engagement applications, and identifies if you are impacted and what steps you may need to take.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: d365-sales-program-softwaredev
---
# Microsoft Dynamics 365 Customer Engagement (online) to require TLS 1.2 for connectivity

In Dynamics 365 (online) version 9.x and Dynamics 365 (online) Government version 8.2, we will begin requiring connections to customer engagement applications to utilize TLS 1.2 (or better) security. This aligns with updated Microsoft and industry security policies and best practices, and you may be required to take actions to maintain connectivity to Dynamics 365 Customer Engagement applications. Review the following information to help you identify if you are impacted and what steps you may need to take.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4051700

## What is TLS?

TLS stands for **Transport Layer Security**, and is a protocol that is an industry standard designed to protect the privacy of information communicated over the Internet. TLS is used in many web browsers and applications that communicate over HTTPS and TCP.

## What is changing?

Today, all Dynamics 365 Customer Engagement online versions support TLS 1.0, 1.1 and 1.2, but starting with the release of Dynamics 365 (online) version 9.x and Dynamics 365 (online) Government version 8.2, we will begin blocking connections to the updated product from clients or browsers that are using TLS 1.0 and 1.1.  

> [!NOTE]
> This change only affects Microsoft Dynamics 365 Online Customer Engagement, not on premises versions.

## How will you or your customers be impacted?

Any connections to Dynamics 365 (online) version 9.x or Dynamics 365 (online) Government version 8.2 will fail if they do not use TLS 1.2 security protocol. This will impact several Dynamics services (listed below), including access to the Dynamics 365 Customer Engagement web application.

## How can you or your customers avoid being impacted?

### For supported web browsers

All [supported browsers](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699710(v=crm.8)) for Dynamics 365 Customer Engagement (versions 7.x - Version 9.x) currently comply with the TLS 1.2 standards and will continue to work as before. However, if you have disabled the TLS 1.2 protocol on your browser, you will be affected and lose connectivity to organizations.

### For developer tools provided by Microsoft

See [What's new for Customer Engagement developer documentation in version 9.0](https://cloudblogs.microsoft.com/dynamics365/it/2017/11/01/whats-new-for-customer-engagement-developer-documentation-in-version-9-0/) to get the latest on our developer tools documentation. Update to the [latest version of tools](/dynamics365/customerengagement/on-premises/developer/download-tools-nuget), used in development, from NuGet. Examples of developer tools include the Plugin Registration Tool and Configuration Migration Tool. Version 9.0 of these tools are backward compatible and can be used for Dynamics 365 (online) version 8.2 Government.

### For code built with the Dynamics 365 SDK

Recompile your client applications using .NET framework 4.6.2 or higher. If your code is already compiled with .NET 4.6.2 or higher, then there is no action required. For custom plugins and workflow assemblies, .NET 4.5.2 should continue to be used.

### Known issue with Visual Studio 2015

When you are running your project/solution in Visual Studio 2015 in debug mode, there is a known issue where you may not be able to connect to Dynamics 365 (online) version 9.x or Dynamics 365 (online) version 8.2 Government. This happens regardless of whether you are using a Target Framework of 4.6.2 or higher. This can occur because the Visual Studio hosting process is compiled against .NET 4.5 which means by default it doesn't support TLS 1.2. You can disable the Visual Studio hosting process as a workaround. Right-click on the name of your project in Visual Studio and then click Properties. On the **Debug** tab, you can uncheck the **Enable the Visual Studio hosting process** option.

> [!NOTE]
> This only impacts the debug experience in Visual Studio 2015. This doesn't impact the binaries or executable that's built. The same issue doesn't occur in Visual Studio 2017.

### One important note for .NET based apps

You can force TLS 1.2 protocol using the following command:

```console
ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
```

This forces the TLS 1.2 security protocol at all time. This isn't recommended as you run the risk of having to update this when there is a newer security protocol adopted by the industry.

### For existing code that cannot be recompiled

You can utilize a registry setting on Windows that will force .NET to utilize the highest possible security standard.

> [!NOTE]
> This is a machine-wide setting and may have undesired affects. It's recommended that you or your customer utilize the method of recompiling to .NET 4.6.2 or higher.

To update the registry settings that force .NET 4.5.2 to prefer TLS 1.2 machine-wide are documented in the [Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358) article. See section [Suggested Actions](/security-updates/SecurityAdvisories/2015/2960358#suggested-actions) under "Manually disable RC4 in TLS on systems running .NET Framework 4.5/4.5.1/4.5.2".

### For non .NET software

Check with your vendor on how to enable TLS 1.2. For most languages, it can be done with a simple config entry.

### For PowerShell

Add `[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12` to your PowerShell script before you call `Get-CrmConnection`.

### For Dynamics 365 for Microsoft Outlook

Dynamics 365 (online) Government version 8.2 and Dynamics 365 (online) version 9.x

- Download and install [version 8.2.2.137](https://www.microsoft.com/download/details.aspx?id=56327).

### For Unified Service Desk (USD)

Download the [latest version of Unified Service Desk](/dynamics365/unified-service-desk/download-unified-service-desk) (versions 3.1, 3.2 and 3.3 are TLS 1.2 compliant).

If you want to continue to use older versions of Unified Service desk, you will need to [update the client desktop's registry entries](/archive/blogs/usd/unified-service-desk-and-tls-1-2-mandate-for-dynamics-365-online).

### For Dynamics 365 for Report Authoring

Dynamics 365 (online) Government version 8.2

- Download and install from [Dynamics 365 Update 2.2 for TLS 1.2 supported clients](https://www.microsoft.com/download/details.aspx?id=57079).

Dynamics 365 (online) version 9.x

- Download and install [version 9.0](https://www.microsoft.com/download/details.aspx?id=56973).

### For Dynamics 365 for Email Router

Dynamics 365 (online) Government version 8.2

- Download and install from [Dynamics 365 Update 2.2 for TLS 1.2 supported clients](https://www.microsoft.com/download/details.aspx?id=57079).

Dynamics 365 (online) version 9.x

- Download and install [version 9.0](https://www.microsoft.com/download/details.aspx?id=56974).

## Example errors

Below are some potential connectivity errors  you might encounter when non-TLS 1.2 security protocol is used:

### Browser error

> "Can't connect securely to this page  
> This might be because the site uses outdated or unsafe TLS security settings. This this keeps happening, try contacting the website's owner."

### Connector error

> "Microsoft.Xrm.Tooling.CrmConnectControl Information: 8 : Login Status in Connect is =  Validating connection to Microsoft Dynamics CRM...  
>
> Microsoft.Xrm.Tooling.Connector.CrmServiceClient Error: 2 : ERROR REQUESTING Token FROM THE Authentication context  
>
> Microsoft.Xrm.Tooling.Connector.CrmServiceClient Error: 2 : Source  : mscorlib  
>
> Method  : ThrowIfExceptional  
>
> Error  : **One or more errors occurred**.  
>
> Stack Trace  : at System.Threading.Tasks.Task.ThrowIfExceptional(Boolean includeTaskCanceledExceptions)  
>
> at System.Threading.Tasks.Task\`1.GetResultCore(Boolean waitCompletionNotification)  
>
> at System.Threading.Tasks.Task\`1.get_Result()  
>
> at Microsoft.Xrm.Tooling.Connector.CrmWebSvc.ExecuteAuthenticateServiceProcess(Uri serviceUrl, ClientCredentials clientCredentials, UserIdentifier user, String clientId, Uri redirectUri, PromptBehavior promptBehavior, String tokenCachePath, Boolean isOnPrem, String authority, Uri& targetServiceUrl, AuthenticationContext& authContext, String& resource)  
>
> Inner Exception Level 1  :  
>
> Source  : Microsoft.IdentityModel.Clients.ActiveDirectory  
>
> Method  : Close  
>
> Error  : **Object reference not set to an instance of an object**.  
>
> Stack Trace  : at Microsoft.IdentityModel.Clients.ActiveDirectory.HttpWebResponseWrapper.Close()  
>
> at Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationParameters.\<CreateFromResourceUrlCommonAsync>d__0.MoveNext()  
>
> \--- End of stack trace from previous location where exception was thrown ---  
>
> at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
>
> at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
>
> at Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationParameters.\<CreateFromResourceUrlAsync>d__8.MoveNext()"

### Developer tools error

> "Inner Exception Level 1 :  
>
> Source : System  
>
> Method : GetResponse  
>
> Error : **The underlying connection was closed: An unexpected error occurred on a send**.
>
> Stack Trace : at System.Net.HttpWebRequest.GetResponse()
>
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataLocationRetriever.DownloadMetadata(TimeoutHelper timeoutHelper)
>
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataRetriever.Retrieve(TimeoutHelper timeoutHelper)
>
> Inner Exception Level 2 :  
>
> Source : System
>
> Method : Read
>
> Error : **Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.**
>
> Stack Trace : at System.Net.Sockets.NetworkStream.Read(Byte[] buffer, Int32 offset, Int32 size)
>
> at System.Net.FixedSizeReader.ReadPacket(Byte[] buffer, Int32 offset, Int32 count)
>
> at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)"

## Additional information

- [TLS 1.2 support at Microsoft](https://www.microsoft.com/security/blog/2017/06/20/tls-1-2-support-at-microsoft/)

- [Dynamics 365: 2019 release wave 2 plan](/dynamics365-release-plan/2019wave2/)

- [Supported extensions](/dynamics365/customerengagement/on-premises/developer/supported-extensions)

- [Web application requirements](/power-platform/admin/web-application-requirements)
