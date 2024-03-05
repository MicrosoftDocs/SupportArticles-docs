---
title: Can't distribute deployment packages
description: Fixes an issue in which you receive the Source directory does not exist error when you distribute deployment packages.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Source directory does not exist error when deployment package distribution fails

This article fixes an issue in which you can't distribute deployment packages and receive the **Source directory does not exist** error.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3121616

## Symptoms

You discover that content for System Center Endpoint Protection (SCEP) software updates has been removed from active deployment packages. When you try to distribute these deployment packages, the attempt fails with the following error:

> The source directory "//name/source/Updates/SCEP/bfdc178c-6e80-47cb-b698-b34dc39b67f4" for package "*Package ID*" does not exist.

## Cause

This issue occurs when the update package shares the same source location with other software update packages. When Configuration Manager performs a cleanup of orphaned folders in this situation, it doesn't recognize that some of these folders actually belong to another active deployment.

## Resolution

To resolve this problem, re-create the package in question, and make sure that you specify a unique source location. This will prevent content folders from being removed from deployment packages.
