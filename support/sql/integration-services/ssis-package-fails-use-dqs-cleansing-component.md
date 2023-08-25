---
title: SSIS package fails to use DQS Cleansing Component
description: This article provides a workaround for the problem that occurs when the SSIS package uses the Data Quality Client Cleansing Component to cleanse dataflow data in a SQL Server environment.
ms.date: 09/21/2020
ms.custom: sap:Integration Services
ms.reviewer: jasonh
---
# Error message when you deploy an SSIS package to a different server in SQL Server

This article helps you resolve the problem that occurs when the SSIS package uses the Data Quality Client Cleansing Component to cleanse dataflow data in a SQL Server environment.

_Original product version:_ &nbsp; SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Enterprise  
_Original KB number:_ &nbsp; 2882914

## Symptoms

Consider the following scenario:

- You create a SQL Server Integration Services (SSIS) package design that uses the Data Quality Services (DQS) Cleansing component to cleanse dataflow data in a Microsoft SQL Server 2012 or SQL Server 2014 environment.
- You move the SSIS package from one server environment to a different server environment. For example, you deploy the SSIS package to a different server.
- You update the DQS Cleansing connection manager to point to the new server name.

In this scenario, you receive the following error message:

> Data Flow Task Name:Error: Microsoft.Ssdqs.Infra.Exceptions.EntryPointException: The Knowledge Base does not exist [Id : 1000999].  
at Microsoft.Ssdqs.Proxy.Database.DBAccessClient.Exec()  
at Microsoft.Ssdqs.Proxy.EntryPoint.KnowledgebaseManagementEntryPointClient.DQProjectGetById(Int64 id)  
at Microsoft.Ssdqs.Component.DataCorrection.Logic.DataCorrectionComponent.PostExecute()  
at Microsoft.SqlServer.Dts.Pipeline.ManagedComponentHost.HostPostExecute(IDTSManagedComponentWrapper100 wrapper)  
Data Flow Task Name:Error: System.NullReferenceException: Object reference not set to an instance of an object.  
at Microsoft.Ssdqs.Component.DataCorrection.Logic.DataCorrectionComponent.ProcessChunk(ReadOnlyCollection`1 fieldMappings, ReadOnlyCollection`1 records, CorrectedRecordsStatusStatistics& correctedRecordsTotalStatusStatistics)  
at Microsoft.Ssdqs.Component.DataCorrection.Logic.DataCorrectionComponent.ProcessInput(Int32 inputID, PipelineBuffer buffer)  
at Microsoft.SqlServer.Dts.Pipeline.ManagedComponentHost.HostProcessInput(IDTSManagedComponentWrapper100 wrapper, Int32 inputID, IDTSBuffer100 pDTSBuffer, IntPtr bufferWirePacket)

## Cause

This problem occurs when the DQS knowledge base ID number, such as 1000999, does not exist on the destination instance of SQL Server in the DQS_MAIN database.

The number will vary every time that you change and publish the DQS knowledge base (KB). The ID number is a unique identifier for each published DQS KB and corresponds to only one KB.

When the SSIS package is persisted to the *.dtsx* file or into the SSISDB database, the numeric ID of the DQS KB is remembered in the design tags, as in the following example:

```xml
<property dataType="System.Int64" name="KnowledgebaseName" typeConverter="NOTBROWSABLE">1000999
</property>
```

The expectation is that the DQS server name and KB number will remain consistent even when you move the SSIS packages to different servers.

To verify that this is the cause, connect to the SQL Server database engine that is hosting the Data Quality Services databases, and then run the following query to determine whether the KB ID that is mentioned in the error message exists:

```sql
SELECT * from [DQS_MAIN].[dbo].[A_KNOWLEDGEBASE] where id=1000999
```

> [!NOTE]
> If you export a DQS KB and then import the KB into a DQS instance, the ID number will change when the KB is imported and then published. Therefore, even if the KB design elements are identical, the number may become out of sync between the SSIS package design and the published DQS KB.

> [!NOTE]
> The `KnowledgebaseName` property of the DQS Cleansing component is not dynamic and is not configurable with the typical SSIS configurations, expressions, variables, or environments. This is a design limitation in SQL Server 2012 and SQL Server 2014.

## Workaround

To work around this problem, follow these steps:

1. Change the DQS server name, or deploy the SSIS package to a different server environment.
2. Open the Integration Services Package in the SQL Server Data Tools designer.
3. Locate the affected data flow task.
4. Double-click the DQS Cleansing component to view the custom editor.
5. Update the KB that is listed in the **Data Quality Knowledge Base**  drop-down list.
6. Click **OK**, and then save the package.

To avoid this problem, you should make sure that you point to the same DQS instance even when you deploy SSIS packages between various servers. Therefore, during SSIS development and before deployment to a production system, you may want to adjust the server names in the connection manager and then perform this workaround.

> [!NOTE]
> Although you can manually edit the XML tags in an SSIS package design, we do not support doing this. You may do this at your own risk by viewing the code of the *.dtsx* file in a text editor, locating the appropriate XML tag, and then adjusting the `KnowledgeBaseName` property to correct the number. To determine the possible number, run the following query to review the ID column for each matching KB name:

```sql
SELECT ID from [DQS_MAIN].[dbo].[A_KNOWLEDGEBASE] where Name like '%KBName%'
```
