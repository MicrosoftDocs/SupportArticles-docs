---
title: Can't access these records
description: Provides a solution to an error that occurs when you try to configure Microsoft Dynamics CRM for Office Outlook and you have a custom security role.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Error message displays when you try to configure Microsoft Dynamics CRM for Office Outlook

This article provides a solution to an error that occurs when you try to configure Microsoft Dynamics CRM for Office Outlook and you have a custom security role.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 2899051

## Symptoms

When you try to configure Microsoft Dynamics CRM for Office Outlook and you have a custom security role, you receive the following error:

> You do not have permission to access these records. Contact your Microsoft Dynamics CRM administrator.

If the security role is assigned through team membership instead of being associated directly to the user, you receive the following error:

> You do not have enough privileges to access the Microsoft Dynamics CRM object or perform the requested operation.

## Cause

Your security role in Microsoft Dynamics CRM is missing sufficient privileges for a specific entity. Which could be the Mailbox entity or some other entity privilege required to successfully configure CRM for Outlook.

## Resolution

First, identify which privilege is missing. You can expand the Details section in the error message that provides additional details including which privilege is missing. As shown in the [More information](#more-information) section below, the details may include a message such as missing prvReadMailbox privilege that would indicate the user needs Read access for the Mailbox entity. The example steps below are for the Mailbox entity but you can follow the same steps replacing the Mailbox entity with whichever privilege is mentioned in the details section of the error.

Update the security role to include user level Read access to the Mailbox entity. If the role is assigned through team membership, the security role will need business unit level or higher access.

1. Sign in to the Microsoft Dynamics CRM Web application as a user with the System Administrator role.
2. From the navigation bar, select Microsoft Dynamics CRM and then select **Settings**.
3. From the navigation bar, select **Settings** and then select **Administration**. If you're using Microsoft Dynamics CRM 2015 or later, select **Security** instead of **Administration**.
4. Select **Security Roles**.
5. Open the security role granted to the user that meets this issue.
6. Select the **Business Management** tab. If the missing privilege is for a different entity, the privilege may be located on one of the other tabs.
7. Select the circle to grant User level Read access to the Mailbox entity. This privilege can be located by finding the Mailbox entity and the intersection with the Read privilege.
8. Select **Save** and **Close**.
9. Configure Microsoft Dynamics CRM for Office Outlook again.

If you're still coming across issues, connect CRM for Outlook to your CRM Online organization, [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) is available to help diagnose the issue.

## More information

The log file contains the following error with the Principal user reference matching your SystemUserId:

> 09:17:01|  Error| Exception : Principal user (Id=4294cbf9-7534-e311-8b6d-6c3be5a8f660, type=8) is missing prvReadMailbox privilege (Id=8e17de3a-5a69-479c-9535-1f7be75b2987)  
at Microsoft.Crm.Application.Platform.ServiceCommands.PlatformCommand.XrmExecuteInternal()  
   at Microsoft.Crm.Application.Platform.ServiceCommands.RetrieveCommand.Execute()  
   at Microsoft.Crm.Caching.MailboxWebServiceCacheLoader.LoadCacheData(Guid key, IOrganizationContext context)  
   at Microsoft.Crm.Caching.ClientCacheLoaderProxy\`2.LoadCacheData(TKey key, IOrganizationContext context)  
   at Microsoft.Crm.Caching.CrmMultiOrgCacheBase\`2.CreateEntry(TKey key, IOrganizationContext context)  
   at Microsoft.Crm.Caching.CrmMultiOrgCacheBase\`2.LookupEntry(TKey key, IOrganizationContext context)  
   at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
   at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
   at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

If the user is a member of a team that only has user level Read access to the Mailbox entity, and they don't have a security role assigned directly to their user record with user level Read access to the Mailbox entity, the log file contains the following error with the Owner ID and Calling User reference matching your SystemUserId:

> 17:16:47|  Error| Exception : SecLib::AccessCheckEx failed. Returned hr = -2147187962, ObjectID: 7f27247a-dda1-e411-80d9-fc15b4285da4, OwnerId: 4294cbf9-7534-e311-8b6d-6c3be5a8f660,  OwnerIdType: 8 and CallingUser: 4294cbf9-7534-e311-8b6d-6c3be5a8f660. ObjectTypeCode: 9606, objectBusinessUnitId: 8bce1ea5-1e75-e411-80cf-c4346bac89f4, AccessRights: ReadAccess  
Server stack trace:  
   at System.ServiceModel.Channels.ServiceChannel.HandleReply(ProxyOperationRuntime operation, ProxyRpc& rpc)  
   at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)  
   at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)  
   at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)
>
> Exception rethrown at [0]:
   at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)  
   at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)  
   at Microsoft.Xrm.Sdk.IOrganizationService.Retrieve(String entityName, Guid id, ColumnSet columnSet)  
   at Microsoft.Xrm.Sdk.WebServiceClient.OrganizationWebProxyClient.<>c__DisplayClass4.\<RetrieveCore>b__3()  
   at Microsoft.Xrm.Sdk.WebServiceClient.WebProxyClient\`1.ExecuteAction[TResult](Func\`1 action)  
   at Microsoft.Xrm.Sdk.WebServiceClient.OrganizationWebProxyClient.RetrieveCore(String entityName, Guid id, ColumnSet columnSet)  
   at Microsoft.Xrm.Sdk.WebServiceClient.OrganizationWebProxyClient.Retrieve(String entityName, Guid id, ColumnSet columnSet)  
   at Microsoft.Crm.Application.SMWrappers.ClientOrganizationServiceProxyBase.Retrieve(String entityName, Guid id, ColumnSet columnSet)  
   at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadMailboxInfo(IClientAuthProvider\`1 orgAuthProvider)  
   at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserInfo(IClientAuthProvider\`1 orgAuthProvider)  
   at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary, IClientAuthProvider\`1 authenticatedProvider)  
   at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadDataToServerInfo()  
   at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__3(Object sender, DoWorkEventArgs e)  
   at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)  
   at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)
