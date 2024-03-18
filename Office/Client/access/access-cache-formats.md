---
title: Access cache formats for SharePoint lists and document libraries
description: Discusses Access cache formats for SharePoint lists and document libraries and performance improvements in Access 2010 and Access 2007.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
ms.date: 03/31/2022
---

# Access cache formats for SharePoint lists and document libraries

## Summary

Both Microsoft Access 2010 and Microsoft Office Access 2007 make significant improvements over earlier versions in how they work together with linked Microsoft SharePoint lists and document libraries to deliver a better user experience.

Beginning in Access 2010, you can choose which caching format best suits your needs. To do this, you can adjust the **Caching Web Service and SharePoint tables** options in the **File** > **Options** > **Current Database** dialog base. Unless you're experiencing one of the known issues that are listed in the following sections, we recommend that you select the option to **Use the cache format that is compatible with Microsoft Access 2010 and later**.

## Improvements in Access 2007

The following improvements in Access 2007 are major changes that increase SharePoint performance:

- Make asynchronous fetches of data from the server. These allow some scenarios to immediately show data before the complete recordset is returned from the server.

- Fetch incremental data changes to a list within an Access session. After the app fetches data in later requests, only query what has changed in the list.

- Cache lists in the local database as XML.

Asynchronous fetching

When data is loaded into a datasheet or form, the first page of data or a single record is often all that is required to let you begin working or scrolling through records. To speed up these scenarios, control is returned to Access as soon as the first batch of data is retrieved from the server. A background thread continues parsing and fetching the remaining data from the server. It blocks you from interacting with data only when the requested record is not yet available (for example, you press the **Move to last record** button immediately after you open the datasheet or form). Although this works in some scenarios, queries that have joins, sorts, and filters require that all the data be retrieved before you can access it.

Fetch incremental data changes

Although data must be fetched from the server when a link is first used within a session of Access, changes that were to the web service infrastructure enable the program to fetch incremental data changes. Access 2007 caches the data rowsets in memory after they are first opened. Therefore, later use of the SharePoint links become faster. In cases of large datasets, there is contention for RAM on the client computer. In this case, rowsets are released, and this frees RAM for the rest of the system.

Cache lists in XML

In addition to the in-memory caching, there are options to cache the XML within the database by using either offline mode or cached mode. This helps in cases in which the rowsets are recycled out of memory or when using the links in a new session of Access. This Is because some of the network time and server calls were eliminated.

## Improvements in Access 2010

Just as in Access 2007, Access 2010 connects to SharePoint lists through web services over HTTP. When a user opens a query, form, or report that consumes data from a SharePoint link, web service requests are made to the SharePoint server to get the list data. The server returns the data in XML, and this is parsed and cached in local tables. Then, the data is fetched by the Access data engine and displayed to the user.

The following improvements in Access 2010 increase SharePoint performance:

- Cache data in local tables

- Improve bulk query operations

- Reduce web service calls

Cache data in local tables

Access 2010 enhances the connected SharePoint list experience by caching data in local tables that persist across Access sessions. This enables Access to parse the bulk of the SharePoint XML data only one time. Later use of the links fetch only incremental data changes from the server. An additional benefit of using local tables internally instead of the in-memory rowsets is that multi-valued lookups and value list use in a SharePoint list becomes much faster.

The first time that a link is opened, Access must still download all the data from SharePoint and parse it into the local tables. In some cases, all the data may be required immediately. For example, all the data must be read before you can move to the last record in the datasheet or run a query that has a join. In these cases, the time that is required to use the data is about the same as in Access 2007. The real-time savings occur the next time that the link is used. This occurs either after you start a new session of Access or if many SharePoint links are used within a session. 

Using Access 2010 Cached mode

By default, the new cached mode is turned on for all new ACCDBs and published applications. You can have existing ACCDBs use the new cached mode by selecting the check box in the **File** > **Options** > **Current Database** dialog box.

Bulk query operations

When you export data to SharePoint, changes are typically sent in batches of 50 records at a time. Access 2010 extends this batching to bulk queries against SharePoint lists.

Reduce web service calls

When you use objects such as forms and subforms that contain multiple SharePoint links, only one web service call is required every time that you open a SharePoint link.

## Known issues in Cache mode

Access 2010 Cache mode should not be selected if that database will be shared together with Access 2007 users. However, you can use Cache mode in a copy of the database that will be shared.

[Access hangs when updating linked SharePoint list](https://support.microsoft.com/help/3200416)

[Access: "Cannot update. Database or object is read-only" error in linked SharePoint list](https://support.microsoft.com/help/3200680) (about a hidden taxonomy list)

[Access: "Cannot update. Database or object is read-only" error when executing update query against the linked SharePoint view](https://support.microsoft.com/help/3200677) (about lookup data that is missing)

[Access: Troubleshooting errors opening linked SharePoint lists/document libraries](https://support.microsoft.com/help/2702762)

[Synchronize a SharePoint 2010 list with Access 2010](https://support.office.com/article/synchronize-a-sharepoint-2010-list-with-access-2010-975bfb97-c799-4fce-b7cc-3db3b397f116)

[Access: "Cannot update. Database or object is read-only" error when executing update query against the linked SharePoint list](https://support.microsoft.com/help/3200674) (because the record exceeds the MaxSize property)

[You cannot download data from a SharePoint list to Access 2010](https://support.microsoft.com/help/2553007)

[TransferSharePointList / ImportSharePointList Macro Action](https://support.office.com/article/transfersharepointlist-macro-action-f4e107b1-5513-4868-a2d9-42be1d08e7fd)
