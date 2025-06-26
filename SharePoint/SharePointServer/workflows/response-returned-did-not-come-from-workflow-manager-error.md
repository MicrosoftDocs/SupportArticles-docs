---
title: Unable to configure and register a workflow manager
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Workflows\Classic Workflow Manager
  - CSSTroubleshoot
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Server
description: Describes how to resolve the error A response was returned that did not come from the Workflow Manager in SharePoint Server 2016.
---

# "A response was returned that did not come from the Workflow Manager" error in SharePoint Server 2016

## Symptoms

When you set up SharePoint Server 2016 on Windows Server 2016 with a single WFM server, then install and configure a workflow manager with SharePoint, registering it to use "SP-WorkflowService", the workflows using SharePoint Designer fails with the following error:

```output
Microsoft.Workflow.Client.AuthenticationException: A response was returned that did not come from the Workflow Manager. Status code = 401:
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>401 - Unauthorized: Access is denied due to invalid credentials.</title>
<style type="text/css">
<!--
body{marg
```

## Cause

The "Anonymous" authentication has been disabled on the WFM server in your DEV farm.

## Resolution

Re-enabling "Anonymous" authentication should fix the issue.

## More information

### How we narrowed down the issue

We used Fiddler's ability to act as proxy and listen to end point calls between SharePoint and Workflow Manager. For more information, see [Debugging SharePoint workflows](/sharepoint/dev/general-development/debugging-sharepoint-server-workflows).

Fiddler revealed that we were failing while putting up/updating scope information for the given workflow and its URL in WFM.

```output
Client (SharePoint) Request
=======================

PUT http://<WFMENDPOINT>/SharePoint/default/23fc1ff1-0a17-41dd-862a-6d7b13be1435  HTTP/1.1
Host: <WFMENDPOINT>
<ScopeInfo xmlns="http://schemas.microsoft.com/workflow/2012/xaml/activities" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><DefaultWorkflowConfiguration><appSettings><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.SiteId</Key><Value>23fc1ff1-0a17-41dd-862a-6d7b13be1435</Value></AppSetting><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.Host</Key><Value><SITE URL></Value></AppSetting><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.HostUri</Key><Value>http://<SITE URL> </Value></AppSetting></appSettings></DefaultWorkflowConfiguration><Description>23fc1ff1-0a17-41dd-862a-6d7b13be1435</Description></ScopeInfo>


Server (WFM) Response
====================

HTTP/1.1 401 Unauthorized
Content-Type: text/html
Server: Microsoft-IIS/10.0
<h2>401 - Unauthorized: Access is denied due to invalid credentials.</h2>
  <h3>You do not have permission to view this directory or page using the credentials that you supplied.</h3>
```

Note **HTTP/1.1 401 Unauthorized** under the Server Response.

In **working** condition, we're updating scope information as such.

```output
Client (SharePoint) Request
======================

PUT http://wfm.contoso.com:12291/SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8  HTTP/1.1
Host: wfm.contoso.com:12291
<ScopeInfo xmlns="http://schemas.microsoft.com/workflow/2012/xaml/activities" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><DefaultWorkflowConfiguration><appSettings><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.SiteId</Key><Value>09d8c9b6-1994-4dad-bf46-cf5de701c0c8</Value></AppSetting><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.Host</Key><Value>sp</Value></AppSetting><AppSetting><Key>Microsoft.SharePoint.ActivationProperties.HostUri</Key><Value>http://sp</Value></AppSetting></appSettings></DefaultWorkflowConfiguration><Description>09d8c9b6-1994-4dad-bf46-cf5de701c0c8</Description></ScopeInfo>

Server (WFM) Response
====================

HTTP/1.1 201 Created
Location: http://wfm.contoso.com:12291/SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8
Server: Microsoft-IIS/10.0
```

Note **HTTP/1.1 201 Created** under the Server Response.

We captured ETL traces to read workflow manager internal activities while publishing the workflow. Failing condition revealed that the request wasn't even reaching WFM internally.

In working condition, we are updating scope information as such.

```output
WFM Server Internal Activities 
=========================

The gateway received an HTTP request. Method: PUT, Uri: http://wfm.contoso.com:12291/SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8, Scope path: 
Gateway received request details: Method: PUT, RequestUri: 'http://wfm.contoso.com:12291/SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8', Version: 1.1, Content: System.Net.Http.StreamContent, Headers:
{
 Accept: application/xml
 Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImRWaWQ1MFpHYzVuLWh1TXdEc1V3bVdCQ2hZSSJ9.eyJhdWQiOiIwMDAwMDAwNS0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDAvd2ZtLmNvbnRvc28uY29tOjEyMjkxQGVhZWQ2MzJkLTEyZjMtNDNlNS1iYmU5LTkwMDhjOGU3YWIxYyIsImlzcyI6IjAwMDAwMDAzLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMEBlYWVkNjMyZC0xMmYzLTQzZTUtYmJlOS05MDA4YzhlN2FiMWMiLCJuYmYiOiIxNTY0MDMyNTMwIiwiZXhwIjoiMTU2NDE2MjEzMCIsIm5hbWVpZCI6IjAwMDAwMDAzLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMEBlYWVkNjMyZC0xMmYzLTQzZTUtYmJlOS05MDA4YzhlN2FiMWMifQ.gIvnI1f9EpgCaZMZ7lp-ryq9u_xJ5eVCPv-EGzqBjU_99anCgw64HsU8wCmtvYarj8Qt6XzjrNbY1eXIXLcSTyLsiww26w-OJIxYbKZgX0wvTehyzgY3k_LdkVOae--RkAZ5jRTSZ2hr_nTMbTNj0kJ8ZmLYkSEqhuuZHtqXLcaOSXXQ0xPosBElr_U513P7n8meFfty624l_WcB99wtCPAmA8_kPNhZp6vrcxVuj6vkqz7lcCzTZY0d2qcDGuW1d5DsZwcNKQ7SSdVC1tbK7VYNDi5qdHSBaaZrHWn70FwMdt_nCRLDpEbd8K2tn6w6Ssnbtdb697TqeIRKsyZ_Ew
 Expect: 100-continue
 Host: wfm.contoso.com:12291
 User-Agent: Microsoft-WF/1.0.1
 E2EActivity: nvOccj36scBdKMCu3bsJLQ==
 client-request-id: 729cf39e-fa3d-c0b1-5d28-c0aeddbb092d
 Content-Length: 636
 Content-Type: application/xml
}
Start retrieving scope security settings from database.
Creating Scope /SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8
Successfully created scope /SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8
Workflow Manager frontend completed HTTP request successfully and is <mark>returning status code 201 (Created).
Gateway sending HTTP response: StatusCode: 201, ReasonPhrase: 'Created', Version: 1.1, Content: <null>, Headers:
{
 Location: http://wfm.contoso.com:12291/SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8
 Server: Microsoft-WF/1.0.1
}
```

Note "Successfully created scope /SharePoint/default/09d8c9b6-1994-4dad-bf46-cf5de701c0c8" and "returning status code 201 (Created)" references above.

:::image type="content" source="media/response-returned-did-not-come.png" alt-text="Screenshot that shows the output.":::

This proved that the request was reaching WFM server but not going deep further to SB or backend. Hence the component in question was IIS. We captured IIS log on WFM in house while publishing the workflow. It revealed that IIS has events in fact while publishing.

```output
2019-07-25 05:28:49 192.168.2.104 PUT /$Scope - 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 401 0 0 1477
2019-07-25 05:28:52 192.168.2.104 PUT /$Scope - 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 201 0 0 562
2019-07-25 05:28:52 192.168.2.104 PUT /$Scope - 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 201 0 0 78
2019-07-25 05:28:53 192.168.2.104 PUT /$Activities/WorkflowXaml_1a80aab2_6f61_4cc9_a8ca_47b599ceb796 $overwriteXClass=true 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 201 0 0 1558
2019-07-25 05:29:05 192.168.2.104 PUT /$Workflows/607e3d78-07fd-4b3b-99c1-2197768e7db1 - 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 201 0 0 6741
2019-07-25 05:29:06 192.168.2.104 GET /$Scope - 12291 - 192.168.2.102 Microsoft-WF/1.0.1 - 200 0 0 15
```

Based on the error "You do not have permission to view this directory or page using the credentials that you supplied", we explored permissions of the "Workflow Management Site" IIS virtual server on WFM in our lab. We have "Anonymous" and "Windows Authentication" set as enabled. Disabling "Anonymous" authentication instantly reproduced the error.

If you're using Claims authentication (Windows claims, Forms authentication or a Trusted Identity provider), the application will be configured for Forms authentication in the web.config, along with ensuring that Anonymous Authentication and Forms Authentication are enabled in IIS configuration.

We by default use windows claim authentication starting SP 2013 and WFM > SP communication happens over Oauth on top of that. We identified that "Anonymous" authentication was disabled on WFM server in your DEV farm. Enabling it fixed the issue. We were able to publish and run the workflows successfully.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
