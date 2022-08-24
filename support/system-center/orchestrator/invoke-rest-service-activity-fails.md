---
title: Invoke REST Service activity fails
description: After creating Invoke REST Service activity, the runbook fails and the log history details shows Property cannot be blank.
ms.date: 08/04/2020
ms.reviewer: matthofa
---
# System Center 2012 Orchestrator Invoke REST Service activity fails to run

This article fixes an issue in which the **Invoke REST Service** activity fails to invoke a runbook and the log history detail shows **Property cannot be blank**.

_Original product version:_ &nbsp; Microsoft System Center 2012 Orchestrator  
_Original KB number:_ &nbsp; 2853747

## Symptoms

When attempting to use the **Representational State Transfer (REST) Integration Pack Guide for Orchestrator in System Center 2012 SP1** to call a REST service, problems can be encountered. The specifics outlined below are with invoking a runbook within Orchestrator using the previously mentioned integration pack.

> Given:  
> Orchestrator 2012  
> "Representational State Transfer (REST) Integration Pack Guide for Orchestrator in System Center 2012 SP1" (forward referred to as "REST IP")  
> "Invoke REST Service" activity configure to invoke a Runbook in Orchestrator 2012 using the following property values:  
>
> HTTP Method:  
> POST  
>
> URL:  
> `https://<servername>:81/orchestrator2012/orchestrator.svc/jobs`
>
> Request Header:  
> Content-Type: application/atom+xml
>
> Request Body:  
> \<?xml version="1.0" encoding="utf-8"?>\<entry xmlns="[http://www.w3.org/2005/Atom](https://www.w3.org/2005/Atom)" xmlns:d="`https://schemas.microsoft.com/ado/2007/08/dataservices`" xmlns:m="`https://schemas.microsoft.com/ado/2007/08/dataservices/metadata`">\<category term="Microsoft.SystemCenter.Orchestrator.WebService.Job" scheme="`https://schemas.microsoft.com/ado/2007/08/dataservices/scheme`" />\<id />\<title />\<published>0001-01-01T00:00:00-05:00\</published>\<updated>0001-01-01T00:00:00-05:00\</updated>\<author>\<name />\</author>\<content type="application/xml">\<m:properties>\<d:CreatedBy m:null="true" />\<d:CreationTime m:type="Edm.DateTime">0001-01-01T00:00:00\</d:CreationTime>\<d:Id m:type="Edm.Guid">00000000-0000-0000-0000-000000000000\</d:Id>\<d:LastModifiedBy m:null="true" />\<d:LastModifiedTime m:type="Edm.DateTime">0001-01-01T00:00:00\</d:LastModifiedTime>\<d:Parameters>\<![CDATA[\<Data>\<Parameter>\<ID>{ef29ac2e-aeb1-4f80-90f5-634783b52aff}\</ID>\<Value>'This is the value for Param1.'\</Value>\</Parameter>\</Data>]]>\</d:Parameters>\<d:ParentId m:type="Edm.Guid" m:null="true" />\<d:ParentIsWaiting m:type="Edm.Boolean" m:null="true" />\<d:RunbookId m:type="Edm.Guid">d010b455-4fe9-4423-ab72-52e5dabcb4e8\</d:RunbookId>\<d:RunbookServerId m:type="Edm.Guid" m:null="true" />\<d:RunbookServers m:null="true" />\<d:Status m:null="true" />\</m:properties>\</content>\</entry>

The **Properties** dialog saves and closes without error.

The activity fails to run and the following exceptions is in the log history details:

> Property 'URL' cannot be blank. Supply a value for 'URL'.  
> Exception: Exception  
> Target site: RestIP.checkPropertiesNotEmpty  
> Stack trace:  
> at Microsoft.SystemCenter.Orchestrator.Integration.REST.ServerExtension.RestIP.checkPropertiesNotEmpty(String property, String desc)  
> at Microsoft.SystemCenter.Orchestrator.Integration.REST.ServerExtension.RestIP.Execute(IActivityRequest request, IActivityResponse response)

The property was given a value as noted above. Examination of the runbook activity after the failure reveals all the properties previously are now blank.

## Cause

This is a known issue with REST IP and is due to the **Request Body** containing a CDATA tag.

## Resolution

There are a few different workarounds available for this problem. The details below are for this specific REST service call to Orchestrator documented in the [Symptoms](#symptoms) section.

Remove the CDATA tags from the **Request Body** and encode the XML string manually or through any number of available tools or web sites. What specifically needs to be manually encoded is the string within the CDATA tag:

```xml
<Data><Parameter><ID>{ef29ac2e-aeb1-4f80-90f5-634783b52aff}</ID><Value>'This is the value for Param1.'</Value></Parameter></Data>
```

Once encoded, it would look like this:

> \&lt;Data\&gt;\&lt;Parameter\&gt;\&lt;ID\&gt;{ef29ac2e-aeb1-4f80-90f5-634783b52aff}\&lt;/ID\&gt;\&lt;Value\&gt;\&#39;This is the value for Param1.\&#39;\&lt;/Value\&gt;\&lt;/Parameter\&gt;\&lt;/Data\&gt;

Then put the resulting string back into the **Request Body** property, and in this example it would look like the following:

> \<?xml version="1.0" encoding="utf-8"?>\<entry xmlns="http://www.w3.org/2005/Atom" xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata">\<category term="Microsoft.SystemCenter.Orchestrator.WebService.Job" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" />\<id />\<title />\<published>0001-01-01T00:00:00-05:00\</published>\<updated>0001-01-01T00:00:00-05:00\</updated>\<author>\<name />\</author>\<content type="application/xml">\<m:properties>\<d:CreatedBy m:null="true" />\<d:CreationTime m:type="Edm.DateTime">0001-01-01T00:00:00\</d:CreationTime>\<d:Id m:type="Edm.Guid">00000000-0000-0000-0000-000000000000\</d:Id>\<d:LastModifiedBy m:null="true" />\<d:LastModifiedTime m:type="Edm.DateTime">0001-01-01T00:00:00\</d:LastModifiedTime>\<d:Parameters>\&lt;Data\&gt;\&lt;Parameter\&gt;\&lt;ID\&gt;{ef29ac2e-aeb1-4f80-90f5-634783b52aff}\&lt;/ID\&gt;\&lt;Value\&gt;'This is the value for Param1.'\&lt;/Value\&gt;\&lt;/Parameter\&gt;\&lt;/Data\&gt;\</d:Parameters>\<d:ParentId m:type="Edm.Guid" m:null="true" />\<d:ParentIsWaiting m:type="Edm.Boolean" m:null="true" />\<d:RunbookId m:type="Edm.Guid">d010b455-4fe9-4423-ab72-52e5dabcb4e8\</d:RunbookId>\<d:RunbookServerId m:type="Edm.Guid" m:null="true" />\<d:RunbookServers m:null="true" />\<d:Status m:null="true" />\</m:properties>\</content>\</entry>

Other options for invoking a runbook that would avoid this scenario would be the following:

- [Run .Net Script](/previous-versions/system-center/system-center-2012-R2/hh206103(v=sc.12)?redirectedfrom=MSDN)
- [Invoke Runbook](/previous-versions/system-center/system-center-2012-R2/hh206078(v=sc.12)?redirectedfrom=MSDN)

## More information

This scenario is not specific to calling the Orchestrator service itself and could be encountered when calling other REST services depending on the required parameters being sent in the request to the targeted REST service.
