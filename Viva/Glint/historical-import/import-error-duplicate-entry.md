---
title: Duplicate entry error during historical imports
description: Fix the Duplicate entry error when you import historical data in Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/17/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI184017
localization_priority: Normal
---

# Duplicate entry error during historical imports

## Symptoms

When you import historical data into Viva Glint, you receive the following error message:

> Error:
>
> Exception [EclipseLink-4002](Eclipse Persistence Services – 2.7.3.v20180807 -4be1041): org.eclipse.persistence.exceptions.DatabaseException Internal Exception: java.sql.batchUpdateException: Duplicate entry '\<ID\>' for key 'AK1survey_result_answer' Error Code: 1062 Query: InsertObjectQuery(com.awareai.model.SurveyResultAnswer@122225f8

## Cause

This issue occurs because there is at least one duplicate user record in the imported Raw Score File. Each respondent should have only one response row in this file.

## Resolution

To fix the issue, remove duplicate user records from the Raw Score File, and then import the data again.
