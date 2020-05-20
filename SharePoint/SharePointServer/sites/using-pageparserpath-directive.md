---
title: Using PageParserPath directive can cause performance problems
author: v-miegge
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Server 2013
- SharePoint Server 2010
---

# Using PageParserPath directive can cause performance problems

Consider the following scenario:

- You have a web application in SharePoint 2010 or SharePoint 2013 environment where you have enabled inline server-side code using the PageParserPath directive in the web.config file.

- You edit more than 15 aspx pages in the folders specified in the 'VirtualPath' attribute of the PageParserPath directives.

In this scenario, the subsequent requests will take longer to be processed.

When PageParserPath directive is used in combination with CompilationMode="Always" AllowServerSideScript="true" IncludeSubFolders="true" property values, each page in the folders specified in the VirtualPath attribute will get compiled into "C:\Windows\Microsoft.NET\Framework64\v2.0.50727\Temporary ASP.NET Files\root\" as an App_Web_GUID.dll file. Once you edit the aspx page in SharePoint, the last modified date of the file will change and ASP.NET will recompile the page. ASP.NET will restart the application domain after 15 recompilations, which will unload all dlls from memory and run garbage collection and release all cached resources. The next request will initialize a new application domain for the web site and start compiling pages and repopulate caches, therefore the request will take more time.

Content deployment or other programmatic modification of aspx pages stored in the content database can also cause changes in the last modified time and eventually an application domain restart due to recompilation limit reached.

Sample PageParserPath directive values, which can cause this behavior.

```
<SafeMode MaxControls="200" CallStack="false" DirectFileDependencies="10" TotalFileDependencies="50" AllowPageLevelTrace="false">
      <PageParserPaths>
 <PageParserPath VirtualPath="/_catalogs/masterpage/*" CompilationMode="Always" AllowServerSideScript="true" IncludeSubFolders="true"/>
 <PageParserPath VirtualPath="/pages/*" CompilationMode="Always" AllowServerSideScript="true" IncludeSubFolders="true"/>
 <PageParserPath VirtualPath="/*" CompilationMode="Always" AllowServerSideScript="true" IncludeSubFolders="true"/>
      </PageParserPaths>
    </SafeMode>
```

## Monitoring

You can enable logging events into the web servers Application Eventlog using ASP.NET Health Monitoring infrastructure. Edit the web.config file of the site where PageParserPath directive is used. Locate the <system.web> section and add the following lines:  

```
<healthMonitoring>
   <rules>
   <add name="Application Events"
       eventName="Application Lifetime Events"
       provider="EventLogProvider"
       profile="Default"
       minInterval="00:01:00" />
   </rules>
</healthMonitoring>
```

Once you edit a page, which is in a folder specified in the VirtualPath attribute and its modification date changes, you will see an event similar to this in the Application Event Log:

Event code:            1003
Event message:      Application compilation is starting.
Event time:            [Date and Time]
Event time (UTC):  [Date and Time]
Event ID:               6e48fceea1194fcb9f3ff05a4eec3d68
Event sequence:    67
Event occurrence: 3
Event detail code:  0

Once the Event occurrence value exceeds 15, you will see the following event:

Event code:            1001
Event message:      Application is starting.
Event time:            [Date and Time]
Event time (UTC):  [Date and Time]
Event ID:               304b82ca4b764de79d42223fcbd2ac49
Event sequence:    1
Event occurrence: 1
Event detail code:  0

This indicates that the application pool was restarted.

## Short-term Solution

As a short-term solution it is possible to increase the default 15 recompilation limit for the ASP.NET engine while a long-term solution is implemented.

In order to increase the recompilation, limit the numRecompilesBeforeAppRestart  has to be added or edited in the compilation element, for example:  

```
<compilation debug="false" numRecompilesBeforeAppRestart="50" />
```

See [Compilation Element (ASP.NET Settings Schema)](https://msdn.microsoft.com/library/s10awwz0%28v=vs.90%29.aspx) for details.

## Long-term Solution

Move the server-side inline scripts from the pages, page layouts, and master pages into server controls. Deploy these controls using solutions and features and remove the PageParserPath directive.

- [User Controls and Server Controls in SharePoint](https://blogs.msdn.com/b/kaevans/archive/2011/04/28/user-controls-and-server-controls-in-sharepoint.aspx)  
- [Developing Custom ASP.NET Server Controls](https://msdn.microsoft.com/library/zt27tfhy%28v=vs.85%29.aspx)

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
