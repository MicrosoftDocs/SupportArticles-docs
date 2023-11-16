---
title: Error when you run the DQS Cleansing transformation
description: This article provides two workarounds for the problem where an error is logged in the SSIS log on SQL Server 2012.
ms.date: 01/14/2021
ms.custom: sap:Data Quality Services
ms.reviewer: smat
ms.topic: troubleshooting 
---
# Error (DQS Cleansing failed the pre-execute phase) when you run the DQS Cleansing transformation in SQL Server 2012

This article helps you to work around the problem where an error is logged in the SSIS log on SQL Server 2012.

_Applies to:_ &nbsp; SQL Server 2012 Developer, SQL Server 2012 Enterprise, SQL Server 2012 Standard  
_Original KB number:_ &nbsp; 2715968

## Symptoms

Consider the following scenario:

- You use the Data Quality Services (DQS) Cleansing transformation in a SQL Server-Integrated Service (SSIS) Data Flow to cleanse your data in Microsoft SQL Server 2012.
- You set the "Configure error output" setting of the DQS Cleansing transformation to "Redirect row." However, you do not specify a location to save the error output.
- You execute the SSIS package.

In this scenario, the following error message is logged in the SSIS log:

> DQS Cleansing failed the pre-execute phase and returned error code 0x80070057.  
System.ArgumentException: Value does not fall within the expected range.  
at Microsoft.SqlServer.Dts.pipeline.Wrapper.IDTSBufferManager100.FindColumnByLineageID(Int32 hBufferType, Int32 nLineageID)  
at Microsoft.Ssdqs.Component.DataCorrection.Logic.DataCorrectionComponent.PreExecute()
at Microsoft.SqlServer.Dts.Pipeline.ManagedComponentHost.HostPreExecute(IDTSManagedComponentWrapper100 wrapper)

## Cause

This problem occurs because a destination is not set for the error output that is generated for rows that do not meet the DQS domain criteria and rules.

## Workaround

To resolve this issue, use one of the following methods.

- Method 1

  If you do not want to redirect error rows, follow these steps to resolve the issue:

  1. Open the DQS Component in the DQS Cleansing Transformation Editor.  
  1. Select Fail Component in the Configure error output drop-down list at the bottom of the DQS Cleansing Transformation Editor.

- Method 2

  If you have to redirect your error rows, then you must make sure that you have a destination location for the errors to be redirected to.
