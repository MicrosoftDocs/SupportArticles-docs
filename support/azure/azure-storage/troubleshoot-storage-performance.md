---
title: Troubleshoot performance issues in Azure storage accounts
description: Identifies and troubleshoots performance issues in Azure storage accounts.
ms.reviewer: normesta, azurestocic, jarrettr, v-weizhu
ms.date: 04/12/2023
ms.service: azure-storage
---

# Troubleshoot performance in Azure storage accounts

This article helps you investigate unexpected changes in behavior (such as slower-than-usual response times). These changes in behavior can often be identified by monitoring storage metrics in Azure Monitor. For general information about using metrics and logs in Azure Monitor, see the following articles:

- [Monitoring Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)
- [Monitoring Azure Files](/azure/storage/files/storage-files-monitoring)
- [Monitoring Azure Queue Storage](/azure/storage/queues/monitor-queue-storage)
- [Monitoring Azure Table storage](/azure/storage/tables/monitor-table-storage)

## Monitoring performance

To monitor the performance of the storage services, you can use the following metrics:

- The **SuccessE2ELatency** and **SuccessServerLatency** metrics show the average time the storage service or API operation type is taking to process requests. **SuccessE2ELatency** is a measure of end-to-end latency that includes the time taken to read the request and send the response in addition to the time taken to process the request (therefore, it includes network latency once the request reaches the storage service). **SuccessServerLatency** is a measure of just the processing time and therefore excludes any network latency related to communicating with the client.

- The **Egress** and **Ingress** metrics show the total amount of data, in bytes, coming in to and going out of your storage service or through a specific API operation type.

- The **Transactions** metric shows the total number of requests that the storage service of API operation is receiving. **Transactions** is the total number of requests the storage service receives.

You can monitor for unexpected changes in any of these values. These changes could indicate an issue that requires further investigation.

In the [Azure portal](https://portal.azure.com), you can add alert rules that notify you when any of the performance metrics for this service fall below or exceed a threshold that you specify.

## Diagnose performance issues

The performance of an application can be subjective, especially from a user perspective. Therefore, it's important to have baseline metrics available to help you identify where there might be a performance issue. Many factors might affect the performance of an Azure storage service from the client application perspective. These factors might operate in the storage service, the client, or the network infrastructure. Therefore, it's important to have a strategy for identifying the origin of the performance issue.

After you've identified the likely location of the cause of the performance issue from the metrics, you can then use the log files to find detailed information to diagnose and troubleshoot the problem further.

## Metrics show high SuccessE2ELatency and low SuccessServerLatency

In some cases, you might find that **SuccessE2ELatency** is higher than the **SuccessServerLatency**. The storage service only calculates the metric **SuccessE2ELatency** for successful requests and, unlike **SuccessServerLatency**, includes the time the client takes to send the data and receive acknowledgment from the storage service. Therefore, a difference between **SuccessE2ELatency** and **SuccessServerLatency** could be either due to the client application being slow to respond or due to conditions on the network.

> [!NOTE]
> You can also view **E2ELatency** and **ServerLatency** for individual storage operations in the Storage Logging log data.

### Investigating client performance issues

Possible reasons for the client responding slowly include having limited available connections or threads or being low on resources such as CPU, memory, or network bandwidth. You may be able to resolve the issue by modifying the client code to be more efficient (for example, by using asynchronous calls to the storage service) or by using a larger Virtual Machine with more cores and more memory.

For the table and queue services, the Nagle algorithm can also cause high **SuccessE2ELatency** compared to **SuccessServerLatency**. For more information, see the post [Nagle's Algorithm is Not Friendly towards Small Requests](/archive/blogs/windowsazurestorage/nagles-algorithm-is-not-friendly-towards-small-requests). You can disable the Nagle algorithm in code by using the `ServicePointManager` class in the `System.Net` namespace. You should do this before you make any calls to the table or queue services in your application since this doesn't affect connections that are already open. The following example comes from the `Application_Start` method in a worker role:

```csharp
var connectionString = Constants.connectionString;
QueueServiceClient queueServiceClient = new QueueServiceClient(connectionString);
ServicePoint queueServicePoint = ServicePointManager.FindServicePoint(queueServiceClient.Uri);
queueServicePoint.UseNagleAlgorithm = false;
```

You should check the client-side logs to see how many requests your client application is submitting and check for general .NET related performance bottlenecks in your client, such as CPU, .NET garbage collection, network utilization, or memory. As a starting point for troubleshooting .NET client applications, see [Debugging, Tracing, and Profiling](/dotnet/framework/debug-trace-profile/).

### Investigating network latency issues

Typically, high end-to-end latency caused by the network is due to transient conditions. You can investigate both transient and persistent network issues, such as dropped packets, by using tools like Wireshark.

## Metrics show low SuccessE2ELatency and low SuccessServerLatency but the client is experiencing high latency

In this scenario, the most likely cause is a delay in the storage request reaching the storage service. You should investigate why requests from the client aren't making it through to the blob service.

One possible reason for the client delaying sending requests is that there are a limited number of available connections or threads.

Also, check whether the client is performing multiple retries, and investigate the reason if it is. To determine whether the client is performing multiple retries, you can:

- Examine logs. If multiple retries are happening, you'll see multiple operations with the same client request IDs.

- Examine the client logs. Verbose logging will indicate that a retry has occurred.

- Debug your code, and check the properties of the `OperationContext` object associated with the request. If the operation has retried, the `RequestResults` property will include multiple unique requests. You can also check the start and end times for each request.

If there are no issues in the client, you should investigate potential network issues such as packet loss. You can use tools such as Wireshark to investigate network issues.

## Metrics show high SuccessServerLatency

In the case of high **SuccessServerLatency** for blob download requests, you should use the Storage logs to see if there are repeated requests for the same blob (or set of blobs). For blob upload requests, you should investigate what block size the client is using (for example, blocks less than 64 K in size can result in overheads unless the reads are also in less than 64 K chunks) and if multiple clients are uploading blocks to the same blob in parallel. You should also check the per-minute metrics for spikes in the number of requests that result in exceeding the per-second scalability targets.

If you see high **SuccessServerLatency** for blob download requests when there are repeated requests for the same blob or set of blobs, consider caching these blobs using Azure Cache or the Azure Content Delivery Network (CDN). For upload requests, you can improve the throughput by using a larger block size. For queries to tables, it's also possible to implement client-side caching on clients that perform the same query operations and where the data doesn't change frequently.

High **SuccessServerLatency** values can also be a symptom of poorly designed tables or queries that result in scan operations or that follow the append/prepend anti-pattern.

> [!NOTE]
> You can find a comprehensive performance checklist from [Microsoft Azure Storage Performance and Scalability Checklist](/azure/storage/blobs/storage-performance-checklist).

## You're experiencing unexpected delays in message delivery on a queue

If you're experiencing a delay between the time an application adds a message to a queue and the time it becomes available to read from the queue, then take the following steps to diagnose the issue:

- Verify that the application is successfully adding the messages to the queue. Check that the application is not retrying the `AddMessage` method several times before succeeding.

- Verify there is no clock skew between the worker role that adds the message to the queue and the worker role that reads the message from the queue. A clock skew makes it appear as if there is a delay in processing.

- Check if the worker role that reads the messages from the queue is failing. If a queue client calls the `GetMessage` method but fails to respond with an acknowledgment, the message will remain invisible on the queue until the `invisibilityTimeout` period expires. At this point, the message becomes available for processing again.

- Check if the queue length is growing over time. This can occur if you don't have sufficient workers available to process all of the messages that other workers are placing in the queue. Also, check the metrics to see if delete requests are failing and the dequeue count on messages, which might indicate repeated failed attempts to delete the message.

- Examine the Storage logs for any queue operations that have higher than expected **E2ELatency** and **ServerLatency** values over a longer period of time than usual.

## See also

- [Troubleshoot client application errors](troubleshoot-storage-client-application-errors.md)
- [Troubleshoot availability issues](troubleshoot-storage-availability.md)
- [Monitor, diagnose, and troubleshoot your Azure Storage](/training/modules/monitor-diagnose-and-troubleshoot-azure-storage/)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]