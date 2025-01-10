---
title: AssemblyBinder role instance is stuck between Busy and Restarting state
description: Provides information about troubleshoot issues in which AssemblyBinder role instance of Compressor application is stuck between Busy and Restarting state and throwing System.IO.IOException exception.
ms.date: 09/26/2022
ms.reviewer: 
author: genlin
ms.author: genli
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# AssemblyBinder role instance is throwing System.IO.IOException exception

This article provides information about troubleshoot issues in which **AssemblyBinder** role instance of Compressor application is stuck between Busy and Restarting state and throwing System.IO.IOException exception stating: There is not enough space on the disk.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464907

> [!NOTE]
> Refer to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the second scenario of the lab. Make sure you have followed the lab setup instructions for **Compressor** application as per [this](https://github.com/prchanda/compressor), to recreate the problem.

## Symptoms

**AssemblyBinder** role instance of Compressor application is throwing the below unhandled exception in the Azure portal blade and stuck between Busy and Restarting state.

```output
Unhandled Exception: There is not enough space on the disk. at System.IO.__Error.WinIOError  (Int32 errorCode, String maybeFullPath) at System.IO.FileStream.WriteCore(Byte[] buffer, Int32 offset, Int32 count) at Ionic.Zip.ZipEntry.ExtractAndCrc(Stream archiveStream, Stream targetOutput, Int16 compressionMethod, Int64 compressedFileDataSize, Int64 uncompressedSize) at Ionic.Zip.ZipEntry.ExtractToStream(Stream archiveStream, Stream output, EncryptionAlgorithm encryptionAlgorithm, Int32 expectedCrc32) at Ionic.Zip.ZipEntry.InternalExtractToBaseDir(String baseDir, String password, ZipContainer zipContainer, ZipEntrySource zipEntrySource, String fileName) at Ionic.Zip.ZipFile._InternalExtractAll(String path, Boolean overrideExtractExistingProperty) at AssemblyBinder.WorkerRole.OnStart() in D:\compressor\AssemblyBinder\WorkerRole.cs:line 56 at Microsoft.WindowsAzure.ServiceRuntime.RoleEnvironment.InitializeRoleInternal(RoleType roleTypeEnum) at Microsoft.WindowsAzure.ServiceRuntime.Implementation.Loader.RoleRuntimeBridge. <InitializeRole> b__0() at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx) at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx) at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state) at System.Threading.ThreadHelper.ThreadStart()'[2018-08-12T14:47:25Z] Last exit time: [2018/08/12, 14:47:25.965].
```

## Troubleshoot steps

From the error call stack, it looks like this WorkerRole is performing some unzip or extract operation at **OnStart()** method but it is failing due to insufficient storage. The next obvious question that will come to your mind is where exactly **WaWorkerHost.exe** process is extracting the file.

In order to find out the answer, use [Process Monitor](/sysinternals/downloads/procmon) tool to take a ProcMon trace and see what you can find.

:::image type="content" source="media/scenario-2-assemblybinder-role-instance-stuck-busy-restart/process-monitor-tool.png" alt-text="Screenshot of ProcMon trace in Process Monitor.":::

**WaWorkerHost.exe** process is writing some file in its default temporary directory, which has a maximum size of 100 MB, which may become full at some point. Upon navigating to the **RoleTemp** directory, you might find that disk space quota is indeed getting exhausted for that directory.

:::image type="content" source="media/scenario-2-assemblybinder-role-instance-stuck-busy-restart/roletemp-directory.png" alt-text="Screenshot of the RoleTemp directory.":::

You might have figured out the cause of the problem, but what should you do when running out of space in **RoleTemp** location? [Here](/azure/cloud-services/cloud-services-troubleshoot-default-temp-folder-size-too-small-web-worker-role) is the answer.

Therefore, you should configure a local storage resource, and point the TEMP and TMP directories to the path of the local storage resource like below:

The local resource declaration must have been added to the service definition file for AssemblyBinder role.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<LocalResources>
   <LocalStorage name="FileStorage" cleanOnRoleRecycle="true" sizeInMB="200" />
</LocalResources>
```

This modification should be performed within the [RoleEntryPoint.OnStart](/previous-versions/azure/reference/ee772851(v=azure.100)?redirectedfrom=MSDN) method.

```xml
localResource = RoleEnvironment.GetLocalResource("FileStorage");
Environment.SetEnvironmentVariable("TMP", localResource.RootPath);
Environment.SetEnvironmentVariable("TEMP", localResource.RootPath);
```

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
