---
title: HTTPS connections fail and SSL bindings are deleted
description: This article provides resolutions for the problem where HTTPS connections fail and SSL bindings are deleted for a website in IIS 7.0 and 7.5.
ms.date: 12/11/2020
ms.custom: sap:WWW Administration and Management
ms.technology: www-administration-management
---
# HTTPS connections fail and SSL bindings are deleted for a website in IIS 7.0 and 7.5

This article helps you resolve the problem where HTTPS connections fail and SSL bindings are deleted for a website in Internet Information Services (IIS) 7.0 and 7.5.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2025598

## Symptoms

Consider the following scenario:

- You have a web application running on Internet IIS 7.0 or higher that is configured with an SSL binding.  
- Intermittently, connections to the website over HTTPS fail.  
- Users can still access the site over HTTP, unless the site is configured to require SSL connections.

When the problem occurs, users trying to browse to the website over HTTPS may see warning messages stating that the SSL certificate has expired or is not yet valid, or that the website name is incorrect. If a site administrator opens the IIS Manager to view the site's SSL settings, they may find that the SSL bindings for the website have been deleted, or have been replaced with invalid certificate binding information. Finally, an event similar to the following is logged in the System event log:

> Log Name:      System  
Source:          Microsoft-Windows-HttpEvent  
Date:              3/31/2010 2:43:28 PM  
Event ID:         15300  
Task Category: None  
Level:             Warning  
Keywords:      Classic  
User:             N/A  
Computer:      IISServer  
Description:  
SSL Certificate Settings deleted for Port : x.x.x.x:443  

## Cause

The SSL binding for the website has been deleted and not replaced, or has been deleted and replaced with invalid certificate info.  The problem occurs because of a legacy SSL certificate hash property interfering with the current SSL binding, resulting in the correct binding being deleted.

## Resolution

Locate the following property in the `<CustomMetaData>` section of the *applicationHost.config* file, and delete it:

```xml
<key path="LM/W3SVC/X">
     <property id="**5506**" dataType="Binary" userType="1" attributes="None" value="oXiHOzFAMOF0YxIuI7soWvDFEzg=" />
</key>
```

This property is a legacy feature from IIS 6.0 and is no longer needed.

## More information

The `5506` custom property was used in IIS 6.0 to store an SSL certificate hash. When an application or service, which depends upon the ABO mapper in IIS 7.0 or IIS 7.5 attempts to start, it tries to initialize the ABO tree structure, which includes generating custom nodes and properties. During this process, it reads from the `<CustomMetaData>` section and tries to map the properties in the ABO tree structure. During mapping, it deletes the current SSL bindings in *HTTP.SYS* and recreates a new binding using the above legacy hash value. If this value is invalid, it fails to add the new SSL binding in *HTTP.sys*.  This will result in the website not having a valid IP: Port combination corresponding to the SSL binding in *HTTP.sys*.  With a blank or invalid SSL binding, HTTPS connections to the website fail.

### Steps to reproduce

The issue can be reproduced by adding the following under the `<CustomMetadata>` section of the *applicationHost.config* file:

```xml
<key path="LM/W3SVC/X">
    <property id="5506" dataType="Binary" userType="1" attributes="None" value="oXiHOzFAMOF0YxIuI7soWvDFEzg=" />
</key>
```

After this is done, launching any application, which requires the ABO Mapper, such as launching the IIS Manager (Inetmgr6.exe) or enumerating the metabase using *ADSUTIL.vbs* will result in the problem described in this article.
