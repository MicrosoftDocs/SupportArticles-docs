---
title: Enable Logging for MSAL.NET and Microsoft Graph SDK
description: Introduces how to enable logging for both MSAL.NET and Microsoft Graph SDK.
ms.reviewer: bachoang, v-weizhu
ms.service: entra-id
ms.date: 07/16/2025
ms.custom: sap:Problem with using the Graph SDK - libraries
ms.topic: how-to
---
# How to enable logging for MSAL.NET and Microsoft Graph SDK

[Microsoft Graph SDK](/graph/sdks/sdks-overview) has the ability to log complete HTTP requests and responses. The way this logging mechanism works is by implementing a custom [HttpClient Message handler](https://visualstudiomagazine.com/articles/2014/08/01/creating-custom-httpclient-handlers.aspx) to intercept every HTTP request and response between the client application and the Microsoft Graph Service. Besides hooking into the processing pipeline of the `GraphServiceClient` class to do request and response tracing, you can also configure proxy information. For more information, see [Customize the Microsoft Graph SDK service client](/graph/sdks/customize-client?tabs=csharp). MSAL.NET is used in the authentication provider of the `GraphServiceClient` class. Consequently, [logging](/azure/active-directory/develop/msal-logging-dotnet) in this library can provide valuable insight into authentication failures.

This article explains how to enable logging for both MSAL.NET and Microsoft Graph SDK by using a [.NET Core 3.0 console application sample](https://github.com/bachoang/MSGraphLoggingSample).

## Logging techniques

Different logging approaches are used to write log entries to Azure Blob Storage for MSAL.NET logging and Microsoft Graph SDK logging. The logging mechanisms provide insights into HTTP requests and responses, as well as authentication failures, which are invaluable for debugging and troubleshooting.

### MSAL.NET logging

For MSAL.NET logging, the [Azure Blob Storage client SDK](/azure/storage/blobs/storage-quickstart-blobs-dotnet) (v12) is used to write log entries into an Azure Blob.

### Microsoft Graph SDK logging

For Microsoft Graph SDK logging, the [Serilog](https://serilog.net/) library is used. Serilog offers various logging providers, known as "sinks," that support different logging environments such as Application Insight, DocumentDB, and Event Hubs.

In the following code, three logging sinks are configured: console logger, file logger, and Azure Blob Storage logger. You don't have to use all three and can add new one(s) or comment out the providers you don't need.

```csharp
Log.Logger = new LoggerConfiguration()
.MinimumLevel.Debug()
.WriteTo.Console() // Serilog console logging
.WriteTo.File(LoggingLocalPath, rollingInterval: RollingInterval.Day) // Serilog file logging
.WriteTo.AzureBlobStorage(AzureStorageConnection, Serilog.Events.LogEventLevel.Verbose, MSGraphAzureBlobContainerName, MSGraphAzureBlobName) // Serilog Azure Blob Storage logging
.CreateLogger();
```

> [!NOTE]
> When the Serilog Azure Blob Storage sink is used for both MSAL.NET and Microsoft Graph SDK logging, you might encounter an authentication issue where the authentication prompt window fails to appear.

## Prerequisites for running the sample application

Before running the sample application, ensure the following prerequisites are met.

### Application registration

1. Register the sample application in Microsoft Entra ID.

    During the application registration, configure `http://localhost` as a redirect URI under the **Mobile and desktop applications** platform. This URI is required for .NET Core applications.

    :::image type="content" source="media/enable-logging-for-msal-and-microsoft-graph/set-redirect-uri.png" alt-text="Screenshot that shows setting a redirect URI":::

2. Configure these delegated Microsoft Graph permissions in **API permissions**:

    - **User.Read.All**
    - **Application.ReadWrite.All**

3. Grant admin consent to these permissions because the sample application uses the following Microsoft Graph requests to get the signed-in user information and create an app registration:

    - `GET https://graph.microsoft.com/beta/me`
    - `POST https://graph.microsoft.com/beta/applications`

> [!NOTE]
> Ensure the signed-in user has one of these administrative roles: Application Developer, Application Administrator, Cloud Application Administrator, or Global Administrator; otherwise, the application creation might fail due to insufficient permissions. For a list of built-in Microsoft Entra roles, see [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) .

### Azure Storage

Create an Azure Storage account for storing MSAL.NET and Microsoft Graph SDK logs as Azure Blobs. For read/write access to Azure Storage, you can use a connection string in **Key 1** or **Key 2** under **Access keys**.

:::image type="content" source="media/enable-logging-for-msal-and-microsoft-graph/connection-string-under-access-keys.png" alt-text="Screenshot that shows connection strings under 'Access keys'":::

### Application code

The complete sample code is available in this [GitHub repository](https://github.com/bachoang/MSGraphLoggingSample). Configuration options are stored in the following `appsettings.json` file. The sample application uses a code snippet from [this article](../app-integration/get-signed-in-users-groups-in-access-token.md) to read configuration settings from the `appsettings.json` file. It relies on the Microsoft Graph beta endpoint, so it references the Microsoft.Graph.Beta package; for v1 endpoint, use the Microsoft.Graph package. For more information, see [Use the Microsoft Graph SDKs with the beta API](/graph/sdks/use-beta).

```json
{
    "Azure": {
    "ClientId": "",
    "TenantId": "",
    "MSALAzureBlobContainerName": "msallogs",
    "MSALAzureBlobName": "MsalLog.txt",
    "MSGraphAzureBlobContainerName": "msgraphlogs",
    "MSGraphAzureBlobName": "{yyyy}-{MM}-{dd}-msgraphlog.txt",
    "LoggingLocalPath": "C:/temp/msgraphlog.txt",
    "AzureStorageConnection": "",
    "Scopes": [ "https://graph.microsoft.com/.default" ]
    }
}
```

The sample application uses both `GET` and `POST` requests to show logging of the complete HTTP requests and responses, including headers and body. The following four helper functions are used to get the information for each part. Any function can be commented out if the corresponding information isn't required.

:::image type="content" source="media/enable-logging-for-msal-and-microsoft-graph/helper-functions.png" alt-text="Screenshot that shows four helper functions":::

These helper functions are used in the logging `HttpClient` message handler as shown here. Requests are logged before calling the `DelegatingHandler.SendAsync` method and responses are logged after the call.

```csharp
public class SeriLoggingHandler : DelegatingHandler
{
    protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage httpRequest, CancellationToken cancellationToken)
        {
            HttpResponseMessage response = null;
            try
            {
                Log.Information("sending Graph Request");
                Log.Debug(GetRequestHeader(httpRequest));
                Log.Debug(GetRequestBody(httpRequest));
                response = await base.SendAsync(httpRequest, cancellationToken);
                Log.Information("Receiving Response:");
                Log.Debug(GetResponseHeader(response));
                Log.Debug(GetResponseBody(response));
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Something went wrong");
                if (response.Content != null)
                {
                   await response.Content.ReadAsByteArrayAsync();// Drain response content to free connections.
                }
            }
            return response;
        }
}
```

The following code shows how to set up the `GraphServcieClient` class to use the logging handler:

```csharp
IPublicClientApplication publicClientApplication = PublicClientApplicationBuilder
            .Create(ClientId)
            .WithTenantId(TenantId)
            // Enable MSAL logging
            .WithLogging(MSALlogger, Microsoft.Identity.Client.LogLevel.Verbose, true)
            .WithRedirectUri("http://localhost")
            .Build();

        InteractiveAuthenticationProvider authProvider = new InteractiveAuthenticationProvider(publicClientApplication, Scopes);

        // get the default list of handlers and add the logging handler to the list
        var handlers = GraphClientFactory.CreateDefaultHandlers(authProvider);

        // Remove Compression handler
        var compressionHandler =
            handlers.Where(h => h is CompressionHandler).FirstOrDefault();
        handlers.Remove(compressionHandler);

        // Add SeriLog logger
        handlers.Add(new SeriLoggingHandler());

        InitializeBlobStorageForMSAL().Wait();

        var httpClient = GraphClientFactory.Create(handlers);
        GraphServiceClient graphClient = new GraphServiceClient(httpClient);
```

> [!CAUTION]
> This sample logs sensitive information, including Personally Identifying Information (PII) and access tokens. Be cautious when sharing debug logs.

## Check MSAL.NET and Microsoft Graph logs

After you run the sample application, Microsoft Graph requests and responses should appear in:

- The console window.
- The directory location configured in the `appsettings.json` file. Log file names include the date, as shown here:

    :::image type="content" source="media/enable-logging-for-msal-and-microsoft-graph/local-microsoft-graph-logs.png" alt-text="Screenshot that shows local logs":::

For Azure Blob Storage logging, the logs are in the `msallogs` and `msgraphlogs` containers:

:::image type="content" source="media/enable-logging-for-msal-and-microsoft-graph/azure-blob-storage-logs.png" alt-text="Screenshot that shows Azure Blob Storage logs":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
