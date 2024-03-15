---
title: Incomplete search results for choice type columns with multiple values
description: Fixes an issue in which incomplete search results for choice type columns with multiple values.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - Microsoft SharePoint Server 2013 Service Pack 1
ms.date: 12/17/2023
---

# Incomplete search results for choice type columns with multiple values  

## Symptoms

You search for list-items or documents by using a keyword query, which represents a choice value that is stored in a choice type column with multiple choices selected and you don't get back the expected search results or even no results at all.  

Here are the steps to reproduce this problem:  

1. On a SharePoint 2013 site you create a new list with the name MyList of type custom list via the UI by clicking on Site Contents, add an app and Custom List.  

2. You open the newly created MyList and create a new column clicking in the Ribbon on the List  tab and Create Column with the following options:  
   - For Column name:  you enter MyChoiceColumn
   - For The type of information in this column is:  you select Choice (menu to choose from)
   - In the textbox with the heading Type each choice on a separate line, you enter the following next three items:
      - Choice1  
      - Choice2  
      - Choice3
   - For Display choices using:  you select Checkboxes (allow multiple selections)  

3. You add six new list items with the following parameters:  

   1. For Title you enter Item1  
    For MyChoiceColumn  you select or keep the pre-selected Choice1   
 
   2. For Title you enter Item2  
    For MyChoiceColumn  you select Choice2    

   3. For Title you enter Item3  
    For MyChoiceColumn  you select Choice3    

   4. For Title you enter Item4  
    For MyChoiceColumn  you select Choice1  and Choice2    

   5. For Title you enter Item5  
    For MyChoiceColumn  you select Choice1  and Choice3    

   6. For Title you enter Item6  
    For MyChoiceColumn  you select Choice2  and Choice3  

     :::image type="content" source="media/incomplete-search-results-for-choice-type-columns-with-multiple-values/list-items.png" alt-text="Screenshot of the six new list items you add." border="false":::      

4. After the next continuous-, incremental- or full-crawl finished, you execute the following three keyword queries from your search center or a search box:  

   1. Choice1  
   1. Choice2  
   1. Choice3

Following items are expected to get returned in the search results:  

  1. Item1, Item4, and Item5   
  2. Item2, Item4, and Item6   
  3. Item3, Item5, and Item6   

But only the following items get returned in the search results:  
  1. Item1   
  2. Item2   
  3. Item3   

## Cause  

The SharePoint 2013 Search schema creates the crawled property ows_MyChoiceColumn, for the multi-value enabled choice type of column, during crawling/indexing the custom list MyList and it will store the contents as a single value string in the full-text index on the file system.  

## Resolution

You execute the following three keyword queries from your search center or a search box:

1. Choice1   
2. Choice2   
3. Choice3  

The following items, which are expected to get returned, will now correctly get returned in the search results:  

1. Item1, Item4, and Item5   
2. Item2, Item4, and Item6   
3. Item3, Item5, and Item6   

## Similar problems and solutions  

You will face the same behavior when using a multi-value enabled choice type of site column but SharePoint 2013 automatically creates a managed property for your site column as described in the TechNet article Automatically created managed properties in SharePoint Server 2013 ([Automatically created managed properties in SharePoint Server](/SharePoint/technical-reference/automatically-created-managed-properties-in-sharepoint)).  

These are the solution steps for a site column with, e.g.,  the name MyChoiceSiteColumn:   

1. Navigate to your Search Service Application administration site and click on Search Schema.  
2. Search for the managed property by entering MyChoiceSiteColumn and click on the retrieved MyChoiceSiteColumnOWSCHCM property to modify the configuration:  

   You have to enable the options Searchable and Allow multiple values      

3. Finally save the new managed property with its configuration by clicking on OK   

Now start a full crawl or select to reindex your SharePoint site, list, or library, which contains the multiple value enabled choice type of column, and wait for the scheduled start of the next continuous or incremental crawl or manually start an incremental crawl.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).