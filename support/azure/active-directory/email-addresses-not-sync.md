---
title: Email addresses aren't synced to Microsoft Entra ID
description: Describes an issue in which users are synced to Microsoft Entra ID but one or more SMTP proxy addresses aren't synced.  This issue occurs if duplicate SMTP proxy addresses exist. Provides a resolution.
ms.date: 05/11/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
---
# Email addresses aren't synced to Microsoft Entra ID

This article describes an issue in which users are synced to Microsoft Entra ID but one or more SMTP proxy addresses aren't synced. This issue occurs if duplicate SMTP proxy addresses exist.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3166798

## Symptoms

Although your users are synced to Microsoft Entra ID, one or more SMTP proxy addresses aren't synced. Additionally, you may see a message that resembles one of the following:

In the Office 365 portal:

> There is an error on one or more user accounts. To see which users are affected and the detailed error message, select the "users with errors" view, and then select the user's display name.

> We detected a duplicate Proxy address conflict on the value \<value>. All attribute values need to be unique across objects. To resolve this conflict, first determine which object should be using the conflicting value. Then, update or remove the conflicting value from the other object(s). This error was detected on \<Date and Time>.

From an email report:

> This object has been updated in your Microsoft Entra ID, but with some modified properties, because the following attributes are associated with another object [ProxyAddresses SMTP:`john@contoso.com`;].

This issue occurs if another object has the same SMTP proxy address.

## Resolution

To resolve this issue, find the users who have duplicate SMTP proxy addresses, and then change the addresses so that they are unique. To do this, follow these steps.

### Step 1: Check your local directory

Use the IdFix DirSync Error Remediation Tool to identify duplicate or invalid attributes.

To resolve duplicate attributes by using the IdFix Tool, see ["Duplicate" is displayed in the ERROR column](/office365/troubleshoot/active-directory/run-idfix-dirsync-error-remediation-tool).

For more information about the IdFix tool, go to [IdFix DirSync Error Remediation Tool](https://github.com/microsoft/idfix).

<a name='step-2-check-azure-ad'></a>

### Step 2: Check Microsoft Entra ID

You can use the Office 365 portal or the Azure Active Directory module for Windows PowerShell to check Microsoft Entra ID for duplicate attributes.

> [!NOTE]
> The report in the Office 365 portal only displays user objects that have these errors. The report doesn't show information about conflicts between groups, contacts, or public folders. See Method 2 to learn how to view conflicts for the other objects.

#### Method 1: Use the Office 365 portal

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. In the Microsoft 365 admin center, go to **Users**, and then select **Active users**.

    A warning at the top of the page is displayed if there are duplicate attribute conflicts on any object in your organization.

3. To filter the view to display only users with errors, select **Users with errors**.
4. Select an object to view details about the conflict. This information is displayed in the lower-right corner of the page.
5. Change the email address so that it's unique.

#### Method 2: Use the Azure AD module for Windows PowerShell

To learn more about how to use the Azure AD module for Windows PowerShell to identify objects that have duplicate values, see [Identity synchronization and duplicate attribute resiliency](/azure/active-directory/hybrid/how-to-connect-syncservice-duplicate-attribute-resiliency).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
