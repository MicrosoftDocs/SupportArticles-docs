---
title: Use SPQuery to query a list
description: Describes how to use SPQuery to query a list in SharePoint Server 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
ms.reviewer: sudeepg, sangits
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Use SPQuery to query a list in SharePoint Server 2013

_Original KB number:_ &nbsp; 2755129

This article describes how to use SPQuery to query a list in Microsoft SharePoint Server 2013.

## Use SPQuery in SharePoint Management Shell

To use SPQuery in SharePoint Management Shell, refer to the following example script:

```powershell
$web=Get-SPWeb http://sps15/sites/SiteName #This URL is the URL of Your SharePoint Site
$list=$web.Lists["Task"] #"Task" is the name of the list.
$query=New-Object Microsoft.SharePoint.SPQuery
$query.Query = "<where><eq><FieldRef Name='status'/><value Type='CHOICE'>Not Started</value></eq></where>"

# 'Status'is the name of the List Column. 'CHOICE'is the information type of the Column.

$SPListItemCollection = $list.GetItems($query)
$SPListItemCollection.Count
$SPListItemCollection | select Web, DisplayName
$web.Dispose()
$list=$web.Lists["Task"] 
$query=New-Object Microsoft.SharePoint.SPQuery
$query.Query="<Where><Eq><FieldRef Name='Age'/><Value Type='Number'>400</Value></Eq></Where>" 
$SPListItemCollection = $list.GetItems($query)
$SPListItemCollection.Count
$SPListItemCollection | select Web, DisplayName
$web.Dispose()
```

## Use SPQuery in C# applications

To use SPQuery in C# applications, refer to the following example code:

```csharp
  static void Main(string[] args)
        {
        SPSite cursite=new SPSite("http://sps15/sites/new");//This URL is the URL of your SharePoint Site.
        SPWeb curweb = cursite.OpenWeb();
        SPQuery curQry = new SPQuery();
        curQry.Query = "<where><eq><FieldRef name='status'/><value type='CHOICE'>Not Started</value></ep></where>";
        SPList mylist = curweb.Lists["Task"];//Task is the name for the list.
          SPListItemCollection curitems = mylist.GetItems(curQry);
          foreach (SPListItem curitem in curitems)
          {
              string resultitem = curitem["Title"].ToString();
              Console.Write(resultitem+"\n\r");
          }
        if (curweb != null)
        {
            string title = curweb.Title;
            Console.Write(title);
        }
        }
```

## Identify the information type

To identify the information type of the information in a column in a list, follow these steps:

1. Log on to the SharePoint site by using the administrator credential for the site collection.
2. Open a list such as **Task**.
3. On the **List** menu, click **List Settings**.
4. View the information type in the **Column** section.
