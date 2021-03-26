---
title: Errors when working with SystemUser records after migrating 
description: Some issues may occur with System User records after you import a Microsoft Dynamics CRM Online organization into a Microsoft Dynamics CRM On-Premise deployment.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Errors occur when working with SystemUser records after migrating from Microsoft Dynamics CRM Online to On Premise

This article provides a resolution for the issue that you may receive some error messages when working with SystemUser records after migration to Microsoft Dynamics CRM On Premise.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2830704

## Symptoms

After importing a Microsoft Dynamics CRM Online organization into a Microsoft Dynamics CRM On-Premise deployment, various issues occur with System User records. Specific symptoms include:

1. When trying to assign the System Administrator Security Role to a Microsoft Dynamics CRM user, the following error occurs:

    > System.Web.HttpUnhandledException: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #009FAAB1
    2013-03-14T14:48:07.871872Z

    Error Details:

    > Unhandled Exception: System.ServiceModel.FaultException`1[[Microsoft.Xrm.Sdk.OrganizationServiceFault, Microsoft.Xrm.Sdk, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]: System.Web.HttpUnhandledException: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #009FAAB1Detail:

2. When trying to modify a System User record in Microsoft Dynamics CRM, the following error occurs:

    > An error has occurred.

    Error Details:

    > Unhandled Exception: System.ServiceModel.FaultException`1[[Microsoft.Xrm.Sdk.OrganizationServiceFault, Microsoft.Xrm.Sdk, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]: Assembly Microsoft.Crm.Yammer, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 can not be loaded from GAC.Detail:  
    \<OrganizationServiceFault xmlns:i="https://www.w3.org/2001/XMLSchema-instance" xmlns="https://schemas.microsoft.com/xrm/2011/Contracts">  
    \<ErrorCode>-2147204719\</ErrorCode>  
    \<ErrorDetails xmlns:d2p1="https://schemas.datacontract.org/2004/07/System.Collections.Generic" />  
    \<Message>Assembly Microsoft.Crm.Yammer, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 can not be loaded from GAC.\</Message>  
    \<Timestamp>*Timestamp*\</Timestamp>  
    \<InnerFault i:nil="true" />  
    \<TraceText i:nil="true" />  
    \</OrganizationServiceFault>

## Cause

Microsoft Dynamics CRM Online has been updated to include the ability to integrate with Yammer. This update is currently not available for Microsoft Dynamics CRM On Premise.

## Resolution

To resolve this issue, the Yammer integration needs to be removed from the database. This can be done with the following scripts:

```sql
--Remove UpdateYammerProperties SDK Message from the database  
delete from SdkMessageResponseFieldBase where SdkMessageResponseId='1c4e947e-79f0-4e35-b2a8-000959ef93f4'  
delete from SdkMessageResponseBase where SdkMessageResponseId='1c4e947e-79f0-4e35-b2a8-000959ef93f4'  
delete from SdkMessageRequestFieldBase where SdkMessageRequestId='a951346f-b39e-44a3-8cfa-9e1d596573d9'  
delete from SdkMessageRequestBase where SdkMessageRequestId='a951346f-b39e-44a3-8cfa-9e1d596573d9'  
delete from SdkMessageProcessingStepBase where SdkMessageProcessingStepId = 'ea822b51-e812-4cf0-938b-2fb9baebf4c5'  
delete from SdkMessageFilterBase where SdkMessageFilterId = 'fec3b044-425a-4dfa-ad49-b7cb150be9f0'  
delete from SdkMessagePairBase where SdkMessagePairId = '190a01bb-7d20-4d08-a862-91f538bb0756'  
delete from SdkMessageBase where SdkMessageId = 'fdc7ffae-6c75-48f0-890a-b9cb96d43de3'  
--Remove references from the BaseIds table (note: there are no ids table for SdkMessageResponseField and SdkMessageRequestField entities)  
delete from SdkMessageResponseBaseIds where SdkMessageResponseId='1c4e947e-79f0-4e35-b2a8-000959ef93f4'  
delete from SdkMessageRequestBaseIds where SdkMessageRequestId='a951346f-b39e-44a3-8cfa-9e1d596573d9'  
delete from SdkMessageProcessingStepBaseIds where SdkMessageProcessingStepId = 'ea822b51-e812-4cf0-938b-2fb9baebf4c5'  
delete from SdkMessageFilterBaseIds where SdkMessageFilterId = 'fec3b044-425a-4dfa-ad49-b7cb150be9f0'  
delete from SdkMessagePairBaseIds where SdkMessagePairId = '190a01bb-7d20-4d08-a862-91f538bb0756'  
delete from SdkMessageBaseIds where SdkMessageId = 'fdc7ffae-6c75-48f0-890a-b9cb96d43de3'

--Remove FollowInYammer SDK Message and its' pluginType from the database  
delete from SdkMessageResponseFieldBase where SdkMessageResponseId='0BF5D7C1-345A-4B13-80C4-A7C2727B20F2'  
delete from SdkMessageResponseBase where SdkMessageResponseId='0BF5D7C1-345A-4B13-80C4-A7C2727B20F2'  
delete from SdkMessageRequestFieldBase where SdkMessageRequestId='83CC2E86-631F-498A-8300-A5AC2547AB3E'  
delete from SdkMessageRequestBase where SdkMessageRequestId='83CC2E86-631F-498A-8300-A5AC2547AB3E'  
delete from SdkMessageProcessingStepBase where SdkMessageProcessingStepId = '1B1B9068-E700-40C1-8C9F-9FC7A473A2C1'  
delete from SdkMessageFilterBase where SdkMessageFilterId = 'A43CE9F5-2698-4F1D-82D9-6FA179AB51D9'  
delete from SdkMessagePairBase where SdkMessagePairId = '00F48FF1-DF35-48BC-B846-9DEB63A3DACB'  
delete from SdkMessageBase where SdkMessageId = '5E4361F9-B294-4884-A186-6AB7B9F5FEA1'  
delete from PluginTypeBase where PluginTypeId = 'EDEF9169-DBC7-49D9-BE83-FCCB9C692B48'

--Remove references from the BaseIds table (note: there are no ids table for SdkMessageResponseField and SdkMessageRequestField entities)  
delete from SdkMessageResponseBaseIds where SdkMessageResponseId='0BF5D7C1-345A-4B13-80C4-A7C2727B20F2'  
delete from SdkMessageRequestBaseIds where SdkMessageRequestId='83CC2E86-631F-498A-8300-A5AC2547AB3E'  
delete from SdkMessageProcessingStepBaseIds where SdkMessageProcessingStepId = '1B1B9068-E700-40C1-8C9F-9FC7A473A2C1'  
delete from SdkMessageFilterBaseIds where SdkMessageFilterId = 'A43CE9F5-2698-4F1D-82D9-6FA179AB51D9'  
delete from SdkMessagePairBaseIds where SdkMessagePairId = '00F48FF1-DF35-48BC-B846-9DEB63A3DACB'  
delete from SdkMessageBaseIds where SdkMessageId = '5E4361F9-B294-4884-A186-6AB7B9F5FEA1'  
delete from PluginTypeBaseIds where PluginTypeId = 'EDEF9169-DBC7-49D9-BE83-FCCB9C692B48'

--Remove PostFollow.Create plugin  
delete from SdkMessageProcessingStepBase where SdkMessageProcessingStepId = 'D87006BC-3423-461d-8821-EA4120995C16'  
delete from PluginTypeBase where PluginTypeId = '2CEFE901-742F-48e1-8741-FA862274F30B'  
delete from SdkMessageProcessingStepBaseIds where SdkMessageProcessingStepId = 'D87006BC-3423-461d-8821-EA4120995C16'  
delete from PluginTypeBaseIds where PluginTypeId = '2CEFE901-742F-48e1-8741-FA862274F30B'

--Remove SystemUser.Update plugin  
delete from SdkMessageProcessingStepBase where SdkMessageProcessingStepId = 'AA12BB05-EAE1-4fbc-A2BE-E21CE11F7386'  
delete from PluginTypeBase where PluginTypeId = '09F61DB5-F673-4401-8C64-109BF7D38416'  
delete from SdkMessageProcessingStepBaseIds where SdkMessageProcessingStepId = 'AA12BB05-EAE1-4fbc-A2BE-E21CE11F7386'  
delete from PluginTypeBaseIds where PluginTypeId = '09F61DB5-F673-4401-8C64-109BF7D38416'

--Remove the Plugin Assembly Microsoft.Crm.Yammer  
delete from PluginAssemblyBase where PluginAssemblyId = '0B887035-5406-44e5-9EE1-0ABCBF980849'  
delete from PluginAssemblyBaseIds where PluginAssemblyId = '0B887035-5406-44e5-9EE1-0ABCBF980849'

--Remove the PostJsonPlugin and its assembly Microsoft.Crm.ExternalProxy.dll  
delete from PluginTypeBase where PluginTypeId = 'A4D7EAAF-9D37-4AC2-98A3-CCB372156479'  
delete from PluginTypeBaseIds where PluginTypeId = 'A4D7EAAF-9D37-4AC2-98A3-CCB372156479'  
delete from PluginAssemblyBase where PluginAssemblyId = 'E220F237-7DBE-4F0C-BE6D-18B08DD78271'  
delete from PluginAssemblyBaseIds where PluginAssemblyId = 'E220F237-7DBE-4F0C-BE6D-18B08DD78271'

--Remove Yammer's Async Operation Job  
DELETE FROM [dbo].[AsyncOperationBase] where [AsyncOperationId]='6EF45A82-1AAB-48ab-8301-CD753F265214'

--Deletes prvConfigureYammer privilege  
Declare @privilegeId as uniqueidentifier

Select @privilegeId =PrivilegeId From Privilege  
Where Name = 'prvConfigureYammer'

Select * From RolePrivileges  
Where PrivilegeId = @privilegeId

Select * From RoleTemplatePrivileges  
Where PrivilegeId = @privilegeId

Select * From PrivilegeObjectTypeCodes  
Where PrivilegeId = @privilegeId

--Starts deleting the Privilege entries  
Delete RolePrivileges  
Where PrivilegeId = @privilegeId

Delete RoleTemplatePrivileges  
Where PrivilegeId = @privilegeId

Delete PrivilegeObjectTypeCodes  
Where PrivilegeId = @privilegeId

Delete Privilege  
Where PrivilegeId = @privilegeId
```

## More information

This script will not be required after Update Rollup 13 is released for Microsoft Dynamics CRM On Premise.
