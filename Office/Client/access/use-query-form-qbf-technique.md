---
title: Use a form to specify the criteria for a query
description: Describes how to use a form to specify the criteria for a query. This technique is called query by form (QBF).
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: tado, WADEJACK
appliesto: 
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# How to use the query by form (QBF) technique in Microsoft Access

_Original KB number:_ &nbsp; 304428

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies only to a Microsoft Access database (.accdb and .mdb).

## Summary

This article shows you how to use a form to specify the criteria for a query. This technique is called query by form (QBF).

## More Information

In the QBF technique, you create a form in which you enter query criteria. This form contains blank text boxes. Each text box represents a field in a table that you want to query. You make entries only in the text boxes for which you want to specify search criteria.

The QBF form resembles a data entry form that has fields that match the fields in a table. A table that has fields for Name, Address, City, State, and ZIP Code can have a QBF form that has corresponding fields. To select certain records, you can enter any combination of search criteria in the form. You can specify a city only, or a city and a state, or a ZIP code only, or any other combination. Fields that you leave blank are ignored. When you select a command button on the form, Access runs a query that uses the search criteria from your form.

To use the QBF technique, follow these steps:

1. Open the sample database Northwind.mdb.
2. Create a new form that isn't based on any table or query, and save it as QBF_Form.
3. On the new form, create two text boxes and one command button that has the following properties. Then, save the form:

   ```console
   Text box 1
   ------------------
   Name: WhatCustomer

   Text box 2
   ------------------
   Name: WhatEmployee

   Command button 1:
   ------------------
   Caption: Search
   OnClick: QBF_Macro
   ```

4. Create the following new macro, and then save it as QBF_Macro:

   ```console
   Action: OpenQuery
   Query Name: QBF_Query
   View: Datasheet
   Data Mode: Edit
   ```

5. Create the following new query that is based on the Orders table, and then save it as QBF_Query:

   ```console
   Field: CustomerID
   Sort: Ascending
   Criteria: Forms![QBF_Form]![WhatCustomer] Or Forms![QBF_Form]![WhatCustomer] Is Null

   Field: EmployeeID
   Sort: Ascending
   Criteria: Forms![QBF_Form]![WhatEmployee] Or Forms![QBF_Form]![WhatEmployee] Is Null

   NOTE: When you type the criteria, make sure that you type the entire criteria in a single Criteria field; do not split the criteria by placing the 'Or' section on a separate row.  

   Field: OrderID
   Field: OrderDate
   ```

6. Open QBF_Form in the Form view. Enter the following combinations of criteria. Select Search after each combination:

   ```console
   Customer ID   Employee ID  Result
   -------------------------------------------------------
   <blank>       <blank>      All 830 orders

   AROUT         <blank>      13 orders

   AROUT         4            4 AROUT orders for employee 4

   <blank>       4            156 orders for employee 4
   ```

After you view the result set for each query, close the Datasheet window. Then, begin your next search. Each time that you select the **Search** button, the parameters in the QBF query filter the data based on the search criteria that you specified on the QBF query form.

### Notes on the QBF parameter criteria

The sample QBF query in this article implements criteria in the query as

Forms!**FormName**!**ControlName**Or Forms!**FormName**!**ControlName**Is Null

to filter the data. These criteria return all matching records. If the criteria value is null, all the records are returned for the specified field.

You can specify any of the following alternative criteria to return slightly different results.

> [!NOTE]
> In the following sample criteria, an underscore (_) is used as a line-continuation character. Remove the underscore from the end of the line when you re-create these criteria.

- `Like Forms!**FormName**!**ControlName**& "*" Or _
Forms!**FormName**!**ControlName**Is Null`

  This criteria statement is the same as the QBF sample, except that you can query by using a wildcard. For example, if you enter "Jo" in a field by using this criteria statement, the query returns every record in the field that begins with "Jo", including Johnson, Jones, Johanna, and so on.

- `Between Forms!**FormName**!StartDate And Forms!**FormName**!EndDate Or _
Forms!**FormName**!StartDate Is Null`

  You can use this criteria statement to query a date field by using Start Date and End Date text boxes on the query form. Records whose start and end dates fall between the values that you specify on the query form are returned. If you omit a Start Date value on the form, however, the query returns all records, regardless of the End Date value.

- Like Forms!**FormName**!**ControlName**& "*" Or Is Null

  This criteria statement returns both records that match the criteria and records that are null. If the criteria are null, all the records are returned. The asterisk (\*) is considered a parameter because it's part of a larger Like expression. Because the asterisk is a hard-coded criteria value (for example, Like "*"), records with null values are returned.

- `Like IIf(IsNull(Forms!**FormName**![**ControlName**]), _
"*",[Forms]![**FormName**]![**ControlName**])`

  This criteria statement returns all the records that match the criteria. If no criteria are specified in the query form, all records that aren't null are returned.

- `IIf(IsNull(Forms!**FormName**![**ControlName**]), _
[**FieldName**],[Forms]![**FormName**]![**ControlName**])`

  This returns all the records that match the criteria. If no criteria are specified in the query form, all records that aren't null are returned (the same result as in the example).
  
