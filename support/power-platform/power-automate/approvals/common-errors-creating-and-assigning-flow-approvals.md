---
title: Troubleshoot errors assigning or creating Power Automate Approvals
description: Troubleshoot Power Automate Approvals errors quickly. Find clear resolutions for assignment, attachment, Dataverse provisioning, and connection issues.
ms.reviewer: hamenon, mansong, v-shaywood
ms.date: 04/28/2026
ms.custom: sap:Approvals\Approval action failing
---
# Common errors creating and assigning Power Automate Approvals

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513675

## Summary

This article discusses common Power Automate Approvals errors and their resolutions. Use it to identify the cause of an error and apply the recommended solution. Errors are grouped into four categories so that you can jump to the relevant section:

- [Assigned To and Requestor](#assigned-to-and-requestor) - issues that have field values
- [Attachments](#attachments) - issues such as blocked file types or size limits
- [Provisioning errors](#provisioning-errors) - that occur when the underlying Dataverse database isn't ready
- [Miscellaneous](#miscellaneous) - issues such as connection ownership and transient race conditions

For more information about the Approvals capability in Power Automate, see [Get started with approvals](/power-automate/get-started-approvals) and [the Approvals connector in Power Platform](/connectors/approvals/).

## Common errors

### Assigned To and Requestor

#### InvalidApprovalCreateRequestAssignedToNoValidUsers

> Required field 'assignedTo' contained no valid users in the organization

This error occurs if the value that's entered into the **Assigned To** field of the approval action isn't a well-formatted email address, UPN, or [Microsoft Entra](/entra/fundamentals/whatis) object ID. It can also occur if the value is well-formatted but doesn't match any user in [Microsoft Graph](/graph/overview). If multiple users are specified (semicolon-delimited), none of the entries are found in Graph.

#### InvalidApprovalCreateRequestAssignedToMissing

> Required field 'assignedTo' is missing or empty.

This error occurs if the **Assigned To** field of the approval action doesn't contain any values. The [flow designer](/power-automate/flows-designer) prevents flows from being saved without a value for this field. This issue typically occurs if the **Assigned To** field is populated from the output of an earlier step, and that expression or output field is empty for this flow run.

#### InvalidApprovalRequestor

> The approval requestor must be a single, valid user account within your organization

This error occurs if the value entered in the **Requestor** field isn't a well-formatted email address, UPN, or Microsoft Entra object ID, or when the value is well-formatted but doesn't match any user in Microsoft Graph. It also occurs if you specify multiple users for the **Requestor** field.

#### InvalidXrmRecordId

> The provided record id '...' is null or invalid

The record identifier that you pass to **Wait for an approval** is null, empty, or not a GUID (in the `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` format). Populate this value with the approval ID from **Create an Approval**.

#### GraphUserDetailByEmailMultipleFound

> Found multiple matching users ('\<ID>, \<ID>') for 'someUserName@contoso.com'.

This error occurs if two or more users in Microsoft Graph match the same **Assigned To** or **Requestor** input (email address or UPN). To prevent the program from assigning approval to the wrong user, the flow doesn't run. The error message returns the unique Microsoft Entra object IDs for the matching records so that you can investigate further together with a tenant administrator. View the user accounts on `graph.microsoft.com`.

### Attachments

#### AttachmentContentNotValidBase64String

> The content for attachment '''...' is not a valid base64 encoded string.

Specify the attachment content in [base64 format](/azure/logic-apps/expression-functions-reference#base64-encoding-decoding). Most connectors that return file data already use this format. For custom data that's passed into the attachment content, use the [base64](/azure/logic-apps/expression-functions-reference#base64) expression.

#### AttachmentEmptyContentNotSupported

> The content for attachment '...' is empty. Attachments with empty content are not supported.

Empty attachments (0 bytes) aren't supported.

#### CdsApiAttachmentSizeLimitExceeded

> Attachment file size limit exceeded. Please contact your admin to make sure the limit is properly configured (The default is 5MB).

The attachment is too large for your Dataverse instance. The default limit is 5 MB per file, but database administrators can change this limit.

To increase the limit, an administrator can follow these steps:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Select **Environments**, and then select the environment that you want to manage.
1. On the command bar, select **Settings**.

   :::image type="content" source="media/common-errors-creating-and-assigning-flow-approvals/environment-admin-center-settings.png" alt-text="Screenshot that shows the Settings button on the command bar.":::

1. Select **Email** > **Email settings**.
1. In the **Attachments** section, update the maximum file size for attachments in kilobytes.

For more information about the Dataverse setting that controls this limit, see [File size limits](/power-apps/developer/data-platform/attachment-annotation-files?tabs=sdk#file-size-limits).

#### CdsApiAttachmentBlockedFileExtension

> Attachment file extension is blocked. Please contact your admin if changes need to be made to the block list.

An administrator in your organization blocks attachments of the specified type.

For security and privacy, Dataverse restricts the creation of certain file types by extension. An administrator can change this restriction by following these steps:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Select **Environments**, and then select the environment that you want to manage.
1. On the command bar, select **Settings**.
1. Select **Product** > **Privacy + Security**.
1. Under **Blocked Attachments**, add or remove file extensions from the semicolon-delimited list.

For more information, see [Manage privacy and security settings](/power-platform/admin/settings-privacy-security).

#### CombinedAttachmentSizeLimitExceeded

> The combined attachment size of 68.9MB exceeds the limit of 50MB.

The combined size of all attachments on this approval is too large. Only 50 MB of attachments are supported.

#### InvalidAttachmentName

> The attachment name '...' is invalid.

The specified attachment name is invalid because it contains (but isn't limited to) characters such as `,`, `/`, `\`, `|`, `?`, `*`, `>`, `<`, and `"`.

### Provisioning errors

> [!NOTE]
> Approvals rely on successful Dataverse provisioning and tenant prerequisites, such as licensing, app enablement in Microsoft Entra, and environment readiness. If you encounter provisioning-related errors, start with the prerequisites section in [Power Automate Approvals Dataverse provisioning errors and recommendations](flow-approval-cds-provisioning-errors.md#prerequisites) before you review the errors in this article.

#### CdsInstanceDisabled

> The Common Data Service database for this environment is disabled

The Microsoft Dataverse instance is disabled in this environment. This state isn't expected, and it might be related to the expiration of all Power Automate and Dataverse plans in your Microsoft Entra tenant. To make sure that the database can be enabled, provide at least one user that has active plans.

#### CdsInstanceNotReady

> The Common Data Service database for this environment is not yet ready.

The database is still provisioning, or provisioning failed. Rerun a flow that uses approvals to retry provisioning.

#### CdsUserDoesNotHavePermissionsToCreateDatabase

> The current user does not have permissions to create a Common Data Service database for this environment. Please ask an environment administrator to create the database.

For nondefault Power Automate and Power Apps environments, only environment administrators can create a Dataverse database directly (through the Power Platform admin center) or indirectly (through Power Automate Approvals).

To resolve this issue, an administrator must take one of the following actions:

- Create the environment manually from the Power Platform admin center.
- Create and run an Approvals flow.
- Grant environment administrator permission to the current user.

#### CdsInstanceProvisioningIncomplete

> A Common Data Service database for this environment has not completed provisioning or does not support the requested approvals functionality. A database administrator must save a Flow using approvals in order to complete provisioning.

Power Automate isn't finished setting up the Approvals solution in this environment's database.

#### XrmProvisionInstanceFailed

> Failed to create the Common Data Service database in this environment with status code 'ViralServicePlanRequired'.

The Dataverse database can't be provisioned because a required service plan is missing. See [Error with status code "ViralServicePlanRequired"](flow-approval-cds-provisioning-errors.md#error-that-has-status-code-viralserviceplanrequired) for steps to resolve this issue.

#### ResourceDisabledInTenant

> Resource `https://publishers.crm.dynamics.com` has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable `https://publishers.crm.dynamics.com` in the Azure Portal.

A required Dynamics 365 resource is disabled in your Microsoft Entra tenant. See [Error with status code "AADApplicationDisabled"](flow-approval-cds-provisioning-errors.md#error-that-has-status-code-aadapplicationdisabled) for steps to resolve this issue.

#### ApplicationDisabledInTenant

> 'The Flow Enterprise Application has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable Microsoft Flow applications 'Microsoft Flow Service' (AppID: '...') and 'Microsoft Flow CDS Integration Service' (AppID: '...') in the Azure Portal.'.

A tenant administrator disabled one or more Microsoft Entra applications that Approvals requires. An administrator must re-enable the applications in the Azure portal. See [Error with status code "AADApplicationDisabled"](flow-approval-cds-provisioning-errors.md#error-that-has-status-code-aadapplicationdisabled) for steps to resolve this issue.

### Miscellaneous

#### ApprovalConnectionOwnerNotEnabledInGraph

> The Approvals connection owner was found in Graph, but the account is not enabled. Object Id: '...'

Microsoft Graph contains the user account that originally created the Approvals connection that's used by the flow, but the account is disabled. An owner of the flow should replace the connection with one that belongs to an active user in the organization.

#### ApprovalConnectionOwnerNotFoundInGraph

> The Approvals connection owner was not found in Graph. Object Id: '...'

The user account that originally created the Approvals connection that's used by the flow isn't in Microsoft Graph. This condition likely occurs because the account was deleted or removed from Microsoft Entra. An owner of the flow should replace the connection with one that belongs to an active user in the organization.

#### ApprovalSubscriptionNotAllowed

> Cannot wait on this approval in its current state.

When the **Wait for an approval** action ran, the approval was already expired or abandoned. This action can only wait on active approvals.

#### InvalidApprovalCustomOptions

> The response options provided for this approval are invalid.  Options must be less than 100 characters and cannot be blank.

This error occurs if the values in the **Custom Response** options for an approval are invalid. To fix the error, go to the [flow designer](/power-automate/flows-designer). The error message specifies the constraints.

#### InvalidApprovalCreateRequestTitleMissing

> Required field 'title' is missing or empty

The approval title is missing or empty. Provide a value for the **Title** field.

#### XrmApplyUserNotMemberOfSecurityGroup

> Could not create a CDS system record representing user '\<User ID>'. Please ask a database administrator to add the user to the authorized security group.

The Dataverse database for this environment is protected by a [security group](/power-platform/admin/control-user-access). An owner of the security group must add all approval creators, requestors, and recipients to the group. Set up the security group from the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

#### XrmApprovalsGeneralPermissionsError

> Encountered a general permissions error trying to access the Dataverse database. This could be caused by modification of the approvals administrator or user roles, or by an incompatible plugin.

Make sure that no custom plugins restrict access to the approvals data entities for organization users or for the [Power Automate service principal](/power-automate/change-cloud-flow-owner#service-principal-application-users) that are used to provision records (`flowdev@microsoft.com`).

#### HTTP 412 Code: 0x80040237 InnerError

> A record with matching key values already exists

This transient error can occur when you create or update an approval. The error is caused by a race condition. To resolve the issue, retry the action.

## Related content

- [Overview of the Power Platform admin center](/power-platform/admin/admin-documentation)
- [Role-based security roles for Dataverse](/power-platform/admin/database-security)
- [Power Automate licensing FAQ](/power-platform/admin/power-automate-licensing/faqs)
