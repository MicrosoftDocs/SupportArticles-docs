---
title: Test connectivity and telemetry ingestion using PowerShell or curl clients
description: Learn how to troubleshoot missing data by using PowerShell or curl clients.
ms.topic: conceptual
ms.date: 8/5/2022
ms.author: toddfous
editor: v-kainawroth
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Application Insights user I want to understand known issues for the Application Insights Agent and how to troubleshoot common issues so I can use Application Insights and the Agent effectively.
---

# Test connectivity and telemetry ingestion using PowerShell or curl clients

## Missing or No Data Symptoms

If data is missing our you cannot find specific telemetry records, it can be the result of failures across every step in the life of a telemetry record:

**SDK/Codeless agents** → **Networking** → **Ingestion endpoint** → **Application Insights ingestion pipeline** → **Kusto backend** ← **Query API** ← **Azure portal**

- The SDK or Agent is misconfigured and not sending data to the ingestion endpoint.
- The SDK or Agent is configured correctly but the networking is blocking calls to the ingestion endpoint.
- The ingestion endpoint is dropping or throttling inbound telemetry.
- The ingestion pipeline is dropping or severely slowing down records as part of its processing. (rare)
- Kusto is facing problems saving the telemetry. (rare)
- The "Draft" or Query API, at api.applicationinsights.io, has failures querying the data from Kusto.
- The Azure portal UI code has issues pulling or rendering the records you are trying to view.

Problems can occur anywhere across the service, and may be tedious to properly diagnose. The goal is to eliminate these layers as fast as possible, so you can investigate the correct step within the processing pipeline that is causing the symptoms. One method that will drastically assist with this isolation is sending a sample telemetry record using PowerShell.

## Troubleshooting with PowerShell

### On-premises or Azure VM

If you connect to the machine or VM where the web application is running, you can attempt to send a single telemetry record to the Applications Insights service instance using PowerShell. Doing so will not require any additional tools.

### Web App

If the app that is having issues sending telemetry is running on Kudu, you can use the PowerShell script outlined here from Kudu's PowerShell Debug Command prompt feature in Web Apps.

The are two caveats to running the operations from Kudu:

- Prior to executing the Invoke-WebRequest command, you have to issue the PowerShell command: `$ProgressPreference = "SilentlyContinue"`
- You cannot use -Verbose or -Debug. Instead, use -UseBasicParsing.

This would look like the following as opposed to the examples further down:

```shell
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -Method POST -Body $availabilityData -UseBasicParsing

```

After you send a telemetry record via PowerShell, you can check to see if the sample telemetry record arrives using the Application Insights Logs tab in the Azure portal. If you see the sample record showing up, you have eliminated a large portion of the processing pipeline:

**A Sample PowerShell Record Correctly Saved and Displayed Suggests:**

- The machine or VM has DNS that resolves to correct IP address.
- The network delivered the telemetry to the ingestion endpoint without blocking or dropping.
- The ingestion endpoint accepted the sample payload and processed through the ingestion pipeline.
- Kusto correctly saved the sample telemetry record.
- The Azure portal Logs tab was able to query the Draft API (api.applicationinsights.io) and render the record in the portal UI

If the sample record does show up, it typically means you just need to troubleshoot the Application Insights SDK or Codeless Agent. You would typically move to collect SDK Logs or PerfView traces, whichever is appropriate for the SDK/Agent version.

There is still a small chance that ingestion or the backend pipeline is sampling records, or dropping specific telemetry types, which may explain why your test record arrives but the customer's production telemetry doesn't. You should always start investigating the SDKs or Agents if the below sample scripts correctly save and return telemetry records.

**Availability Test Result Telemetry Records**

Availability Web Test Results are the best telemetry type to test with. The main reason is because our ingestion pipeline never samples out Availability Test records. If you instead send a Request Telemetry record using PowerShell, that record could get sampled out with Ingestion Sampling, and not show up when you go to query for it. Start with a sample Availability Test Records first, then try other telemetry types as needed.

### PowerShell Script To Send an Availability Test Telemetry

This script builds a raw REST request to deliver a single Availability Test Result record to the customers Application Insights component. You can supply the **ConnectionString** or **InstrumentationKey** parameters.

- Connection String only: Telemetry sent to regional endpoint in connection string
- Ikey only: Telemetry sent to global ingestion endpoint
- If both Connection String and Ikey parameters are supplied the script sends telemetry to the regional endpoint in the connection string

It is easiest to run the script from the PowerShell ISE environment on an IaaS or VMSS (virtual machine scale set) instance. You can also copy and paste it into the App Services Kudu interface PowerShell debug console.

```shell
# Info: Provide either the Connection String or Ikey for your Application Insights Resource
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

# If Ikey is the only parameter supplied, we'll send telemetry to the
# global ingestion endpoint instead of regional endpoint found in connection strings
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
  "iKey": "$iKey",
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

When the above script executes, you want to review the response details. We are looking for an HTTP 200 response, and as part of the response JSON payload we want to see the **itemsReceived** count **matches** the **itemsAccepted**. This means that the ingestion endpoint is informing the client: you sent one record, I accepted one record.

<a name="items-received-matches-items-accepted.png" alt="Code showing the amount of items received and items accepted"></a>

### PowerShell Script To Send a Request Telemetry

If you want to test sending a single Request Telemetry record, the below script will help you format it. This telemetry type is susceptible to server-side ingestion sampling configuration. Make sure ingestion sampling is turned off to help confirm if these records are getting saved correctly.

```shell
# Info: Provide either the Connection String or Ikey for your Application Insights Resource
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

# If Ikey is the only parameter supplied, we'll send telemetry to the
# global ingestion endpoint instead of regional endpoint found in connection strings
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
        "url": http://localhost:8080/requestData/sampleurl,
        "httpMethod": "GET"
       }
   },
   "ver": 1,
   "iKey": "$iKey",
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

### Curl Client To Send Availability Test Telemetry Record

For customers running Linux VMs, you could rely on Curl client to send a similar REST call instead of PowerShell. Below is a Curl request to send a single Availability Web Test result record. You will need to adjust the ingestion endpoint host, the ikey value and the timestamp values.

Curl command for **Linux/MaxOS**:

```
>curl -H "Content-Type: application/json" -X POST -d '{"data":{"baseData":{"ver":2,"id":"SampleRunId","name":"MicrosoftSupportSampleWebtestResultUsingCurl","duration":"00.00:00:10","success":true,"runLocation":"RegionName","message":"SampleWebtestResult","properties":{"SampleProperty":"SampleValue"}},"baseType":"AvailabilityData"},"ver":1,"name":"Microsoft.ApplicationInsights.Metric","time":"<span style="font-size:11.0pt;line-height:107%;font-family:&quot;Calibri&quot;,sans-serif;background:yellow">2021-10-05T22:00:00.0000000Z</span>","sampleRate":100,"iKey":"<span style="font-size:11.0pt;line-height:107%;font-family:&quot;Calibri&quot;,sans-serif;background:yellow">4c529c82-dee8-4723-b030-7b56bae7562a</span>","flags":0}' [https://%3cspan]https://<span style="font-size:11.0pt;line-height:107%;font-family:&quot;Calibri&quot;,sans-serif;background:yellow">dc.applicationinsights.azure.com</span>/v2.1/track

```

Curl command for **Windows** (adjust timestamp before running):

```shell
curl -H "Content-Type: application/json" -X POST -d {\"data\":{\"baseData\":{\"ver\":2,\"id\":\"SampleRunId\",\"name\":\"MicrosoftSupportSampleWebtestResultUsingCurl\",\"duration\":\"00.00:00:10\",\"success\":true,\"runLocation\":\"RegionName\",\"message\":\"SampleWebtestResult\",\"properties\":{\"SampleProperty\":\"SampleValue\"}},\"baseType\":\"AvailabilityData\"},\"ver\":1,\"name\":\"Microsoft.ApplicationInsights.Metric\",\"time\":\"2021-10-05T22:00:00.0000000Z\",\"sampleRate\":100,\"iKey\":\"4c529c82-dee8-4723-b030-7b56bae7562a\",\"flags\":0} https://dc.applicationinsights.azure.com/v2/track

```

### PowerShell Script To Send 100 Trace Messages

You can try to send a burst of telemetry records from the client machine to their component. For this approach, you will want to find a version of Microsoft.ApplicationInsights.dll loaded on the customer's machine. You can find it as part of NuGet package installation or Application Insights Agent (SMv2) installation. The below script will load the dll then call TrackTrace 100 times sending 100 telemetry records to the global ingestion endpoint at dc.services.visualstudio.com.

```shell
# One Parameter: Provide the Instrumentation Key
$iKey = "{replace-with-your-ikey}"

# Load App Insights dll from local NuGet package if it exists
# Add-Type -Path "c:\users\{useralias}\.nuget\packages\microsoft.applicationinsights\2.17.0\lib\netstandard2.0\Microsoft.ApplicationInsights.dll";
# Load App Insights dll from Application Insights Agent installation directory
Add-Type -Path "C:\Program Files\WindowsPowerShell\Modules\Az.ApplicationMonitor\1.1.2\content\PowerShell\Microsoft.ApplicationInsights.dll";
$client = New-Object Microsoft.ApplicationInsights.TelemetryClient;

$client.InstrumentationKey=$iKey;
$i = 1;
while ($i -le 100) {
   $client.TrackTrace("Sample Trace Message # $i", $null);
   $i +=1;
}
$client.Flush();
read-host “Press ENTER to continue...”

```

### SSL/TLS Troubleshooting

If you suspect the problem is between the client and our ingestion endpoint due to SSL/TLS configuration, you can adjust how PowerShell participates in the SSL/TLS protocol. Include these snippets if you need to diagnose secure channel as part of the connection between the client VM and our Ingestion endpoints

First is an option to control which SSL/TLS protocol is used by PowerShell to make a connection to our ingestion endpoint. Add any one of these lines to the top of your PowerShell script to control the protocol used in the test REST request:

```shell
# Uncomment one or more of these lines to test TLS/SSL protocols other than the machine default option
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::SSL3
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS11
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS12
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::TLS13

```

Second is an option to ignore any SSL Certificate validation issues. If your customer has a firewall or proxy server that may be doing SSL certificate offloading, you can ignore any SSL cert issues by adding this snippet just before the `Invoke-WebRequest` call:

```shell
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

If the customer's application defaults to the system or machine default TLS settings then you can change those default settings within the registry on Windows machines using details found in this article: [Transport Layer Security (TLS) registry settings](/windows-server/security/tls/tls-registry-settings#tls-dtls-and-ssl-protocol-version-settings).

Alternatively, if you need to change the default TLS/SSL protocol used by a .NET application then you can follow the official guidance here [Transport Layer Security (TLS) best practices with the .NET Framework](/dotnet/framework/network-programming/tls).

### Next Steps

If sending telemetry via PowerShell from the customers impacted machine works, you will want to investigate their SDK or Codeless configuration for further troubleshooting.

If sending telemetry via PowerShell also fails, continue to isolate where the problem could be: DNS investigations, TCP connection to ingestion endpoint, look for Dropped Metrics on the Ingestion tab within ASC, etc.
