---
title: Show fiscal dates on a timescaled view
description: Describes how Fiscal Dates are shown on a timescaled view.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: v-abrudv, adrianje
ms.custom: 
  - CI 112121
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Standard 2010
  - Project Professional 2010
ms.date: 05/26/2025
---


# How fiscal dates are shown on a timescaled view

_Original version:_ 2011

_Original KB number:_  86287

In Microsoft Project 2010, when the fiscal year is set to start in a month other than January that is also before the current month, the current date may appear incorrect. When a fiscal year is specified, the current date becomes a fiscal date, which results in the date jumping ahead by one year. This is the correct year based on the information supplied to Microsoft Project and standard fiscal year calculations.

## Examples to show fiscal dates on a timescaled view

**Example 1**

1. Click **Project Information** on the **Project** tab in Project.

2. Change the current date to 6/29/97.

3. Change the Timescale to Years over Quarters.
   1. On the **View** tab, select **Timescale** from the **Timescale** drop-down list. 
   
   2. On the **Middle Tier** tab, in the **Units** box, select **Years**.
   
   3. On the **Bottom Tier** tab, in the **Units** box, select **Quarters**. 
   
   4. Click **OK**.
4. Change the Fiscal Year to start in February.
   1. On the **File** tab, click **Options**, and then click **Schedule**.
   
   2. Under **Calendar options for this project: \<Project Name>**, in the **Fiscal year starts in** list, click **February**.
   
   3. Click **OK**.

The **Current Date** vertical bar in the Gantt chart now shows the year 1998.

**Example 2**

If the **Fiscal year starts in** option is set to a month that is past the current date, the current date on the Gantt bar remains the same, and the future months are incremented by one year starting at the month specified.

1. Click **Project Information** on the **Project** tab in Project.

2. Change the current date to 6/29/97.

3. Change the Timescale to Years over Quarters.
   1. On the **View** tab, select **Timescale** from the **Timescale** drop-down list. 
   
   2. On the **Middle Tier** tab, in the **Units** box, select **Years**.
   
   3. On the **Bottom Tier** tab, in the **Units** box, select **Quarters**. 
   
   4. Click **OK**.
4. Change the Fiscal Year to start in July.
   1. On the **File** tab, click **Options**, and then click **Schedule**.
   
   2. Under **Calendar options for this project: \<Project Name>**, in the **Fiscal year starts in** list, click **July**. 
   
   3. Click **OK**.

The time scale in the Gantt chart shows the current date is still in the current year; however, the next month (July in this example) is in 1998.
