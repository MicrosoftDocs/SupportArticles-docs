---
title: Error when you run a query in Access
description: Provides a resolution for a problem that occurs in Access 2010. You receive an error message when you run a query in Access 2010 because of a double-byte Arabic number.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: cochen, mattbum
appliesto: 
  - Access 2010
ms.date: 03/31/2022
---

# You receive an error message when you run a query in Microsoft Access because of a double-byte Arabic number

## Symptoms

In Microsoft Access 2010, Microsoft Access 2007, or in Microsoft Office Access 2003, you experience one of the following symptoms:

### Symptom 1

You receive an error message when you run a query that has a field name that begins with a double-byte arabic number. For example, if the field name contains two or more characters, such as "�PMonth", you receive the following error message:

```adoc
Syntax error in query expression ' Table Name .�PMonth': Missing operator.  
```

If the field name only contains one character, such as "1", you receive the following error message:

```adoc
Invalid use of '.', '!', or '()' in query expression ' Table Name. '. NoteIn Access 2003, this issue only occurs when you run the query on a Windows Vista-based computer. 
```

### Symptom 2

You use a table that contains some fields whose names begin with double-byte arabic numbers. Then, you create a query to select all the data for the field names that begin with double-byte arabic numbers. When you run this query, you receive the following error message:

```adoc
Syntax error (missing operator) in query expression 'TableName.FieldName'.
```

**Note** The **TableName** placeholder represents the name of the table that you are querying. The **FieldName** placeholder represents the name of the field name that you are querying.

**Note** This issue may also occur for objects other than tables.

## Resolution

To resolve the issue that is described in Symptom 1, see Resolution 1.

To resolve the issue that is described in Symptom 2, see Resolution 2.

### Resolution 1

To resolve this problem, enclose the field name in single-byte square brackets ([ ]). For example, change the field name from 1Month to [1 Month].

### Resolution 2

To resolve this problem, use one of the following methods:

#### Method 1

1. Change any field names that begin with double-byte arabic numbers so that they do not use double-byte arabic numbers.    
2. Create and then save a new query.   

#### Method 2

1. Create a new query that is based on the table. Name the new query Query1.   
2. Create a field that is named TableName.* to the query.

   **Note** Do not add any other fields except TableName.*.   
3. Save the new query.   
4. Use the new query to select the fields that you want.   

## More Information

### Steps to reproduce the problem

1. In Access, create a table.   
2. Define a field by using a name that begins with a double-byte Arabic number.    
3. Create a query that refers to the field in the table.    
4. Run the query.    
