---
title: Http.sys registry settings for Windows
description: Registry values can be added to control Http.sys behavior.
ms.date: 04/16/2020
ms.custom: sap:Health, Diagnostic, and Performance Features\IIS logging
ms.topic: concept-article
---
# Http.sys registry settings for Windows

This article describes Http.sys registry settings for Windows.

_Original product version:_ &nbsp; Windows 8, Windows Server 2012, 2008 R2, 2008  
_Original KB number:_ &nbsp; 820129

## Summary

In Windows Server 2008 and later versions, Http.sys is the kernel mode driver that handles Hypertext Transfer Protocol (HTTP) requests. Several registry values can be configured according to specific requirements. The table in the [Registry keys](#registry-keys) section contains the following information about these registry values:

- Registry key names
- Default values
- Valid value ranges
- Registry key functions
- WARNING codes (where applicable)

> [!NOTE]
> See the [Warning codes](#warning-codes) section for information about potential risks when you create and configure registry values by using settings other than the default settings.

This article is intended for advanced users and assumes knowledge of the registry and of the risks that are involved when the registry is changed.

## Registry keys

> [!IMPORTANT]
>This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see
[How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

You can create the following DWORD registry values under the following registry key:  
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters`

|Registry key|Default value|Valid value range|Registry key function|WARNING code|
|---|---|---|---|---|
|AllowRestrictedChars|0|Boolean|If nonzero, Http.sys accepts hex-escaped chars in request URLs that decode to U+0000 - U+001F and U+007F - U+009F ranges.|0|
|EnableAggressiveMemoryUsage|0|0<br/>1|Preallocate nonpaged pool memory. By default, the HTTP service stops accepting connections when less than 20 megabytes (MB) of nonpaged pool memory is available. After you add this value to the registry, the HTTP service stops accepting connections when less than 8 MB of nonpaged pool memory is available. Setting this registry value may reduce the number of _Connections_refused_ and 503 errors in the _Httperr.log_ file.|0|
|EnableNonUTF8|1|Boolean|If zero, Http.sys accepts only UTF-8-encoded URLs. If nonzero, Http.sys also accepts ANSI- or DBCS-encoded URLs in requests.|0|
|FavorUTF8|1|Boolean|If nonzero, Http.sys always tries to decode a URL as UTF-8 first; if that conversion fails and `EnableNonUTF8` is nonzero, Http.sys then tries to decode it as ANSI or DBCS. If zero (and `EnableNonUTF8` is nonzero), Http.sys tries to decode it as ANSI or DBCS; if that is not successful, it tries a UTF-8 conversion.|0|
|MaxBytesPerSend|65536|1-0xFFFFF (Bytes)|Overrides the TCP window size that is used by Http.sys. A higher value may enable higher download speeds in network environments that have high bandwidth and high latency.|0|
|MaxConnections|MAX_ULONG|1024 (1k) - 2031616 (2 MB) connections|Overrides the `MaxConnections` calculation in the driver. This is primarily a function of memory.|1|
|MaxEndpoints|0|0 - 1024|The maximum number of current endpoint objects that are permitted. The default value of zero implies that the maximum is computed from available memory.|1|
|MaxFieldLength|16384|64 - 65534 (64k - 2) bytes|Sets an upper limit for each header. See `MaxRequestBytes`. This limit translates to approximately 32k characters for a URL.|1|
|MaxRequestBytes|16384|256 - 16777216 (16 MB) bytes|Determines the upper limit for the total size of the Request line and the headers.<br/>Its default setting is 16 KB. If this value is lower than `MaxFieldLength`, the `MaxFieldLength` value is adjusted.|1|
|PercentUAllowed|1|Boolean|If nonzero, Http.sys accepts the _% uNNNN_ notation in request URLs.|0|
|UrlSegmentMaxCount|255|0 - 16,383 segments|Maximum number of URL path segments. If zero, the count bounded by the maximum value of a `ULONG`.|1|
|UriEnableCache|1|Boolean|If nonzero, the Http.sys response and fragment cache are enabled.|0|
|UriMaxUriBytes|262144 (bytes)|4096 (4k) - 16777216 (16 MB) bytes|Any response that is greater than this value is not cached in the kernel response cache.|1<br/>3|
|UriScavengerPeriod|120 (seconds)|10 - 0xFFFFFFFF seconds|Determines the frequency of the cache scavenger. Any response or fragment that has not been accessed in the number of seconds equal to `UriScavengerPeriod` is flushed.|1<br/>2|
|UrlSegmentMaxLength|260|0 - 32,766 chars|Maximum number of characters in a URL path segment (the area between the slashes in the URL). If zero, it is the length that is bounded by the maximum value of a `ULONG`.|1|
|DisableServerHeader|0|0 - 2|This key controls how http.sys behaves with regards to appending the http response header Server for responses that it sends to clients. A value of 0, which is the default value, will use the header value the application provides to http.sys, or will append the default value of `Microsoft-HTTPAPI/2.0` to the response header. A value of 1 will not append the Server header for responses generated by http.sys (responses ending in 400, 503, and other status codes). A value of 2 will prevent http.sys from appending a Server header to the response. If a Server header is present on the response, it will not be removed, if one is not present, it will not be added.|0|

You may experience slow performance in Internet Information Services (IIS) when Internet Server API (ISAPI) applications or Common Gateway Interface (CGI) applications that are hosted on IIS send responses. If you experience this issue, you can add the `MaxBufferedSendBytes` DWORD value to the registry.

In Windows Server 2008 and later versions, you can also create the following DWORD value under the following registry key:  
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTPFilter\Parameters`

|Registry key|Default value|Valid value range|Registry key function|WARNING code|
|---|---|---|---|---|
|CertChainCacheOnlyUrlRetrieval|1|0<br/>1|By default, the AIA hints are not followed during chain validation when IIS is configured to use Client Certificates. This behavior is for performance and security reasons. For example, this behavior can help prevent DoS attacks. However, this behavior can also lead to unexpected certificate rejections when AIA retrieval is needed. To override this behavior, you can set the DWORD parameter `CertChainCacheOnlyUrlRetrieval` to 0 (zero) under the `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTPFilter\Parameters` registry key.|Not applicable|

## Warning codes

- 0: No risks.
- 1: Changing this registry key is considered dangerous. This key causes Http.sys to use more memory and may increase vulnerability to malicious attacks.
- 2: A low value may cause the cache to be flushed more frequently. If this behavior occurs, it may affect performance.
- 3: A low value may affect performance for static content.

Changes that are made to the registry will not take effect until you restart the HTTP service. Additionally, you may have to restart any related IIS services.

To restart the HTTP service, type and all related IIS services, follow these steps:

1. Select **Start**, select **Run**, type _Cmd_, and then select **OK**.
2. At the command prompt, type `net stop http`, and then press Enter.
3. At the command prompt, type `net start http`, and then press Enter.
4. At the command prompt, type `net stop iisadmin /y`, and then press Enter.

    > [!NOTE]
    > Any IIS services that depend on the IIS Admin Service service will also be stopped. Notice the IIS services that are stopped when you stop the IIS Admin Service service. You will restart each service in the next step.
5. Restart the IIS services that were stopped in step 4. To do this, type `net start servicename` at the command prompt and then press Enter. In the command, _servicename_ is the name of the service that you want to restart. For example, to restart the World Wide Web Publishing Service service, type `net start World Wide Web Publishing Service`, and then press Enter.
