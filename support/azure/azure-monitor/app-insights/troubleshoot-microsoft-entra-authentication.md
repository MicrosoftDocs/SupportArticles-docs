---
title: Troubleshoot Microsoft Entra Authentication Issues
description: Provides general recommendations and specific suggestions for Microsoft Entra authentication issues.
ms.date: 10/03/2025
ms.service: azure-monitor
ms.custom: sap:Microsoft Entra authentication fails
---

# Troubleshoot Microsoft Entra authentication issues

This article provides distinct troubleshooting scenarios and steps to resolve a [Microsoft Entra authentication](/azure/azure-monitor/app/azure-ad-authentication) issue before raising a support ticket.

## Ingestion HTTP errors

The ingestion service returns specific errors, regardless of the SDK language. Network traffic can be collected by using a tool such as Fiddler. You should filter traffic to the ingestion endpoint set in the connection string.

### HTTP/1.1 400 Authentication not supported

This error shows the resource is set for Microsoft Entra-only.

Review and correctly configure the SDK because it's sending to the wrong API.

> [!NOTE]
> `v2/track` doesn't support Microsoft Entra ID. When the SDK is correctly configured, telemetry is sent to `v2.1/track`.

### HTTP/1.1 401 Authorization required

This error indicates that the SDK is correctly configured but it's unable to acquire a valid token. This error might indicate an issue with Microsoft Entra ID.

Identify exceptions in the SDK logs or network errors from Azure Identity.

### HTTP/1.1 403 Unauthorized

This error means the SDK uses credentials without permission for the Application Insights resource or subscription.

Check the Application Insights resource's access control. You must configure the SDK with credentials that have the Monitoring Metrics Publisher role.

## Language-specific troubleshooting

## [.NET](#tab/net)

### Event source

The Application Insights .NET SDK emits error logs by using the event source. To learn more about collecting event source logs, see [Troubleshooting no data - collect logs with PerfView](asp-net-troubleshoot-no-data.md#PerfView).

If the SDK fails to get a token, the exception message is logged as `Failed to get AAD Token. Error message:`.

## [Java](#tab/java)

### HTTP traffic

You can inspect network traffic by using a tool like Fiddler. To enable the traffic to tunnel through Fiddler, either add the following proxy settings in the configuration file:

```JSON
"proxy": {
"host": "localhost",
"port": 8888
}
```

Or add the following Java Virtual Machine (JVM) args while running your application: `-Djava.net.useSystemProxies=true -Dhttps.proxyHost=localhost -Dhttps.proxyPort=8888`

If Microsoft Entra ID is enabled in the agent, outbound traffic includes the HTTP header `Authorization`.

### 401 Unauthorized

If you see the message, `WARN c.m.a.TelemetryChannel - Failed to send telemetry with status code: 401, please check your credentials` in the log, it means the agent couldn't send telemetry. You likely didn't enable Microsoft Entra authentication on the agent, while your Application Insights resource has `DisableLocalAuth: true`. Ensure you pass a valid credential with access permission to your Application Insights resource.

If you're using Fiddler, you might see the response header `HTTP/1.1 401 Unauthorized - please provide the valid authorization token`.

### CredentialUnavailableException

If you see the exception, `com.azure.identity.CredentialUnavailableException: ManagedIdentityCredential authentication unavailable. Connection to IMDS endpoint cannot be established` in the log file, it means the agent failed to acquire the access token. The likely cause is an invalid client ID in your User-Assigned Managed Identity configuration.

### Failed to send telemetry

If you see the message, `WARN c.m.a.TelemetryChannel - Failed to send telemetry with status code: 403, please check your credentials` in the log, it means the agent couldn't send telemetry. The likely reason is that the credentials used don't allow telemetry ingestion.

Using Fiddler, you might notice the response `HTTP/1.1 403 Forbidden - provided credentials do not grant the access to ingest the telemetry into the component`.

The issue could be due to:

* Creating the resource with a system-assigned managed identity or associating a user-assigned identity without adding the Monitoring Metrics Publisher role to it.
* Using the correct credentials for access tokens but linking them to the wrong Application Insights resource. Ensure your resource (virtual machine or app service) or user-assigned identity has Monitoring Metrics Publisher roles in your Application Insights resource.

### Invalid Client ID

If the exception, `com.microsoft.aad.msal4j.MsalServiceException: Application with identifier <CLIENT_ID> was not found in the directory` in the log, it means the agent failed to get the access token. This exception likely happens because the client ID in your client secret configuration is invalid or incorrect.

This issue occurs if the administrator doesn't install the application or no tenant user consents to it. It also happens if you send your authentication request to the wrong tenant.

## [Java native](#tab/java-native)

> [!NOTE]
> Microsoft Entra ID authentication isn't available for *GraalVM Native* applications.

## [Node.js](#tab/nodejs)

Turn on internal logs by using the following setup. After you enable them, the console shows error logs, including any error related to Microsoft Entra integration. Examples include failing to generate the token with the wrong credentials or errors when the ingestion endpoint fails to authenticate using the provided credentials.

```javascript
let appInsights = require("applicationinsights");
appInsights.setup("InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=https://xxxx.applicationinsights.azure.com/").setInternalLogging(true, true);
```

## [Python](#tab/python)

### Error starts with "credential error" (with no status code)

Something is incorrect about the credential you're using and the client isn't able to obtain a token for authorization. It's because the required data is lacking for the state. An example would be passing in a system `ManagedIdentityCredential` but the resource isn't configured to use system-managed identity.

### Error starts with "authentication error" (with no status code)

The client failed to authenticate with the given credential. This error usually occurs when the credential used doesn't have the correct role assignments.

### I'm getting a status code 400 in my error logs

You're probably missing a credential or your credential is set to `None`, but your Application Insights resource is configured with `DisableLocalAuth: true`. Make sure you're passing in a valid credential and that it has permission to access your Application Insights resource.

### I'm getting a status code 403 in my error logs

This error usually occurs when the provided credentials don't grant access to ingest telemetry for the Application Insights resource. Make sure your Application Insights resource has the correct role assignments.

---
