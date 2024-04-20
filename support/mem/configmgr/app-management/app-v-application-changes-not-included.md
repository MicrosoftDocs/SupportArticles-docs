---
title: Changes to an App-V application aren't included
description: Describes a problem in which changes to an App-V application are not included when you use App-V Sequencer.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, alvinm
ms.custom: sap:Application Management\Application Virtualization (App-V)
---
# Changes to an App-V application are not included when you use App-V Sequencer

This article provides a workaround to solve the issue that changes to a Microsoft Application Virtualization (App-V) application via the App-V Sequencer are not included in this application in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft Application Virtualization for Windows Desktops, Microsoft Application Virtualization for Remote Desktop Services  
_Original KB number:_ &nbsp; 2683934

## Symptoms

Consider this scenario:

- You create a Microsoft App-V application.
- You deploy the source for the application to a System Center 2012 Configuration Manager distribution point.
- You change the application by using the App-V Sequencer.
- You deploy the content for the updated application to the distribution point.

In this scenario, when users run the application, your changes are not included in the application.

## Cause

This problem occurs because the App-V Sequencer saves the virtual application's SFT file (.sft) using a different name when changes are saved for the application. For example, if your virtual application is named MyApp.sft, the App-V Sequencer will save the changed application as MyApp_2.sft. Without manual adjustment, the Deployment Type for the App-V application will still refer to the original SFT file name.

## Workaround

To work around this problem, change the Deployment Type to refer to the current SFT file manually.

## More information

Because the file name changes when you update an App-V application, Binary Delta Replication is not used to download the updated content to the clients. Binary Delta Replication is possible only when you work with two versions of a file that have the same name.
