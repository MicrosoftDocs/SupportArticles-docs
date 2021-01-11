---
title: Call into PipelineObjects fails
description: When you make a call into the PipelineObjects assembly from your own application, it may fail with an exception.
ms.date: 03/18/2020
ms.prod-support-area-path: ESB Toolkit
---
# Call into PipelineObjects fails with exception

This article provides a solution for the failure when you make a call into the `PipelineObjects` from your application.

_Original product version:_ &nbsp; BizTalk Server 2013, 2010  
_Original KB number:_ &nbsp; 2888774

## Symptoms

When you make a call into the `PipelineObjects` assembly from your own application, it may fail with an error like the following:

> System.Reflection.TargetInvocationException was unhandled  
> HResult=-2146232828  
> Message=Exception has been thrown by the target of an invocation.  
> Source=mscorlib  
> StackTrace:  
> at System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck, Boolean& canBeCached,   
> RuntimeMethodHandleInternal& ctor, Boolean& bNeedSecurityCheck)  
> at System.RuntimeType.CreateInstanceSlow(Boolean publicOnly, Boolean skipCheckThis, Boolean fillCache, StackCrawlMark& stackMark)  
> at System.RuntimeType.CreateInstanceDefaultCtor(Boolean publicOnly, Boolean skipCheckThis, Boolean fillCache, StackCrawlMark& stackMark)  
> at System.Activator.CreateInstance(Type type, Boolean nonPublic)  
> at System.Activator.CreateInstance(Type type)  
> at Microsoft.Test.BizTalk.PipelineObjects.PipelineFactory.CreatePipelineFromType(Type pipelineType)  
> at MyTestApp.Program.Main(String[] args) in C:\MyTestApp\Program.cs:line 9  
> at System.AppDomain._nExecuteAssembly(RuntimeAssembly assembly, String[] args)  
> at System.AppDomain.ExecuteAssembly(String assemblyFile, Evidence assemblySecurity, String[] args)  
> at Microsoft.VisualStudio.HostingProcess.HostProc.RunUsersAssembly()  
> at System.Threading.ThreadHelper.ThreadStart_Context(Object state)  
> at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)  
> at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)  
> at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state)  
> at System.Threading.ThreadHelper.ThreadStart()  
> InnerException: System.InvalidCastException  
> HResult=-2147467262  
> Message=Unable to cast COM object of type 'System.__ComObject' to interface type 'Microsoft.BizTalk.Component.Interop.IComponentTypeInfo'. This operation failed because the QueryInterface call on the COM component for the interface with IID '{custom IID}' failed due to the following error: No such interface supported (Exception from HRESULT: 0x80004002 (E_NOINTERFACE)).  
> Source=Microsoft.BizTalk.Pipeline  
> StackTrace:  
> at Microsoft.BizTalk.PipelineOM.Pipeline.AddComponent(Stage stage, IBaseComponent realComponent)  
>at MyPipeline.MySendPipeline..ctor()  

## Cause

`PipelineObjects.dll` requires the Microsoft .NET Framework runtime activation policy to be used by the application calling it.

## Resolution

Modify the *app.config* for the executable calling `PipelineObjects` to include the following `<startup>` element:

```xml
<configuration>
    <startup useLegacyV2RuntimeActivationPolicy="true">
        <supportedRuntime version="v4.0" />
    </startup>
</configuration>
```

## More information

`PipelineObjects.dll` is a tool that is provided with the BizTalk Software Development Kit (SDK) and is located in the `SDK\Utilities\PipelineTools` folder.

For more information about the `<startup>` element, see
[\<startup> element](/dotnet/framework/configure-apps/file-schema/startup/startup-element).
