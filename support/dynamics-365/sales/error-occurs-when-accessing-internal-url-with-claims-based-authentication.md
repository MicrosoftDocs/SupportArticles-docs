---
title: No user exists with the specified domain name and user ID error when accessing internal URL
description: No Microsoft Dynamics CRM user exists with the specified domain name and user ID. (0x80040354) this error occurs when accessing internal URL with Claims Based Authentication. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# No user exists with the specified domain name and user ID error when accessing internal URL with Claims Based Authentication

This article provides a resolution for the error **No Microsoft Dynamics CRM user exists with the specified domain name and user ID** that occurs when accessing internal URL with Claims Based Authentication.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2809818

## Symptoms

When accessing the internal URL for Microsoft Dynamics CRM 2011 with Claims Based Authentication enabled, a user may be unable to access the Microsoft Dynamics CRM site. If Internet Facing Deployment (IFD) is set up, users may be able to access the Microsoft Dynamics CRM site still using the IFD URL.

If you turn on developer errors in IIS, you may see the following error:

> No Microsoft Dynamics CRM user exists with the specified domain name and user ID. (0x80040354)

In a Microsoft Dynamics CRM platform trace, the following messages may appear:

> The SID that is passed below is for a user other than the user that is actually trying to be authenticated:
>
> [*DateTime*] Process: w3wp |Organization:00000000-0000-0000-0000-000000000000 |Thread: 13 |Category: Platform.Sql |User: 00000000-0000-0000-0000-000000000000 |Level: Verbose |ReqId: *ReqId* | CrmDbConnection.InternalExecuteReader ilOffset = 0x16  
 at CrmDbConnection.InternalExecuteReader(IDbCommand command, Boolean capturePerfTrace) ilOffset = 0x16  
 at CrmDbConnection.ExecuteReader(IDbCommand command, Boolean impersonate, Boolean capturePerfTrace) ilOffset = 0x10  
 at ServerLocatorService.TryGetDefaultUserOrganizationFromDatabase(String authenticationInfo, Guid& organizationId) ilOffset = 0x66  
 at ServerLocatorService.TryGetDefaultOrganization(String authenticationInfo, Guid& orgId) ilOffset = 0x40  
 at ServerLocatorService.GetDefaultOrganization(String authenticationInfo) ilOffset = 0x16  
 at WindowsAuthenticationProvider.QueryForOrganizationId(String userToken) ilOffset = 0xC  
 at WindowsAuthenticationProviderBase.Authenticate(HttpApplication application, WindowsIdentity userIdentity) ilOffset = 0x90  
 at AuthenticationStep.Authenticate(HttpApplication application) ilOffset = 0x31  
 at AuthenticationPipeline.Authenticate(HttpApplication application) ilOffset = 0x11  
 at AuthenticationEngine.Execute(Object sender, EventArgs e) ilOffset = 0x10D  
 at SyncEventExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute() ilOffset = 0x5D  
 at HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously) ilOffset = 0x15  
 at ApplicationStepManager.ResumeSteps(Exception error) ilOffset = 0x10E  
 at HttpApplication.System.Web.IHttpAsyncHandler.BeginProcessRequest(HttpContext context, AsyncCallback cb, Object extraData) ilOffset = 0x5C  
 at HttpRuntime.ProcessRequestInternal(HttpWorkerRequest wr) ilOffset = 0xFC  
 at ISAPIRuntime.ProcessRequest(IntPtr ecb, Int32 iWRType) ilOffset = 0x45  
\>exec p_GetDefaultOrgFromAuthInfo 'W: S-1-5-21-1229272821-1580436667-839522115-500'

> [*DateTime*] Process: w3wp |Organization:00000000-0000-0000-0000-000000000000 |Thread: 15 |Category: Platform |User: 00000000-0000-0000-0000-000000000000 |Level: Verbose |ReqId: *ReqId* | ClaimsIdentityAuthorizationManager.Authenticate ilOffset = 0x1E4  
 at ClaimsIdentityAuthorizationManager.Authenticate(OperationContext operationContext) ilOffset = 0x1E4  
 at ClaimsIdentityAuthorizationManager.CheckAccessCore(OperationContext operationContext) ilOffset = 0xA0  
 at AuthorizationBehavior.Authorize(MessageRpc& rpc) ilOffset = 0x28  
 at ImmutableDispatchRuntime.ProcessMessage11(MessageRpc& rpc) ilOffset = 0x293  
 at MessageRpc.Process(Boolean isOperationContextSet) ilOffset = 0x62  
 at ChannelHandler.DispatchAndReleasePump(RequestContext request, Boolean cleanThread, OperationContext currentOperationContext) ilOffset = 0x1D7  
 at ChannelHandler.HandleRequest(RequestContext request, OperationContext currentOperationContext) ilOffset = 0xF1  
 at ChannelHandler.AsyncMessagePump(IAsyncResult result) ilOffset = 0x21  
 at AsyncThunk.UnhandledExceptionFrame(IAsyncResult result) ilOffset = 0x0  
 at AsyncResult.Complete(Boolean completedSynchronously) ilOffset = 0xC2  
 at ReceiveItemAndVerifySecurityAsyncResult\`2.InnerTryReceiveCompletedCallback(IAsyncResult result) ilOffset = 0x55  
 at AsyncThunk.UnhandledExceptionFrame(IAsyncResult result) ilOffset = 0x0  
 at AsyncResult.Complete(Boolean completedSynchronously) ilOffset = 0xC2  
 at AsyncQueueReader.Set(Item item) ilOffset = 0x21  
 at InputQueue\`1.EnqueueAndDispatch(Item item, Boolean canDispatchOnThisThread) ilOffset = 0xDD  
 at InputQueue\`1.EnqueueAndDispatch(T item, Action dequeuedCallback, Boolean canDispatchOnThisThread) ilOffset = 0x0  
 at SingletonChannelAcceptor\`3.Enqueue(QueueItemType item, Action dequeuedCallback, Boolean canDispatchOnThisThread) ilOffset = 0x35  
 at HttpChannelListener.HttpContextReceived(HttpRequestContext context, Action callback) ilOffset = 0x109  
 at HostedHttpTransportManager.HttpContextReceived(HostedHttpRequestAsyncResult result) ilOffset = 0x52  
 at HostedHttpRequestAsyncResult.HandleRequest() ilOffset = 0x101  
 at HostedHttpRequestAsyncResult.BeginRequest() ilOffset = 0x0  
 at HostedHttpRequestAsyncResult.OnBeginRequest(Object state) ilOffset = 0x9  
 at AspNetPartialTrustHelpers.PartialTrustInvoke(ContextCallback callback, Object state) ilOffset = 0x19  
 at HostedHttpRequestAsyncResult.OnBeginRequestWithFlow(Object state) ilOffset = 0x30  
 at ScheduledOverlapped.IOCallback(UInt32 errorCode, UInt32 numBytes, NativeOverlapped\* nativeOverlapped) ilOffset = 0x22  
 at IOCompletionThunk.UnhandledExceptionFrame(UInt32 error, UInt32 bytesRead, NativeOverlapped\* nativeOverlapped) ilOffset = 0x5  
 at _IOCompletionCallback.PerformIOCompletionCallback(UInt32 errorCode, UInt32 numBytes, NativeOverlapped* pOVERLAP) ilOffset = 0x3C  
\>CrmSessionAuthenticationManager published CrmClaimsIdentity [UserToken:C:admin@contoso.local] [UserId:{*UserId*}].

## Cause

Physical path credentials are specified in IIS. These credentials should not be in place as this will overwrite the kerberos authentication that is taking place.

## Resolution

To fix this issue, follow these steps:

1. Go to Start, point to **Administrative Tools**, open **Internet Information Services (IIS) Manager**.
2. Expand the Server and then expand Sites.
3. Right-click on the Microsoft Dynamics CRM site and select **Manage Website** and select **Advanced Settings**.
4. In the window that appears, find the **Physical Path Credentials** line and verify it does not contain credentials.
