---
title: Troubleshoot HTTP 502.2 Bad Gateway error in CGI applications
description: Describes HTTP 502.2 Bad Gateway error in CGI applications and provides troubleshooting steps to resolve this issue.
ms.date: 04/09/2012
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart
---
# Troubleshoot HTTP 502.2 Bad Gateway error in CGI applications

_Applies to:_ &nbsp; Internet Information Services 6.0, Internet Information Services 7.0

This article describes HTTP 502.2 Bad Gateway error in Common Gateway Interface (CGI) applications and provides troubleshooting steps to resolve this issue.

## Symptom

You have a Web site that is hosted on Internet Information Services (IIS) 7.0. When you visit the Web site in a Web browser, you may receive an error message that resembles the following:

> Server Error in Application \<application name\>
> HTTP Error 502.2 - Bad Gateway
> HRESULT: 0xC00000FD or 0x00000003
> Description of HRESULT: Specified CGI application did not return a complete set of HTTP headers.

## Cause

This problem occurs because the CGI process terminates unexpectedly before the CGI process sends a response back to IIS 7.0.

## Tools

- Tracing module on IIS 7.X
- [Enterprise Tracing for Windows (ETW Tracing)](/windows-hardware/drivers/devtest/event-tracing-for-windows--etw-) on IIS 6.0
- [Microsoft Network Monitor 3.4](https://www.microsoft.com/download/4865)

## Troubleshooting steps

When sending a request to a CGI application running via IIS, the user is presented with the following error instead of the expected response:

> The specified CGI application misbehaved by not returning a complete set of HTTP headers

Capture a [Netmon](/windows-hardware/drivers/portable/using-the-netmon-tool) trace. It shows:

```output
HTTP: Response to Client; HTTP/1.1; Status Code = 502 - Bad Gateway
HTTP: Protocol Version =HTTP/1.1
HTTP: Status Code = Bad Gateway
HTTP: Reason =Bad Gateway
HTTP: Content-Length =232
HTTP: Content-Type =text/html
HTTP: Server =Microsoft-IIS/6.0
HTTP: Date =Tue, 23 Aug 2005 20:25:47 GMT
HTTP: Data: Number of data bytes remaining = 232 (0x00E8)
00000: 00 11 BC 3E 62 3C 00 0F 1F 6C 1F E1 08 00 45 00 ..¼>b<...l.á..E.
00010: 01 9A EF 40 40 00 80 06 00 00 D8 A2 10 5C 0A C8 .šï@@.&euro;...Ø¢.\.È
00020: 04 15 00 50 55 B1 AA C6 89 52 E7 D6 85 01 50 18 ...PU±ªÆ‰RçÖ….P.
00030: 09 2F F9 67 00 00 48 54 54 50 2F 31 2E 31 20 35 ./ùg..HTTP/1.1 5
00040: 30 32 20 42 61 64 20 47 61 74 65 77 61 79 0D 0A 02 Bad Gateway..
00050: 43 6F 6E 74 65 6E 74 2D 4C 65 6E 67 74 68 3A 20 Content-Length: 
00060: 32 33 32 0D 0A 43 6F 6E 74 65 6E 74 2D 54 79 70 232..Content-Typ
00070: 65 3A 20 74 65 78 74 2F 68 74 6D 6C 0D 0A 53 65 e: text/html..Se
00080: 72 76 65 72 3A 20 4D 69 63 72 6F 73 6F 66 74 2D rver: Microsoft-
00090: 49 49 53 2F 36 2E 30 0D 0A 44 61 74 65 3A 20 54 IIS/6.0..Date: T
000A0: 75 65 2C 20 32 33 20 41 75 67 20 32 30 30 35 20 ue, 23 Aug 2005 
000B0: 32 30 3A 32 35 3A 34 37 20 47 4D 54 0D 0A 0D 0A 20:25:47 GMT....
000C0: 3C 68 74 6D 6C 3E 3C 68 65 61 64 3E 3C 74 69 74 <html><head><tit
000D0: 6C 65 3E 45 72 72 6F 72 3C 2F 74 69 74 6C 65 3E le>Error</title>
000E0: 3C 2F 68 65 61 64 3E 3C 62 6F 64 79 3E 3C 68 65 </head><body><he
000F0: 61 64 3E 3C 74 69 74 6C 65 3E 45 72 72 6F 72 20 ad><title>Error 
00100: 69 6E 20 43 47 49 20 41 70 70 6C 69 63 61 74 69 in CGI Applicati
00110: 6F 6E 3C 2F 74 69 74 6C 65 3E 3C 2F 68 65 61 64 on</title></head
00120: 3E 0A 3C 62 6F 64 79 3E 3C 68 31 3E 43 47 49 20 >.<body><h1>CGI 
00130: 45 72 72 6F 72 3C 2F 68 31 3E 54 68 65 20 73 70 Error</h1>The sp
00140: 65 63 69 66 69 65 64 20 43 47 49 20 61 70 70 6C ecified CGI appl
00150: 69 63 61 74 69 6F 6E 20 6D 69 73 62 65 68 61 76 ication misbehav
00160: 65 64 20 62 79 20 6E 6F 74 20 72 65 74 75 72 6E ed by not return
00170: 69 6E 67 20 61 20 63 6F 6D 70 6C 65 74 65 20 73 ing a complete s
00180: 65 74 20 6F 66 20 48 54 54 50 20 68 65 61 64 65 et of HTTP heade
00190: 72 73 2E 3C 2F 62 6F 64 79 3E 3C 2F 62 6F 64 79 rs.</body></body
001A0: 3E 3C 2F 68 74 6D 6C 3E ></html>
```

Capture [FREB](troubleshoot-php-with-failed-request-tracing.md) log for the HTTP error message and locate which module is throwing this error message.

Troubleshoot the CGI process executable file to determine why the CGI process terminates unexpectedly. You may have to generate a memory dump file of the CGI process when the access violation occurs.

This problem occurs when the CGI application does exactly what the error suggests: inserts invalid data into the HTTP Header value(s) that is sends to IIS as part of its response. In IIS 6 with Windows 2003 SP1 installed, you can use ETW Tracing to see what the CGI is returning.

### Capture a Trace file using ETW Tracing

1. Copy the ETWSetup.zip file to the IIS6 Server.
1. Extract it on the server.
1. Open the folder from the command prompt.
1. Enter _iis6trace-start.cmd_ to start the tracing.
1. Reproduce the issue.
1. Enter _iis6trace-stop.cmd_ to stop the tracing.
1. At this point, you should have an _iistrace\_etl.etl_ file in that folder.
1. Zip up that file and send it to Microsoft Support Engineer.
1. Support engineer can help you convert ETL file into XML.
1. Here is an example trace file from this sort of CGI problem:

The request to the CGI starts at line 391:

```xml
<ROW>
<EventNumber>391</EventNumber> 
<EventName>IISGeneral</EventName> 
<EventTypeName>GENERAL_REQUEST_START</EventTypeName> 
<Timestamp>2005-08-23 20:19:06</Timestamp> 
<UserData>ContextId={00000000-0000-0000-4c06-0060000000ef}|SiteId=1|AppPoolId=DefaultAppPool|ConnId=-1224979097571031481|RawConnId=0|RequestURL=http://siteaddress:80/cgi-bin/htmlos.exe/00182.3.055317239900014075|RequestVerb=POST</UserData> 
</ROW>
```

The request is processed by IIS, you see it's for a CGI, and it's passed along to the CGI. The CGI starts its processing at line 405:

```xml
<ROW>
<EventNumber>405</EventNumber> 
<EventName>IISCGI</EventName> 
<EventTypeName>CGI_LAUNCH</EventTypeName> 
<Timestamp>2005-08-23 20:19:07</Timestamp> 
<UserData>ContextId={00000000-0000-0000-4c06-0060000000ef}|CommandLine="D:\Inetpub\cgi-bin\htmlos.exe" |ErrorCode=0x00000000|ProcessId=3136</UserData> 
</ROW>
```

Line 441 shows the problem in the CGI:

```xml
<ROW>
<EventNumber>441</EventNumber> 
<EventName>IISCGI</EventName> 
<EventTypeName>CGI_PREMATURE_TERMINATION</EventTypeName> 
<Timestamp>2005-08-23 20:25:47</Timestamp> 
<UserData>ContextId={00000000-0000-0000-4c06-0060000000ef}|Headers=</UserData> 
</ROW>
```

For some reasons, the CGI application is ended prematurely. Notice the value of the headers entry. It's empty. This is why  the error is sent to the client that the CGI is sending a bad set of headers. It is in fact sending an empty list of headers.

Line 446 shows the 502 that is sent to the client. It's actually a 502.2 (substatus of 2):

```xml
<ROW>
<EventNumber>446</EventNumber> 
<EventName>IISGeneral</EventName> 
<EventTypeName>GENERAL_REQUEST_END</EventTypeName> 
<Timestamp>2005-08-23 20:25:47</Timestamp> 
<UserData>ContextId={00000000-0000-0000-4c06-0060000000ef}|BytesSent=370|BytesReceived=105906875|HttpStatus=502|HttpSubStatus=2</UserData> 
</ROW>
```
