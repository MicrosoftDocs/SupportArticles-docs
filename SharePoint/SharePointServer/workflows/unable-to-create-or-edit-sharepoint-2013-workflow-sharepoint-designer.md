---
title: Unable to create or edit SharePoint 2013 workflow in SharePoint Designer
description: Resolves a situation where you cannot create or edit a SharePoint 2013 workflow in SharePoint Designer.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\SharePoint Designer
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - SharePoint Designer 2013
ms.date: 12/17/2023
---

# Unable to create or edit SharePoint 2013 workflow in SharePoint Designer

## Symptoms
When you create or edit a SharePoint 2013 workflow in SharePoint Designer, nothing appears to happen and no error is reported in the SharePoint Designer UI. You might see a Window pop-up for building cache appear and then quickly disappear.

If you capture an HTTP trace from Fiddler or from a browser-based developer tool, you see the following error:

> Exception occurred in scope<br />Microsoft.SharePoint.WorkflowServices.WorkflowDeploymentService.GetActivitySignatures. Exception=System.ArgumentException: An item with the same key has already been added.

## Cause
A feature in the SharePoint farm was added twice with two different feature IDs.

## Resolution
To resolve this issue, identify and remove the feature with the duplicate ID.

1. Review the Unified Logging Service (ULS) collected in Verbose mode to track down the duplicate feature by using one of the following methods: 
   - Find the search error message mentioned above.
   - Search for a correlation ID or a SPRequestGUID, both of which are part of the Server Response in the HTTP trace captured in Fiddler or the browser developer tool.

2. When reviewing the ULS log, you will see a list of all features installed in the farm that were queried. Find the last feature that was queried before the error occurred and make a note of the feature's ID.

3. Run the command Get-SPFeature *Feature ID* to get the name of the feature.

4. Run the command Get-SPFeature *Name of the feature* to get the feature ID. The output will display two feature IDs associated for the same feature. This is the cause of the issue. One of the two feature IDs is a duplicate.

5. Identify the duplicate by checking the feature folders on all the servers in the farm. As an alternative, run Get-SPFeature *Name of the feature* on each server to discover whether one or more servers has a reference to or shows a duplicate feature ID. Make a note of the site URL that is shown in the output.

6. To remove the duplicate feature ID, disable the feature with the duplicate feature ID and then uninstall it by using the following steps: 
   1. To disable the feature, run the command Disable-spfeature -id *Feature ID* -url http://site.
   2. To uninstall the feature, run the command Uninstall-spfeature -id *Feature ID*.

If the issue persists, it is possible that the configuration cache might still hold duplicate feature ID information. You can clear the configuration cache on all servers to overcome.

To clear the SharePoint configuration cache, see the following blog post:

[Clear the SharePoint Configuration Cache](/archive/blogs/josrod/clear-the-sharepoint-configuration-cache)

## More information
When you attempt to create or edit a SharePoint 2013 Workflow using SharePoint Designer, it must first build a cache of all workflow activities. These include SharePoint built-in activities and any other product or features installed in the SharePoint farm (such as Project, Nintex, etc.). The SharePoint server provides the workflow activity details to SharePoint Designer when Designer makes a GetActivitySignatures call to the server:

```
Microsoft.SharePoint.WorkflowServices.StoreWorkflowDeploymentProvider.GetActivitySignatures(DateTime lastChanged).
```

To provide all the workflow activities available in SharePoint farm (GetActivitySignatures), SharePoint must list out all features present in the farm and build a dictionary. In a situation where a particular feature is added with a second, duplicate ID, SharePoint will encounter problem while building the dictionary and error out as "An item with the same key has already been added."

Note that the DateTime, lastChanged value is dependent on whether Designer already has a cache of Workflow activities or not for a particular site. When Designer is building a workflow activities cache for the first time for a site, the value of the DateTime lastChanged parameter will be 0000. From that point onward, the value will contain the last time that the cache was built. Using this method, Designer will pull down only new added workflow activities.

To view the GetActivitySignature cache created by SharePoint Designer, browse to the following location on the computer running SharePoint designer:

```
%USERPROFILE%\AppData\Local\Microsoft\WebsiteCache\SharePoint Site name\SharePoint Build version\Activity.xml
```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
