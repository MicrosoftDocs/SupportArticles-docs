---
title: Post-processing of SharePoint files can take up to 24 hours
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Files and Documents\Upload
  - CI 125085
  - CSSTroubleshoot
ms.reviewer: shahna
description: Explains why post-processing of files in SharePoint Online can take up to 24 hours to complete.
---

# SharePoint file post-processing may take up to 24 hours

## Summary

When Microsoft SharePoint runs analyses on files, the post-processing may take up to 24 hours depending on the file type (including images, videos, audio files, and PDF files). Office files, however, typically take only a few hours to finish and may complete first.

## Status

This behavior is by design.

## More information

SharePoint does a variety of post-processing tasks after files are uploaded or edited. When one of these analyses is triggered, SharePoint extracts the file metadata, and writes it as properties on the file. Depending on the file type, SharePoint does the following additional analysis processes:

- Document language detection
- Time-to-read calculation
- Key point extraction
- Image object detection
- Optical Character Recognition (OCR) 



Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
