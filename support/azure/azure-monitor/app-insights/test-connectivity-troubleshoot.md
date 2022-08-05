---
title: Test connectivity and telemetry ingestion using PowerShell or curl clients
description: Learn how to troubleshoot missing data by using PowerShell or curl clients.
ms.topic: conceptual
ms.date: 8/5/2022
ms.author: toddfous
author: todd.foust
editor: v-kainawroth
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Application Insights user I want to understand known issues for the Application Insights Agent and how to troubleshoot common issues so I can use Application Insights and the Agent effectively.
---

# Test connectivity and telemetry ingestion using PowerShell or curl clients

## Missing or No Data Symptoms

One of the most common problems is the 'missing data' or 'not finding specific telemetry records' symptom.

Missing data symptoms can be the result of failures across every single step in the life of a telemetry record.

**SDK/Codeless Agents** ---> **Networking** ---> **Ingestion Endpoint** ---> **App Insights Ingestion Pipeline** ---> **Kusto Backend** <--- **Query API** <--- **Azure Portal**

1. The SDK or Agent could be misconfigured and not sending data to our ingestion endpoint
2. The SDK/Agent could be correctly configured but the customer's, or public networking may be blocking calls to the ingestion endpoint
3. The Ingestion Endpoint may be dropping or throttling inbound telemetry
4. The Ingestion Pipeline may possibly dropping or severely slowing down some records as part of its processing (rare)
5. Kusto could be facing some problems saving the telemetry (very rare)
6. The "Draft" or Query API, at api.applicationinsights.io, may have failures querying the data out of Kusto
7. The Azure Portal UI code may have an issue pulling and rendering the records the customer is trying to view.

As you can see, 'no telemetry' or 'partial telemetry' symptoms can occur anywhere across the service, and may be tedious to properly diagnose. The goal is to eliminate these layers as fast as possible so that we investigate the correct step within the processing pipeline which is causing the symptoms. One tool that will drastically assist with this isolation is to send a sample telemetry record using PowerShell.

## Troubleshooting with PowerShell

### On-Premises or Azure VM

If you connect to the machine/VM where the customer's web application is running, then you can attempt to send a single telemetry record to the customers Applications Insights service instance using PowerShell. This does not require you to install any other tool, so it's easy to walkthrough and test with the customer.

### Web App

It is possible using the Powershell script outlined here from Kudu's PowerShell Debug Command prompt feature in Web Apps. It is probably a good idea to test from this tool if this where the app is running that is having issues sending telemetry.

The are two caveats to running the operations from Kudu one, prior to executing the Invoke-WebRequest command, issue the Powershell command: ```$ProgressPreference = "SilentlyContinue"``` and two you cannot use -Verbose or -Debug, instead use -UseBasicParsing. This would look like following as opposed to the examples further down:

```shell
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -Method POST -Body $availabilityData -UseBasicParsing

```

After you send a telemetry record via PowerShell, then you can check to see if the sample telemetry record arrives using the Application Insights Logs tab in the Azure Portal. If you do see the sample record show up, then you have just eliminated a large portion of the processing pipeline:

**A Sample PowerShell Record Correctly Saved and Displayed Suggests:**

- The client machine/VM has DNS that resolves to correct IP address
- The client/public network delivered the telemetry to our ingestion endpoint without blocking or dropping
- Ingestion endpoint accepted that sample payload and processed through the ingestion pipeline
- Kusto correctly saved the sample telemetry record
- The Azure Portal Logs tab was able to query our Draft API (api.applicaitoninsights.io) and render that record in the portal UI

If the sample record does show up, then it typically means you just need to troubleshoot the Application Insights SDK or Codeless Agent. You would typically move to collect SDK Logs or PerfView traces, whichever is appropriate for the SDK/Agent version.

There are still small chances that ingestion or the backend pipeline is sampling records, or dropping a specific telemetry types, which may explain why your test record arrives but the customers production telemetry doesn't, but you should always start investigating the SDKs or Agents if the below sample scripts correctly save and return telemetry records.

**Availability Test Result Telemetry Records**

Availability Web Test Results are the best telemetry type to test with. The main reason is because our ingestion pipeline never samples out Availability Test records. If you were to instead send a Request Telemetry record using PowerShell, then that record could get sampled out with Ingestion Sampling, and not show up when you go to query for it. Start with a sample Availability Test Records first, then try other telemetry types as needed. 

### PowerShell Script To Send an Availability Test Telemetry

This script builds a raw REST request to deliver a single Availability Test Result record to the customers Application Insights component. You can supply the **ConnectionString** or **InstrumentationKey** parameters.

- Connection String only: Telemetry sent to regional endpoint in connection string
- Ikey only: Telemetry sent to global ingestion endpoint
- If both Connection String and Ikey parameters are supplied the script sends telemetry to the regional endpoint in the connection string

It is easiest to have customer run this from the PowerShell ISE environment on an IaaS or VMSS instance, you can also copy and paste the script into the App Services Kudu interface PowerShell debug console

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

When the above script executes, you want to review the response details. We are looking for a HTTP 200 response, and as part of the response JSON payload we want to see the **itemsReceived** count **matches** the **itemsAccepted**. This is the ingestion endpoint informing the client, you sent one record, I accepted one record.

![image.png](/.attachments/image-0e46ee4c-d6e4-4605-a73f-e94f3db6c5de.png)

### PowerShell Script To Send a Request Telemetry

If you want to test sending a single Request Telemetry record then the below script will help format a Request telemetry record. Remember, this telemetry type is susceptible to server-side ingestion sampling configuration, so make sure ingestion sampling is turned off to help confirm if these records are getting saved correctly.

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

You may also want to try and send a burst of telemetry records from the client machine to their component. For this approach, you will want to find a version of Microsoft.ApplicationInsights.dll loaded on the customers machine. You can find it as part of Nuget package installation or Application Insights Agent (SMv2) installation. The below script will load the dll then call TrackTrace 100 times sending 100 telemetry records to the global ingestion endpoint at dc.services.visualstudio.com.

```shell
# One Parameter: Provide the Instrumentation Key
$iKey = "{replace-with-your-ikey}"

# Load App Insights dll from local Nuget package if it exists
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

If the customers application defaults to the system or machine default TLS settings then you can change those default settings within the registry on Windows machines using details found in this article: [Transport Layer Security (TLS) registry settings](windowsserverdocs/WindowsServerDocs/security/tls/tls-registry-settings.md#tls-dtls-and-ssl-protocol-version-settings).

Alternatively, if you need to change the default TLS/SSL protocol used by a .NET application then you can follow the official guidance here [Transport Layer Security (TLS) best practices with the .NET Framework](docs/docs/framework/network-programming/tls.md)

### Next Steps

If sending telemetry via PowerShell from the customers impacted machine works then you will want to investigate their SDK or Codeless configuration for further troubleshooting.

If sending telemetry via PowerShell also fails, then continue to isolate where the problem could be: DNS investigations, TCP connection to ingestion endpoint, look for Dropped Metrics on the Ingestion tab within ASC, etc.
