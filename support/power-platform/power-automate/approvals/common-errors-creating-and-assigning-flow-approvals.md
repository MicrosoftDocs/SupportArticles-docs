---
title: Common errors creating and assigning flow approvals
description: Common Power Automate approval errors and potential resolutions.
ms.reviewer: hamenon, mansong
ms.date: 02/07/2023
ms.subservice: power-automate-approvals
---
# Common errors creating and assigning flow approvals

This article introduces the common Power Automate approval errors and potential resolutions.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513675

## Assigned To and Requestor

### InvalidApprovalCreateRequestAssignedToNoValidUsers

> Required field 'assignedTo' contained no valid users in the organization

This error occurs if the input value(s) to the Assigned To field of the approval action was either not a well -formatted email address, UPN, or Microsoft Entra object ID, or it was well formatted, but didn't match any users in Microsoft Graph. If multiple users were specified (semi-colon delimited), then this means that all entries couldn't be found in Graph.

### InvalidApprovalCreateRequestAssignedToMissing

> Required field 'assignedTo' is missing or empty.

This error occurs if the Assigned To field of the approval action didn't contain any values. The Flow designer prevents any Flows from being saved without any value for this field, so typically this can occur if the Assigned To field is populated from the output of some other step and for this Flow run, there was no value for the expression or output field.

### InvalidApprovalRequestor

> The approval requestor must be a single, valid user account within your organization

This error occurs if the input value(s) to the Assigned To field of the approval action was either not a well-formatted email address, UPN, or Microsoft Entra object ID, or it was well formatted, but didn't match any users in Microsoft Graph. It will also be returned if multiple value users were specified for the re questor field.

### InvalidXrmRecordId

> The provided record id '...' is null or invalid

The record identifier passed to "Wait for an approval" is null, empty, or not a guid (in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx). This value should be populated with the approval ID from **Create an Approval**.

### GraphUserDetailByEmailMultipleFound

> Found multiple matching users ('\<ID>, \<ID>') for 'someUserName@contoso.com'.

This error will occur if two users in Microsoft Graph were found for the same Assigned To (or Requestor) input (email address or UPN). Rather than potentially assign the approval to the wrong user account, Flow will fail the run. The unique Microsoft Entra object IDs for the two or more matching records are returned in the error message so that users can investigate further with a user administrator in their tenant. (The user accounts can be viewed on `graph.microsoft.com`).

## Attachments

### AttachmentContentNotValidBase64String

> 'The content for attachment '''...' is not a valid base64 encoded string.'.

The attachment content must be specified in [base64 format](https://en.wikipedia.org/wiki/Base64). Most connectors that return file data already do this. For custom data passed into the attachment content, use the `base64` expression.

### AttachmentEmptyContentNotSupported

> 'The content for attachment '...' is empty. Attachments with empty content are not supported.'.

Empty attachments (0 bytes) aren't supported.

### CdsApiAttachmentSizeLimitExceeded

> 'Attachment file size limit exceeded. Please contact your admin to make sure the limit is properly configured (The default is 5MB).'.

The attachment is too large for your CDS instance. The default size is 5 MB per file, but this can be configured by database administrators.

### CdsApiAttachmentBlockedFileExtension

> 'Attachment file extension is blocked. Please contact your admin if changes need to be made to the block list.'.

An administrator in your organization has blocked attachments of the specified type.

### CombinedAttachmentSizeLimitExceeded

> 'The combined attachment size of 68.9MB exceeds the limit of 50MB.'.

The combined size of all attachments on this approval is too large. Only 50 MB of attachments are supported.

### InvalidAttachmentName

> 'The attachment name '...' is invalid.'.

The specified attachment name is invalid because it contains characters such as (but not limited to), /, \, |, ?, *, >, <, ".

## Provisioning Errors

For more information about these provisioning errors, see [Flow Approval CDS Provisioning Errors and Recommendations](https://support.microsoft.com/help/4513672/flow-approval-cds-provisioning-errors-and-recommendations).

### CdsInstanceDisabled

> The Common Data Service database for this environment is disabled

The Common Data Service instance has been disabled in this environment. This isn't expected, and is may related to the expiration of all Flow & CDS plans within your Microsoft Entra tenant. To ensure the database can be enabled, make sure at least one user has active plans.

### CdsInstanceNotReady

> The Common Data Service database for this environment is not yet ready.

The database for this instance is still being provisioned, or has failed provisioning. Rerunning a Flow that uses approvals will attempt to re - provision the instance.

### CdsUserDoesNotHavePermissionsToCreateDatabase

> The current user does not have permissions to create a Common Data Service database for this environment. Please ask an environment administrator to create the database.

For non-Default Flow and Power Apps environments, only environment admins can directly (through the Flow Admin portal) or indirectly (through Flow Approvals) create the Common Data Service database. Either an administrator must

- Create the environment manually from the Flow Admin portal.
- Create and run an Approvals Flow.
- Grant environment administrator permission to the current user.

### CdsInstanceProvisioningIncomplete

> A Common Data Service database for this environment has not completed provisioning or does not support the requested approvals functionality. A database administrator must save a Flow using approvals in order to complete provisioning.

Microsoft Flow hasn't yet been able to set up the Approvals solution within the database for this instance.

### XrmProvisionInstanceFailed

> Failed to create the Common Data Service database in this environment with status code 'ViralServicePlanRequired'.

### ResourceDisabledInTenant

> Resource `https://publishers.crm.dynamics.com` has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable `https://publishers.crm.dynamics.com` in the Azure Portal.

### ApplicationDisabledInTenant

> 'The Flow Enterprise Application has been disabled by your tenant administrator. Contact your tenant administrator and request that they enable Microsoft Flow applications 'Microsoft Flow Service' (AppID: '...') and 'Microsoft Flow CDS Integration Service' (AppID: '...') in the Azure Portal.'.

One or more necessary Microsoft Entra applications for Approvals to work have been disabled by your tenant administrator(s). An administrator will need to re-enable the application(s) in the Azure portal.

## Miscellaneous

### ApprovalConnectionOwnerNotEnabledInGraph

> 'The Approvals connection owner was found in Graph, but the account is not enabled. Object Id: ''...'

The user that originally created the Approvals connection used by the flow is no longer found in Graph, likely because the user account has been removed. An owner of the flow should replace the connection with one belonging to a user in the organization.

### ApprovalConnectionOwnerNotFoundInGraph

> 'The Approvals connection owner was not found in Graph. Object Id: '...''.

The user that originally created the Approvals connection used by the flow is no longer found in Graph, likely because the user account has been removed. An owner of the flow should replace the connection with one belonging to a user in the organization.

### ApprovalSubscriptionNotAllowed

> 'Cannot wait on this approval in its current state.'.

By the time the "Wait for an approval" action executed, the approval had already been completed. Only active approvals can be waited upon by this action.

### InvalidApprovalCustomOptions

> The response options provided for this approval are invalid.  Options must be less than 100 characters and cannot be blank.

This occurs if the inputs to the Custom Response options for an approval are invalid and need to be fixed in the Flow designer. The constraints are specified in the error message itself.

### InvalidApprovalCreateRequestTitleMissing

> Required field 'title' is missing or empty

The approval title was null or empty, which isn't supported.

### XrmApplyUserNotMemberOfSecurityGroup

> Could not create a CDS system record representing user '\<User ID>'. Please ask a database administrator to add the user to the authorized security group.'.

The CDS database for this environment is protected by a security group. An owner of the security group will need to add all approval creators, requestors, and recipients to the security group. The security group can be configured from the Power Platform Admin Center.

### XrmApprovalsGeneralPermissionsError

> 'Encountered a general permissions error trying to access the CDS database. This could be caused by modification of the approvals administrator or user roles, or by an incompatible plugin.

Ensure no custom plugins restrict access to the approvals data entities for either organization users for the Power Automate service principal used to provision records (`flowdev@microsoft.com`).

### HTTP 412 Code: 0x80040237 InnerError

> 'A record with matching key values already exists'

This transient error can occur when trying to create or update an approval. This error occurs due to a race condition that's triggered when creating the approval. Retry the action to solve this issue.
