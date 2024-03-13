---
title: Bad or missing data was encountered error when creating reports
description: Describes an error message you get when you generate a report in Microsoft Management Reporter. Provides a resolution.
ms.reviewer: kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Bad or missing data was encountered" error when you generate a report in Microsoft Management Reporter

This article provides a resolution for the **Bad or missing data was encountered** error that may occur when creating a report in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2686810

## Symptoms

When you generate a report in Microsoft Management Reporter, you receive the following error message:

> Bad or missing data was encountered while loading the report and its building blocks.

Other users can generate the same report without receiving this error.

## Cause

There is an invalid path for the files location.

## Resolution

Select **Tools** and then select **Options**. In the Management Reporter files location field, verify that you have a valid path entered. The user must have at least Modify permissions to this folder.
