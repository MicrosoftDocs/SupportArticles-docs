---
title: Troubleshoot Dataverse plug-ins
description: Contains information about errors that can occur during plug-in execution, or Dataverse errors that are related to plug-ins, and how to avoid or fix them.
ms.date: 02/07/2024
author: divkamath
ms.author: dikamath
ms.reviewer: phecke
manager: kvivek
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - JimDaly
  - phecke
---
# Troubleshoot Dataverse plug-ins

This article contains information about errors that can occur during plug-in execution, or Dataverse errors that are related to plug-ins, and how to avoid or fix them.

## Error "Time conversion couldn't be completed"

> Error Code: -2147220956  
> Error Message: The conversion could not be completed because the supplied DataTime did not have the Kind property set correctly. For example, when the Kind property is DateTimeKind.Local, the source time zone must be TimeZoneInfo.Local.

This error can occur during a <xref:System.TimeZoneInfo.ConvertTimeToUtc(System.DateTime,System.TimeZoneInfo)?displayProperty=nameWithType> call in the plug-in code to convert a `DateTime` value in the Santiago or Volgograd time zone to Coordinated Universal Time (UTC).

This error is caused by a known product limitation, and there's presently no workaround.

For more information, see [Specify time zone settings for a user](/power-apps/developer/data-platform/specify-time-zone-settings-user).

## Error "Sandbox Worker process crashed"

> Error Code: -2147204723  
> Error Message: The plug-in execution failed because the Sandbox Worker process crashed. This is typically due to an error in the plug-in code.

This error simply means that the worker process running your plug-in code crashed. Your plug-in might be the reason for the crash, but it could also be another plug-in running concurrently for your organization. Because the process crashed, we can't extract any more specific information about why it crashed. But after examining data from the crash dumps after the fact, we found that this error usually occurs due to one of the four reasons:

- [Unhandled exception in the plug-in](#unhandled-exception-in-the-plug-in)
- [Stack Overflow error in the plug-in](#stack-overflow-error-in-the-plug-in)
- [Using threads to queue work with no try/catch in thread delegate](#using-threads-to-queue-work-with-no-trycatch-in-thread-delegate)
- [Worker process reaches the memory limit](#worker-process-reaches-the-memory-limit)

### Unhandled exception in the plug-in

When you write a plug-in, you should try to anticipate which operations might fail and wrap them in a try-catch block. When an error occurs, you should use the <xref:Microsoft.Xrm.Sdk.InvalidPluginExecutionException> class to gracefully terminate the operation with an error meaningful to the user.

For more information, see [Handle exceptions in plug-ins](/power-apps/developer/data-platform/handle-exceptions).

A common scenario for this exception is when using the [HttpClient.SendAsync](xref:System.Net.Http.HttpClient.SendAsync%2A) or [HttpClient.GetAsync](xref:System.Net.Http.HttpClient.GetAsync%2A) method. These [HttpClient](xref:System.Net.Http.HttpClient) methods are asynchronous operations that return a [Task](xref:System.Threading.Tasks.Task). To work in a plug-in where code needs to be synchronous, people might use the [Task&lt;TResult&gt;.Result](xref:System.Threading.Tasks.Task%601.Result) property. When an error occurs, `Result` returns an [AggregateException](xref:System.AggregateException). An `AggregateException` consolidates multiple failures into a single exception, which can be difficult to handle. A better design is to use [Task&lt;TResult&gt;.GetAwaiter()](xref:System.Threading.Tasks.Task.GetAwaiter).[GetResult()](xref:System.Runtime.CompilerServices.TaskAwaiter.GetResult) because it propagates the results as the specific error that caused the failure.

The following example shows the correct way to manage the exception and an outbound call using the [HttpClient.GetAsync](xref:System.Net.Http.HttpClient.GetAsync%2A) method. This plug-in attempts to get the response text for a Uri set in the unsecure config for a step registered for it.

```csharp
using Microsoft.Xrm.Sdk;
using System;
using System.Net.Http;

namespace ErrorRepro
{
    public class AsyncError : IPlugin
    {
        private readonly string webAddress;

        public AsyncError(string unsecureConfig)
        {
            if (string.IsNullOrEmpty(unsecureConfig)) {
                throw new InvalidPluginExecutionException("The ErrorRepro.AsyncError plug-in requires that a Url be set in the unsecure configuration for the step registration.");
            }
            webAddress = unsecureConfig;

        }

        public void Execute(IServiceProvider serviceProvider)
        {
            ITracingService tracingService =
            (ITracingService)serviceProvider.GetService(typeof(ITracingService));

            tracingService.Trace($"Starting ErrorRepro.AsyncError");
            tracingService.Trace($"Sending web request to {webAddress}");

            try
            {
                string responseText = GetWebResponse(webAddress, tracingService);
                tracingService.Trace($"Result: {responseText.Substring(0, 100)}");
            }
            catch (Exception ex)
            {
                tracingService.Trace($"Error: ErrorRepro.AsyncError {ex.Message}");
                throw new InvalidPluginExecutionException(ex.Message);
            }
            tracingService.Trace($"Ending ErrorRepro.AsyncError");
        }

        //Gets the text response of an outbound web service call
        public string GetWebResponse(string webAddress, ITracingService tracingService)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromMilliseconds(15000); //15 seconds
                    client.DefaultRequestHeaders.ConnectionClose = true; //Set KeepAlive to false

                    HttpResponseMessage response = client.GetAsync(webAddress).GetAwaiter().GetResult(); //Make sure it is synchronous
                    response.EnsureSuccessStatusCode();

                    tracingService.Trace($"ErrorRepro.AsyncError.GetWebResponse succeeded.");

                    string responseContent = response.Content.ReadAsStringAsync().GetAwaiter().GetResult(); //Make sure it is synchronous

                    tracingService.Trace($"ErrorRepro.AsyncError.GetWebResponse responseContent parsed successfully.");

                    return responseContent;

                }
            }
            catch (Exception ex)
            {
                //Capture the inner exception message if it exists.
                // It should have a more specific detail.
                string innerExceptionMessage = string.Empty;
                if (ex.InnerException != null) {
                    innerExceptionMessage = ex.InnerException.Message;
                }

                tracingService.Trace($"Error in ErrorRepro.AsyncError : {ex.Message} InnerException: {innerExceptionMessage}");
                if (!string.IsNullOrEmpty(innerExceptionMessage))
                {
                    throw new Exception($"A call to an external web service failed. {innerExceptionMessage}", ex);
                }

                throw new Exception("A call to an external web service failed.", ex);
            }
        }
    }
}
```

### Stack overflow error in the plug-in

This type of error occurs most frequently right after you make some changes in your plug-in code. Some people use their own set of base classes to streamline their development experience. Sometimes these errors originate from changes to those base classes that a particular plug-in depends on.

For example, a recursive call without a termination condition, or a termination condition, which doesn't cover all scenarios, can cause this error to occur. For more information, see [StackOverflowException Class > Remarks](xref:System.StackOverflowException#remarks).

You should review any code changes that were applied recently for the plug-in and any other code that the plug-in code depends on.

#### Example

The following plug-in code causes a `StackOverflowException` due to a recursive call with no limits. Despite the use of the tracing and attempting to capture the error, the tracing and the error aren't returned because the worker process that would process them terminated.

```csharp
using Microsoft.Xrm.Sdk;
using System;

namespace ErrorRepro
{
    public class SOError : IPlugin
    {
        public void Execute(IServiceProvider serviceProvider)
        {
            ITracingService tracingService =
           (ITracingService)serviceProvider.GetService(typeof(ITracingService));

            tracingService.Trace($"Starting ErrorRepro.SOError");

            try
            {
                tracingService.Trace($"Calling RecursiveMethodWithNoLimit to trigger StackOverflow error.");

                RecursiveMethodWithNoLimit(tracingService); //StackOverflowException occurs here.
            }
            catch (Exception ex)
            {
                //This trace will not be written
                tracingService.Trace($"Error in ErrorRepro.SOError {ex.Message}");

                //This error will never be thrown
                throw new InvalidPluginExecutionException($"Error in ErrorRepro.SOError. {ex.Message}");
            }

            //This trace will never be written
            tracingService.Trace($"Ending ErrorRepro.SOError");
        }

        public static void RecursiveMethodWithNoLimit(ITracingService tracingService)
        {
            tracingService.Trace($"Starting ErrorRepro.SOError.RecursiveMethodWithNoLimit");

            RecursiveMethodWithNoLimit(tracingService);

            tracingService.Trace($"Ending ErrorRepro.SOError.RecursiveMethodWithNoLimit");
        }
    }
}
```

In a synchronous plug-in step, the plug-in code previously shown returns the following error in the Web API when the request is configured to [include additional details with errors](/power-apps/developer/data-platform/webapi/compose-http-requests-handle-errors#include-additional-details-with-errors).

```json
{
    "error": {
        "code": "0x8004418d",
        "message": "The plug-in execution failed because the Sandbox Worker process crashed. This is typically due to an error in the plug-in code.\r\nSystem.ServiceModel.CommunicationException: The server did not provide a meaningful reply; this might be caused by a contract mismatch, a premature session shutdown or an internal server error.\r\n   at Microsoft.Crm.Sandbox.SandboxWorkerProcess.Execute(SandboxCallInfo callInfo, SandboxPluginExecutionContext requestContext, Guid pluginAssemblyId, Int32 sourceHash, String assemblyName, Guid pluginTypeId, String pluginTypeName, String pluginConfiguration, String pluginSecureConfig, Boolean returnTraceInfo, Int64& wcfExecInMs, Int64& initializeInMs, Int64& trackCallInMs, Int64& trackGoodReturnInMs, Int64& waitInMs, Int64& taskStartDelay) +0x330: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #8503641A",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiExceptionSourceKey": "Plugin/ErrorRepro.SOError, ErrorRepro, Version=1.0.0.0, Culture=neutral, PublicKeyToken=c2bee3e550ec0851",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiStepKey": "d5958631-b87e-eb11-a812-000d3a4f50a7",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiDepthKey": "1",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiActivityIdKey": "a3028bda-73c2-4eef-bcb5-157c5a4c323e",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiPluginSolutionNameKey": "Active",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiStepSolutionNameKey": "Active",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiExceptionCategory": "SystemFailure",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiExceptionMesageName": "SandboxWorkerNotAvailable",
        "@Microsoft.PowerApps.CDS.ErrorDetails.ApiExceptionHttpStatusCode": "500",
        "@Microsoft.PowerApps.CDS.HelpLink": "http://go.microsoft.com/fwlink/?LinkID=398563&error=Microsoft.Crm.CrmException%3a8004418d&client=platform",
        "@Microsoft.PowerApps.CDS.TraceText": "\r\n[ErrorRepro: ErrorRepro.SOError]\r\n[d5958631-b87e-eb11-a812-000d3a4f50a7: ErrorRepro.SOError: Create of account]\r\n\r\n",
        "@Microsoft.PowerApps.CDS.InnerError.Message": "The plug-in execution failed because the Sandbox Worker process crashed. This is typically due to an error in the plug-in code.\r\nSystem.ServiceModel.CommunicationException: The server did not provide a meaningful reply; this might be caused by a contract mismatch, a premature session shutdown or an internal server error.\r\n   at Microsoft.Crm.Sandbox.SandboxWorkerProcess.Execute(SandboxCallInfo callInfo, SandboxPluginExecutionContext requestContext, Guid pluginAssemblyId, Int32 sourceHash, String assemblyName, Guid pluginTypeId, String pluginTypeName, String pluginConfiguration, String pluginSecureConfig, Boolean returnTraceInfo, Int64& wcfExecInMs, Int64& initializeInMs, Int64& trackCallInMs, Int64& trackGoodReturnInMs, Int64& waitInMs, Int64& taskStartDelay) +0x330: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #8503641A"
    }
}
```

The following shows how this error is recorded in the plug-in Tracelog:

```console
Unhandled exception: 
Exception type: System.ServiceModel.FaultException`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]
Message: The plug-in execution failed because the Sandbox Worker process crashed. This is typically due to an error in the plug-in code.
System.ServiceModel.CommunicationException: The server did not provide a meaningful reply; this might be caused by a contract mismatch, a premature session shutdown or an internal server error.
   at Microsoft.Crm.Sandbox.SandboxWorkerProcess.Execute(SandboxCallInfo callInfo, SandboxPluginExecutionContext requestContext, Guid pluginAssemblyId, Int32 sourceHash, String assemblyName, Guid pluginTypeId, String pluginTypeName, String pluginConfiguration, String pluginSecureConfig, Boolean returnTraceInfo, Int64& wcfExecInMs, Int64& initializeInMs, Int64& trackCallInMs, Int64& trackGoodReturnInMs, Int64& waitInMs, Int64& taskStartDelay) +0x330: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #4BC22433Detail: 
<OrganizationServiceFault xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.microsoft.com/xrm/2011/Contracts">
  <ActivityId>48c5818e-4912-42f0-b1b6-e3bbe7ae013d</ActivityId>
  <ErrorCode>-2147204723</ErrorCode>
  <ErrorDetails xmlns:d2p1="http://schemas.datacontract.org/2004/07/System.Collections.Generic" />
  <HelpLink i:nil="true" />
  <Message>The plug-in execution failed because the Sandbox Worker process crashed. This is typically due to an error in the plug-in code.
System.ServiceModel.CommunicationException: The server did not provide a meaningful reply; this might be caused by a contract mismatch, a premature session shutdown or an internal server error.
   at Microsoft.Crm.Sandbox.SandboxWorkerProcess.Execute(SandboxCallInfo callInfo, SandboxPluginExecutionContext requestContext, Guid pluginAssemblyId, Int32 sourceHash, String assemblyName, Guid pluginTypeId, String pluginTypeName, String pluginConfiguration, String pluginSecureConfig, Boolean returnTraceInfo, Int64&amp; wcfExecInMs, Int64&amp; initializeInMs, Int64&amp; trackCallInMs, Int64&amp; trackGoodReturnInMs, Int64&amp; waitInMs, Int64&amp; taskStartDelay) +0x330: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #4BC22433</Message>
  <Timestamp>2021-03-06T22:14:22.0629638Z</Timestamp>
  <ExceptionRetriable>false</ExceptionRetriable>
  <ExceptionSource>WorkerCommunication</ExceptionSource>
  <InnerFault i:nil="true" />
  <OriginalException>System.ServiceModel.CommunicationException: The server did not provide a meaningful reply; this might be caused by a contract mismatch, a premature session shutdown or an internal server error.

Server stack trace: 
   at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)
   at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)
   at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)

Exception rethrown at [0]: 
   at Microsoft.Crm.Sandbox.SandboxWorkerProcess.Execute(SandboxCallInfo callInfo, SandboxPluginExecutionContext requestContext, Guid pluginAssemblyId, Int32 sourceHash, String assemblyName, Guid pluginTypeId, String pluginTypeName, String pluginConfiguration, String pluginSecureConfig, Boolean returnTraceInfo, Int64&amp; wcfExecInMs, Int64&amp; initializeInMs, Int64&amp; trackCallInMs, Int64&amp; trackGoodReturnInMs, Int64&amp; waitInMs, Int64&amp; taskStartDelay)</OriginalException>
  <TraceText i:nil="true" />
</OrganizationServiceFault>
```

### Using threads to queue work with no try/catch in thread delegate

You shouldn't use parallel execution patterns in plug-ins. This anti-pattern is called out in the best practice article: [Don't use parallel execution within plug-ins and workflow activities](/power-apps/developer/data-platform/best-practices/business-logic/do-not-use-parallel-execution-in-plug-ins). Using these patterns can cause issues managing the transaction in a synchronous plug-in. However, another reason not to use these patterns is that any work done outside of a `try`/`catch` block in a thread delegate can crash the worker process.

### Worker process reaches the memory limit

Each worker process has a finite amount of memory. There are conditions where multiple concurrent operations that include large amounts of data could exceed the available memory and cause the process worker to crash.

#### RetrieveMultiple with File data

The common scenario, in this case, is when a plug-in executes for a `RetrieveMultiple` operation where the request includes file data. For example, when retrieving emails that include any file attachments. The amount of data that might be returned in a query like this is unpredictable because any email might be related to any number of file attachments, and the attachments can vary in size.

When multiple requests of a similar nature are running concurrently, the amount of memory required becomes large. If the amount of memory exceeds the limit, the process crashes. The key to preventing this situation is limiting `RetrieveMultiple` queries that include entities with related file attachments. Retrieve the records using `RetrieveMultiple`, but retrieve any related files as needed using individual `Retrieve` operations.

#### Memory Leaks

A less common scenario is where the code in the plug-in is leaking memory. This situation can occur when the plug-in isn't written as stateless, which is another best practice. For more information, see [Develop Plugin implementations as stateless](/power-apps/developer/data-platform/best-practices/business-logic/develop-iplugin-implementations-stateless). When the plug-in isn't stateless, and there's an attempt to continually add data to a stateful property like an array, the amount of data grows to the point where it uses all the available memory.

## Transaction errors

There are two common types of errors related to transactions:

> Error Code: -2146893812  
> Error Message: ISV code reduced the open transaction count. Custom plug-ins should not catch exceptions from OrganizationService calls and continue processing.

> Error Code: -2147220911  
> Error Message: There is no active transaction. This error is usually caused by custom plug-ins that ignore errors from service calls and continue processing.

> [!NOTE]
> The top error was added most recently. It should occur immediately and in the context of the plug-in that contains the problem. The bottom error can still occur in different circumstances, typically involving custom workflow activities. It might be due to problems in another plug-in.

Anytime an error related to a data operation occurs within a synchronous plug-in, the transaction for the entire operation is ended.

For more information, see [Scalable Customization Design in Microsoft Dataverse](/power-apps/developer/data-platform/scalable-customization-design/overview).

A common cause is that a developer believes they can attempt to perform an operation that *might* succeed, so they wrap that operation in a `try`/`catch` block and attempt to swallow the error when it fails.

While this pattern might work for a client application, within the execution of a plug-in, any data operation failure results in rolling back the entire transaction. You can't swallow the error, so you must make sure to always return an <xref:Microsoft.Xrm.Sdk.InvalidPluginExecutionException>.

## Error "Sql error: Execution Timeout Expired"

> Error Code: -2147204783  
> Error Message: Sql error: 'Execution Timeout Expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.'

### Cause

There are a wide variety of reasons why a SQL timeout error might occur. Three of them are described here:

- [Blocking](#blocking)
- [Cascade operations](#cascade-operations)
- [Indexes on new tables](#indexes-on-new-tables)

#### Blocking

The most common cause for a SQL timeout error is that the operation is waiting for resources blocked by another SQL transaction. The error is the result of Dataverse protecting the integrity of the data and from long-running requests that impact performance for users.

Blocking might be due to other concurrent operations. Your code might work fine in isolation in a test environment and still be susceptible to conditions that only occur when multiple users are initiating the logic in your plug-in.

When writing plug-ins, it's essential to understand how to design customizations that are scalable. For more information, see [Scalable Customization Design in Dataverse](/power-apps/developer/data-platform/scalable-customization-design/overview).

#### Cascade operations

Certain actions you make in your plug-in, such as assigning or deleting a record, can initiate cascading operations on related records. These actions could apply locks on related records causing subsequent data operations to be blocked, which in turn can lead to a SQL timeout.

You should consider the possible impact of these cascading operations on data operations in your plug-in. For more information, see [Table relationship behavior](/power-apps/maker/data-platform/create-edit-entity-relationships#table-relationship-behavior).

Because these behaviors can be configured differently between environments, the behavior might be difficult to reproduce unless the environments are configured in the same way.

#### Indexes on new tables

If the plug-in is performing operations using a table or column that was created recently, some Azure SQL capabilities to manage indexes might make a difference after a few days.

## Errors due to user privileges

In a client application, you can disable commands that users aren't allowed to perform. Within a plug-in, you don't have this ability. Your code might include some automation that the calling user doesn't have the privileges to perform.

You can register the plug-in to run in the context of a user known to have the correct privileges by setting the **Run in User's Context** value to that user. Or you can execute the operation by impersonating another user. For more information, see:

- [Register a plug-in](/power-apps/developer/data-platform/register-plug-in)
- [Impersonate a user](/power-apps/developer/data-platform/impersonate-a-user)

## Error when executing in the context of a disabled user

When a plug-in executes in the context of a disabled user, the following error is returned:

> Error Message: System.ServiceModel.FaultException`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]: The user with **SystemUserId=\<User-ID\>** in OrganizationContext=\<Context\> is disabled. Disabled users cannot access the system. Consider enabling this user. Also, users are disabled if they don't have a license assigned to them.

To fix the error, run a query to identify the steps linked to the disabled user, and get details about the related plug-in and `SdkMessage`.

```http
https://<env-url>/api/data/v9.2/sdkmessageprocessingsteps
?$filter=_impersonatinguserid_value eq '<disabled-userId-from-error>'&
$expand=plugintypeid($select=name,friendlyname,assemblyname;
$expand=pluginassemblyid($select=solutionid,name,isolationmode)),sdkmessageid($select=solutionid,name)&
$select=solutionid,name,stage,_impersonatinguserid_value,mode
```

## Error "Message size exceeded when sending context to Sandbox"

> Error Code: -2147220970  
> Error Message: Message size exceeded when sending context to Sandbox. Message size: ### Mb

This error occurs when a message payload is greater than 116.85 MB, and a plug-in is registered for the message. The error message includes the size of the payload that caused this error.

The limit helps ensure that users running applications can't interfere with each other based on resource constraints. The limit helps provide a level of protection from unusually large message payloads that threaten the availability and performance characteristics of the Dataverse platform.

116.85 MB is large enough that it should be rare to encounter this case. The most likely situation where this case might occur is when you retrieve a record with multiple related records that include large binary files.

If you receive this error, you can:

1. Remove the plug-in for the message. If there are no plug-ins registered for the message, the operation completes without an error.
2. If the error is occurring in a custom client, you can modify your code so that it doesn't attempt to perform the work in a single operation. Instead, write code to retrieve the data in smaller parts.

## Error "The given key wasn't present in the dictionary"

Dataverse frequently uses classes derived from the abstract <xref:Microsoft.Xrm.Sdk.DataCollection%602> class that represents a collection of keys and values. For example, with plug-ins, the  <xref:Microsoft.Xrm.Sdk.IExecutionContext>.<xref:Microsoft.Xrm.Sdk.IExecutionContext.InputParameters> property is a <xref:Microsoft.Xrm.Sdk.ParameterCollection> derived from the <xref:Microsoft.Xrm.Sdk.DataCollection%602> class. These classes are essentially dictionary objects where you access a specific value using the key name.

### Error codes

This error occurs when the key value in the code doesn't exist in the collection. The result is a run-time error rather a platform error. When this error occurs within a plug-in, the error code depends on whether the error was caught.

If the developer caught the exception and returned <xref:Microsoft.Xrm.Sdk.InvalidPluginExecutionException>, as described in [Handle exceptions in plug-ins](/power-apps/developer/data-platform/handle-exceptions), the following error is returned:

> Error Code: -2147220891  
> Error Message: ISV code aborted the operation.

However, with this error, it's common that the developer doesn't catch it properly and the following error is returned:

> Error Code: -2147220956  
> Error Message: An unexpected error occurred from ISV code.

> [!NOTE]
> "ISV" stands for *Independent Software Vendor*.

### Cause

This error frequently occurs at design time and can be due to a misspelling or using the incorrect casing. The key values are case-sensitive.

At run-time, the error is frequently due to the developer assuming that the value is present when it isn't. For example, in a plug-in registered for the update of a table, only those values that are changed are included in the <xref:Microsoft.Xrm.Sdk.Entity>.<xref:Microsoft.Xrm.Sdk.Entity.Attributes> collection.

### Resolution

To solve this error, you must check that the key exists before attempting to use it to access a value.

For example, when accessing a table column, you can use the <xref:Microsoft.Xrm.Sdk.Entity>.<xref:Microsoft.Xrm.Sdk.Entity.Contains(System.String)> method to check whether a column exists in a table, as shown in the following code.

```csharp
// Obtain the execution context from the service provider.  
IPluginExecutionContext context = (IPluginExecutionContext)
    serviceProvider.GetService(typeof(IPluginExecutionContext));

// The InputParameters collection contains all the data passed in the message request.  
if (context.InputParameters.Contains("Target") &&
    context.InputParameters["Target"] is Entity)
    {
    // Obtain the target entity from the input parameters.  
    Entity entity = (Entity)context.InputParameters["Target"];

    //Check whether the name attribute exists.
    if(entity.Contains("name"))
    {
        string name = entity["name"];
    }
```

Some developers use the <xref:Microsoft.Xrm.Sdk.Entity>.<xref:Microsoft.Xrm.Sdk.Entity.GetAttributeValue%60%601(System.String)> method to avoid this error when accessing a table column. This method returns the default value of the type if the column doesn't exist. If the default value is null, this method works as expected. But if the default value doesn't return null, such as with a `DateTime`, the value returned is `1/1/0001 00:00` rather than null.

## Error "You can't start a transaction with a different isolation level than is already set on the current transaction"

> Error Code: -2147220989  
> Error Message: You cannot start a transaction with a different isolation level than is already set on the current transaction

Plug-ins are intended to support business logic. Modifying any part of the data schema within a synchronous plug-in isn't supported. These operations frequently take longer and might cause cached metadata used by applications to become out of sync. However, these operations can be performed in a plug-in step registered to run asynchronously.

## Known issue: Activity.RegardingObjectId name value not set with plug-in

The most common symptom of this issue is that the **Regarding** field in an activity record shows `(No Name)` rather than the primary name attribute value.

Within a plug-in, you can set lookup attributes with an [EntityReference](xref:Microsoft.Xrm.Sdk.EntityReference) value. The [EntityReference.Name](xref:Microsoft.Xrm.Sdk.EntityReference.Name) property isn't required. Typically you don't need to include it when setting a lookup attribute value because Dataverse sets it. You should set values like this during the **PreOperation** stage of the event pipeline. For more information, see [Event execution pipeline](/power-apps/developer/data-platform/event-framework#event-execution-pipeline).

The exception to this rule is when setting the [ActivityPointer.RegardingObjectId](/power-apps/developer/data-platform/reference/entities/activitypointer#BKMK_RegardingObjectId) lookup. All the entity types that are derived from `ActivityPointer` inherit this lookup. By default, these include [Appointment](/power-apps/developer/data-platform/reference/entities/appointment), [Chat](/power-apps/developer/data-platform/reference/entities/chat), [Email](/power-apps/developer/data-platform/reference/entities/email), [Fax](/power-apps/developer/data-platform/reference/entities/fax), [Letter](/power-apps/developer/data-platform/reference/entities/letter), [PhoneCall](/power-apps/developer/data-platform/reference/entities/phonecall), [RecurringAppointmentMaster](/power-apps/developer/data-platform/reference/entities/recurringappointmentmaster), and any custom tables that were created as activity types. For more information, see [Activity tables](/power-apps/developer/data-platform/entity-metadata#activity-tables).

If you set this value in the **PreOperation** stage, the name value isn't added by Dataverse. The value is null, and the formatted value that should contain this value isn't present when you retrieve the record.

### Workaround

There are two ways to work around this issue:

1. You can set the [EntityReference.Name](xref:Microsoft.Xrm.Sdk.EntityReference.Name) property value with the correct primary name field value prior to setting the value of the lookup attribute.
1. You can set the lookup value in the **PreValidation** stage rather than **PreOperation** stage.

### More information

- [Use plug-ins to extend business processes](/power-apps/developer/data-platform/plug-ins)
- [Workflow extensions](/power-apps/developer/data-platform/workflow/workflow-extensions)
