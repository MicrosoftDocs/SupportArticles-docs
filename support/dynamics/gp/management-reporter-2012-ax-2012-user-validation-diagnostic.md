---
title: User Validation diagnostic
description: Diagnostic tool to check users in Management Reporter and Microsoft Dynamics AX and confirm they are valid.
ms.reviewer: kellybj, kevogt
ms.date: 03/31/2021
---
# [SDP 3][eac0d4f1-1e4a-4713-9e07-65e49e866fd0] Management Reporter 2012 AX 2012 User Validation diagnostic

The Microsoft Management Reporter (MR) 2012 Dynamics AX 2012 [User Validation diagnostic](https://aka.ms/mr2012AXUserValidation) checks both users in the Microsoft MR database and users in the AX database to confirm they are valid users in Active Directory.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2810536

## Introduction

When you run the diagnostic, it prompts you for the following items:

1. Microsoft Dynamics AX SQL server name: Enter in the name of the SQL server where the Microsoft Dynamics AX database resides.
2. Microsoft Dynamics AX database name: Enter in the name of the Microsoft Dynamics AX SQL database.
3. Microsoft MR SQL server name: Enter in the name of the SQL server where the Microsoft MR database resides.
4. Microsoft MR database name: Enter in the name of the Microsoft MR SQL database.

## More information

This diagnostic checks Active Directory for a valid user entry for each Microsoft MR and Microsoft Dynamics AX user. Only Microsoft Dynamics AX users who are granted MR rights will be tested.
