---
title: A failure occurred in CrmSecurity
description: Provides a solution to an error that occurs when you select the Approve Email button on a mailbox record in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "A failure occurred in CrmSecurity" error occurs when attempting to approve the email address of a mailbox record in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you select the **Approve Email** button on a mailbox record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4510938

## Symptoms

When you select the **Approve Email** button on a mailbox record, you receive the following error:

> "Error  
A failure occurred in CrmSecurity. If you contact support, please provide the technical details."

## Cause

This error occurs if you try to approve the email as a user that doesn't have both of the following required roles:

- Global Administrator or Exchange Administrator in Office 365
- System Administrator security role in Dynamics 365

## Resolution

By default, Dynamics 365 requires that the approval of an email address in Dynamics 365 is performed by someone with both of the required roles mentioned in the [Cause](#cause) section. The System Administrator role in Dynamics 365 or the Dynamics 365 service administrator role in Office 365 aren't sufficient for doing this action. For more information including how this requirement can be disabled, see [Changes to Mailbox approval in Dynamics 365](https://support.microsoft.com/help/4506139).

## More information

If you select the **Download Log File** button, you see details like the following example:

> "Unhandled Exception: System.ServiceModel.FaultException'1[[Microsoft.Xrm.Sdk.OrganizationServiceFault, Microsoft.Xrm.Sdk, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]: System.Web.HttpUnhandledException (0x80004005): Exception of type 'System.Web.HttpUnhandledException' was thrown. ---> Microsoft.Crm.CrmException: The Queue: a5efd992-dbc6-48af-ad61-09e0258edb68 email `example@contoso.com` doesn't match with UPN. User 39ff663e-a75a-e811-a986-000d3a3672b5 should be a global administrator to approve mailbox in organization \<organization>.  
at Microsoft.Crm.Dialogs.ApproveEmailAddressDialogPage.ConfigureForm()  
at Microsoft.Crm.Application.Controls.AppUIPage.OnPreRender(EventArgs e)  
at Microsoft.Crm.Application.Controls.AppPage.OnPreRender(EventArgs e)  
at System.Web.UI.Control.PreRenderRecursiveInternal()  
at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
at System.Web.UI.Page.HandleError(Exception e)  
at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
at System.Web.UI.Page.ProcessRequest()  
at System.Web.UI.Page.ProcessRequest(HttpContext context)  
at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
at System.Web.HttpApplication.ExecuteStepImpl(IExecutionStep step)  
at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean&
completedSynchronously): Microsoft Dynamics CRM has experienced an error. Reference number
for administrators or support: #3A5E4FEADetail:  
\<OrganizationServiceFault xmlns:i="https://www.w3.org/2001/XMLSchema-instance" xmlns="https://schemas.microsoft.com/xrm/2011/Contracts">  
  \<ActivityId>\<ID>\</ActivityId  
  \<ErrorCode> \*\*-2147220970\*\* \</ErrorCode>  
  \<ErrorDetails xmlns:d2p1="https://schemas.datacontract.org/2004/07/System.Collections.Generic" />  
    \<Message>System.Web.HttpUnhandledException (0x80004005): Exception of type \'System.Web.HttpUnhandledException\' was thrown. ---&gt; Microsoft.Crm.CrmException: \*\*The Queue: a5efd992-dbc6-48af-ad61-09e0258edb68 email `example@contoso.com` doesn't match with UPN. User 39ff663e-a75a-e811-a986-000d3a3672b5 should be a global administrator to approve mailbox in organization \<organization>\*\*.  
   at Microsoft.Crm.Dialogs.ApproveEmailAddressDialogPage.ConfigureForm()  
   at Microsoft.Crm.Application.Controls.AppUIPage.OnPreRender(EventArgs e)  
   at Microsoft.Crm.Application.Controls.AppPage.OnPreRender(EventArgs e)  
   at System.Web.UI.Control.PreRenderRecursiveInternal()  
   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
   at System.Web.UI.Page.HandleError(Exception e)  
   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
   at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
   at System.Web.UI.Page.ProcessRequest()  
   at System.Web.UI.Page.ProcessRequest(HttpContext context)  
   at
System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
   at System.Web.HttpApplication.ExecuteStepImpl(IExecutionStep step)  
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean&amp; completedSynchronously): Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #3A5E4FEA</Message>  
  \<Timestamp>2018-12-04T18:17:41.8971683Z\</Timestamp  
  \<ExceptionRetriable>false</ExceptionRetriable>  
  \<ExceptionSource i:nil="true" />  
  \<InnerFault>  
  \<ActivityId>\<ID></ActivityId  
  \<ErrorCode> \*\*-2147220906\*\* \</ErrorCode>
\<ErrorDetails xmlns:d3p1="https://schemas.datacontract.org/2004/07/System.Collections.Generic" />  
\<Message>The Queue: a5efd992-dbc6-48af-ad61-09e0258edb68 email `testdl@MyContosoDemo.onmicrosoft.com` doesn't match with UPN. User 39ff663e-a75a-e811-a986-000d3a3672b5 should be a global administrator to approve mailbox in organization \<organization>.\</Message>  
\<Timestamp>2018-12-04T18:17:41.8981705Z\</Timestamp  
\<ExceptionRetriable>false\</ExceptionRetriable>  
\<ExceptionSource i:nil="true" />  
\<InnerFault i:nil="true" />  
\<OriginalException i:nil="true" />  
\<TraceText i:nil="true" />  
\</InnerFault>  
\<OriginalException i:nil="true" />  
\<TraceText i:nil="true" />  
\</OrganizationServiceFault>"
