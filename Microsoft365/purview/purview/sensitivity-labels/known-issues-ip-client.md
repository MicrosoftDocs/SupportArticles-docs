---
# required metadata

title: Known issues for the Microsoft Purview Information Protection Client
description: Describes known issues with the Microsoft Purview Information Protection client.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.date: 09/04/2025
ms.topic: troubleshooting
ms.service: purview
---
# Known issues for the information protection client

[!INCLUDE [looking-for-mip](../includes/looking-for-mip.md)]

Use the lists and tables below to find details about known issues and limitations related to Microsoft Purview Information Protection features.

## Other digital signing and encryption solutions

Microsoft Purview Information Protection can't label, protect or decrypt files\emails that are digitally signed or encrypted with other solutions, such as removing protection from mails that are signed or encrypted with S/MIME.

## Client support for container files, such as .zip files

Container files are files that include other files, with a typical example being .zip files that contain compressed files. Other examples include .rar, .7z, .msg files and PDF documents that include attachments. 

You can classify and protect these container files, but the classification and protection isn't applied to each file inside the container.

If you have a container file that includes classified and protected files, you must first extract the files to change their classification or protection settings. However, you can remove the protection for all files in supported container files by using the [Set-FileLabel](/powershell/module/purviewinformationprotection/set-filelabel) cmdlet. 

Encryption for .msg files is supported in the [MIP SDK](/information-protection/develop/concept-email) only.

The Microsoft Purview Information Protection viewer can't open attachments in a protected PDF document. In this scenario, when the document is opened in the viewer, the attachments aren't visible.

For more information, see [Admin Guide: File types supported by the Microsoft Purview Information Protection client](/previous-versions/azure/information-protection/rms-client/client-admin-guide-file-types).

## Known issues for watermarks

When you're adding a watermark to a label, keep in mind that if you use font size one, it automatically adjusts to fit the page. However, if you use any other font size, it uses the size you specified in the font settings.

## PowerShell support for the Microsoft Purview Information Protection client

The current release of the **Microsoft Purview Information Protection** PowerShell module that's installed with the Microsoft Purview Information Protection client has the following known issues:

- **Outlook personal folders (*.pst* files)**. Natively protecting *.pst* files isn't supported using the **Microsoft Purview Information Protection** module.

- **Outlook protected email message (.msg files with a .rpmsg attachment)**. Unprotecting Outlook protected email messages is supported by the **Microsoft Purview Information Protection** module for messages inside an Outlook personal folder (.pst file), or on disk in an Outlook message file (.msg file).

-  **PowerShell 7**. Currently PowerShell 7 isn't supported by the Microsoft Purview Information Protection Client. Using PS7 results in the error: "Object reference not set to an instance of an object."

For more information, see [Admin Guide: Using PowerShell with the Microsoft Purview Information Protection client](/previous-versions/azure/information-protection/rms-client/client-admin-guide-powershell).

## Known issues Microsoft Purview Information Protection Scanner

- Scanning of .msg files with signed PDF files is currently not supported.

- Sensitive Information Types (SIT) that are Trainable Classifiers and EDM (Exact Data Match) classifiers.

- Password protected files.

### Known issues for coauthoring

Known issues for coauthoring are relevant only when coauthoring is [enabled in your tenant](/microsoft-365/compliance/sensitivity-labels-coauthoring).

Known issues for coauthoring in Microsoft Purview Information Protection include:

- [Supported versions for coauthoring and sensitivity labels](#supported-versions-for-coauthoring-and-sensitivity-labels)

- [Policy updates](#policy-updates)

- [Unsupported features for coauthoring](#unsupported-features-for-coauthoring)

> [!IMPORTANT]
> Coauthoring and sensitivity labels can't be deployed to some users only, as any new labels won't be visible to users with an older version of the Office client.
>
> For more information about coauthoring support, see the [Microsoft 365 documentation](/microsoft-365/compliance/sensitivity-labels-coauthoring), especially [documented limitations](/microsoft-365/compliance/sensitivity-labels-coauthoring).
>

#### Supported versions for coauthoring and sensitivity labels

All apps, services, and operation tools in your tenant must support coauthoring.

Before you start, make sure that your system complies with the version requirements listed in the [Microsoft 365 prerequisites for coauthoring](/microsoft-365/compliance/sensitivity-labels-coauthoring#prerequisites). 

We recommend that you always use the latest Office version available. Earlier versions might cause unexpected results, such as not being able to see labels in Microsoft Purview Information Protection, or no policy enforcement.

> [!NOTE]
> While sensitivity labels can be applied on files in Office 97-2003 formats, such as  **.doc**, **.ppt**, and **.xls**, coauthoring for these file types isn't supported. Once a label is applied on a newly-created file, or a file in the advanced file format, such as **.docx**, **.pptx**, and **.xlsx**, saving the file in an Office 97-2003 format will cause the label to be removed.
>

#### Policy updates

If your labeling policy was updated while an Office application was opened with Microsoft Purview Information Protection, any new labels are displayed, but applying them results in an error.

If this occurs, close and reopen your Office application to be able to apply your labels.

> [!NOTE]
> Unlike the Microsoft Azure Information Protection dialog box, the **Restricted Access** dialog box doesn't support specifying a domain name to automatically include all users in the organization.
>

#### Unsupported features for coauthoring

The following features aren't supported or are partially supported when [coauthoring is enabled](/microsoft-365/compliance/sensitivity-labels-coauthoring) for files encrypted with sensitivity labels:

- **DKE templates and DKE user-defined properties**. For more information, see [Double Key Encryption (DKE)](/purview/rights-management-tenant-key#double-key-encryption-dke).

- This means that applying a label with user-defined permissions prevents you from working on the document with others at the same time.

- **Removing external content marking in apps**. External content marking is removed only when a label is applied, and not when the document is saved. For more information, see [The client side of Azure Information Protection](/purview/sensitivity-labels-office-apps#office-built-in-labeling-and-the-azure-information-protection-client).

- Features listed in the [Microsoft 365 documentation](/microsoft-365/compliance/sensitivity-labels-coauthoring#limitations) as coauthoring limitations.
- Labelbycustomproperties for mapping other labeling solutions won't work with co-auth enabled.

## Sharing external doc types across tenants

When users share external doc types, such as PDFs, across tenants, recipients receive a consent prompt that requires them to accept the sharing of the listed permissions. For example:

:::image type="content" source="media/known-issues-ip-client/cross-tenant-consent.png" alt-text="Cross-tenant consent prompt.":::

Depending on your application, you might see this prompt repeatedly for the same document. When the prompt appears, select **Accept** to continue to the shared document.

## Known issues in policies

Publishing policies might take up to 24 hours.
## Known issues for the Microsoft Purview Information Protection viewer

- [External users](#external-users-and-the-microsoft-purview-information-protection-viewer)
- [ADRMS protected files on Android devices](#adrms-protected-files-on-android-devices)

For more information, see [**Unified labeling client**: View protected files with the Microsoft Purview Information Protection viewer](https://support.microsoft.com/topic/9fb56fae-7989-48b0-850f-f446e057cf73).

### External users and the Microsoft Purview Information Protection viewer 

If an external user already has a guest account in Microsoft Entra ID, the Microsoft Purview Information Protection Viewer might display an error when the user opens a protected document, telling them that they can't sign in with a personal account.

If such an error appears, the user must install [Adobe Acrobat DC with the MIP extension](https://helpx.adobe.com/il_en/acrobat/kb/mip-plugin-download.html) in order to open the protected document.

When a user opens the protected document after installing Adobe Acrobat DC with the MIP extension, that user might still see an error showing that the selected user account doesn't exist in the tenant, and prompting them to select an account. 

This is an expected error. In the prompt window, select **Back** to continue opening the protected document.

>[!NOTE]
> The Microsoft Purview Information Protection Viewer supports guest *organizational* accounts in Microsoft Entra ID, but not personal or Windows Live accounts.
>

### ADRMS protected files on Android devices

On Android devices, ADRMS-protected files can't be opened by the Microsoft Purview Information Protection Viewer app.

## Known issues for track and revoke features

Tracking and revoking document access using the unified labeling client has the following known issues:

- [Password-protected documents](#password-protected-documents)

- [Documents accessed via SharePoint or OneDrive](#documents-accessed-via-sharepoint-or-onedrive)

For more information, see the [Admin Guide](/purview/track-and-revoke-admin) and [User Guide](https://support.microsoft.com/office/1de9a543-c2df-44b6-9464-396b23018f96) procedures.

#### Password-protected documents

Password-protected documents aren't supported by track and revoke features.
#### Documents accessed via SharePoint or OneDrive

- Protected documents that are uploaded to SharePoint or OneDrive lose their **ContentID** value, and access can't be tracked or revoked.

- If a user downloads the file from SharePoint or OneDrive and accesses it from their local machine, a new **ContentID** is applied to the document when they open it locally.

    Using the original **ContentID** value to track data won't include any access performed for the user's downloaded file. Additionally, revoking access based on the original **ContentID** value won't revoke access for any of the downloaded files.

    If administrators have access to the downloaded files, they can use PowerShell to identify a document's **ContentID** for track and revoke actions.

### Known issues for the Microsoft Purview Information Protection client and OneDrive

If you have documents stored in OneDrive with a sensitivity label applied, and an administrator changes the label in the labeling policy to add protection, the newly applied protection isn't automatically applied to the labeled document. 

In such cases, relabel the document manually to apply the protection as needed.

## Microsoft Purview Information Protection-based Conditional Access policies

External users who receive content protected by [Conditional Access policies](/azure/active-directory/conditional-access/concept-conditional-access-policy-common) must have a Microsoft Entra business-to-business (B2B) collaboration guest user account in order to view the content.

While you can invite external users to activate a guest user account, allowing them to authenticate and pass the conditional access requirements, it might be difficult to ensure that this occurs for all external users required.

We recommend enabling Microsoft Purview Information Protection-based conditional access policies for your internal users only.

**Enable conditional access policies for Microsoft Purview Information Protection for internal users only**:

1.    In the Azure portal, navigate to the **Conditional Access** blade, and select the conditional access policy you wish to modify.
2.    Under **Assignments**, select **Users and groups**, and then select **All users**. Make sure that the **All guest and external users** option is *not* selected.
3.    Save your changes.

You can also entirely disable/exclude CA within Microsoft Purview Information Protection if the functionality isn't required for your organization, in order to avoid this potential issue.

For more information, see the [Conditional Access documentation](/azure/active-directory/conditional-access/concept-conditional-access-users-groups).

## Can't publish or use labels with sub-labels as standalone labels

If a label contains any sub-labels in the [Microsoft Purview compliance portal](/microsoft-365/compliance/sensitivity-labels#sensitivity-labels-and-azure-information-protection), this label must not be published as a standalone label to any Microsoft Purview Information Protection users. 

Similarly, Microsoft Purview Information Protection doesn't support labels that contain sub-labels as default labels, and you can't configure automatic labeling for these labels.

Additionally, using a label with UDP (User Defined Permissions) as a default label isn't supported in the Unified Labeling Client. 
