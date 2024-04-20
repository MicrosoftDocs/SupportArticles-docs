---
title: Initialize CA Error editing a device enrollment profile
description: Describes an issue in which you receive Initialize CA Error when you try to edit a device enrollment profile in Configuration Manager current branch version 1902.
ms.date: 12/05/2023
ms.custom: sap:Mobile Device Management
ms.reviewer: kaushika
---
# Initialize CA Error when editing a device enrollment profile in Configuration Manager 1902

This article helps you resolve an issue where you can't edit a device enrollment profile in Configuration Manager current branch version 1902 and get **Initialize CA Error**.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1902)  
_Original KB number:_ &nbsp; 4508759

## Symptoms

Consider the following scenario in Configuration Manager:

- You enable the following option in the management point properties to configure at least one management point for managing modern devices:

  **Allow mobile devices and Mac computers to use this management point**

- In the Configuration Manager console, you go to **Administration** > **Client Settings** > **Enrollment**, and then select **Set Profile** under **User Settings** > **Enrollment profile**.
- You select an enrollment profile, and then select **Edit Selected**.

In this scenario, the following error message window opens:

> Initialize CA Error

The message contains the following detail information:

> System.ArgumentException  
> Controls created on one thread cannot be parented to a control on a different thread.  
> Stack Trace:  
&nbsp; &nbsp;at System.Windows.Forms.Control.ControlCollection.Add(Control value)  
&nbsp; &nbsp;at System.Windows.Forms.Form.ControlCollection.Add(Control value)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.ControlsInspector.SetInvalidControl(Control control, String errorMessage)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.ControlsInspector.SetInvalidControl(Control control)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.ControlsInspector.EvaluateControl(Control control)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.ControlsInspector.InspectAll()  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.DeviceManagement.Enrollment.CreateEnrollmentProfileDialog.AddItemToListViewCAServers(String name, String fqdn, DataTable certTemplates)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.DeviceManagement.Enrollment. CreateEnrollmentProfileDialog.InitializationWorker_DoWork(Object sender, DoWorkEventArgs e)  
&nbsp; &nbsp;at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)  
&nbsp; &nbsp;at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)

## Cause

This is a known issue in Configuration Manager current branch, version 1902.

## Resolution

To fix this issue, update to [Configuration Manager current branch version 1906](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1906).

## Workaround

To work around this issue without updating, delete the enrollment profile, and then create a new profile.
