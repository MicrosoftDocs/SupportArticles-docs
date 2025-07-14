---
title: Definition of Microsoft Project constraints
description: Provides the definitions of Project constraints.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: adrianje
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# Definition of Microsoft Project constraints

## Summary

Each constraint type in Microsoft Project can be defined as a formula using the following conventions:

ES = Early Start of the activity

LS = Late Start of the activity

EF = Early Finish of the activity

LF = Late Finish of the activity

SS = Scheduled Start of the activity

SF = Scheduled Finish of the activity

CD = Constraint Date

## More Information

The following are definitions of Microsoft Project constraints.


- As Late As Possible: Schedules the task as late as it can without delaying subsequent tasks. Use no constraint date.
  
  ES=(Calculated)LS

- As Soon As Possible: Schedules the task to start as early as it can. Use no constraint date.

  (Scheduled)ES=(Calculated)ES + Delay

- Finish No Earlier Than: Schedules the task to finish on or after the constraint date.
 
  EF=CD (if Date<EF)

- Finish No Later Than: Schedules the task to finish on or before the constraint date.
  
  LF=CD (if Date<LF)

- Must Finish On: Schedules the task to finish on the constraint date. Once selected the task will not be moveable on the timescale.

  EF,LF,SF=CD

- Must Start On: Schedules the task to start on the constraint date. Once selected the task will not be movable on the timescale.
  
  ES,LS,SS=CD

- Start No Earlier Than: Schedules the task to start on or after the constraint date.
  
  ES=CD(if Date<ES)

- Start No Later Than: Schedules the task to start on or before the constraint date.

  LS=CD(if Date<LS)
