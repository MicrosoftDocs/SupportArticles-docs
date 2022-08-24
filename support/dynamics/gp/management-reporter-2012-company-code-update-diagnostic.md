---
title: Management Reporter 2012 Company Code Update Diagnostic
description: Diagnostic tool to change the company code in Microsoft Management Reporter 2012.
ms.reviewer: kellybj, kevogt
ms.date: 03/31/2021
---
# [SDP 3.0][f2915ec5-185d-4984-b42e-2e7b30c7f116] Management Reporter 2012 Company Code Update Diagnostic

This diagnostic will enable you to update company codes on your reports and tree definitions from the Legacy provider ("-Curr") to DDM provider (no "-Curr"). This diagnostic is useful when upgrading from the Microsoft Dynamics GP Legacy provider to the Microsoft Dynamics GP DataMart Provider.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2844146

## Prerequisites

- Backup of the MR SQL database
- Dynamics GP Legacy provider installed (or was at some point)
- Dynamics GP DataMart provider installed

## Introduction

After providing the MR SQL Server and the MR database name, you will be able to map each "-Curr" company to another existing company without the "-Curr". After confirming each mapping, the diagnostic will run update SQL scripts against the MR database to change the company on the reports and trees that were selected.
