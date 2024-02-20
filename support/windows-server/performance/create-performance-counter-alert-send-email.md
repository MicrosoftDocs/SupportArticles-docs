---
title: Create performance counter alert and send email
description: Describes how to create performance counter alert and send email when the alert is triggered.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Create performance counter alert and send email when the alert is triggered

This article provides the steps to create performance counter alert and send email when the alert is triggered.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2424491

## Summary

### Step 1: To configure alert actions

1. Expand Reliability and Performance in the navigation pane.

2. Expand Data Collector Sets, expand User Defined, and click the name of the Data Collector Set with performance counter alerts.

3. In the console pane, right-click the name of a Data Collector whose type is Alert and click Properties.

4. On the Data Collector Properties page, click the Alerts tab. The data collectors and alerts already configured should appear.

5. Click the Alert Action tab to choose whether to write an entry to the event log Applications and Services Logs/Microsoft/Windows/Diagnosis-PLA/Operational when the alert criteria are met. You can also start a Data Collector Set when the alert criteria are met.

6. Click the Alert Task tab to choose a Windows Management Interface (WMI) task and arguments to run when the alert criteria are met.

### Step 2: Create a task in task scheduler

1. Click start Administrative tools>Task Scheduler.

2. Right-click Task Scheduler Library-select create task.

3. Enter the task name.

4. check the box for Run with highest privileges.

5. Select Action tab and select New.

6. In the New Action window under Action, select Send an e-mail.

7. Fill the email details and click ok.

### Step 3  

1. Go to the properties of the DataCollector Set that we created in step 1

2. select Alert Task and type the task name that we created in step 2.
