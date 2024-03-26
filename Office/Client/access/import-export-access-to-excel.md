---
title: Access errors during import or export to Excel
description: Resolve Access errors during importing or exporting to Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Access 2010
  - Access 2013
ms.date: 03/31/2022
---

# Access: Errors during Import/Export to Excel xls

## Symptoms

Access encounters Import/Export errors when working with Excel *.xls files that have cells, which contain more than 8224 bytes of data.

```adoc
Import Error: The wizard is unable to access information in the file '<filename>'. Please check that the file exists and is in the correct format.
Export Error: External table is not in the expected format.
```

## Cause

Changes that were released beginning with Access 2010 Service Pack 1 prevent Access from opening an existing Excel *.xls file if the contents of a cell are greater than 8224 bytes.

## Resolution

You may use one of the following methods to prevent the issue.

1. Use the *.xlsx format instead 
2. Restrict any memo/long text fields to a length less than 8224 bytes
3. When exporting, delete the existing .xls file before performing the export using the same file name
4. Open the .xls file in Excel before performing the Import/Export from Access