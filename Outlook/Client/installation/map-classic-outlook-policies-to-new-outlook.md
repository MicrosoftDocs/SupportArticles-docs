---
title: Map Classic Outlook Policies to New Outlook
description: Discusses how to map classic Outlook policies, such as Cloud Policy and ADMX policies, to new Outlook policies, such as Outlook on the web mailbox policies.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Install, Update, Activate, and Deploy
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 3448
ms.reviewer: cibeler, vickim, jhollander, jeffkalv, meerak, v-shorestris
appliesto:
  - New Outlook for Windows
search.appverid: MET150
ms.date: 02/13/2025
---

# Map classic Outlook policies to new Outlook

If your organization uses policies to configure classic Outlook, you might want to implement comparable policies for new Outlook. All [ADMX policies](/windows/client-management/understanding-admx-backed-policies) and most policies from [Cloud Policy service for Microsoft 365](/microsoft-365-apps/admin-center/overview-cloud-policy) (Cloud policies) apply only to classic Outlook. This article discusses how you can map ADMX and Cloud policies for classic Outlook to the following policies for new Outlook:

- Cloud policies that apply to new Outlook
- [Mailbox policies for Outlook on the web and new Outlook](/exchange/clients-and-mobile-in-exchange-online/outlook-on-the-web/create-outlook-web-app-mailbox-policy) (Outlook on the web mailbox policies)

> [!NOTE]
> Outlook on the web mailbox policies also affect new Outlook.

## Find existing policies for classic Outlook

### Cloud policies

Use the following steps to find the existing Cloud policies for classic Outlook that are used in your organization:

1. Sign in to the [Microsoft 365 Apps admin center](https://config.office.com/).

2. Select **Customization** \> **Policy Management** to view a list of policy configurations.

   **Note**: A policy configuration is a set of Cloud policies. Each policy configuration is scoped to a set of users.

3. For each policy configuration, select its checkbox, and then select **Export** to generate a CSV file that lists all policies that are in the policy configuration.

4. For each policy that's listed in an exported CSV file, the **Setting ID** value contains the policy ID. If a **Setting ID** value consists of multiple values that are separated by a semicolon, ignore `outlk16`. Typically, pick the rightmost value. Make a list of the applicable policy IDs for all policies that are in the exported CSV files.

> [!NOTE]
> If the **Scope** value in the exported CSV file is `Group`, the **Groups** value names the groups that all policies in the policy configuration apply to. To identify a group's membership, see [Bulk download members of a group](/entra/identity/users/groups-bulk-download-members).

### ADMX policies

Use the following steps to determine the ADMX policies that are used in your organization:

1. Run the PowerShell cmdlet [Get-GPOReport](/powershell/module/grouppolicy/get-gporeport) on a domain controller to get a list of Group Policies for a domain. Alternatively, you can view the list of Group Policies for a domain on the **Settings** tab of the [Group Policy Management Console](/windows-server/identity/ad-ds/manage/group-policy/group-policy-management-console).

2. In the list of Group Policies for a domain, the ADMX policies for Outlook are listed under **User Configuration (Enabled)** \> **Policies** \> **Administrative Templates** \> **Microsoft Outlook 2016/\<policy category\>**. For example, you might see an Outlook policy that's named **Keep Search Folders in Exchange Online**. Make a list of the Outlook policy names.

3. Search for each Outlook policy name in the language-specific administrative template file, _outlk16.adml_, to find the associated policy ID. For example, the **Keep Search Folders in Exchange Online** policy has the policy ID `L_KeepsearchfoldersinExchangeonline`. Make a list of the policy IDs.

   > [!TIP]
   > The _outlk16.adml_ file is usually located in the _%SystemRoot%\PolicyDefinitions\\<locale\>_ folder on a domain controller. Alternatively, you can download the _outlk16.adml_ file from [Group Policy Administrative Template files (ADMX/ADML)](https://www.microsoft.com/download/details.aspx?id=49030).

## Determine policies for new Outlook

Use the following tables to map classic Outlook policies to equivalent or related new Outlook policies.

If your organization directly edits registry keys instead of using Group Policy to configure classic Outlook, use the **Registry values for classic Outlook** column instead of the **Policy IDs for classic Outlook** column.

If the tables don't include a particular policy ID or registry value for classic Outlook, a comparable policy for new Outlook might not exist.

</br>
<details>
<summary><b>Table: Account management policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_Preventusersfromaddingemailaccounttypes](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[L_PreventusersfromaddingIMAPemailaccounts](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[L_PreventusersfromaddingPOP3emailaccounts](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[L_PreventusersfromaddingExchangeemailaccounts](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[L_PreventusersfromaddingEASemailaccounts](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[L_Preventusersfromaddingothertypesofemailaccounts](https://gpsearch.azurewebsites.net/#12610) | •&nbsp;[disableimap](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[disablepop3](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[disableexchange](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[disableeas](https://gpsearch.azurewebsites.net/#12610)<br>•&nbsp;[disableothertypes](https://gpsearch.azurewebsites.net/#12610) | Controls whether users can add personal email accounts to Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the parameter [PersonalAccountsEnabled](/powershell/module/exchange/set-owamailboxpolicy#-personalaccountsenabled). For more information, see [Allow only corporate mailboxes to be added](/microsoft-365-apps/outlook/manage/policy-management#allow-only-corporate-mailboxes-to-be-added). |
| •&nbsp;[L_AutomaticallyConfigureProfileBasedOnActive](https://gpsearch.azurewebsites.net/#13841) | •&nbsp;[zeroconfigexchange](https://gpsearch.azurewebsites.net/#13841) | Configures the primary account in Outlook. | Enable the Cloud policy: **Require the Primary Account to match the Windows signed-in account**.<br>For more information, see [Automatically configure account](/microsoft-365-apps/outlook/manage/policy-management#automatically-configure-account-based-on-active-directory-primary-smtp-address).<br>**Note**: We strongly recommend that you enable this Cloud policy if you [disable personal accounts](/powershell/module/exchange/set-owamailboxpolicy#-personalaccountsenabled). |

</details>
</br>
<details>
<summary><b>Table: Attachment management policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_Level1Attachments](https://gpsearch.azurewebsites.net/#12419)<br>•&nbsp;[L_Level2AddFilePolicy](https://gpsearch.azurewebsites.net/#12426)<br>•&nbsp;[L_additionalextensions23](https://gpsearch.azurewebsites.net/#12426) | •&nbsp;[showlevel1attach](https://gpsearch.azurewebsites.net/#12419)<br>•&nbsp;[fileextensionsaddlevel2](https://gpsearch.azurewebsites.net/#12426) | Configures how Outlook handles potentially dangerous email attachments. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with one or more of the following parameters:<br>•&nbsp;[AllowedFileTypes](/powershell/module/exchange/set-owamailboxpolicy#-allowedfiletypes)<br>•&nbsp;[BlockedFileTypes](/powershell/module/exchange/set-owamailboxpolicy#-blockedfiletypes)<br>•&nbsp;[DirectFileAccessOnPrivateComputersEnabled](/powershell/module/exchange/set-owamailboxpolicy#-directfileaccessonprivatecomputersenabled)<br>•&nbsp;[DirectFileAccessOnPublicComputersEnabled](/powershell/module/exchange/set-owamailboxpolicy#-directfileaccessonpubliccomputersenabled)<br>•&nbsp;[ForceSaveFileTypes](/powershell/module/exchange/set-owamailboxpolicy#-forcesavefiletypes)<br>•&nbsp;[ForceSaveMimeTypes](/powershell/module/exchange/set-owamailboxpolicy#-forcesavemimetypes)<br>For more information, see [Specify what attachments can be downloaded](/microsoft-365-apps/outlook/manage/policy-management#specify-what-attachments-can-be-downloaded). |
| •&nbsp;[L_DisableAttachmentPreviewing](https://gpsearch.azurewebsites.net/#12298) | •&nbsp;[disableattachmentpreviewing](https://gpsearch.azurewebsites.net/#12298) | Specifies whether users can preview attachments in email messages. For more information, see [Public attachment handling](/exchange/clients-and-mobile-in-exchange-online/outlook-on-the-web/public-attachment-handling). | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [ConditionalAccessPolicy](/powershell/module/exchange/set-owamailboxpolicy#-conditionalaccesspolicy) parameter. To prevent attachment preview, set the parameter value to `ReadOnlyPlusAttachmentsBlocked`.<br>Other related parameters:<br>•&nbsp;[DirectFileAccessOnPrivateComputersEnabled](/powershell/module/exchange/set-owamailboxpolicy#-directfileaccessonprivatecomputersenabled)<br>•&nbsp;[DirectFileAccessOnPublicComputersEnabled](/powershell/module/exchange/set-owamailboxpolicy#-directfileaccessonpubliccomputersenabled) |
| •&nbsp;[L_InternetAndNetworkPathsIntoHyperlinks](https://gpsearch.azurewebsites.net/#12379)  | [pgrfafo_25_1](https://gpsearch.azurewebsites.net/#12379) | Configures how Outlook handles internet and network paths in email messages. | Use the [Set-MailboxMessageConfiguration](/powershell/module/exchange/set-mailboxmessageconfiguration#-linkpreviewenabled) cmdlet together with the [LinkPreviewEnabled](/powershell/module/exchange/set-mailboxmessageconfiguration#-linkpreviewenabled) parameter to control whether Outlook enables [link previews](https://support.microsoft.com/office/use-link-preview-in-outlook-com-and-outlook-on-the-web-ebbfd8ce-d38e-40ef-bb8c-a5362e881163) in email messages. |

</details>
</br>
<details>
<summary><b>Table: Data sharing management policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_OSTCreation](https://gpsearch.azurewebsites.net/#12521) | •&nbsp;[noost](https://gpsearch.azurewebsites.net/#12521) | Configures offline capabilities in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [OfflineEnabledWin](/powershell/module/exchange/set-owamailboxpolicy#-offlineenabledwin) parameter to specify whether new Outlook can create files for offline use. For more information, see [Disable offline mode](/microsoft-365-apps/outlook/manage/policy-management#disable-offline-mode).<br>**Note**: New Outlook doesn't create OST files and instead uses cached mode. |
| •&nbsp;[L_TurnOffContactExport](https://gpsearch.azurewebsites.net/#12363) | •&nbsp;[disableexportingcontact](https://gpsearch.azurewebsites.net/#12363) | Specifies whether users can export contacts from the Outlook address book. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [AllowCopyContactsToDeviceAddressBook](/powershell/module/exchange/set-owamailboxpolicy#-allowcopycontactstodeviceaddressbook) parameter. |
| •&nbsp;[L_DoNotDownloadPhotosFromTheActiveDirectory](https://gpsearch.azurewebsites.net/#12392) | •&nbsp;[downloadphotosfromad](https://gpsearch.azurewebsites.net/#12392) | Configures photo settings. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [DisplayPhotosEnabled](/powershell/module/exchange/set-owamailboxpolicy#-displayphotosenabled) parameter. |
| •&nbsp;[L_PreventCopyingOrMovingItemsBetweenAccounts](https://gpsearch.azurewebsites.net/#12513) | •&nbsp;[disablecrossaccountcopy](https://gpsearch.azurewebsites.net/#12513) | Specifies whether users can copy and move items between Outlook accounts. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [ItemsToOtherAccountsEnabled](/powershell/module/exchange/set-owamailboxpolicy#-itemstootheraccountsenabled) parameter. |
| •&nbsp;[L_Preventusersfromaddingpsts](https://gpsearch.azurewebsites.net/#12596)<br>•&nbsp;[L_empty78](https://gpsearch.azurewebsites.net/#12596)<br>•&nbsp;[L_Preventusersfromaddingnewcontentto](https://gpsearch.azurewebsites.net/#12597) | •&nbsp;[disablepst](https://gpsearch.azurewebsites.net/#12596)<br>[pstdisablegrow](https://gpsearch.azurewebsites.net/#12597) | Controls what users can do with PST files. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [OutlookDataFile](/powershell/module/exchange/set-owamailboxpolicy#-outlookdatafile) parameter. |

</details>
</br>
<details>
<summary><b>Table: Calendar management policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_ShortenEventsType](https://gpsearch.azurewebsites.net/#15973)<br>•&nbsp;[L_SelecttheShortenEventsType](https://gpsearch.azurewebsites.net/#15973)<br>•&nbsp;[L_EnableEndEarly](https://gpsearch.azurewebsites.net/#14434) | •&nbsp;[shortenevents](https://gpsearch.azurewebsites.net/#15973)<br>•&nbsp;[endeventsearly](https://gpsearch.azurewebsites.net/#14434) | Shortens appointments and meetings by ending them early. | Use the [Set-OrganizationConfig](/powershell/module/exchange/set-organizationconfig) cmdlet together with one or more of the following parameters:<br>•&nbsp;[DefaultMinutesToReduceShortEventsBy](/powershell/module/exchange/set-organizationconfig#-defaultminutestoreduceshorteventsby)<br>•&nbsp;[DefaultMinutesToReduceLongEventsBy](/powershell/module/exchange/set-organizationconfig#-defaultminutestoreducelongeventsby)<br>•&nbsp;[ShortenEventScopeDefault](/powershell/module/exchange/set-organizationconfig#-shorteneventscopedefault) |
| •&nbsp;[L_Firstweekofyear](https://gpsearch.azurewebsites.net/#12346)<br>•&nbsp;[L_Choosethefirstweekoftheyear](https://gpsearch.azurewebsites.net/#12346)<br>•&nbsp;[L_Firstdayoftheweek](https://gpsearch.azurewebsites.net/#12345)<br>•&nbsp;[L_Choosethefirstdayoftheweek](https://gpsearch.azurewebsites.net/#12345)  | •&nbsp;[firstwoy](https://gpsearch.azurewebsites.net/#12346)<br>•&nbsp;[firstdow](https://gpsearch.azurewebsites.net/#12345) | Configures the first week of the year, and the first day of the week. | Use the [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration) cmdlet together with one or more of the following parameters:<br>•&nbsp;[FirstWeekOfYear](/powershell/module/exchange/set-mailboxcalendarconfiguration#-firstweekofyear)<br>•&nbsp;[WeekStartDay](/powershell/module/exchange/set-mailboxcalendarconfiguration#-weekstartday) |
| •&nbsp;[L_Accesstopublishedcalendars](https://gpsearch.azurewebsites.net/#12326) | •&nbsp;[restrictedaccessonly](https://gpsearch.azurewebsites.net/#12326) | Specifies whether users can access [published calendars](https://support.microsoft.com/office/introduction-to-publishing-internet-calendars-a25e68d6-695a-41c6-a701-103d44ba151d). | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [InterestingCalendarsEnabled](/powershell/module/exchange/set-owamailboxpolicy#-interestingcalendarsenabled) parameter. |
| •&nbsp;[L_Restrictuploadmethod](https://gpsearch.azurewebsites.net/#12327)<br>•&nbsp;[L_PreventpublishingtoOfficeOnline](https://gpsearch.azurewebsites.net/#12322) | •&nbsp;[singleuploadonly](https://gpsearch.azurewebsites.net/#12327)<br>•&nbsp;[disableofficeonline](https://gpsearch.azurewebsites.net/#12322) | Configures calendar sharing settings in Outlook. | Use the [New-SharingPolicy](/powershell/module/exchange/new-sharingpolicy) cmdlet to [create a sharing policy](/exchange/sharing/sharing-policies/create-a-sharing-policy). |
| •&nbsp;[L_Workinghours](https://gpsearch.azurewebsites.net/#12347)<br>•&nbsp;[L_Starttime](https://gpsearch.azurewebsites.net/#12347)<br>•&nbsp;[L_EndTime](https://gpsearch.azurewebsites.net/#12347) | •&nbsp;[caldefstart](https://gpsearch.azurewebsites.net/#12347)<br>•&nbsp;[caldefend](https://gpsearch.azurewebsites.net/#12347) | Configures a user's working hours in Outlook Calendar. | Use the [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration) cmdlet together with one or more of the following parameters:<br>•&nbsp;[WorkingHoursStartTime](/powershell/module/exchange/set-mailboxcalendarconfiguration#-workinghoursstarttime)<br>•&nbsp;[WorkingHoursEndTime](/powershell/module/exchange/set-mailboxcalendarconfiguration#-workinghoursendtime) |
| •&nbsp;[L_RemindersonCalendaritems](https://gpsearch.azurewebsites.net/#12342) | •&nbsp;[apptreminders](https://gpsearch.azurewebsites.net/#12342) | Configures reminders for Calendar items. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [RemindersAndNotificationsEnabled](/powershell/module/exchange/set-owamailboxpolicy#-remindersandnotificationsenabled) parameter.<br>Use the [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration) cmdlet together with one or more of the following parameters:<br>•&nbsp;[RemindersEnabled](/powershell/module/exchange/set-mailboxcalendarconfiguration#-remindersenabled)<br>•&nbsp;[ReminderSoundEnabled](/powershell/module/exchange/set-mailboxcalendarconfiguration#-remindersoundenabled) |

For other mailbox calendar settings, see [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration).

</details>
</br>
<details>
<summary><b>Table: Diagnostic policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_DisableSupportTicketCreationInOutlook](https://gpsearch.azurewebsites.net/#14974) | •&nbsp;[disablesupportticketcreationinoutlook](https://gpsearch.azurewebsites.net/#14974) | Disables support ticket creation in Outlook. | Enable the Cloud policy: **Disable support ticket creation in Outlook**. |
| •&nbsp;[L_DisableSupportDiagnostics](https://gpsearch.azurewebsites.net/#14975)<br>•&nbsp;[L_DisableOnlineModeAuthDiagnostics](https://gpsearch.azurewebsites.net/#14433) | •&nbsp;[disablesupportdiagnostics](https://gpsearch.azurewebsites.net/#14975)<br>•&nbsp;[disableonlinemodeauthdiagnostics](https://gpsearch.azurewebsites.net/#14433) | Configures diagnostic settings in Outlook. | Enable the Cloud policy: **Disable support diagnostics in Outlook**.<br>For more information, see [Get diagnostics feature for users to submit logs to Microsoft Support](https://m365admin.handsontek.net/new-microsoft-outlook-new-get-diagnostics-feature-for-users-to-submit-logs-to-microsoft-support-during-an-interaction/). |
| •&nbsp;[L_DisableSupportBackstage](https://gpsearch.azurewebsites.net/#14976) | •&nbsp;[disablesupportbackstage](https://gpsearch.azurewebsites.net/#14976) | Configures Microsoft Support settings in Outlook. | Enable the Cloud policy: **Disable the Support tab under the File menu in Outlook**.<br>To disable all support options, disable the Cloud policy: **Allow access to Contact Support in the new Outlook**.<br>For more information, see [Disable contact support](/microsoft-365-apps/outlook/manage/policy-management#disable-contact-support-in-the-new-outlook-for-windows). |
| •&nbsp;[L_Enablemailloggingtroubleshooting](https://gpsearch.azurewebsites.net/#12408) | •&nbsp;[enablelogging](https://gpsearch.azurewebsites.net/#12408) | Enables [mail logging](https://support.microsoft.com/office/what-is-the-enable-logging-troubleshooting-option-0fdc446d-d1d4-42c7-bd73-74ffd4034af5) in Outlook. | Enable the Cloud policy: **Enable mail logging (troubleshooting)**. |
| •&nbsp;[L_DisableOutlookFeedbackFeatures](https://gpsearch.azurewebsites.net/#14977) | •&nbsp;[disableoutlookfeedbackfeatures](https://gpsearch.azurewebsites.net/#14977) | Configures feedback settings in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [FeedbackEnabled](/powershell/module/exchange/set-owamailboxpolicy#-feedbackenabled) parameter to disable inline feedback surveys.<br>To manage other feedback options, see [Manage Microsoft feedback](/microsoft-365/admin/manage/manage-feedback-ms-org). |

</details>
</br>
<details>
<summary><b>Table: Mail configuration policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_MSGUnicodeformatwhendraggingtofilesystem](https://gpsearch.azurewebsites.net/#12409) | •&nbsp;[msgformat](https://gpsearch.azurewebsites.net/#12409) | Specifies whether e-mail messages that are dragged from Outlook to the file system are saved in Unicode or ANSI format. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the [UseISO885915](/powershell/module/exchange/set-owamailboxpolicy#-useiso885915) parameter. |
| •&nbsp;[L_RepliesOrForwardsToSignedEncryptedMessagesAreSignedEncrypted](https://gpsearch.azurewebsites.net/#12447) | •&nbsp;[nocheckonsessionsecurity](https://gpsearch.azurewebsites.net/#12447) | Configures message encryption settings. | [Manage message encryption](/purview/manage-office-365-message-encryption) |
| •&nbsp;[L_ReadingPane](https://gpsearch.azurewebsites.net/#12399)<br>•&nbsp;[L_Markitemasreadwhenselectionchanges](https://gpsearch.azurewebsites.net/#12399)<br>•&nbsp;[L_Waitxxxsecondsbeforemarkingitemsasread](https://gpsearch.azurewebsites.net/#12399) | •&nbsp;[previewdontmarkuntilchange](https://gpsearch.azurewebsites.net/#12399)<br>•&nbsp;[previewwaitseconds](https://gpsearch.azurewebsites.net/#12399) | Configures **Mark as Read** behavior in the Outlook reading pane. | Use the [Set-MailboxMessageConfiguration](/powershell/module/exchange/set-mailboxmessageconfiguration) cmdlet together with the following parameters:<br>•&nbsp;[PreviewMarkAsReadBehavior](/powershell/module/exchange/set-mailboxmessageconfiguration#-previewmarkasreadbehavior)<br>•&nbsp;[PreviewMarkAsReadDelaytime](/powershell/module/exchange/set-mailboxmessageconfiguration#-previewmarkasreaddelaytime) |

</details>
</br>
<details>
<summary><b>Table: Offline configuration policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_DisallowDownloadFullItemsFileCachedExchangeMode](https://gpsearch.azurewebsites.net/#12491)<br>•&nbsp;[L_InCachedExchangemakeSendReceiveF9nulloperation](https://gpsearch.azurewebsites.net/#12486) | •&nbsp;[nofullitems](https://gpsearch.azurewebsites.net/#12491)<br>•&nbsp;[nomanualonlinesync](https://gpsearch.azurewebsites.net/#12486) | Configures Cached Exchange mode in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [OfflineEnabledWin](/powershell/module/exchange/set-owamailboxpolicy#-offlineenabledwin) parameter. For more information, see [Disable offline mode](/microsoft-365-apps/outlook/manage/policy-management#disable-offline-mode). |

</details>
</br>
<details>
<summary><b>Table: Security configuration policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_RequestanSMIMEreceiptforallSMIMEsignedmessages](https://gpsearch.azurewebsites.net/#12461)<br>•&nbsp;[L_SMIMEinteroperabilitywithexternalclients](https://gpsearch.azurewebsites.net/#12450)<br>•&nbsp;[L_BehaviorforhandlingSMIMEmessages](https://gpsearch.azurewebsites.net/#12450) | •&nbsp;[requestsecurereceipt](https://gpsearch.azurewebsites.net/#12461)<br>•&nbsp;[externalsmime](https://gpsearch.azurewebsites.net/#12450) | Configures S/MIME encryption settings in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the parameter [SMimeEnabled](/powershell/module/exchange/set-owamailboxpolicy#-smimeenabled).<br>Use the [Set-SmimeConfig](/powershell/module/exchange/set-smimeconfig) cmdlet together with the  [OWAAlwaysEncrypt](/powershell/module/exchange/set-owamailboxpolicy#-offlineenabledwin) parameter to specify whether Outlook automatically encrypts outgoing email messages.<br>For more information, see [Encrypt emails with S/MIME](https://support.microsoft.com/office/encrypt-emails-with-s-mime-or-microsoft-365-message-encryption-in-outlook-373339cb-bf1a-4509-b296-802a39d801dc). |
| •&nbsp;[L_DonotdownloadpermissionlicenseforIRMemailduring](https://gpsearch.azurewebsites.net/#12609) | •&nbsp;[donotacquiredrmlicenseonsync](https://gpsearch.azurewebsites.net/#12609) | Configures Information Rights Management (IRM) features in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the [IRMEnabled](/powershell/module/exchange/set-owamailboxpolicy#-irmenabled) parameter.<br>For more information, see [Enable or disable IRM](/exchange/enable-or-disable-information-rights-management-on-client-access-servers-exchange-2013-help). |
| •&nbsp;[L_HideJunkMailUI](https://gpsearch.azurewebsites.net/#12366) | •&nbsp;[disableantispam](https://gpsearch.azurewebsites.net/#12366) | Configures junk email settings. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [ReportJunkEmailEnabled](/powershell/module/exchange/set-owamailboxpolicy#-reportjunkemailenabled) parameter to specify paths for the **Blocked senders** list and **Safe senders** list.<br>For more information, see [Configure junk email settings](/defender-office-365/configure-junk-email-settings-on-exo-mailboxes). |

</details>
</br>
<details>
<summary><b>Table: Other features policies</b></summary>

| **Policy IDs for classic Outlook** | **Registry values for classic Outlook** | **Notes** | **Policies for new Outlook** |
|-|-|-|-|
| •&nbsp;[L_BlockAllUnmanagedAddins](https://gpsearch.azurewebsites.net/#12626)<br>•&nbsp;[L_ListOfManagedAddins](https://gpsearch.azurewebsites.net/#12627)<br>•&nbsp;[L_ListOfManagedAddins2](https://gpsearch.azurewebsites.net/#12627)<br>•&nbsp;[L_SetTrustedAddins](https://gpsearch.azurewebsites.net/#12439)<br>•&nbsp;[L_ListOfTrustedAddins](https://gpsearch.azurewebsites.net/#12439) | •&nbsp;[restricttolist](https://gpsearch.azurewebsites.net/#12626) | Controls Outlook add-ins. | Use the [Set-OrganizationConfig](/powershell/module/exchange/set-organizationconfig) cmdlet together with the  [AppsForOfficeEnabled](/powershell/module/exchange/set-organizationconfig#-appsforofficeenabled) parameter to enable or disable send add-ins.<br>For more information, see [Add-ins for Outlook](/exchange/clients-and-mobile-in-exchange-online/add-ins-for-outlook/add-ins-for-outlook). |
| •&nbsp;[L_KeepsearchfoldersinExchangeonline](https://gpsearch.azurewebsites.net/#12572)<br>•&nbsp;[L_SpecifydaystokeepfoldersaliveinExchangeonlinemode](https://gpsearch.azurewebsites.net/#12572)<br>•&nbsp;[L_SetDefaultSearchScope](https://gpsearch.azurewebsites.net/#12291)<br>•&nbsp;[L_SetDefaultSearchScopeDropID](https://gpsearch.azurewebsites.net/#12291) | •&nbsp;[searchonlinekeepalivedays](https://gpsearch.azurewebsites.net/#12572)<br>•&nbsp;[defaultsearchscope](https://gpsearch.azurewebsites.net/#12291) | Configures Search Folders and search options in Outlook. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [SearchFoldersEnabled](/powershell/module/exchange/set-owamailboxpolicy#-searchfoldersenabled) parameter. |
| •&nbsp;[L_DisableFileArchive](https://gpsearch.azurewebsites.net/#12413)<br>•&nbsp;[L_AutoArchiveSettings](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_TurnonAutoArchive](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_Permanentlydeleteolditems](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_empty19](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_Cleanoutitemsolderthan](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_Showarchivefolderinfolderlist](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_Archiveordeleteolditems](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_Deleteexpireditemsemailfoldersonly](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_PromptbeforeAutoArchiveruns](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[L_RunAutoArchiveeveryxdays](https://gpsearch.azurewebsites.net/#12414) | •&nbsp;[disablemanualarchive](https://gpsearch.azurewebsites.net/#12413)<br>•&nbsp;[doaging](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[archivedelete](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[archivegranularity](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[archiveperiod](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[archivemount](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[archiveold](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[deleteexpired](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[promptforaging](https://gpsearch.azurewebsites.net/#12414)<br>•&nbsp;[everydays](https://gpsearch.azurewebsites.net/#12414) | Configures mailbox archive settings. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [ShowOnlineArchiveEnabled](/powershell/module/exchange/set-owamailboxpolicy#-showonlinearchiveenabled) parameter.  |
| •&nbsp;[L_DisableSignatures](https://gpsearch.azurewebsites.net/#12378) | •&nbsp;[disablesignatures](https://gpsearch.azurewebsites.net/#12378) | Specifies whether users can add signatures to e-mail messages. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [SignaturesEnabled](/powershell/module/exchange/set-owamailboxpolicy#-signaturesenabled) parameter. |
| •&nbsp;[L_Alwayscheckspellingbeforesending](https://gpsearch.azurewebsites.net/#12391) | •&nbsp;[check](https://gpsearch.azurewebsites.net/#12391) | Configures spell checker settings. | Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [SpellCheckerEnabled](/powershell/module/exchange/set-owamailboxpolicy#-spellcheckerenabled) parameter. |
| •&nbsp;[L_DisableWeather](https://gpsearch.azurewebsites.net/#12356)<br>•&nbsp;[L_WeatherServiceUrl](https://gpsearch.azurewebsites.net/#12354)<br>•&nbsp;[L_Empty](https://gpsearch.azurewebsites.net/#12354) | •&nbsp;[disableweather](https://gpsearch.azurewebsites.net/#12356)<br>•&nbsp;[weatherserviceurl](https://gpsearch.azurewebsites.net/#12354) | Configures weather service features in Outlook. | •  Use the [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet together with the  [WeatherEnabled](/powershell/module/exchange/set-owamailboxpolicy#-weatherenabled) parameter.<br>•  Use the [Set-MailboxCalendarConfiguration](/powershell/module/exchange/set-mailboxcalendarconfiguration) cmdlet together with the [WeatherLocationBookmark](/powershell/module/exchange/set-mailboxcalendarconfiguration#-weatherlocationbookmark) parameter. |

</details>

## Create policies for new Outlook

### Cloud policies

To create Cloud policies, see [Steps for creating a policy configuration](/microsoft-365-apps/admin-center/overview-cloud-policy#steps-for-creating-a-policy-configuration).

### Outlook on the web mailbox policies

To create and assign an Outlook on the web mailbox policy, follow these steps:

1. [Create an Outlook on the web mailbox policy](/exchange/clients-and-mobile-in-exchange-online/outlook-on-the-web/create-outlook-web-app-mailbox-policy#use-exchange-online-powershell-to-create-a-mailbox-policy-for-outlook-on-the-web-and-the-new-outlook-for-windows).

   > [!TIP]
   > We recommend that you use PowerShell instead of the Exchange admin center (EAC) to create Outlook on the web mailbox policies because PowerShell supports more policy options.

2. [Assign an Outlook on the web mailbox policy to a mailbox](/exchange/clients-and-mobile-in-exchange-online/outlook-on-the-web/apply-or-remove-outlook-web-app-mailbox-policy#use-exchange-online-powershell-to-apply-an-outlook-on-the-web-mailbox-policy-to-a-mailbox).

   **Note**: An Outlook on the web mailbox policy is a set of Outlook policies. The [Set-OwaMailboxPolicy](/powershell/module/exchange/set-owamailboxpolicy) cmdlet adds Outlook policies to an Outlook on the web mailbox policy. You can assign only one Outlook on the web mailbox policy to each user mailbox.

   > [!TIP]
   > If you want to assign multiple Outlook on the web mailbox policies to the same user mailbox, add all applicable Outlook policies to a single Outlook on the web mailbox policy. Then assign the single Outlook on the web mailbox policy to the user mailbox.

   To bulk assign the same Outlook on the web mailbox policy to multiple users, run the following cmdlets in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   $users = Import-Csv -Path '<path to a CSV file that lists the users in a column named "User">'
   $users | ForEach-Object { Set-CASMailbox -Identity $_.User -OWAMailboxPolicy "<policy name>" }
   ```

   To check the Outlook on the web mailbox policy for multiple users, run the following PowerShell code:

   ```PowerShell
   $users = Import-Csv -Path '<path to a CSV file that lists the users in a column named "User">'
   $userData = @()
   $users | ForEach-Object {
     $casMailbox = Get-CASMailbox -Identity $_.User
     $userData += [PSCustomObject]@{
       DisplayName = $casMailbox.DisplayName
       PrimarySmtpAddress = $casMailbox.PrimarySmtpAddress
       OWAMailboxPolicy  = $casMailbox.OWAMailboxPolicy
     }
   }
   $userData | Format-Table -AutoSize
   ```
