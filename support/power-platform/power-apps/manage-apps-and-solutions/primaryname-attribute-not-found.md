---
title: PrimaryName attribute not found for entity
description: Describes an issue where the message PrimaryName attribute not found for Entity during solution import.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 08/01/2023
author: nhelgren
ms.author: nhelgren
---
# PrimaryName attribute not found for entity

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

The below message is displayed during solution import: 

> PrimaryName attribute not found for Entity

## Cause

This error happens when the primary name attribute of a table isn't part of the solution xml file.

## Workaround

Remove the table from the solution in the source environment, and then add the table back to the source environment with full assets. This adds the table and necessary metadata. Export the solution and import again into the target environment.
