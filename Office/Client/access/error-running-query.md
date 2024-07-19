---
title: Unable to run a query with the UniqueValues property
description: Workaround an issue in which you can't run a query that has the UniqueValues query property set to Yes.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: v-jomcc
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# "The field is too small to accept the amount of data you attempted to add" error when running a query

_Original KB number:_ &nbsp; 896950

## Symptoms

In Microsoft Office Access, you may create a query that has the `UniqueValues` query property set to **Yes**, and the query may include a Memo field. When you run the query, you may receive the following error message:

> The field is too small to accept the amount of data you attempted to add. Try inserting or pasting less data.

Additionally, the query may run without an error message. However, the data that is returned in the memo field is truncated to 255 characters.

## Cause

This problem occurs because when you set the `UniqueValues` query property to **Yes**, a DISTINCT keyword is added to the resulting SQL statement. The DISTINCT keyword directs Access to perform a comparison between records. When Access performs a comparison between two Memo fields, Access treats the fields as Text fields that have a 255-character limit. Sometimes Memo field data that is larger than 255 characters will generate the error message that is mentioned in the "Symptoms" section. Sometimes only 255 characters are returned from the Memo field.

## Workaround

To work around this problem, modify the original query by removing the Memo field. Then, create a second query that is based on both the table and the original query. This new query uses all the fields from the original query, and this new query uses the Memo field from the table. When you run the second query, the first query runs. Then, this data is used to run the second query. This behavior returns the Memo field data based on the returned data of the first query. To do this, follow these steps.

### Access 2007

1. Copy the original query, and then name this copyBackup Copy **OriginalName**.
2. Right-click the original query, and then click **Design View**.
3. Click the column that contains the Memo field, and then click **Delete Columns** in the **Query Setup** group on the **Design** tab.
4. Save the query.
5. On the **Create** tab, click **Query Design** in the **Other** group.
6. Click the **Both** tab.
7. Click the original query, and then click **Add**.
8. Click the table on which the original query is based, and then click **Add**.
9. Click **Close**.
10. Add the fields from the original query, and then add the memo field from the table.
11. Create a link between the table and the query by using the appropriate field.

    For more information about how to use joins in Microsoft Query, click the following article number to view the article in the Microsoft Knowledge Base:

    [136699](https://support.microsoft.com/help/136699) Description of the usage of joins in Microsoft Query

12. Save the query.
13. On the **Design** tab, click **Run** in the **Results** group.

    The query should run as expected, and the Memo field is not truncated.

### Access 2003, Access 2002, and Access 2000

1. Copy the original query, and then name this copyBackup Copy **OriginalName**.
2. Click the original query, and then click **Design** on the **Database** toolbar.
3. Click the column that contains the Memo field, and then click **Delete** on the **Edit** menu.
4. Save the query.
5. Double-click **Create query in design view**.
6. Click the **Both** tab.
7. Click the original query, and then click **Add**.
8. Click the table that the original query is based on, and then click **Add**.
9. Click **Close**.
10. Add the fields from the original query, and then add the memo field from the table.
11. Create a link between the table and the query.

    For more information about how to create a link, click the following article number to view the article in the Microsoft Knowledge Base:

    [136699](https://support.microsoft.com/help/136699) Description of the usage of joins in Microsoft Query

12. Save the query.
13. On the **Query** menu, click **Run**.

    The query should run as expected, and the Memo field is not truncated.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
