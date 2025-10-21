---
title: Troubleshoot missing application telemetry in Azure Monitor Application Insights
description: Describes how to test connectivity and telemetry ingestion by using PowerShell or curl to identify the step in the processing pipeline that causes telemetry to go missing.
ms.date: 07/07/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: aaronmax, toddfous, v-weizhu, matthofa, v-nawrothkai, v-ryanberg, v-gsitser
ms.service: azure-monitor
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
#Customer intent: As an Application Insights user I want to know where in the processing pipeline telemetry goes missing so I know where to troubleshoot.
---
# Troubleshoot missing application telemetry in Azure Monitor Application Insights

This article helps you to identify the step in the processing pipeline that causes telemetry to be missing by testing connectivity and telemetry ingestion using PowerShell or curl.

## The Azure portal fails to pull or render the records you're trying to view

If your Application Insights data collection endpoint is configured to use Microsoft Entra ID (formerly Azure AD) for authentication, your application must also be configured to authenticate with Microsoft Entra ID. In this scenario, your application is responsible for authenticating using Microsoft Entra ID. If the application isn't correctly configured, telemetry is rejected and doesn't appear in the Azure portal even if instrumentation appears correct and your application is generating telemetry data.

To configure your application to authenticate using Microsoft Entra ID, follow the steps in [Enable Microsoft Entra ID (formerly Azure AD) authentication](/azure/azure-monitor/app/opentelemetry-configuration#enable-microsoft-entra-id-formerly-azure-ad-authentication).

## Steps that can cause telemetry to be missing

The following graphic shows steps where telemetry can be missing during ingestion and consumption:

:::image type="content" source="media/investigate-missing-telemetry/telemetry-processing-pipeline.png" alt-text="Steps that telemetry passes in processing pipeline.":::

If application telemetry doesn't show in the Azure portal, failures across steps in the processing pipeline could be the cause:

- The Application Insights SDK or agent is misconfigured and doesn't send application telemetry to the ingestion endpoint.
- The SDK or agent is configured correctly, but the network blocks calls to the ingestion endpoint.
- The ingestion endpoint drops or throttles inbound telemetry.
- The ingestion pipeline drops or severely slows down telemetry as part of its processing due to [service health](https://azure.microsoft.com/get-started/azure-portal/service-health/#overview).
- (Uncommon) Log Analytics faces service health problems when saving telemetry records.
- (Uncommon) The query API at `api.applicationinsights.io` fails when querying records from Log Analytics.
- Other possible causes and solutions are discussed in [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

> [!TIP]
> The Application Insights support teams can't assist with networking issues. When submitting a support ticket for networking issues that prevent Application Insights from receiving telemetry data, such as DNS resolution failures, ensure that you specify Azure Networking or Azure Private Link in your product or issue description in the Azure portal. This makes sure that your support case is routed correctly.

## Identify step by sending sample telemetry record

Configuration problems or transient issues may occur anywhere across the Applications Insights service. To identify the step within the processing pipeline that causes symptoms of no data or missing data, send a sample telemetry record by using PowerShell or curl. For the PowerShell script or curl command, go to the following sections:

- [PowerShell script to send availability test result](#powershell-script-send-availability-test-result)
- [Curl command to send availability test result](#curl-command-send-availability-test-result)
- [PowerShell script to send request telemetry record](#powershell-script-send-request-telemetry-record)

If the web app runs on an on-premises server or Azure VM, connect to the server or VM and send a single telemetry record to the Applications Insights service instance by using PowerShell. If the web app that has issues sending telemetry [runs on Kudu](/azure/app-service/resources-kudu), run the following script from Kudu's PowerShell debug console in Azure Web Apps.

```powershell
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -Method POST -Body $availabilityData -UseBasicParsing
```

> [!NOTE]
>
> - Before running the `Invoke-WebRequest` cmdlet, issue the `$ProgressPreference = "SilentlyContinue"` cmdlet.
> - You can't use `-Verbose` or `-Debug`. Instead, use `-UseBasicParsing`.

After you send a sample telemetry record by using PowerShell, navigate to the Application Insights **Logs** tab in the Azure portal and check if it arrives. If the sample telemetry record is shown, then a large portion of the processing pipeline is eliminated.

A sample telemetry record that's correctly saved and displayed means:

- The local server or VM has DNS that resolves to the correct IP address.
- The network delivered the sample to the ingestion endpoint without blocking or dropping.
- The ingestion endpoint accepted the sample payload and processed it through the ingestion pipeline.
- Log Analytics correctly saved the sample record.
- The Azure portal **Logs** tab is able to query the API (`api.applicationinsights.io`) and render the sample record in the Azure portal.

If the generated sample record arrives at your Application Insights instance, and you can query for the sample record by using the **Logs resource** menu, [troubleshoot the Application Insights SDK or agent](#troubleshoot-application-insights-sdk-agent). You can now collect SDK logs, self-diagnostic logs, or profiler traces, as appropriate for the SDK or agent version.

The following sections provide information about sending a sample telemetry record using PowerShell or curl.

## <a id="powershell-script-send-availability-test-result"></a>PowerShell script to send availability test result

Availability test results are the ideal telemetry type to test with. The reason is that the ingestion pipeline never samples out availability test results. If you send a request telemetry record, it could get sampled out when you have enabled ingestion sampling. Start with a sample availability test result and then try other telemetry types as needed.

Here's a sample PowerShell script that sends an availability test result:

```powershell
# Info: Provide either the connection string or ikey for your Application Insights resource
$ConnectionString = ""
$InstrumentationKey = ""
function ParseConnectionString {
param ([string]$ConnectionString)
  $Map = @{}
  foreach ($Part in $ConnectionString.Split(";")) {
     $KeyValue = $Part.Split("=")
     $Map.Add($KeyValue[0], $KeyValue[1])
  }
  return $Map
}
# If ikey is the only parameter supplied, we'll send telemetry to the global ingestion endpoint instead of regional endpoint found in connection strings
If (($InstrumentationKey) -and ("" -eq $ConnectionString)) {
$ConnectionString = "InstrumentationKey=$InstrumentationKey;IngestionEndpoint=https://dc.services.visualstudio.com/"
}
$map = ParseConnectionString($ConnectionString)
$url = $map["IngestionEndpoint"] + "v2/track"
$ikey = $map["InstrumentationKey"]
$lmUrl = $map["LiveEndpoint"]
$time = (Get-Date).ToUniversalTime().ToString("o")
$availabilityData = @"
{
  "data": {
        "baseData": {
            "ver": 2,
            "id": "SampleRunId",
            "name": "Microsoft Support Sample Webtest Result",
            "duration": "00.00:00:10",
            "success": true,
            "runLocation": "Region Name",
            "message": "Sample Webtest Result",
            "properties": {
                "Sample Property": "Sample Value"
                }
        },
        "baseType": "AvailabilityData"
  },
  "ver": 1,
  "name": "Microsoft.ApplicationInsights.Metric",
  "time": "$time",
  "sampleRate": 100,
  "iKey": "$ikey",
  "flags": 0
}
"@
# Uncomment one or more of the following lines to test client TLS/SSL protocols other than the machine default option
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::SSL3
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS11
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS12
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS13
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -Method POST -Body $availabilityData -UseBasicParsing
```

This script builds a raw REST request to deliver a single availability test result to the Application Insights component. When you use this script, supply the `$ConnectionString` or `$InstrumentationKey` parameter.

- If only the connection string parameter is supplied, telemetry is sent to the regional endpoint in the connection string.
- If only the instrumentation key (ikey) parameter is supplied, telemetry is sent to the global ingestion endpoint.
- If both connection string and ikey parameters are supplied, the script sends telemetry to the regional endpoint in the connection string.

> [!NOTE]
>
> - Test the connection made by your application. If you enable Application Insights in the Azure portal, you likely rely on connection strings with regional endpoints, `https://<region>.in.applicationinsights.azure.com`. If your SDK configuration only supplies the ikey, you rely on the global endpoint, `https://dc.applicationinsights.azure.com`. Make sure to populate the script parameter that matches your web application SDK configuration, either supplying the connection string or the ikey.
> - On March 31, 2025, support for instrumentation key ingestion ended. Instrumentation key ingestion continues to work, but we no longer provide updates or support for the feature. [Transition to connection strings](/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings) to take advantage of [new capabilities](/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings#new-capabilities).

It's easiest to run this script from the PowerShell ISE environment on an IaaS or [Azure virtual machine scale set](/azure/virtual-machine-scale-sets/overview) instance. You can also copy and paste the script into the [App Service Kudu](/azure/app-service/resources-kudu) interface PowerShell debug console and then run it.

When the script is executed, look for an HTTP 200 response and review the response details. As part of the response JSON payload, the following details are expected:

- The `itemsReceived` count matches the `itemsAccepted`.
- The ingestion endpoint informs the client: you sent one telemetry record, and we accepted one telemetry record.

Refer to the following screenshot as an example:

:::image type="content" source="media/investigate-missing-telemetry/items-received-matches-items-accepted.png" alt-text="Code that shows the number of items received and items accepted.":::

## <a id="curl-command-send-availability-test-result"></a>Curl command to send availability test result

If you're running Linux VMs, use curl instead of PowerShell to send a similar REST request. You need to adjust the **ingestion endpoint hostname**, the `iKey` value, and the `time` values. The Application Insights ingestion endpoint doesn't accept any records older than 48 hours.

Here are sample curl commands that send a single availability test result:

- Curl command for Linux/MacOS:

    ```
    curl -H "Content-Type: application/json" -X POST -d '{"data":{"baseData":{"ver":2,"id":"SampleRunId","name":"MicrosoftSupportSampleWebtestResultUsingCurl","duration":"00.00:00:10","success":true,"runLocation":"RegionName","message":"SampleWebtestResult","properties":{"SampleProperty":"SampleValue"}},"baseType":"AvailabilityData"},"ver":1,"name":"Microsoft.ApplicationInsights.Metric","time":"2022-09-01T12:00:00.0000000Z","sampleRate":100,"iKey":"########-####-####-####-############","flags":0}' https://dc.applicationinsights.azure.com/v2.1/track
    ```

- Curl command for Windows:

    ```console
    curl -H "Content-Type: application/json" -X POST -d {\"data\":{\"baseData\":{\"ver\":2,\"id\":\"SampleRunId\",\"name\":\"MicrosoftSupportSampleWebtestResultUsingCurl\",\"duration\":\"00.00:00:10\",\"success\":true,\"runLocation\":\"RegionName\",\"message\":\"SampleWebtestResult\",\"properties\":{\"SampleProperty\":\"SampleValue\"}},\"baseType\":\"AvailabilityData\"},\"ver\":1,\"name\":\"Microsoft.ApplicationInsights.Metric\",\"time\":\"2021-10-05T22:00:00.0000000Z\",\"sampleRate\":100,\"iKey\":\"########-####-####-####-############\",\"flags\":0} https://dc.applicationinsights.azure.com/v2/track
    ```

## <a id="powershell-script-send-request-telemetry-record"></a>PowerShell script to send request telemetry record

To troubleshoot missing request telemetry, use the following PowerShell script to test sending a single request telemetry record. This telemetry type is susceptible to the server-side ingestion sampling configuration. Verify that [ingestion sampling](/azure/azure-monitor/app/sampling#ingestion-sampling) is turned off to confirm if the test record is saved correctly.

```powershell
# Info: Provide either the connection string or ikey for your Application Insights resource
$ConnectionString = ""
$InstrumentationKey = ""
function ParseConnectionString {
param ([string]$ConnectionString)
  $Map = @{}
  foreach ($Part in $ConnectionString.Split(";")) {
     $KeyValue = $Part.Split("=")
     $Map.Add($KeyValue[0], $KeyValue[1])
  }
  return $Map
}
# If ikey is the only parameter supplied, we'll send telemetry to the global ingestion endpoint instead of regional endpoint found in connection strings
If (($InstrumentationKey) -and ("" -eq $ConnectionString)) {
$ConnectionString = "InstrumentationKey=$InstrumentationKey;IngestionEndpoint=https://dc.services.visualstudio.com/"
}
$map = ParseConnectionString($ConnectionString)
$url = $map["IngestionEndpoint"] + "v2/track"
$ikey = $map["InstrumentationKey"]
$lmUrl = $map["LiveEndpoint"]
$time = (Get-Date).ToUniversalTime().ToString("o")
$requestData = @"
{
   "data": {
      "baseType": "RequestData",
      "baseData": {
        "ver": 2,
        "id": "22093920382029384",
        "name": "GET /msftsupport/requestdata/",
        "starttime": "$time",
        "duration": "00:00:01.0000000",
        "success": true,
        "responseCode": "200",
        "url": "https://localhost:8080/requestData/sampleurl",
        "httpMethod": "GET"
       }
   },
   "ver": 1,
   "iKey": "$ikey",
   "name": "Microsoft.ApplicationInsights.Request",
   "time": "$time",
   "sampleRate": 100,
   "flags": 0
}
"@
# Uncomment one or more of the following lines to test client TLS/SSL protocols other than the machine default option
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::SSL3
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS11
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS12
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS13
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -Method POST -Body $requestData -UseBasicParsing
```

## Troubleshoot SSL or TLS configuration

If these scripts fail, troubleshoot the SSL or TLS configuration. Most ingestion endpoints require clients to use TLS 1.2 and specific cipher suites. In this case, adjust how PowerShell participates as a client in the SSL or TLS protocol. Include the following snippets if you need to diagnose a secure channel as part of the connection between the client VM and the ingestion endpoints.

- Option 1: Control which SSL or TLS protocol is used by PowerShell to make a connection to the ingestion endpoint.

    Uncomment any of the following lines by removing the `#` character and add them before the `Invoke-WebRequest` cmdlet in your PowerShell script to control the protocol used in the test REST request:

    ```powershell
    # Uncomment one or more of these lines to test TLS/SSL protocols other than the machine default option
    # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::SSL3
    # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS
    # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS11
    # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS12
    # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS13
    ```

- Option 2: Ignore any SSL certificate validation issues.

    If you have a firewall or proxy server that participates in SSL certificate offloading, ignore any SSL certificate issues by adding the following snippet just before the `Invoke-WebRequest` cmdlet:

    ```powershell
    # Ignore mismatched SSL certificate
    add-type @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy {
            public bool CheckValidationResult(
                ServicePoint srvPoint, X509Certificate certificate,
                WebRequest request, int certificateProblem) {
                return true;
            }
        }
    "@
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    ```

If the application defaults to the system or server default TLS settings, change those default settings within the registry on Windows machines. For details, see [Transport Layer Security (TLS) registry settings](/windows-server/security/tls/tls-registry-settings#tls-dtls-and-ssl-protocol-version-settings).

If you need to change the default TLS/SSL protocol used by a .NET application, follow the guidance in [Transport Layer Security (TLS) best practices with the .NET Framework](/dotnet/framework/network-programming/tls).

## <a id="troubleshoot-application-insights-sdk-agent"></a>Troubleshoot setup or configuration of Application Insights SDK or agent

If sending telemetry from your application's host machine by using PowerShell or curl is successful, missing telemetry is likely due to setup or configuration issues of the Application Insights SDK or agent. Enable Application Insights monitoring for your application host and programming language to verify that all your configurations or code follow proper guidance and examples.

If tests performed by using PowerShell or curl fail to send telemetry to the ingestion endpoint, verify a few common client-side related issues that may contribute to the problem:

- DNS on your network fails to resolve the ingestion endpoint to the correct IP address.
- TCP connection from your application server to the ingestion endpoint may be blocked by firewalls or gateway devices.
- The ingestion endpoint that the SDK connects to may require TLS 1.2, but your application may by default use TLS 1.0 or TLS 1.1.
- You may have more than one [Azure Monitor Private Link](/azure/azure-monitor/logs/private-link-security) impacting your private network, which may overwrite your DNS entries to resolve the ingestion endpoint to the wrong private IP address.

## Troubleshoot Microsoft Entra authentication issues

This section provides distinct troubleshooting scenarios and steps to resolve [Microsoft Entra authentication](/azure/azure-monitor/app/azure-ad-authentication) issues before you contact Microsoft support.

### Ingestion HTTP errors

The ingestion service returns specific errors regardless of the SDK language. Network traffic can be collected by using a tool such as Fiddler. Make sure that you filter traffic to the ingestion endpoint that's set in the connection string.

### HTTP/1.1 400 Authentication not supported

This error shows that the resource is set as Microsoft Entra-only.

Review and configure the SDK correctly because it's sending to the wrong API.

> [!NOTE]
> `v2/track` doesn't support Microsoft Entra ID. If the SDK is configured correctly, telemetry is sent to `v2.1/track`.

#### HTTP/1.1 401 Authorization required

This error indicates that the SDK is configured correctly but can't acquire a valid token. This error might indicate that an issue that affects Microsoft Entra ID exists.

Identify exceptions in the SDK logs or network errors from Azure Identity.

#### HTTP/1.1 403 Unauthorized

This error means that the SDK uses credentials without permission for the Application Insights resource or subscription.

Check the access control for the Application Insights resource. You must ensure the identity used by the SDK has been assigned the Monitoring Metrics Publisher role.

### Language-specific troubleshooting

### [.NET](#tab/net)

#### Enable error logs

The Application Insights .NET SDK emits error logs by using the event source. To learn more about collecting event source logs, see [Troubleshooting no data - collect logs with PerfView](asp-net-troubleshoot-no-data.md#collect-logs-with-perfview).

If the SDK doesn't get a token, the exception message is logged as "Failed to get AAD Token. Error message."

### [Java](#tab/java)

#### HTTP traffic

You can inspect network traffic by using a tool such as Fiddler. To enable the traffic to tunnel through Fiddler, add the following proxy settings in the configuration file:

```JSON
"proxy": {
"host": "localhost",
"port": 8888
}
```

Alternatively, add the following Java Virtual Machine (JVM) arguments while running your application: 

> `-Djava.net.useSystemProxies=true -Dhttps.proxyHost=localhost -Dhttps.proxyPort=8888`

If Microsoft Entra ID is enabled in the agent, outbound traffic includes the `Authorization` HTTP header.

#### 401 Unauthorized

You might see the following entry in the log:

> `WARN c.m.a.TelemetryChannel - Failed to send telemetry with status code: 401, please check your credentials`

This message means that the agent can't send telemetry. In this situation, you likely didn't enable Microsoft Entra authentication on the agent while your Application Insights resource had `DisableLocalAuth: true`. Make sure that you pass a valid credential that has access permission to your Application Insights resource.

If you use Fiddler, you might see the following response header:

> `HTTP/1.1 401 Unauthorized - please provide the valid authorization token`

#### CredentialUnavailableException

You might see the following entry in the log file:

> `com.azure.identity.CredentialUnavailableException: ManagedIdentityCredential authentication unavailable. Connection to IMDS endpoint cannot be established`

This exception means that the agent didn't acquire the access token. The likely cause is an invalid client ID in your User-Assigned Managed Identity configuration.

#### Failed to send telemetry

You might see the following message in the log:

`WARN c.m.a.TelemetryChannel - Failed to send telemetry with status code: 403, please check your credentials`

This message means that the agent can't send telemetry. The likely reason is that the credentials that are used don't allow telemetry ingestion.

If you use Fiddler, you might notice the following response:

> "HTTP/1.1 403 Forbidden - provided credentials do not grant the access to ingest the telemetry into the component"

This issue can be caused by any of the following actions:

- Creating a resource that has a system-assigned managed identity.
- Associating a user-assigned identity without adding the Monitoring Metrics Publisher role to it.
- Using the correct credentials for access tokens, but linking them to the wrong Application Insights resource. In this situation, make sure that your resource (virtual machine or app service) or user-assigned identity has Monitoring Metrics Publisher roles in your Application Insights resource.

#### Invalid Client ID

You might see the following exception in the log:

> `com.microsoft.aad.msal4j.MsalServiceException: Application with identifier <CLIENT_ID> was not found in the directory`

This means that the agent didn't get the access token. This exception likely occurs because the client ID in your client secret configuration is invalid or incorrect or failed to generate the token by using the wrong credentials.

This issue occurs if the admin doesn't install the application or if no tenant user consents to it. It occurs also if you send your authentication request to the wrong tenant.

### [Java native](#tab/java-native)

> [!NOTE]
> Microsoft Entra ID authentication isn't available for *GraalVM Native* applications.

### [Node.js](#tab/nodejs)

Turn on internal logs by using the following setup. After you enable the logs, the console shows error logs, including any errors that are related to Microsoft Entra integration. Examples include failing to generate the token with the wrong credentials or if the ingestion endpoint doesn't authenticate by using the provided credentials.

```javascript
let appInsights = require("applicationinsights");
appInsights.setup("InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=https://xxxx.applicationinsights.azure.com/").setInternalLogging(true, true);
```

### [Python](#tab/python)

### Error starts with "credential error" (with no status code)

Something is incorrect about the credential you're using and the client isn't able to obtain a token for authorization. It's because the required data is lacking for the state. An example would be passing in a system `ManagedIdentityCredential` but the resource isn't configured to use system-managed identity.

### Error starts with "authentication error" (with no status code)

The client failed to authenticate with the given credential. This error usually occurs if the credential used doesn't have the correct role assignments.

### Status code 400 is logged in the error logs

You're probably missing a credential or your credential is set to `None`, but your Application Insights resource is configured with `DisableLocalAuth: true`. Make sure that you pass in a valid credential and that it has permission to access your Application Insights resource.

### Status code 403 is logged in error logs

This error usually occurs when the provided credentials don't grant access to ingest telemetry for the Application Insights resource. Make sure your Application Insights resource has the correct role assignments.

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
