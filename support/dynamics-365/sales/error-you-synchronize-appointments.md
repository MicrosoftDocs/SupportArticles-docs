---
title: Error when you synchronize appointments
description: This article provides a resolution for the problem that occurs when you synchronize an appointment to the Microsoft Dynamics CRM 2011 Outlook client.
ms.reviewer: jbirnbau
ms.topic: troubleshooting
ms.date: 
---
# 'Unknown Error' When Synchronizing Appointments in the Microsoft Dynamics CRM 2011 Outlook Client

This article helps you resolve the problem that occurs when you synchronize an appointment to the Microsoft Dynamics CRM 2011 Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2797386

## Symptoms

When synchronizing an appointment to the Microsoft Dynamics CRM 2011 Outlook client, the following error occurs:

> An unknown error occurred while synchronizing data to Outlook.

When client tracing is enabled, the following stack error appears:

> [2012-12-17 16:30:41.530] Process:OUTLOOK |Organization:721c66ca-xxxx-40d2-8857-7f9f46bec876 |Thread: 26 |Category: Application.Outlook |User: 00000000-0000-0000-0000-000000000000 |Level: Error |ReqId: | SchedulableActivityForOutlook.GenerateCrmPartyInfo ilOffset = 0x5E
at SchedulableActivityForOutlook. GenerateCrmPartyInfo (String entityId, Object messageItem, IDynamicEntityForOutlook dynamicEntity) ilOffset = 0x5E
at ThreadsSupport.ExecuteThreadProc(ThreadProc threadProc, IntPtr parameter) ilOffset = 0x0  
Exception occurred during outlook interop: System.FormatException: The specified string is not in the form required for an e-mail address.  
at System.Net.Mail.MailAddressParser.ReadCfwsAndThrowIfIncomplete(String data, Int32 index)
at System.Net.Mail.MailAddressParser.ParseDomain(String data, Int32& index)
at System.Net.Mail.MailAddressParser.ParseAddress(String data, Boolean expectMultipleAddresses, Int32& index)
at System.Net.Mail.MailAddressParser.ParseAddress(String data)
at System.Net.Mail.MailAddress..ctor(String address, String displayName, Encoding displayNameEncoding)
at Microsoft.Crm.Outlook.OutlookItemWrapper.DecodeRecipientEmailAddress(PropValue mapiEntryId, PropValue altId, PropValue emailValue, PropValue emailType, String& displayName)
at Microsoft.Crm.Outlook.OutlookItemWrapper.GetOutlookRecipients(Object itemWrapper, Object messageItem)
at Microsoft.Crm.Outlook.OutlookItemWrapper.GenerateCrmPartyInfo(Guid entityId, IClientOrganizationContext context, Object messageItem, IDynamicEntityForOutlook dynamicEntity)
at Microsoft.Crm.Application.SMWrappers.SchedulableActivityForOutlook.GenerateCrmPartyInfo(String entityId, Object messageItem, IDynamicEntityForOutlook dynamicEntity)

## Cause

This is caused by the **Required Attendees** field being absent from the Appointment form. While this field cannot be removed from the form in Microsoft Dynamics CRM 2011, previous versions of Microsoft Dynamics CRM did allow the **Required Attendees** attribute to be removed. As a result, this issue may only occur in organizations that were upgraded from Microsoft Dynamics CRM 3.0 or 4.0 to Microsoft Dynamics CRM 2011.

When the field is missing and a record added to an appointment does not have a value in the e-mail address field, the **AddressUsed** field in the `ActivityPartyBase` table is set to a value of `EMAIL_ADDRESS`. As the field is not **NULL** or populated with a valid e-mail address, Outlook reports an unknown error when syncing the appointment to the client.

## Resolution

Add the **Required Attendees** field back to the Appointment form:

1. Navigate to **Settings**, click **Customizations**, click **Customize the System**, click **Entities**, click **Appointment**, and then click **Forms**.
2. Open up the main **Appointment** form that your environment is using. By default, this is the **Information** form.
3. Select the **Required Attendees** field from the **Field Explorer** list on the right and drag it into the form where desired.
4. If preferred, you may click **Change Properties** while the field is selected and uncheck the **Visible by default** option to make the field hidden on the form.
5. In the ribbon, click **Save**, and then click **Publish**.

Once the **Required Attendees** field is added back to the **Appointment** form, you can query the `ORG_MSCRM` database to find any existing appointments where the issue is present using the following steps:

1. Open Microsoft SQL Server Management Studio and choose **New Query** in the ribbon.
2. Choose your `ORG_MSCRM` database from the dropdown list in the ribbon.
3. Within the query window, type: `SELECT * FROM ActivityPartyBase WHERE AddressUsed = 'EMAIL_ADDRESS'`.
4. In the event that this displays results, the records that are affected can be identified by referencing the **PartyIdName** column.

Any records that are displayed in the results of the previous step can be fixed with the following steps:

1. Open a record that is displaying `EMAIL_ADDRESS` within the **AddressUsed** column in the previous steps.
2. Change the **E-mail** field to a temporary e-mail address and click **Save** in the ribbon to save the record.
3. Remove the temporary e-mail address you just added to the **E-mail** field and click **Save** in the ribbon to save the record again.
