---
title: Resolve auto-labeling failures in SharePoint and OneDrive files
description: Describes the reasons for auto-labeling failures and provides recommended actions to resolve them.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.service: purview
ms.topic: troubleshooting-general
ms.custom: 
  - sap:Sensitivity Labels\Auto-Labeling
  - CI 12114
  - CSSTroubleshoot
  - msecd-doc-authoring-1030
ms.reviewer: richardstowe, v-gsitser
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 11/24/2026
ai-usage: ai-assisted

#customer intent: As an administrator, I want to identify auto-labeling failure reasons so that I can follow the recommended action for an affected file.

---
# Resolve auto-labeling failures in SharePoint and OneDrive files

## Summary

This article describes why auto-labeling might fail for files on SharePoint and OneDrive for work or school. It provides a list of the failures that you might see in the Microsoft Purview portal and the recommended actions to resolve them.

> [!NOTE]
> If **Total labeled to date** and **Labeling activity** show different counts, see [Numbers don't agree or Exchange activity is missing](troubleshoot-auto-labeling-policies.md#numbers-dont-agree-or-exchange-activity-is-missing). A reporting mismatch alone doesn't establish a labeling failure. Use the failure codes in this article if an affected file has an explicit failure reason.

## About auto-labeling failures

After an auto-labeling policy identifies a file on SharePoint or OneDrive for work or school that matches its conditions, and scans it successfully, either the SharePoint service or the OneDrive service, as appropriate, applies the label. If the service can't complete applying the label, the auto-labeling operation is considered a failure.  
  
Auto-labeling might fail due to any of the following reasons:

- The file format doesn’t support auto-labeling.
- The file is protected.
- The label isn’t configured correctly.
- SharePoint or OneDrive infrastructure conditions.

The failures that occur due to infrastructure conditions that affect the SharePoint or OneDrive service are transient. In this scenario, the service automatically retries the labeling operation. The other reasons that cause the failures need to be resolved manually.

> [!NOTE]
> When a labeling operation fails, the affected file retains the same label from before the labeling or has no label if a label wasn’t assigned already.

## Details of auto-labeling failures

You can see details about the failure reasons in the Microsoft Purview portal. To access the details, you must have one of the following roles:

- Compliance Administrator
- Compliance Data Administrator
- Information Protection Admin
- Information Protection Analyst

Portal layouts can vary. The following steps describe the newer policy review pages; earlier experiences might open Activity explorer instead.

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/).
1. Select **Solutions** > **Information Protection** > **Policies** > **Auto-labeling policies**.
1. Select the policy you want to check, and then select **View details** in the policy details panel.
1. Select **Labeling failures** to see failed label applications, or **Label removal failures** for a policy that removes labels.
1. Select a file and review **Failure reason**. If a **Details** tab is available, open it to find the reason.
1. Make a note of the failure code.

For a summary of label-application failures in the newer layout, open **Insights** in the policy details panel. The **Labeling failures** card shows the total failures for the last 30 days and the top three failure reasons. Select **Review items** on the card to open the failed-file list.

## Resolve auto-labeling failures

Select the failure code from the following table and follow the instructions in the Recommended action column to resolve the cause of the failure.

> [!TIP]
> If multiple files that an auto-labeling policy processes fail and return the same failure code, check the [SharePoint Online service health dashboard](https://admin.microsoft.com/Adminportal/Home#/servicehealth) for an active incident in the same time window before you investigate further. A spike in the `SqlThrottled\`, `TransientErrorStorageConnection\`, or `Unknown_SPException\` failure codes often corresponds to a known service event.

| Failure code | Description | Recommended action |
|---|---|---|
| FileLocked | Another user or process locked the file. | No action required. The system automatically retries this operation. |
| FileCheckOut | A user checked out the file. | No action required. The system automatically retries this operation. |
| EncryptedFileNotSupported | The file is protected by external encryption (for example, password protection or non-Microsoft encryption) that prevents label application. | Remove the external encryption or password protection from the file to allow labeling. |
| FileNotSupported | The file type isn't supported for sensitivity labeling. | No action required. This file type doesn't support sensitivity labels. |
| FileExtensionNotSupported | The file extension isn't supported for labeling. | No action required. This file extension doesn't support sensitivity labels. |
| UnsupportedFileType | PDF labeling isn't enabled. | Enable [PDF support](/purview/sensitivity-labels-sharepoint-onedrive-files#adding-support-for-pdf) for sensitivity labels in SharePoint and OneDrive. |
| CannotOverrideCurrentLabel | The file already has a sensitivity label with equal or higher priority than the one the policy is trying to apply. | No action required. The existing label takes precedence by design. |
| ZeroByteFile | The file is empty (0 bytes). Label metadata can't be written to an empty file. | No action required. |
| GetTagsFailure | SharePoint couldn't read the existing label metadata from the file. | No action required. The system automatically retries this operation. |
| DisabledOrUnsupportedLabel | The sensitivity label is disabled or not supported for this tenant. | Verify that the label is published and active in your labeling policy. |
| RmsUnavailable | Azure Rights Management was temporarily unavailable. This reason applies when the label also applies encryption. | No action required. The system automatically retries this operation. |
| InvalidFileName | The file name is invalid. | Rename the file to remove invalid characters or reduce the length of the file name. |
| Conflict (LabelVersionConflict) | The file's label state differed from the state expected by the labeling operation, or the current label state couldn't be confirmed, so this labeling attempt failed. This condition can occur when another labeling process, such as a document library's default label, updates the file before auto-labeling finishes, or when the file contains stale or incomplete label information. | No immediate action is typically required. The system automatically retries this operation, and this error represents a failed labeling attempt rather than necessarily indicating that the file remains unlabeled. Check the file's current label. If it now has the intended label, no further action is required for this failure. |
| InvalidLabelOwnerEmail | A valid identity for the label owner couldn't be determined, so this labeling attempt failed. | Work with your SharePoint or OneDrive administrator to review the identity information associated with the file and site, such as the last modifier and file or site owner. If an identity is missing, invalid, or out of date, correct it. |
| Transient (LabelServiceTransientError) | The sensitivity label service was temporarily unavailable, so SharePoint couldn't get the label details it needed to apply the label. The file keeps its existing label, or stays unlabeled, until the retry succeeds. | No action required. The system automatically retries this operation. A later successful labeling event for the same file means the retry worked. If the same files keep failing with this reason, check the [service health dashboard](https://admin.microsoft.com/Adminportal/Home#/servicehealth). If there's no active incident, contact Microsoft Support. |
| CancelledByEventHandler | An event handler on the SharePoint site canceled the operation. | If this reason persists, review custom SharePoint event receivers on the affected site. One of them is rejecting label-property updates. |
| UnauthorizedAccessException | The system was denied access when attempting to modify the file. | No action required. The system automatically retries this operation. |
| Unknown_SPException | An unclassified SharePoint error occurred. | No action required. The system automatically retries this operation. If you see this reason repeatedly for the same files, contact Microsoft Support. |
| TransientErrorStorageConnection | A temporary storage connectivity error occurred. | No action required. The system automatically retries this operation. |
| GenericException | SharePoint hit an error that doesn't fit a more specific failure code. These errors are usually temporary, such as a dependent service briefly not responding. | No action required. The system automatically retries this operation. A later successful labeling event for the same file means the retry worked. If the same files keep failing with this reason and never get labeled, contact Microsoft Support. Include the file URL, the failure time, and the correlation ID from the audit record. |
| SqlThrottled | SharePoint was throttling requests due to high database load. | No action required. The system automatically retries this operation. |
| DirectoryNotFound | The folder no longer exists. | No action required. The folder was deleted after the file was classified. |
| QuotaExceeded | The site storage quota is exceeded. | Free up storage on the site or increase the storage quota, and then rerun the policy. |
| FileNotFound | The file no longer exists. | No action required. The file was deleted or moved after it was classified. |
