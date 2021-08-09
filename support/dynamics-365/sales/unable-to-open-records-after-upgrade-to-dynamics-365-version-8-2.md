---
title: Cannot open records after upgrade to version 8.2
description: Unable to open records after upgrade to Dynamics 365 (version 8.2). Form shows as Requesting data from Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to open records after upgrade to Dynamics 365 (version 8.2)

This article provides a resolution for the issue that you can't open records after upgrade to Microsoft Dynamics 365 (version 8.2).

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4021546

## Symptoms

After you upgrade to Microsoft Dynamics 365 (version 8.2), users see the following message when attempting to open records:

> Requesting data from Dynamics 365

## Cause

Microsoft is investigating the cause of this issue.  

## Resolution

Clear your web browser cache.

### For Internet Explorer

For information about how to clear the Internet Explorer history and cache, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).

### For Chrome

For information about how to clear browsing data in Google Chrome, see [Clear browsing data](https://support.google.com/chrome/answer/2392709).  

## More information

Instead of the message **Requesting data from Dynamics 365**, you may encounter a script error report. If you select to show the details, the details section includes the following information:  

> \<ScriptErrorDetails> \<Message>Cannot read property 'indexOf' of null\</Message> \<Line>0\</Line> \<URL>/form/page.aspx?lcid=1033&themeId=f499443d-2082-4938-8842-e7ee62de9a23&tstamp=516018&updateTimeStamp=636282175432024213&userts=131376974756230385&ver=1414106529#etc=1&extraqs=%3f_gridType%3d1%26etc%3d1%26id%3d%257b1C1A06B8-9C2A-E711-811A-480FCFEB3AB1%257d%26rskey%3d%257b00000000-0000-0000-00AA-000010001001%257d&pagemode=iframe&pagetype=entityrecord&rskey=%7b00000000-0000-0000-00AA-000010001001%7d&counter=1493225782146\</URL> \<PageURL>/form/page.aspx?lcid=1033\</PageURL> \<Function>SendMessageToPageManager(message)\</Function> \<FunctionRaw>function SendMessageToPageManager(message){try{window.parent.Mscrm.TurboForm.Control.CustomScriptsManager.processMessage(message);}catch(e){parent.Mscrm.CrmDebug.fail("Exception encountered processing message: " + message);parent.catchError(e.mes\</FunctionRaw> \<CallStack> \<Function>SendMessageToPageManager(message)\</Function> \<Function>RunHandlerInternal(method,parameters,executionContext,executeIfAvailableOnly)\</Function> \<Function>RunHandlers()\</Function> \<Function>OnScriptTagLoaded(url)\</Function> \<Function>anonymous(){OnScriptTagLoaded(url);}\</Function> \</CallStack> \</ScriptErrorDetails>
