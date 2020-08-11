---
title: Private OneDrive for Business results is not included
description: FAQ about private OneDrive for Business results is not included in the online results.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# SharePoint Online search results no longer includes private OneDrive for Business results

## Summary

The Microsoft SharePoint CSOM and REST search API has a new default scope for queries in which private, non-shared results are filtered out of the tenant-wide experience. This new scope limits queries to run against SharePoint content and shared OneDrive for Business content. This means that results from the private OneDrive for Business content are no longer returned by default.

We define private OneDrive for Business content as content that only the owner of the OneDrive for Business has access to.

## Frequently asked questions

**Q1: When will the change occur?**

**A1:** This change will roll out to SharePoint Online customers starting mid-November 2018. 

**Q2: Which queries are affected?**

**A2:** The new default behavior affects queries that are issued on the SharePoint CSOM and REST search API in SharePoint Online. For example, the search query URL resembles the following:

> http://*\<server>*/_api/search/query

> [!NOTE]
> Queries that run in the context of a system-privileged app, such as eDiscovery, are not affected by this change.

**Q3: Do I have to do anything because of this change?**

**A3:** Only if you use the SharePoint Online search API to power a search experience, and users expect to receive results from SharePoint and OneDrive for Business, including their private OneDrive for Business content. Typically, this is not the case for custom search experiences. In such experiences, private results are frequently considered as noise in the search results. 

To include results from a user's private OneDrive for Business content, use the new **ContentSetting** query parameter to retrieve all results. The search API then queries all SharePoint and OneDrive content, but returns the results from the user's OneDrive for Business content in a separate result block.

Consider the following example search query: 

> https://*fabrikam*.com/_api/search/query?Querytext='query_string'&Properties='ContentSetting:3'&ClientType='MyClientType'

This query returns a search result that resembles the following output:

```asciidoc
<d:PrimaryQueryResult m:type="Microsoft.Office.Server.Search.REST.QueryResult">
  <d:RelevantResults m:type="Microsoft.Office.Server.Search.REST.RelevantResults">
    ..
    <d:Table m:type="SP.SimpleDataTable">
      <d:Rows>
        <d:element m:type="SP.SimpleDataRow">
          <d:Cells>
            <d:element m:type="SP.KeyValue">
              ...
              <d:Key>title</d:Key>
              <d:Value>Someone else's document</d:Value>
              <d:ValueType>Edm.String</d:ValueType>
            </d:element>
            ...
          </d:Cells>
        </d:element>
        ...
        ...
      </d:Rows>
    </d:Table>
    <d:TotalRows m:type="Edm.Int32">239</d:TotalRows>
    …
  </d:RelevantResults>
  ...
</d:PrimaryQueryResult>
…
<d:SecondaryQueryResults m:type="Collection(Microsoft.Office.Server.Search.REST.QueryResult)">
  <d:element>
    <d:CustomResults m:type="Collection(Microsoft.Office.Server.Search.REST.CustomResult)"/>
    <d:QueryId>Personal Results Table</d:QueryId>
    ...
    <d:RelevantResults m:type="Microsoft.Office.Server.Search.REST.RelevantResults">
      ...
      <d:Properties m:type="Collection(SP.KeyValue)">
        ...
      </d:Properties>
      <d:ResultTitle>From your OneDrive</d:ResultTitle>
      <d:ResultTitleUrl>Your OneDrive URL</d:ResultTitleUrl>
      <d:RowCount m:type="Edm.Int32">3</d:RowCount>
      <d:Table m:type="SP.SimpleDataTable">
        <d:Rows>
          <d:element m:type="SP.SimpleDataRow">
            <d:Cells>
              ...
              <d:element m:type="SP.KeyValue">
                <d:Key>title</d:Key>
                <d:Value>My ODB document 1</d:Value>
                <d:ValueType>Edm.String</d:ValueType>
              </d:element>
            </d:Cells>
            ...
          </d:element>
        </d:Rows>
      </d:Table>
      <d:TotalRows m:type="Edm.Int32">18</d:TotalRows>
      <d:TotalRowsIncludingDuplicates m:type="Edm.Int32">18</d:TotalRowsIncludingDuplicates>
    </d:RelevantResults>
    ...
  </d:element>
</d:SecondaryQueryResults>
```

The **SecondaryQueryResults** element contains three query result rows from your OneDrive for Business content.

## References

For more information about the SharePoint search API, see [Using the SharePoint search Query APIs](https://docs.microsoft.com/sharepoint/dev/general-development/using-the-sharepoint-search-query-apis).

For more information about the query parameters that are supported by the SharePoint search REST API, see [SharePoint Search REST API overview](https://docs.microsoft.com/sharepoint/dev/general-development/sharepoint-search-rest-api-overview).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
