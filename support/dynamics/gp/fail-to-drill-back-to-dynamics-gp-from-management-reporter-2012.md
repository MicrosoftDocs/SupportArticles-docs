---
title: Error when you drill back to Dynamics GP from Microsoft Management Reporter 2012 
description: Provides a solution to an error that you may receive when you drill back to Dynamics GP from MR 2012.
ms.topic: troubleshooting
ms.reviewer: theley, davidtre, kevogt
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# Error message when you drill back to Dynamics GP from Microsoft Management Reporter 2012: "A connection to Microsoft Dynamics GP could not be established"

This article provides a solution to an error that occurs when you drill back to Dynamics GP from Microsoft Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2692525

## Symptoms

You will receive the following error message when you drill back to Microsoft Dynamics GP from Microsoft Management Reporter 2012.

> A connection to Microsoft Dynamics GP could not be established. Be sure that you are logged on to the appropriate company and try again.

## Cause

Drilling back does not work if a user switches companies without closing Dynamics GP.

## Resolution

Close Dynamics GP and sign in to the appropriate company.
