---
title: Troubleshooting 502 errors in ARR
description: This article provides resolutions for the IIS Failed Request Tracing Network Monitor WinHTTP tracing related to ARR.
ms.date: 04/09/2012
ms.reviewer: riande, rimarr, v-jayaramanp
ms.topic: troubleshooting
---

# Troubleshooting 502 errors in ARR

This article helps you resolve the problems related to 502 errors in Application Request Routing (ARR).

_Applies to:_ &nbsp; Internet Information Services

## HTTP 502 - Overview

When you work with IIS Application Request Routing (ARR) deployments, one of the errors that you might see is "HTTP 502 - Bad Gateway". The 502.3 error means that while acting as a proxy, ARR was unable to complete the request to the upstream server and send a response back to the client. This problem can happen for multiple reasons. For example, failure to connect to the server, no response from the server, or the server took too long to respond (time out). If you're able to reproduce the error by browsing the web farm from the controller, and [detailed errors](https://www.iis.net/learn/troubleshoot/diagnosing-http-errors/how-to-use-http-detailed-errors-in-iis) are enabled on the server, you may see an error similar to the following error message:

:::image type="content" source="media/troubleshooting-502-errors-in-arr/http-error-502-3-operation-timed-out.png" alt-text="Screenshot that shows detailed 502 errors that appear when detailed errors are enabled on the server.":::

The root cause of the error determines what you should do to resolve the issue.

## 502.3 timeout errors

ARR uses the error code in the preceding screenshot to proxy the request and determine the source of the failure because it contains the return code from WinHTTP.

You can decode the error code with the tool [err.exe](https://download.microsoft.com/download/4/3/2/432140e8-fb6c-4145-8192-25242838c542/Err_6.4.5/Err_6.4.5.exe). In this example, the error code maps to ERROR\_WINHTTP\_TIMEOUT. You can also find this information in the IIS logs for the associated website on the ARR controller. The following is an excerpt from the IIS log entry for the 502.3 error, with most of the fields trimmed for readability:

| sc-status | sc-substatus | sc-win32-status | time-taken |
| --- | --- | --- | --- |
| 502 | 3 | 12002 | 29889 |

The win32 status 12002 maps to the same ERROR\_WINHTTP\_TIMEOUT error reported in the error page.

#### What exactly timed-out?

You can check this time-out by enabling [Failed Request Tracing](https://www.iis.net/learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis) on the IIS server. The first point that you can see, in the failed request trace log and this is where the request was sent to in the ARR\_SERVER\_ROUTED event. The second point is the X-ARR-LOG-ID, which you can use to track the request on the target server. This helps to trace the target or destination of the HTTP request:

```output
77. ARR_SERVER_ROUTED  RoutingReason="LoadBalancing", Server="192.168.0.216", State="Active", TotalRequests="3", FailedRequests="2", CurrentRequests="1", BytesSent="648", BytesReceived="0", ResponseTime="15225" 16:50:21.033 
78. GENERAL_SET_REQUEST_HEADER HeaderName="Max-Forwards", HeaderValue="10", Replace="true" 16:50:21.033 
79. GENERAL_SET_REQUEST_HEADER HeaderName="X-Forwarded-For", HeaderValue="192.168.0.204:49247", Replace="true" 16:50:21.033 
80. GENERAL_SET_REQUEST_HEADER HeaderName="X-ARR-SSL", HeaderValue="", Replace="true" 16:50:21.033 
81. GENERAL_SET_REQUEST_HEADER HeaderName="X-ARR-ClientCert", HeaderValue="", Replace="true" 16:50:21.033 
82. GENERAL_SET_REQUEST_HEADER HeaderName="X-ARR-LOG-ID", HeaderValue="dbf06c50-adb0-4141-8c04-20bc2f193a61", Replace="true" 16:50:21.033 
83. GENERAL_SET_REQUEST_HEADER HeaderName="Connection", HeaderValue="", Replace="true" 16:50:21.033
```

The following example shows how this might look on the target server's Failed Request Tracing logs. You can validate that you have found the correct request by matching up the "X-ARR-LOG-ID" values in both traces.

```output
185. GENERAL_REQUEST_HEADERS Headers="Connection: Keep-Alive Content-Length: 0 Accept: */* Accept-Encoding: gzip, deflate Accept-Language: en-US Host: test Max-Forwards: 10 User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0) X-Original-URL: /time/ X-Forwarded-For: 192.168.0.204:49247 X-ARR-LOG-ID: dbf06c50-adb0-4141-8c04-20bc2f193a61 
<multiple entries skipped for brevity> 
345. GENERAL_FLUSH_RESPONSE_END BytesSent="0", ErrorCode="An operation was attempted on a nonexistent network connection. (0x800704cd)" 16:51:06.240
```

In the previous example, you can see that the ARR server disconnected before the HTTP response was sent. The timestamp for GENERAL\_FLUSH\_RESPONSE\_END can be used as a rough guide to find the corresponding entry in the IIS logs on the destination server.

| date | time | s-ip | cs-method | cs-uri-stem | cs-uri-query | s-port | cs-username | sc-status | sc-substatus | sc-win32-status | time-taken |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2011-07-18 | 16:51:06 | 192.168.0.216 | GET | /time/ | - | 80 | - | 200 | 0 | 64 | 45208 |

IIS on the destination server logged an HTTP 200 status code, indicating that the request completed successfully. Also, the win32 status has changed to 64, which maps to ERROR\_NETNAME\_DELETED. This status code generally indicates that the client (ARR being the 'client' in this case) disconnected before the request completed.

#### Cause

The ARR server reported a timeout, which is where you should look first.

Although the member server log indicates that the response was sent in 45 seconds (45208 ms), the IIS log entry from the ARR server indicates that the time-taken is very close to 30 seconds. This indicates that ARR is timing out the request, and you can confirm this by looking at the proxy timeout in the server farm's proxy settings. By default, it's set to 30 seconds.

So, in this case, you can clearly see that the ARR timeout was shorter than the execution of the request. Therefore, you might want to check to see if this execution time was typical or if you needed to look into why the request was taking longer than expected. If this execution time was expected and normal, increasing the ARR timeout should resolve the error.

Other possible reasons for ERROR\_WINHTTP\_TIMEOUT include:

- `ResolveTimeout`: Occurs if name resolution takes longer than the specified timeout period.
- `ConnectTimeout`: Occurs if it takes longer than the specified timeout period to connect to the server after the name resolved.
- `SendTimeout`: Occurs if sending a request takes longer than this time-out value. The send operation is canceled.
- `ReceiveTimeout`: Occurs if a response takes longer than this time-out value. The request is canceled.

When you observe the first two reasons, `ResolveTimeout` and `ConnectTimeout`, the troubleshooting methodology outlined previously wouldn't work. This is because you wouldn't see any traffic on the target server and therefore wouldn't know the error code. So, in this case of `ResolveTimeout` or `ConnectTimeout` you might want to capture a WinHTTP trace for additional insight. See the [WinHTTP or WEBIO tracing](#winhttp-or-webio-tracing) section and at the following blogs for other examples on troubleshooting and tracing:

- [502.3 Bad Gateway "The operation timed out" with IIS Application Request Routing (ARR)](https://blogs.iis.net/richma/archive/2010/07/03/502-3-bad-gateway-the-operation-timed-out-with-iis-application-request-routing-arr.aspx)
- [Winhttp Tracing Options for Troubleshooting with Application Request Routing](https://blogs.iis.net/richma/archive/2012/08/24/winhttp-tracing-options-for-troubleshooting-with-application-request-routing.aspx)

## 502.3 Connection termination errors

502.3 errors are also returned when the connection between ARR and the member server is disconnected mid-stream. To test this type of problem, create an .aspx page that calls `Response.Close()`. In the following example, there's a directory called "time", which is configured with an .aspx page as the default document in that directory. When you try to browse to the directory, ARR shows the following error message:

:::image type="content" source="media/troubleshooting-502-errors-in-arr/502-3-service-terminated-abnormally.png" alt-text="Screenshot that shows connection termination errors.":::

The error 0x80072efe corresponds to ERROR\_INTERNET\_CONNECTION\_ABORTED. The request can be traced to the server that actually processed it using the same steps used earlier in this troubleshooter, with one exception. While Failed Request Tracing on the destination server shows the request processed on the server, the associated log entry doesn't appear in the IIS logs. Instead, this request is logged in the HTTPERR log as follows:

```output
HTTP/1.1 GET /time/ - 1 Connection_Dropped DefaultAppPool
```

The built-in logs on the destination server don't provide any additional information about the problem, so the next step would be to gather a network trace from the ARR server. In the previous example, the .aspx page called `Response.Close()` without returning any data. Viewing this in a network trace would show that a `Connection: close` HTTP header was coming from the destination server. With this information, you could start an investigation into why the `Connection: close` header was sent.

The following error is another example of an invalid response from the member server:

:::image type="content" source="media/troubleshooting-502-errors-in-arr/502-3-invalid-unrecognized-response.png" alt-text="Screenshot that shows an invalid response from the member server.":::

In this example, ARR started to receive data from the client but something went wrong while reading the request entity body. This resulted in the 0x80072f78 error code being returned. To investigate further, use [Network Monitor](../../../../windows-server/networking/network-monitor-3.md) on the member server to get a network trace of the problem. This particular error example was created by calling `Response.Close()` in the *ASP.net* page after sending part of the response and then calling `Response.Flush()`. If the traffic between the ARR server and the member servers is over SSL, then [WinHTTP](https://technet.microsoft.com/library/cc731131(WS.10).aspx) tracing on Windows Server 2008 or WebIO tracing on Windows Server 2008 R2 may provide additional information. WebIO tracing is described later in this troubleshooter.

## 502.4 No appropriate server could be found to route the request

The HTTP 502.4 error with an associated error code of 0x00000000 generally indicates that all the members of the farm are either offline or otherwise unreachable.

:::image type="content" source="media/troubleshooting-502-errors-in-arr/no-appropriate-server-found-route-request.png" alt-text="Screenshot that shows a message of no appropriate server could be found to route the request.":::

The first step is to verify that the member servers are online. To check this, go to the **Servers** node under the farm in the **IIS Manager**.

:::image type="content" source="media/troubleshooting-502-errors-in-arr/servers-node-under-service-farm.png" alt-text="Screenshot that shows you how to navigate to the Servers node under the Server farm in IIS Manager.":::

To bring back the offline servers, right-click on the server name, and select **Add to Load Balancing**. If you can't bring the servers back online, verify if the member servers are reachable from the ARR server. Check the **trace Messages** pane in the **Servers** page to look for some clues about the problem. If you're using Web Farm Framework (WFF) 2.0, you may receive this error when the application pool restarts. You need to restart the Web Farm Service to recover.

## WinHTTP or WebIO tracing

Usually, [Network Monitor](../../../../windows-server/networking/network-monitor-3.md)  provides you with the information you need to identify exactly what is timing out. However, there are times (such as when the traffic is SSL encrypted) that you will need to try a different approach. On Windows 7 and Windows Server 2008R2 you can enable WinHTTP tracing using the netsh tool by running the following command from an administrative command prompt:

```Console
netsh trace start scenario=internetclient capture=yes persistent=no level=verbose tracefile=c:\temp\net.etl
```

Then, reproduce the problem. After the problem is reproduced, stop the tracing by running the following command:

```Console
netsh trace stop
```

The `stop` command takes a few seconds to finish. When it's done, you find a *net.etl* file and a *net.cab* file in `C:\temp`. The .cab file contains event logs and other data that may prove helpful in analyzing the .etl file.

To analyze the log,

1. Open it in Netmon 3.4 or later.
1. Make sure you have set up your parser profile.
1. Scroll through the trace until you find the *w3wp.exe* instance where ARR is running by correlating with the **UT process name** column.
1. Right-click on w3wp and select **Add UT Process name to display filter**. This sets the display filter similar to:

    ```Console
    UTProcessName == "w3wp.exe (1432)"
    ```

  You can further filter the results by changing it to the following:

  ```Console
  UTProcessName == "w3wp.exe (<pid>)" AND ProtocolName == "WINHTTP_MicrosoftWindowsWinHttp"
  ```

  You'll need to scroll through the output until you find the timeout error. In the following example, a request timed out because it took more than 30 seconds (ARR's default timeout) to run.

   ```output  
   336  2:32:22 PM  7/22/2011  32.6380453  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::sys-recver starts in _INIT state 
   337  2:32:22 PM  7/22/2011  32.6380489  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::current thread is not impersonating 
   340  2:32:22 PM  7/22/2011  32.6380584  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::sys-recver processing WebReceiveHttpResponse completion (error-cdoe = ? (0x5b4), overlapped = 003728F0) 
   341  2:32:22 PM  7/22/2011  32.6380606  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::sys-recver failed to receive headers; error = ? (1460)
   342  2:32:22 PM  7/22/2011  32.6380800  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::ERROR_WINHTTP_FROM_WIN32 mapped (?) 1460 to (ERROR_WINHTTP_TIMEOUT) 12002 
   343  2:32:22 PM  7/22/2011  32.6380829  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::sys-recver returning ERROR_WINHTTP_TIMEOUT (12002) from RecvResponse() 
   344  2:32:22 PM  7/22/2011  32.6380862  w3wp.exe (1432)  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:32:23.123 ::sys-req completes recv-headers inline (sync); error = ERROR_WINHTTP_TIMEOUT (12002) 
   ```

   In the following example, the content server was completely offline:
  
   ```output
   42  2:26:39 PM  7/22/2011  18.9279133  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::WinHttpReceiveResponse(0x11d23d0, 0x0)  {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   43  2:26:39 PM  7/22/2011  18.9279633  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::sys-recver starts in _INIT state  {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   44  2:26:39 PM  7/22/2011  18.9280469  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::current thread is not impersonating  {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   45  2:26:39 PM  7/22/2011  18.9280776  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::sys-recver processing WebReceiveHttpResponse completion (error-cdoe = WSAETIMEDOUT (0x274c), overlapped = 003728F0)  {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   46  2:26:39 PM  7/22/2011  18.9280802  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::sys-recver failed to receive headers; error = WSAETIMEDOUT (10060) {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   47  2:26:39 PM  7/22/2011  18.9280926  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::ERROR_WINHTTP_FROM_WIN32 mapped (WSAETIMEDOUT) 10060 to (ERROR_WINHTTP_TIMEOUT) 12002  {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   48  2:26:39 PM  7/22/2011  18.9280955  WINHTTP_MicrosoftWindowsWinHttp  WINHTTP_MicrosoftWindowsWinHttp:12:26:39.704 ::sys-recver returning ERROR_WINHTTP_TIMEOUT (12002) from RecvResponse() {WINHTTP_MicrosoftWindowsWinHttp:4, NetEvent:3} 
   ```

## Other resources

- [Error Lookup Tool](https://www.microsoft.com/download/details.aspx?id=100432)
- [Winhttp Error Codes](https://msdn.microsoft.com/library/aa383770(VS.85).aspx)
- [Failed Request Tracing](https://www.iis.net/learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis)
- [Winhttp Tracing](https://technet.microsoft.com/library/cc731131(WS.10).aspx)
- [Network Monitor](https://www.microsoft.com/download/details.aspx?id=4865)
