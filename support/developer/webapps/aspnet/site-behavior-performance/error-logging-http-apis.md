---
title: Error logging in HTTP APIs
description: This article describes the error-logging capabilities of HTTP APIs.
ms.date: 05/28/2020
ms.custom: sap:Performance
---
# Error logging in HTTP APIs

This article describes the error-logging capabilities of HyperText Transfer Protocol (HTTP) application programming interfaces (APIs).

_Original product version:_ &nbsp; Windows Server 2008 R2, Windows Server 2008, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1  
_Original KB number:_ &nbsp; 820729

## Summary  

Some errors that occur in an HTTP-based application are automatically handled by the HTTP API instead of being passed back to an application for handling. This behavior occurs because the frequency of such errors might otherwise flood an event log or an application handler.

The following topics describe the different aspects of HTTP API error logging.

- [Configure HTTP API error logging](#configure-http-api-error-logging)  
    Registry settings control the HTTP API logs errors, the maximum permitted size of log files, and the location of the log files.

- [Format of the HTTP API error logs](#format-of-the-http-api-error-logs)  
    The HTTP API creates log files that follow the World Wide Web Consortium (W3C) log file conventions. You can use standard tools to parse these log files. However, unlike W3C log files, HTTP API log files don't contain the columns names.

- [Kinds of errors that the HTTP API logs](#kinds-of-errors-that-the-http-api-logs)  
    The HTTP API logs many common errors.

The following methods describe the resolution of HTTP API error logging.

## Configure HTTP API error logging

Three registry values under an HTTP \Parameters key control the HTTP API error logging. These keys are located at the registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters`.

> [!NOTE]
> The location and the form of the configuration values may change in later versions of the Windows operating system.

You must have Administrator/Local System credentials to change the registry values, and to view or change the log files and the folder that contains them.

Configuration information in the registry values is read when the HTTP API driver starts. So if you change the settings, you must stop, and then restart the driver to read the new values. To do it, type the following console commands:

```console
net stop http
net start http
```

The following naming convention is used to name the log files:  
    httperr + **sequence number** + .log  
    Example: httperr4.log

Log files are cycled when they reach the maximum size that the ErrorLogFileTruncateSize registry value specifies. This value can't be less than 1 megabyte (MB).

If the configuration of error logging isn't valid, or if any kind of failure occurs while the HTTP API is writing to the log files, the HTTP API uses event logging to notify administrators that error logging isn't occurring.

The following table describes the registry configuration values.

|Registry value|Description|
|---|---|
|EnableErrorLogging|A DWORD that you can set to TRUE to enable error logging or to FALSE to disable it. The default value is TRUE.|
|ErrorLogFileTruncateSize|A DWORD that specifies the maximum size of an error log file, in bytes. The default value is 1 MB (0x100000).<br/><br/>The specified value can't be smaller than the default value.|
|ErrorLoggingDir|A String that specifies the folder where the HTTP API puts its logging files.<br/><br/>The HTTP API creates a subfolder HTTPERR in the specified folder, and then stores the log files in the subfolder. This subfolder and the log files receive the same permission settings. The Administrator and Local System Accounts have full access. Other users don't have access. <br/><br/> The following example is the default folder when the folder isn't specified in the registry:<br/> `%SystemRoot%\System32\LogFiles`<br/><br/> The ErrorLoggingDir string value must be a fully qualified local path. However, it can contain `%SystemRoot%`. A network drive or network share can't be used.|
  
## Format of the HTTP API error logs

Generally, HTTP API error log files have the same format as W3C error logs, except that HTTP API error log files don't contain column headings. Each line of an HTTP API error log records one error. The fields appear in a specific order. A single space character (0x0020) separates each field from the previous field. In each field, plus signs (0x002B) replace space characters, tabs, and non-printable control characters.

The following table identifies the fields and the order of the fields in an error log record.

|Field|Description|
|---|---|
|Date|The Date field follows the W3C format. This field is based on Coordinated Universal Time (UTC). The Date field is always 10 characters in the form of YYYY-MM-DD. For example, May 1, 2003 is expressed as 2003-05-01.|
|Time|The Time field follows the W3C format. This field is based on UTC. The time field is always eight characters in the form of MM:HH:SS. For example, 5:30 PM (UTC) is expressed as 17:30:00.|
|Client Internet Protocol (IP) Address|The IP address of the affected client. The value in this field can be either an IPv4 address or an IPv6 address. If the client IP address is an IPv6 address, the ScopeId field is also included in the address.|
|Client Port|The port number for the affected client.|
|Server IP Address|The IP address of the affected server. The value in this field can be either an IPv4 address or an IPv6 address. If the server IP address is an IPv6 address, the ScopeId field is also included in the address.|
|Server Port|The port number of the affected server.|
|Protocol Version|The version of the protocol that is being used.<br/><br/> If the connection hasn't been parsed sufficiently to determine the protocol version, a hyphen (0x002D) is used as a placeholder for the empty field.<br/><br/>If either the major version number or the minor version number that is parsed is greater than or equal to 10, the version is logged as HTTP/?.?.|
|Verb|The verb states the last request that is parsed passes. Unknown verbs are included, but any verb that is more than 255 bytes is truncated to this length. If a verb isn't available, a hyphen (0x002D) is used as a placeholder for the empty field.|
|CookedURL + Query|The URL and any query that is associated with it are logged as one field that is separated by a question mark (0x3F). This field is truncated at its length limit of 4,096 bytes.<br/><br/>If this URL was parsed ("cooked"), it's logged with local code page conversion and is treated as a Unicode field.<br/><br/>If this URL hasn't been parsed ("cooked") at the time of logging, it's copied exactly, without any Unicode conversion.<br/><br/>If the HTTP API can't parse this URL, a hyphen (0x002D) is used as a placeholder for the empty field.|
|Protocol Status|The protocol status can't be greater than 999.<br/><br/>If the protocol status of the response to a request is available, it's logged in this field.<br/><br/>If the protocol status isn't available, a hyphen (0x002D) is used as a placeholder for the empty field.|
|SiteId|Not used in this version of the HTTP API. A placeholder hyphen (0x002D) always appears in this field.|
|Reason Phrase|This field contains a string that identifies the kind of error that is being logged. This field is never left empty.|
|Queue Name|It's the request queue name.|
  
The following sample lines are from an HTTP API error log:

```console
2002-07-05 18:45:09 172.31.77.6 2094 172.31.77.6 80 HTTP/1.1 GET /qos/1kbfile.txt 503 - ConnLimit  
2002-07-05 19:51:59 127.0.0.1 2780 127.0.0.1 80 HTTP/1.1 GET /ThisIsMyUrl.htm 400 - Hostname  
2002-07-05 19:53:00 127.0.0.1 2894 127.0.0.1 80 HTTP/2.0 GET / 505 - Version_N/S  
2002-07-05 20:06:01 172.31.77.6 64388 127.0.0.1 80 - - - - - Timer_MinBytesPerSecond
```

## Kinds of errors that the HTTP API logs

The HTTP API logs error responses to clients, connection time-outs, orphaned requests, and dropped connections that are handled incorrectly.

The following list identifies the kinds of errors that the HTTP API logs:

- Responses to clients  
    The HTTP API sends an error response to a client, for example, a 400 error that is caused by a parse error in the last received request. After the HTTP API sends the error response, it closes the connection.

- Connection time-outs  
    The HTTP API times out a connection. If a request is pending when the connection times out, the request is used to provide more information about the connection in the error log.

- Orphaned requests  
    A user-mode process stops unexpectedly while there are still queued requests that are routed to that process. The HTTP API logs the orphaned requests in the error log.Specific error types are named by Reason Phrase strings that always appear as the last field of each error line. The following table identifies the HTTP API Reason Phrases.

|Reason Phrase| Description|
|---|---|
|AppOffline|A service unavailable error occurred (an HTTP error 503). The service isn't available because application errors caused the application to be taken offline.|
|AppPoolTimer|A service unavailable error occurred (an HTTP error 503). The service isn't available because the application pool process is too busy to handle the request.|
|AppShutdown|A service unavailable error occurred (an HTTP error 503). The service isn't available because the application shuts down automatically in response to administrator policy.|
|BadRequest|A parse error occurred while processing a request.|
|Client_Reset|The connection between the client and the server was closed before the request could be assigned to a worker process. The most common cause of this behavior is that the client prematurely closes its connection to the server.|
|Connection_Abandoned_By_AppPool|A worker process from the application pool has quit unexpectedly or orphaned a pending request by closing its handle.|
|Connection_Abandoned_By_ReqQueue|A worker process from the application pool has quit unexpectedly or orphaned a pending request by closing its handle. Specific to Windows Vista and later versions and to Windows Server 2008 and later versions.|
|Connection_Dropped|The connection between the client and the server was closed before the server could send its final response packet. The most common cause of this behavior is that the client prematurely closes its connection to the server.|
|Connection_Dropped_List_Full|The list of dropped connections between clients and the server is full. Specific to Windows Vista and later versions and to Windows Server 2008 and later versions.|
|ConnLimit|A service unavailable error occurred (an HTTP error 503). The service isn't available because the site level connection limit has been reached or exceeded.|
|Connections_Refused|The kernel NonPagedPool memory has dropped below 20 MB and http.sys has stopped receiving new connections|
|Disabled|A service unavailable error occurred (an HTTP error 503). The service isn't available because an administrator has taken the application offline.|
|EntityTooLarge|An entity exceeded the maximum size that is permitted.|
|FieldLength|A field length limit was exceeded.|
|Forbidden|A forbidden element or sequence was met while parsing.|
|Header|A parse error occurred in a header.|
|Hostname|A parse error occurred while processing a Hostname.|
|Internal|An internal server error occurred (an HTTP error 500).|
|Invalid_CR/LF|An illegal carriage return or line feed occurred.|
|LengthRequired|A required length value was missing.|
|N/A|A service unavailable error occurred (an HTTP error 503). The service isn't available because an internal error (such as a memory allocation failure or URL Reservation List conflict) occurred.|
|N/I|A not-implemented error occurred (an HTTP error 501), or a service unavailable error occurred (an HTTP error 503) because of an unknown transfer encoding.|
|Number|A parse error occurred while processing a number.|
|Precondition|A required precondition was missing.|
|QueueFull|A service unavailable error occurred (an HTTP error 503). The service isn't available because the application request queue is full.|
|RequestLength|A request length limit was exceeded.|
|Timer_AppPool|The connection expired because a request waited too long in an application pool queue for a server application to de-queue and process it. This time-out duration is ConnectionTimeout. By default, this value is set to two minutes.|
|Timer_ConnectionIdle|The connection expired and remains idle. The default ConnectionTimeout duration is two minutes.|
|Timer_EntityBody|The connection expired before the request entity body arrived. When a request clearly has an entity body, the HTTP API turns on the Timer_EntityBody timer. At first, the limit of this timer is set to the ConnectionTimeout value (typically, two minutes). Every time that another data indication is received on this request, the HTTP API resets the timer to give the connection two more minutes (or whatever is specified in ConnectionTimeout).|
|Timer_HeaderWait|The connection expired because the header parsing for a request took more time than the default limit of two minutes.|
|Timer_MinBytesPerSecond|The connection expired because the client wasn't receiving a response at a reasonable speed. The response send rate was slower than the default of 240 bytes/sec. Which can be controlled with the MinFileBytesPerSec metabase property.|
|Timer_ReqQueue|The connection expired because a request waited too long in an application pool queue for a server application to de-queue. This time-out duration is ConnectionTimeout. By default, this value is set to two minutes. Specific to Windows Vista and later versions and to Windows Server 2008 and later versions.|
|Timer_Response|Reserved. Currently not used.|
|Timer_SslRenegotiation<br/>|The connection expired because Secure Sockets Layer (SSL) renegotiation between the client and server took longer than the default time-out of two minutes.<br/>|
|URL|A parse error occurred while processing a URL.|
|URL_Length|A URL exceeded the maximum permitted size.|
|Verb|A parse error occurred while processing a verb.|
|Version_N/S|A version-not-supported error occurred (an HTTP error 505).|
  