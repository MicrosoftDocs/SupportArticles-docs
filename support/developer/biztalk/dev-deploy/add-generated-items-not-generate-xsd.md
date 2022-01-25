---
title: Add Generated Items Wizard can't generate an XSD schema
description: This article discusses a problem in a BizTalk Server project where the Add Generated Items Wizard fails to generate an XSD schema and you might get an error message.
ms.date: 03/16/2020
ms.custom: sap:Development and Deployment
ms.reviewer: rickcau
---
# Add Generated Items Wizard fails to generate an XSD schema

This article discusses a problem in a Microsoft BizTalk Server project where the Add Generated Items Wizard doesn't generate an XML Schema Definition (XSD) schema.

_Original product version:_ &nbsp; BizTalk Server 2006, 2004  
_Original KB number:_ &nbsp; 911771

## Symptoms

On a computer that's running Microsoft Visual Studio, you try to use the Add Generated Items Wizard in a BizTalk Server 2006 or BizTalk Server 2004 project to generate an XSD schema. The wizard doesn't generate an XSD schema, and you might get an error message like this one:

> There were some errors generated during schema generation. Go to task list to view errors. Task list may be filtered, enable showing of all task list items to see schema generation errors.

## Cause

The problem might happen when you try to convert a complex Document Type Definition (DTD) schema or a complex XML-Data Reduced (XDR) schema to an XSD schema.

## Resolution

To resolve the problem, use one of the following methods:

- Manually create an XSD schema.
- Use a partner program to convert the complex DTD schema or the complex XDR schema to an XSD schema.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed as the original product version at the beginning of this article.

## More information

When you try to use the BizTalk Schema Generator in Microsoft BizTalk Server to convert a complex DTD schema or a complex XDR schema to an XSD schema, the BizTalk Schema Generator parses the schema and tries to generate a valid XSD schema. The DTD schema and the XDR schema are older XML schemas that have been replaced by the XSD schema. The BizTalk Schema Generator in BizTalk Server 2004 doesn't support the conversion of complex DTD schemas or complex XDR schemas to an XSD schema.
