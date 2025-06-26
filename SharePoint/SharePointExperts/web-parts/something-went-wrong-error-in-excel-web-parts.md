---
title: A We don't know what happened, but something went wrong error in Excel Web Access Web Parts
description: Fixes the error about Excel Services when you try to view a Microsoft Excel workbook in the Excel Web Access Web Part.
author: helenclu
ms.author: luche
ms.reviewer: remcgurk
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User experience\Webpart infrastructure
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# "We don't know what happened, but something went wrong." error in Excel Web Access Web Parts

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you try to view a Microsoft Excel workbook in the Excel Web Access Web Part, you receive the following error:

:::image type="content" source="./media/something-went-wrong-error-in-excel-web-access-web-parts/excel-services.png" alt-text="Screenshot that shows the error of something went wrong about Excel Services.":::

In the Unified Logging Service (ULS) logs, the following log is displayed:

```output
The EXECUTE permission was denied on the object 'rbs_fn_get_blob_reference', database 'SharePoint_Content_80', schema 'mssqlrbs'.
```

## Resolution

To resolve this issue, grant the following permissions for the Application Pool account on the content database:

- db_rbs_admin
- db_rbs_filestream_maintaner_1
- db_rbs_filestream_reader_1
- db_rbs_filestream_writer_1
- db_rbs_maintainer
- db_rbs_reader
- db_rbs_writer

:::image type="content" source="./media/something-went-wrong-error-in-excel-web-access-web-parts/application-pool-account-permissions.png" alt-text="Screenshot that shows the application pool account permissions dialog box":::
