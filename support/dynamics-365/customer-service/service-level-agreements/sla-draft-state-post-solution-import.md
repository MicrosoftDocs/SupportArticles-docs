---
title: SLA's state changes to Draft after importing a solution
description: Resolves an issue where an SLA defined in an organization goes into a draft state after you import an upgrade solution containing the SLA.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 07/19/2023
---
# SLA's state changes from Active to Draft after importing an upgrade solution that contains the SLA

This article provides a resolution for an issue where the state of a service-level agreement (SLA) defined in an organization changes to **Draft** after you import an upgrade solution that contains the SLA.

## Symptoms

If an upgrade solution contains an SLA that's defined in an organization, the SLA's state changes from **Active** to **Draft** after you import the solution.

## Cause

The reason for changing the state to **Draft** is to apply any metadata changes from the source SLA to the target SLA during the solution import.

## Resolution

This is a by-design behavior. You need to manually activate the SLA again after importing the solution.
