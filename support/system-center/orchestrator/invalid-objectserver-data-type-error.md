---
title: Invalid ObjectServer data type 
description: Describes an issue where the activities in the Integration Pack for IBM Tivoli NetCool/OMNIbus return the Invalid ObjectServer data type error.
ms.date: 08/04/2020
---
# NetCool/Omnibus integration pack for Orchestrator returns error Invalid ObjectServer data type

This article describes an issue where the activities in the integration pack for IBM Tivoli NetCool/OMNIbus return the **java.lang.RuntimeException: Invalid ObjectServer data type** error.

_Original product version:_ &nbsp; Microsoft System Center 2012 Orchestrator  
_Original KB number:_ &nbsp; 2805835

## Symptoms

The error message **java.lang.RuntimeException: Invalid ObjectServer data type** is returned by the activities in the integration pack for IBM Tivoli NetCool/OMNIbus if the **Status** table in the **Alerts** database includes one or more columns of type **char**.

## Cause

NetCool/Omnibus expects **varchar** type data. The column being written to is currently of type **char**.

## Resolution

This issue has been corrected in System Center 2012 Orchestrator Service Pack 1 (SP1).
