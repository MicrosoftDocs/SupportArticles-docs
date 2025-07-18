---
title: Mailbox Named Properties Quota Exceeded
description: Provides a workaround for an issue in which a sender receives NDR 554 5.2.2 and MapiExceptionNamedPropsQuotaExceeded when they send an email message or calendar invite.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 3733
ms.reviewer: cboonham, fernandose, bettysnchez, meerak, v-shorestris
appliesto:
  - Outlook for Windows
  - Outlook for Microsoft 365
  - Outlook on the web
  - Outlook for Mac
  - Outlook for Microsoft 365 for Mac
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 06/30/2025
---

# Mailbox named properties quota exceeded

## Symptoms

A user reports one or more of the following issues:

- When the user tries to open an item in their mailbox in Microsoft Outlook on the web, such as a message, attachment, embedded message, or folder, they receive the following error message:

   > Sorry, we're having trouble opening this item. This could be temporary, but if you see it again you might want to restart Outlook. Your request can't be completed right now.

- When an email message or calendar invite is sent to the user, the sender receives a non-delivery report (NDR) that contains the following information:

   > Reason: [{LED=554 5.2.2 mailbox full;  
   > STOREDRV.Deliver.Exception:QuotaExceededException.MapiExceptionNamedPropsQuotaExceeded; Failed to process message due to a permanent exception with message

As an admin, you encounter issues if you perform any of the following actions on the user's mailbox:

- You run a [network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace#collect-a-network-trace-in-the-browser-browser-based-apps-only) to capture messages sent from Outlook on the web when the signed in user tries to open any item in their mailbox. The trace captures the following error message:

   > "MessageText": "Cannot get ID from name.", "ResponseCode": "ErrorQuotaExceeded", "ResponseClass": "Error" 

- You run the [Get-MailboxFolderStatistics](/powershell/module/exchange/get-mailboxfolderstatistics) PowerShell cmdlet to retrieve folder information. The command output contains the following error message:

   > Internal server error : { "code": "InternalServerError", "message": "Internal server error",  "innererror": { "message": "Internal server error", "type": "Microsoft.Exchange.Admin.OData.Core.ODataServiceException", "stacktrace": "",     "internalexception": { "message": "Cannot get ID from name.", "type": "Microsoft.Exchange.Data.Storage.QuotaExceededException", "stacktrace": "", "internalexception": { "message": "MapiExceptionNamedPropsQuotaExceeded: GetIdsFromNames operation has failed (hr=0x80040900,ec=-2147219200)

- You run the Microsoft [Test-MailboxExtendedProperty.ps1](https://microsoft.github.io/CSS-Exchange/M365/Test-MailboxExtendedProperty/) script to check the number of named property definitions in a user mailbox. The script reports that the mailbox has reached one or more of its named property quotas.

   > [!TIP]
   > Named properties are also known as [extended properties](/graph/api/resources/extended-properties-overview).

## Cause

After a named property quota for a namespace is reached, any request to add a new named property definition that exceeds the quota will generate an exception. The exceptions cause the symptoms to occur.

> [!NOTE]
> The quotas apply to the number of named properties that are defined in a mailbox. If the same named property is applied to a large number of emails, it's still considered a single named property definition.

The number of named property definitions in a mailbox typically stays well below the quotas. However, some third-party Outlook add-ins create an excessive number of named property definitions that saturate a mailbox. For example, an add-in might create a new named property definition for every piece of custom data that it stores, rather than reusing a few predefined named properties.

The following table shows the named property quotas for a mailbox.

| **Quota type** | **Quota** **applies to** | **Quota** | **Percent of total quota** |
|-|-|-|-|
| Namespace | All namespaces | 16,384 | 100% |
| Namespace | InternetHeaders namespace<br>(GUID: `00020386-0000-0000-C000-000000000046`) | 9,830 | 60% |
| Namespace | PublicStrings namespace<br>(GUID: `00020329-0000-0000-C000-000000000046`) | 3,277 | 20% |
| Namespace | Custom namespace<br>(Identified by a custom GUID) | 3,277 | 20% |
| Prefix | Named properties within a namespace that have the same prefix | 1,638 | Not applicable |

Clarifications on quotas:

- The total number of named property definitions across all namespaces in a mailbox is capped at 16,384, regardless of individual quotas. Individual namespace quotas represent a theoretical maximum.
- Microsoft reserves about 25% of the overall quota for internal use. The listed quotas include both customer-defined and reserved named properties.
- Each custom namespace is limited to 3,277 named property definitions. There's no limit to the number of custom namespaces that you can create.
- The prefix quota (1,638) applies within each namespace, restricting the number of named property definitions that share the same first five characters.

> [!TIP]
> To confirm the overall quota for all named property definitions in a mailbox, run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell): `Get-MailboxStatistics -Identity <user ID> | Format-List NamedPropertiesCountQuota`

## Workaround

Use the following steps:

1. [Determine which named properties have reached their quotas](#determine-which-named-properties-have-reached-their-quotas).

2. [Repair the mailbox](#repair-the-mailbox).

### Determine which named properties have reached their quotas

Run the [Test-MailboxExtendedProperty.ps1](https://microsoft.github.io/CSS-Exchange/M365/Test-MailboxExtendedProperty/) script to determine which namespace quota for the user mailbox has been reached:

- If the output of the script reports that a specific namespace has reached its quota, note the namespace.
- If the output of the script reports that the total named properties quota is exceeded, but no individual namespace has reached its quota, note the namespace that's most saturated.

If the noted namespace is the InternetHeaders or PublicStrings namespace, go to [InternetHeaders or PublicStrings](#internetheaders-or-publicstrings-namespace). Otherwise, go to [Custom namespace](#custom-namespace).

#### InternetHeaders or PublicStrings namespace

1. Run the following PowerShell cmdlet to list the named property definitions for the applicable namespace:

   ```PowerShell
   $userId = "<SMTP address or alias>"
   $namespaceGuid = "<GUID>"
   Get-MailboxExtendedProperty -Identity $userId | Where-Object {$_.PropertyNamespace -eq $namespaceGuid} | ForEach-Object { [PSCustomObject]@{Value = if ($_.PropertyName -ne $null) {$_.PropertyName} else {$_.PropertyId.ToString()}; PropertyType = $_.PropertyType} } | Sort-Object Value | Format-Table -AutoSize @{Label='PropertyName or PropertyId'; Expression={$_.Value}}, PropertyType
   ```

   The command output alphabetically lists named property identifiers, either **PropertyName** or **PropertyId**, depending on which is populated in the named property definition. Check for instances where the number of **PropertyName** or **PropertyId** values that share a common prefix is greater than the allowed prefix quota. For example, you might find several thousand **PropertyName** values that start with `X-DG-Ref-`.

2. Research these questions:

   - Which Outlook add-in or app created the named property definitions that have that prefix?
   - Can the add-in or app be removed or updated to a version that doesn't create excessive named property definitions?

   **Note**: For an example of an Outlook add-in that saturates the PublicStrings namespace, see [Outlook sync issues cause emails to be stuck in the Outbox and undeliverable mail items](https://support.microsoft.com/office/outlook-sync-issues-cause-emails-to-be-stuck-in-the-outbox-and-undeliverable-mail-items-d0f23200-a50b-4e89-9b96-54c602d5540f).

3. If the excessive named property definitions exist in the **PublicStrings** namespace and are identified by a **PropertyName**, go to [Repair the mailbox](#repair-the-mailbox). Otherwise, contact [Microsoft Support](https://support.microsoft.com/contactus/) for further assistance.

#### Custom namespace

1. Research these questions:

   - Which Outlook add-in or app created the namespace?
   - Can the add-in or app be removed or updated to a version that doesn't create excessive named property definitions?
   - Do any unnecessary named properties that saturate the namespace have an identifiable pattern in **PropertyName** or **PropertyId**?

2. Contact [Microsoft Support](https://support.microsoft.com/contactus/) for further assistance.

### Repair the mailbox

> [!IMPORTANT]
> - This procedure applies only to named properties in the **PublicStrings** namespace. The named properties must be identified by a **PropertyName**. 
> - Named properties that are reserved for Microsoft internal use (well-known properties) can't be removed.
> - The cleanup task works at a low level, allowing it to remove named properties even from a mailbox under a compliance hold.

Make sure that you have uninstalled the Outlook add-in or app that's causing the issue, or updated it to a working version. Then, use the following steps to repair the mailbox.

> [!WARNING]
> Incorrect use of this procedure can permanently damage a mailbox. Carefully check all the named properties that you specify. This procedure permanently deletes all instances of those properties and their associated values from messages, attachments, embedded messages, and folders. Although it's possible to cancel a scheduled cleanup request, canceling a cleanup request that has started won't undo any changes that are already made.

1. Run the following PowerShell commands to get the named properties that match the naming pattern (prefix) that you previously identified in the [PublicStrings namespace](#internetheaders-or-publicstrings-namespace):

   ```PowerShell
   $userId = "<SMTP address or alias>"
   $pattern = "<wildcard pattern>" # e.g., "X-DG-Ref-*" or "MyApp_Setting_*"
   $publicStringsGuid = "00020329-0000-0000-c000-000000000046"
   $namedProperties = Get-MailboxExtendedProperty -Identity $userId | Where-Object { $_.PropertyName -like $pattern -and $_.PropertyNamespace -eq $publicStringsGuid}
   ```

2. Run the following PowerShell command to generate a comma-separated string of formatted named property identifiers:

   ```PowerShell
   $formattedProps = ($namedProperties | ForEach-Object { "s#{0}#{1}#31" -f $_.PropertyNamespace, $_.PropertyName }) -Join ","
   ```

   The command output is the required formatted string value for the -Properties parameter of the New-MailboxExtendedPropertyCleanupRequest PowerShell cmdlet.

   <a id="step-3"></a>
3. Run the following PowerShell cmdlet to check the number of mailbox items that have named properties that match the specified pattern. These named properties will be removed if the cmdlet is run without the **DetectOnly** parameter.

   ```PowerShell
   New-MailboxExtendedPropertyCleanupRequest -Identity $userId -Properties $formattedProps -DetectOnly
   ```

   This command makes no changes to the mailbox. The `CorruptionsDetected` parameter indicates the number of mailbox items found that have named properties that match the specified pattern. For information about errors that you might receive when you run this cmdlet, see [Cleanup request errors](#cleanup-request-errors).

   <a id="step-4"></a>
4. Run the following PowerShell cmdlet to clean up the named properties:

   ```PowerShell
   $cleanupRequest = New-MailboxExtendedPropertyCleanupRequest -Identity $userId -Properties $formattedProps
   ```

   Cleanup requests are queued until sufficient server resources are available and the mailbox load is low. Queued cleanup requests typically enter the `Running` state within 24 hours. After the cleanup request state transitions from `Queued` to `Running`, the request usually takes under an hour to complete. The duration depends on the mailbox size.

   If you want to cancel a scheduled cleanup request, run the following PowerShell cmdlet.

   ```PowerShell
   Remove-MailboxExtendedPropertyCleanupRequest -Identity $cleanupRequest.Identity
   ```

   Cancelling a cleanup request that has started won't undo any changes that are already made.

5. Run the following PowerShell cmdlet to monitor your cleanup request:

   ```PowerShell
   Get-MailboxExtendedPropertyCleanupRequest -Identity $cleanupRequest.Identity | Select-Object -Property * -ExcludeProperty Argument | Format-List
   ```

   When the cleanup request finishes and its state shows as `Succeeded`, Exchange Online automatically schedules a mailbox move. The move finishes the cleanup process by removing the unwanted named property definitions from the mailbox. The move can take from a few hours to a few days, depending on the size of the mailbox and the availability of system resources in Exchange Online.

   > [!TIP]
   > - If the state of the cleanup request shows as `Failed`, rerun the command from Step 4 to schedule a new request.
   > - Completed requests are eventually purged from the system, so if you encounter an error message stating that a request wasn't found, go to step 6.

6. Run the following PowerShell commands to check whether the entire cleanup process, including the mailbox move, has finished:

   ```PowerShell
   $moves = Get-MailboxStatistics -Identity <user ID> -IncludeMoveHistory
   $moves.MoveHistory[0] | Format-List Status, StartTimestamp, CompletionTimestamp 
   ```

   Verify that the **Status** value is `Completed` and the **CompletionTimestamp** value is a past date.

7. To verify that the targeted named properties are deleted, repeat Step 1. You can also check the number of named properties in each namespace by rerunning the [Test-MailboxExtendedProperty.ps1](https://microsoft.github.io/CSS-Exchange/M365/Test-MailboxExtendedProperty/) script.

## Cleanup request errors

The following table lists the cleanup request errors that you might receive when you run the New-MailboxExtendedPropertyCleanupRequest cmdlet.

| **Error code** | **Error descriptor** | **Resolution** |
|-|-|-|
|    1041 | CorruptStore | Contact [Microsoft Support](https://support.microsoft.com/contactus/) for assistance. |
|    1127 | InvalidRecipients | Make sure that the user mailbox isn't soft deleted or hard deleted. |
|    1201 | OperationCannotContinue | The cleanup request was unexpectedly interrupted during the `Running` state. Rerun the command in Step 4 to schedule a new cleanup request. If the issue persists, contact [Microsoft Support](https://support.microsoft.com/contactus/) for assistance. |
|    1280 | Timeout | The cleanup request timed out after entering the `Running` state. The maximum duration of the running state is 2 hours. Rerun the command in [Step 4](#step-4) to schedule a new cleanup request. When the new cleanup request enters the `Running` state, it resumes where it left off. |
| <ul><li>1222</li><li>-2147746050</li><li>0x80040102</li><li>blank value</li></ul> | <ul><li>NotSupported</li><li>UserException</li></ul> | Check the list of named properties that you pass to the New-MailboxExtendedPropertyCleanupRequest cmdlet in [Step 3](#step-3). Make sure that:<ul><li>The list contains at least one named property.</li><li>The named properties are in the required format.</li><li>All named properties exist in the PublicStrings namespace. </li></ul> |
| 1401 | DuplicateObject | A cleanup request tried to clean the same mailbox that another cleanup request is processing. Check the status of the original cleanup request. If that also failed, reschedule a single new cleanup request. |
| 5002 | TaskRequestFailed | Contact [Microsoft Support](https://support.microsoft.com/contactus/) for assistance. |

## Structure of a named property definition

To get detailed information about a named property, you can run the following PowerShell cmdlet:

```PowerShell
$userId = "<SMTP address or alias>"
$namespaceGuid = "<GUID>"
$propertyNameOrId = "<property name or ID>"
Get-MailboxExtendedProperty -Identity $userId | Where-Object {$_.PropertyNamespace -eq $namespaceGuid -and ($_.PropertyName -eq $propertyNameOrId -or $_.PropertyId -eq $propertyNameOrId)} | Format-List
```

The following example shows the definition of a named property in the PublicStrings namespace:

> MailboxLocation : 6e096ff1-28d9-4d85-8e7e-6766467ce548\ffb78758-45d7-4db5-9fa4-a298733cbb04  
> PropertyTag : 32864  
> PropertyNamespace : 00020329-0000-0000-c000-000000000046  
> PropertyId :  
> PropertyName : LastCapturedGestureTime  
> PropertyType : StringProperty  
> Identity : 6e096ff1-28d9-4d85-8e7e-6766467ce548\ffb78758-45d7-4db5-9fa4-a298733cbb04:00020329-0000-0000-c000-000000000046\LastCapturedGestureTime  
> IsValid : True  
> ObjectState : Unchanged  

### Definition fields

- **MailboxLocation**: Identifies the mailbox. The format is: `<tenant ID>\<Exchange mailbox GUID>`.
- **PropertyTag**: A MAPI internal identifier for the named property within the context of the mailbox.
- **PropertyNamespace**: A GUID that identifies the named property namespace. The value matches one of the following namespaces:
   - InternetHeaders (`00020386-0000-0000-C000-000000000046`). Commonly used by older add-ins.
   - PublicStrings (`00020329-0000-0000-C000-000000000046`). Commonly used by older add-ins.
   - Custom namespace. Most new add-ins define named properties in a custom namespace.
- **PropertyId** or **PropertyName**: Identifies the named property within the **PropertyNamespace** by using either a numerical ID (**PropertyId**) or a string name (**PropertyName**).
- **PropertyType**: The data type of the named property. For example, `StringProperty` or `IntegerProperty`.
- **Identity**: Identifies the named property within the mailbox. The format is: `<MailboxLocation>:<PropertyNamespace>\<PropertyId or PropertyName>`.
- **IsValid** and **ObjectState**: Status fields.
