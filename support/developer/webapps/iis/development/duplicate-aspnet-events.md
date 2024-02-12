---
title: Child requests generate duplicate ASP.NET events
description: This article describes a problem that triggers duplicate ASP.NET events. Occurs because of URL child requests in IIS 7.0 or a later version of IIS.
ms.date: 04/07/2020
ms.custom: sap:Development
ms.subservice: development
ms.reviewer: amymcel, kaorif
ms.topic: article
---
# Child requests generate duplicate ASP.NET events in IIS

This article discusses a by design behavior that duplicate ASP.NET events are created by child requests during the Integrated pipeline mode worker process in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 7.0, 8.0, 8.5  
_Original KB number:_ &nbsp; 2901671

## Symptoms

You have IIS 7.0 or a later version of IIS configured to use integrated pipeline mode. However, some HyperText Transfer Protocol (HTTP) modules or Internet Server Application Program Interface (ISAPI) applications may trigger duplicate ASP.NET events such as `BeginRequest` and `EndRequest`.

## Situations where this issue occurs

When a client requests a specific URL (webpage), IIS may sometimes re-request the same URL or another URL on the server side. The client's original request is called the _parent request_, and the request that IIS executes is called the _child request_.

For example, both of the following may execute a child request:

- An ISAPI extension that uses the `HSE_REQ_EXEC_URL support` function and that is installed as a wildcard script map.
- The native HTTP module that calls the `IHttpContext::ExecuteRequest` method.

`HSE_REQ_EXEC_URL` enables an ISAPI extension to rewrite a URL request in order to call another extension or to call the original URL by using the `HSE_EXEC_URL_INFO` structure. If you invoke the child request, you set pszUrl of the `HSE_EXEC_URL_INFO` structure member to the child URL's URI stem. If you call the original URL, you set `pszUrl` to **NULL**. In addition to the `HSE_REQ_EXEC_URL` ISAPI extension, the `IHttpContext::ExecuteRequest` method executes the child request by specifying the `IHttpContext` interface in the `pHttpContext` parameter.

When both the parent request and the child request target an ASP.NET-connected application that runs in the Integrated pipeline mode worker process, duplicate ASP.NET events may be generated. You can confirm this behavior by using Failed Request Event Buffering (FREB). This is also known as Failed Request Tracing.

## Logs

The following log entry shows client requests to /parent.aspx:

|Event|Information|
|---|---|
|GENERAL_REQUEST_START|SiteId="1", AppPoolId="DefaultAppPool", ConnId="610612739", RawConnId="0", RequestURL="http://localhost:80/parent.aspx", RequestVerb="GET"|
  
The following log entry shows that a `BEGIN_REQUEST` notification in global.asax is triggered by a request to /parent.aspx. This is the first `BEGIN_REQUEST` notification:

|Event|Information|
|---|---|
|NOTIFY_MODULE_START|ModuleName="global.asax", Notification="BEGIN_REQUEST", fIsPostNotification="false"|
|AspNetStart|Data1="GET", Data2="/parent.aspx", Data3=""|
  
The following log entry shows that the native HTTP module (myhttpmodule.dll) runs and that it executes the child request, child.aspx:

|Event|Information|
|---|---|
|NOTIFY_MODULE_START|ModuleName="myhttpmodule", Notification="MAP_PATH", fIsPostNotification="false"|
|GENERAL_CHILD_REQUEST_START|SiteId="1", RequestURL="http://localhost:80/child.aspx", RequestVerb="GET", RecursiveLevel="1"|
|GENERAL_REQUEST_START|SiteId="1", AppPoolId="DefaultAppPool", ConnId="1610612739", RawConnId="0", RequestURL="http://localhost:80/child.aspx", RequestVerb="GET"|
  
The following log entry shows that `BEGIN_REQUEST` notification in global.asax is triggered by a request to /child.aspx. This is the second `BEGIN_REQUEST` notification:

|Event|Information|
|---|---|
|NOTIFY_MODULE_START|ModuleName="global.asax", Notification="BEGIN_REQUEST", fIsPostNotification="false"|
|AspNetStart|Data1="GET", Data2="/child.aspx", Data3=""|
  
The following log entry shows that the `END_REQUEST` notification in global.asax is triggered by a request to /child.aspx. This is the first END_REQUEST notification:

|Event|Information|
|---|---|
|NOTIFY_MODULE_START|ModuleName="global.asax", Notification="END_REQUEST", fIsPostNotification="false"|
|AspNetPipelineEnter|Data1="ASP.global_asax"|
|AspNetPipelineLeave|Data1="ASP.global_asax"|
  
The following log entry shows that the child request finishes:

|Event|Information|
|---|---|
|GENERAL_REQUEST_END|BytesSent="332", BytesReceived="266", HttpStatus="200", HttpSubStatus="0"|
|GENERAL_CHILD_REQUEST_END|BytesSent="332", HttpStatus="200", HttpSubStatus="0"|
|NOTIFY_MODULE_COMPLETION|ModuleName="myhttpmodule", Notification="MAP_PATH", fIsPostNotificationEvent="false", CompletionBytes="0", ErrorCode="The operation completed successfully. (0x0)"|
|AspNetEnd||
  
The following log entry shows that `END_REQUEST` notification in global.asax is triggered by a request to /parent.aspx. This is the second `END_REQUEST` notification:

|Event|Information|
|---|---|
|NOTIFY_MODULE_START|ModuleName="global.asax", Notification="END_REQUEST", fIsPostNotification="false"|
|AspNetPipelineEnter|Data1="ASP.global_asax"|
|AspNetPipelineLeave|Data1="ASP.global_asax"|
  
The following log entry shows that the parent request finishes:

|Event|Information|
|---|---|
|GENERAL_REQUEST_END|BytesSent="332", BytesReceived="266", HttpStatus="200", HttpSubStatus="0"|
  
## References

For more information about how to call the `ExecuteRequest` method to execute the child request, see [IHttpContext::ExecuteRequest Method](/iis/web-development-reference/native-code-api-reference/ihttpcontext-executerequest-method).

In this sample code, the parent request is `/default.aspx`, and the child request is `/example/default.aspx`.
