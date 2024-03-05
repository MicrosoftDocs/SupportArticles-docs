---
title: An error occurred when loading the task sequence 
description: Fixes an issue where you can't create a Microsoft Deployment Toolkit task sequence in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, markstan
---
# An error occurred when loading the task sequence when you create an MDT task sequence

This article helps you fix an issue where you receive the **An error occurred when loading the task sequence** error when you create a Microsoft Deployment Toolkit (MDT) task sequence in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 2468097

## Symptoms

After selecting the **Finish** button when attempting to create an MDT task sequence, the task sequence may fail to create with the following error:

> An error occurred when loading the task sequence

The TaskSequenceProvider.log file may also show errors similar to the following:

> Failed to load class properties and qualifiers for class BDD_UsePackage in task sequence. 0x80041002 (2147749890) TaskSequenceProvider  
> Failed to load node Use Toolkit Package from XML into WMI 0x80041002 (2147749890) TaskSequenceProvider  
> Failed to load children steps for node "Execute Task Sequence" from XML 0x80041002 (2147749890) TaskSequenceProvider  
> Failed to load children steps for node "" from XML 0x80041002 (2147749890)  TaskSequenceProvider  
> Failed to load XML for the task sequence into WMI 0x80041002 (2147749890) TaskSequenceProvider

## Cause

This error can occur if the MDT Windows Management Instrumentation (WMI) classes are not properly registered.

## Resolution

To resolve this issue, follow the steps below:

1. Close all of your remote and local Configuration Manager admin console sessions.
2. Log on to your Configuration Manager server, in Microsoft Deployment Toolkit, select **Configure ConfigMgr Integration**.
3. In the **Configure ConfigMgr Integration** wizard, select **Remove the MDT console extensions for System Center Configuration Manager**, click **Next**, then click **Finish**.
4. Rerun **Configure ConfigMgr Integration**, select **Install the MDT extensions for Configuration Manager**, click **Next**, then click **Finish**.

Once you do the steps, try creating the task sequence again. It should now complete successfully.

## More information

This error occurs because the BDD_* WMI classes have not been correctly registered under the \root\SMS\site_\<sitecode> namespace in WMI.
