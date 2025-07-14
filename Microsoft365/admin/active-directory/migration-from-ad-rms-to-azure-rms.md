---
title: An update for supporting migration from AD RMS to Azure RMS
description: Describes a fix is available for Office to support AD RMS in Read-Only mode.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft Azure Active Directory Rights Management
  - Active Directory Rights Management Services Client 2.0
ms.date: 03/31/2022
---

# An update is available for Office to support migrations from AD RMS to Azure RMS

## Symptoms

If an organization has Active Directory Rights Management Services (AD RMS) deployed and wants to migrate to Azure Information Protection, the typical migration process involves exporting the root keys from the AD RMS cluster and importing them into Azure RMS. Azure RMS is a service that is part of the Azure Information Protection platform.

In some cases, an AD RMS cluster may be configured in a way that prevents the keys from being exported and imported to the cloud. This behavior can occur if one of the following conditions is true:

- The keys are marked as non-exportable and protected by a hardware security module that is not directly supported by Azure Information Protection.
- The key is in a hardware security module for which the operator cards or other artifacts required for key export are not available.

## Resolution

A fix is available that enables Office for MSIPC RMS clients to continue to use AD RMS to consume previously protected content without granting the ability to protect new content by using these keys. The fix lets the clients protect and consume content by using Azure RMS.

This update is available from Microsoft Update. For more information, see [Windows Update FAQ](https://support.microsoft.com/help/12373/windows-update-faq).

This fix is available for Microsoft Office 2013, Office 2016, and other MSIPC applications that are developed by using the MSIPC SDK 2.1.

The update is available for the following versions of Office:

- Office 2013 version 15.0.4849.1000, or later versions
- Office 2016 MSI version 16.0.4496.1000, or later versions.
- Office 2016 C2R version 16.0.7407.1000, or later versions

To set AD RMS in read-only mode after you install the fix on Windows clients that are running Office 2013, Office 2016, or other applications developed by using the MSIPC SDK, you have to deny access to the Publish.asmx page. To do this, follow these steps: 

1. Log on to each AD RMS server that is used by users to protect content: Click **Start**, point to **Administrative Tools**, and then click **Internet Information Services (IIS) Manager**.
2. If the **User Account Control** dialog box appears, confirm that the action displayed is what you want, and then click **Continue**.
3. Expand the domain node, expand Sites, expand Default Web Site, and then expand _**wmcs**.

   **Note** Be aware that you may have installed AD RMS in a website other than the default website. If this is the case, you have to adjust the path above accordingly.
1. Right-click the licensing folder, and then click **Switch to Content View**.
1. Right-click **Publish.asmx**, and then click **Switch to Features View**.
1. Under IIS, double-click **Authentication**. Make sure that **Anonymous Authentication** is disabled (be aware that this authentication will disable collaboration with other companies that use Trusted User Domain exchanges). 
1. Right-click the licensing directory again, and then click **Switch to Content View**.
1. Right-click **Publish.asmx**, and then click **Edit Permissions**.
1. In the **Security** pane, click **Edit**, and then click **Add**.
1. Enter the name of the group that you want to prevent from protecting content by using AD RMS, click **OK**, and then click **Full Control** in the **Deny** column. To deny all users the ability to protect content with AD RMS, use **Everyone** as the group.
1. Click OK.
1. Close IIS Manager.

As soon as IIS is configured in this manner on all the AD RMS nodes, you can confirm that a client can use AD RMS in read-only mode by doing the following action:

1. Start with a client that is not configured to use either AD RMS or Azure RMS. Open content that was protected by using AD RMS.
2. Next, try to protect new content. You will be unable to perform this operation.

A client that was configured to use Azure RMS will also be able to consume content from AD RMS without affecting its prior configuration with Azure RMS. After the client consumes content from AD RMS, they will continue to protect content by using Azure RMS.

If you configure IIS as part of the de-provisioning process for AD RMS, you should also use the AD RMS console to unpublish the AD RMS service connection point.

## More Information

During a typical migration from AD RMS to Azure Information Protection, the root key (known as the Server Licensor Certificate [SLC]) of the AD RMS cluster that is used to protect content is exported from the cluster and imported into the Azure RMS service part of the Azure Information Protection platform. Then, Windows clients are configured to redirect requests for licenses to open content that is protected by the AD RMS cluster to the Azure RMS service. RMS then issues the licenses as per the policy in the document and other artifacts that enable the client to use AD RMS for protecting content. 

Among these artifacts, Windows clients obtain the Client Licensor Certificate (CLC) by calling APIs that are available under Publish.asmx in the AD RMS cluster. As soon as the CLC is issued, this certificate enables the client to protect content by using keys that are associated to the SLC key of the AD RMS cluster.

By denying access to these APIs, a client that has this fix installed and that is configured to use Azure RMS can consume content from AD RMS without receiving a CLC from AD RMS. This enables the client to continue using Azure RMS to protect all new content while keeping access to content previously protected with AD RMS, even if the AD RMS key has not been imported into Azure RMS.

This allows for a gradual phase-out of the AD RMS infrastructure because new content is protected by using Azure RMS until the content that's protected by AD RMS is re-protected by the new keys in Azure RMS or it is no longer relevant. Then, the AD RMS cluster and its SLC can be decommissioned.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
