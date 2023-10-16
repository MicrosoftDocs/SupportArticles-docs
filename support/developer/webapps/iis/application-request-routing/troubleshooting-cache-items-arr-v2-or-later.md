---
title: Troubleshooting cache items in ARR version 2.0 or later
description: This article provides resolutions for troubleshooting cache items ARR version 2.0 or later.
ms.date: 04/09/2012
ms.reviewer: apurvajo, chihshen, v-jayaramanp
ms.topic: troubleshooting
---

# Troubleshooting cache items in ARR version 2.0 or later

_Applies to:_ &nbsp; Internet Information Services

## Overview

In this walkthrough, you can learn how to trace a request as it passes through ARR and is sent to a next-tier server, and look at the information that can be acquired to determine where the request was sent and where it was served from.

## Tools used in this troubleshooter

- ARR Helper
- [Failed Request Tracing (FREB)](/iis/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis-85)
- IIS Advanced Logging
- [Network Monitor](../../../../windows-server/networking/network-monitor-3.md)

## Understand the architecture of the farm

The first step is to understand the architecture of the environment including the following.

- ARR Farm topology (how many servers, how routing is configured, other devices)
- URL Rewrite rules in place

In this walkthrough, you can use the following configuration to trace a request.

:::image type="content" source="media/troubleshooting-cache-items-arr-v2/troubleshooting-cache-items-arr-v2-1108.png" alt-text="Diagram shows a child node, a parent node, and an origin server with arrows to indicate cache misses and requests.":::

### Disk cache configuration

The following code snippet shows a local drive with a maximum size of 100 GB is configured.

```xml
<diskCache> 
<driveLocation path="E:\temp$\arrcache" maxUsage="100" />            
</diskCache>
```

### Global cache control rules

This rule is defined as cache for 60 minutes when no cache control directive exists.

```xml
<rule name="ARR_CacheControl_b5aec65d-6327-407f-a28c-b34e48c5cda2" enabled="true" patternSyntax="Wildcard"> 
     <match url="*" />     
       <serverVariables>        
         <set name="ARR_CACHE_CONTROL_OVERRIDE" value="0,max-age=3600" />         
       </serverVariables>
</rule>
```

## Build a data gathering plan

This section will walk you through the flow of cache hits and misses as they transit through ARR, and identify any tools or logs you might use to investigate the requests. The following steps outline the request flow for content not previously cached using the configuration provided as our reference and the tools used at each step.

- The requested content isn't found locally (neither in memory nor on disk on child node).

  - FREB Logs
  - IIS built in logging
  - Network Monitor

- The request is forwarded to the next tier cache node (parent node).

  - FREB Logs
  - IIS Advanced Logging module
  - IIS built in logging
  - Network Monitor

- The requested content isn't found at the next tier cache node (neither in memory nor on disk).   Repeat point 2 as many times as appropriate based on cache hierarchy.
- The request is forwarded to the origin server.

  - FREB Logs
  - IIS built in logging
  - Network Monitor

## Gather the data

### The requested content is not found locally (neither in memory nor on disk)

Here you can identify a cache hit or miss in either the IIS logs or FREB logs. The FREB logs provide additional details such as where the request was routed, which is important if there are multiple down level servers.

**IIS Log Entry** - You will find the following entries in the **cs-uri-query** field that identifies the cache Hit or Miss and the GUID for the request, which can be used to identify the request on down level servers.

```output
X-ARR-CACHE-HIT=0
```

```output
0 =  Cache miss, 1 = Cache hit
```

```output
X-ARR-LOG-ID=62a3161c-b4f5-408e-9ce7-55d25c018aea
```

```output
Guid identifying this request. This can be used to track as the request is passed to Parent nodes.
```

**FREB Log Entry** - The cache miss is found by the entry `ARR_DISK_CACHE_GET_FAILED`.

| Type | Entry | Details |
| --- | --- | --- |
| r | ARR\_DISK\_CACHE\_GET\_FAILED Warning | FilePath="\\?\C:\ARRCache\localhost\iisstart.htm.full", ErrorCode="The system cannot find the file specified. (0x80070002)", IsRangeEntry="false", RangeOffset="0", RangeSegmentSize="0" |

Identify the server to which the request is routed. Observe the request being sent to server `W2K8WEBSERVER2`, which will be the next level server for data review.

| Type | Entry |Details|
| --- | --- | --- |
| i | ARR\_SERVER\_ROUTED | RoutingReason="LoadBalancing", Server="W2K8WEBSERVER2", State="Active", TotalRequests="8", FailedRequests="0", CurrentRequests="1", BytesSent="1127", BytesReceived="6441379", ResponseTime="31351" |

The following headers are added to the request for forwarding. If some names are different than the default names such as `X-Forwarded-For`, `X-ARR-ClientCert`, and `X-ARR-LOG-ID`, the names have been customized in Server Farm proxy settings.

|Header |Details |
| --- | --- |
| GENERAL\_SET\_REQUEST\_HEADER | HeaderName="Max-Forwards", HeaderValue="10", Replace="true" |
| GENERAL\_SET\_REQUEST\_HEADER | HeaderName="X-Forwarded-For", HeaderValue="127.0.0.1:62489", Replace="true" |
| GENERAL\_SET\_REQUEST\_HEADER | HeaderName="X-ARR-SSL", HeaderValue="", Replace="true" |
| GENERAL\_SET\_REQUEST\_HEADER | HeaderName="X-ARR-ClientCert", HeaderValue="", Replace="true" |
| GENERAL\_SET\_REQUEST\_HEADER | HeaderName="X-ARR-LOG-ID", HeaderValue="fe9d20da-a571-4451-8ef3-0e7faf1a463a", Replace="true" |

### The request is forwarded to the next tier cache node (parent node)

In the previous step, you had identified this server as `W2K8WEBSERVER2`. In this step, you can examine the following data on this server. There are multiple data points that can be used. Using `X-ARR-LOG-ID`, you can identify if the request reached this server.

**FREB Logs** - The request can be identified by the `X-ARR-LOG-ID` sent from the child node. The  `fe9d20da-a571-4451-8ef3-0e7faf1a463a` was identified in the previous step.

|Header|Details|
| --- | --- |
| GENERAL\_REQUEST\_HEADERS | Headers="Connection: Keep-Alive Accept: \*/\* Host: localhost Max-Forwards: 10 X-Original-URL: /iisstart.htm X-Forwarded-For: 127.0.0.1:62489 X-ARR-LOG-ID: fe9d20da-a571-4451-8ef3-0e7faf1a463a |

**IIS Advanced Logging Module** - By using advanced logging, you can add custom logging fields based on the headers `X-Forwarded-For` and `X-ARR-LOG-ID` and then use filtering to only log when these headers are present.

```output
#Software: IIS Advanced Logging Module
#Version: 1.0
#Start-Date: 2009-10-16 18:42:51.494
#Filter: ((ARRLogID isPresent ) || (xforward isPresent ))
#Fields:  date time cs-uri-stem cs-uri-query s-contentpath sc-status s-computername cs(Referer) sc-win32-status sc-bytes cs-bytes X-ARR-LOG-ID X-Forwarded-For
```

```console
2009-10-16 18:51:29.983 /iisstart.htm - "C:\inetpub\wwwroot\iisstart.htm" 200 "W2K8WEBSERVER2" - 0 1680 219 "fe9d20da-a571-4451-8ef3-0e7faf1a463a" "127.0.0.1:62489"
```

**Network Monitor** - Use the trace to identify the `X-ARR-LOG-ID` and `X-Forwarded-For` if you want to trace a particular request.

[ARR Helper](https://blogs.iis.net/anilr/archive/2009/03/03/client-ip-not-logged-on-content-server-when-using-arr.aspx) - This module adds the `X-Forwarded-For` header to the `C-IP` field and the `X-ARR-LOG-ID` header to the `cs-uri-query` field of the default IIS logs.

> [!NOTE]
> The ArrHelper isn't currently supported by Microsoft.

**Repeat Steps 1 and 2 for multiple levels of cache**

If the server parent node `W2K8WEBSERVER2` is set up with ARR and caching features, you might need to check the IISLOGS or FREB to see if there was a cache Hit or Miss and decide where to proceed depending on that cache's entry status.

### Request is forwarded to the Origin Server

This step can be treated as a normal HTTPS request and can be tracked with the following tools:

- [Network Monitor](../../../../windows-server/networking/network-monitor-3.md) - Captures traces on the Origin server to verify receipt of the request.
- IIS Logs - Checks IIS logs for HTTP Response codes for the content you are tracing.
- [IIS FREB Logs](/iis/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis-85) - If the request was found in the Network trace and the HTTP response code wasn't a 200, you might want to use FREB again to troubleshoot the issue.

## Troubleshooting cache failures

**Check Cache-Control Headers**

Verify Cache-Control headers received from the client. This can be done in conjunction with checking the cache control rules since the headers can be configured to override headers.

**Review Cache-Control Rules in ARR**

Check the Cache Control Rules in ARR to verify whether ARR caching is enabled.

**Verify HTTP.SYS settings**

For more information about why content isn't cached by *HTTP.sys* in kernel, see [Instances in which HTTP.sys doesn't cache content](../general/instances-httpsys-not-cache.md).

**Disk Cache Failures**

ARR logs events to the Application event log when disk failures occur and mark the disk as unhealthy.

```output
Log Name: Application 
Source: Application Request Routing 
Date: 11/2/2009 5:26:59 PM 
Event ID: 1006 
Task Category: None 
Level: Warning 
Keywords: Classic 
User: N/A 
Computer: 
Description: Drive with path '\?\E:\temp$\arrcache\' is being marked unhealthy. The data contains the error code. 
Event Xml: 
```

## More information

- [Reasons content is not cached by HTTP.sys in kernel](../general/instances-httpsys-not-cache.md)
- [Network Monitor](../../../../windows-server/networking/network-monitor-3.md)
