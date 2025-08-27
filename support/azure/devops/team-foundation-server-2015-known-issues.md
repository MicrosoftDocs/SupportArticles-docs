---
title: Team Foundation Server 2015 known issues
description: This article describes the known issues in Team Foundation Server 2015.
ms.date: 08/14/2020
ms.custom: sap:Server Administration
ms.service: azure-devops-server
---
# Team Foundation Server 2015 known issues

This article shows the known issues in Team Foundation Server 2015.

_Original product version:_ &nbsp; Team Foundation Server 2015  
_Original KB number:_ &nbsp; 3077455

## Team Foundation Server 2015 known issues description

This article lists the known issues for the Microsoft Team Foundation Server 2015.

To see the full list of Team Foundation Server 2015 products and to select a product for download, check out [Microsoft Visual Studio Team Foundation Server 2015](https://www.microsoft.com/download/details.aspx?id=48260).

### Team Foundation Server 2015 details

To discover what is new in Team Foundation Server 2015, see the [Team Foundation Server 2015 Release Notes](/visualstudio/releasenotes/tfs2015-rtm-vs).

- You cannot change the `syncnamechanges` property.

    In Team Foundation Server 2015, we deprecated the ability to change the `syncnamechanges` property on a field. Therefore, you can no longer create projects that use the `OOB` templates in new collections for which the following conditions are true:

  - You uploaded a custom process to a new collection that has a field that shares the same reference name as an `OOB` template field.
  - The `syncnamechanges` property is false for that field.
  - You created a project by using the custom process template.

  In Update 1, we will restore the ability to change the `syncnamechanges` property. In the meantime, you can try one of these workarounds:

  - Update the custom process template to match the `syncnamechanges` property of the `OOB` template, and upload it to a new collection.
  - Contact Customer Support to have them to provide a script to fix the conflicting fields.

- Fields marked as _syncnamechanges=false_ through identity rules cause issues for the client object model.

    In Team Foundation Server 2015, we introduced the concept of an _identity field_. A field is considered to be an identity field if it has any rules on it that relate to identities, such as \<ValidUser />. This enables us to fix issues that involve duplicate display names. Previously, if two users had the same name, you could not differentiate between them. Now that we have identity fields, we store the DisplayPart as 'display name \<email or domain\alias>'. For example, instead of 'Sean Contoso', the DisplayPart is now stored as 'Sean Contoso \<scontoso@microsoft.com>'.

- If _syncnamechanges=true_ is set for a field, we store the Constant ID of the value instead of the actual string value for the field. If _syncnamechanges=false_ is set, the string value is directly stored on the work item. For identity fields, there is an issue that affects the client object model. Because the string value is stored, we are returning that string value as-is to the client. This causes the client-side rule engine to treat the field as invalid because it is not expecting the value in the format of 'Sean Contoso \<scontoso@microsoft.com>'.

- Workaround options:

  - Before you upgrade, update any templates that have the `syncnamechanges` property set to **false** for fields that have identity rules to set the `syncnamechanges` property to **true**. You must do this before you upgrade because the ability to change the state of the `syncnamechanges` property is removed from Team Foundation Server 2015.

  - Add an \<AllowExistingValue /> rule on any identity field that has the `syncnamechanges` property set to **false**. This enables the client object model rule engine to accept the existing value. This unblocks customers until we can provide a script that can convert fields that have their `syncnamechanges` property set to **false** to fields that have their `syncnamechanges` property set to **true**.  

## More information

- [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591)

- Updates for other products in the Team Foundation Server family can be found on the [Microsoft download site for Visual Studio](https://visualstudio.microsoft.com/downloads/) website.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

### Requirements and compatibility

For the requirements and compatibility for Team Foundation Server 2015, see [Team Foundation Server Compatibility and Requirements Summary](https://mikefourie.files.wordpress.com/2015/08/tfs2015compat.pdf).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
