---
title: Frequently asked questions about File Exchange System
description: Provides answers to frequently asked questions about the new file exchange system on the Microsoft Business Solutions Web sites.
ms.reviewer: kyouells
ms.date: 04/22/2021
---
# Frequently asked questions about the File Exchange System

You can now use the File Exchange System instead of the File Transfer Protocol (FTP) to exchange large files with Microsoft Business Solutions Web sites and support technicians. This article answers many of the frequently asked questions about the File Exchange System.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 905631

> [!NOTE]
> Microsoft Business Solutions-Axapta 3.0 is now part of Microsoft Dynamics AX 3.0. All references to Microsoft Business Solutions-Axapta and Microsoft Axapta pertain to Microsoft Dynamics AX.

- **Q1: What is the File Exchange System?**

  A1: The File Exchange System is an extranet system that is designed to make file transfers among Microsoft Business Solutions support technicians, partners, and customers easier.

- **Q2: Where is the File Exchange System used?**

  A2: The File Exchange System is used for certain Microsoft Business Solutions downloads, such as service packs and product releases, from the PartnerSource and CustomerSource Web sites. Partners and customers may also be asked to use the File Exchange System for file transfers when partners and customers work with Microsoft Business Solutions Technical Support.

- **Q3: How can I receive access to the File Exchange System?**

  A3: All partners and customers who access the File Exchange System must use Passport Network credentials. Partners and customers must be invited to upload to the File Exchange System by a Microsoft Business Solutions technical support engineer. If you are provided a file link to download from the File Exchange System, you must enter your Passport Network credentials to download the file.

- **Q4: What differs from the current PartnerSource and CustomerSource downloads?**

  A4: All files that are downloaded from or uploaded to the File Exchange System must be transferred by using Microsoft File Transfer Manager. To download or upload a file to the File Exchange System for the first time, follow these steps:

  1. In the **Security Warning** dialog box, select **Yes** to install Microsoft File Transfer Manager.
  2. In the **Confirm Transfer Request** dialog box, select **Transfer**.

      > [!NOTE]
      > This process may take several minutes, depending on the size of file that is being uploaded or downloaded.
  3. The **Microsoft File Transfer Manager** dialog box appears. Select **Close** to close the dialog box as soon as the transfer is completed.

     > [!NOTE]
     > The File Exchange System contains the following features:
     >
     >  - You can view all upload and download activity by selecting **History**.
     >  - You can configure specific options for Microsoft File Transfer Manager by selecting **Options**.

- **Q5: When I try to download a file from the File Exchange System, I receive the following error: There was an error launching File Transfer Manager. Please try again later or contact help provider.**

- A5: This error typically indicates that the Active X components are not enabled in Internet Explorer. To enable Active X components, follow these steps:

  1. In Internet Explorer, select **Tools**, and then select **Internet Options**.
  2. Select the **Security** tab.
  3. Under **Select a Web content zone to specify its security settings**, select the **Internet** option.
  4. Select **Custom Level**.
  5. In the Security Settings window, enable all Active X controls and plug-ins.
  6. Select **OK**.
  7. Select **Apply**.
  8. Select **OK**.
  9. Close Internet Explorer.
  10. Open Internet Explorer.
  11. Try to download the file.

- **Q6: When I try to download a file from the File Exchange System, I am prompted for a user name and a password. What is wrong?**

  A6: You may have to disable the pop-up blocker in Microsoft Internet Explorer. In this case, you will usually see a message in the **Information Bar** dialog box that states that the pop-up blocker has blocked an installation on the page. To resolve the issue, follow these steps:

  1. Select the **Information Bar** dialog box, and then select **Download File**.
  2. Run the ActiveX installation, and then try to download the file again.

- **Q7: When I try to upload a file to the File Exchange system, the transfer takes a long time. What is wrong?**

  A7: The file upload speed depends on the size of the file and on the type of connection that you have to the Internet. If the file is large, the upload may take a long time.

- **Q8: I am in the middle of uploading or downloading a large file, and I have to log off. What can I do?**

  A8: To suspend and restart a file transfer, follow these steps:

  1. In the **Microsoft File Transfer Manager** dialog box, select **Suspend**.
  2. Select **Options** to open the **Options** dialog box.
  3. In the **Options** dialog box, mark the **Place Application Shortcut on the Desktop** check box.
  4. When you log back on, select the desktop icon to open the **Microsoft File Transfer Manager** dialog box, select the check box next to the transfer that you suspended, and then select **Resume**.

- **Q9: A technical support engineer sent me an invitation e-mail message for the File Exchange System, and I lost the message. What can I do?**

  A9: Technical Support will send you an invitation only if the incident requires files to be uploaded or downloaded. You do not need an invitation to download service packs, tax updates, or year-end updates from CustomerSource or from PartnerSource. If the e-mail message that contains the invitation was lost, you must contact the Technical Support representative who sent you the invitation and ask the representative to send you another invitation.

- **Q10: If I still have issues with the File Exchange System, who can I contact for help?**

  A10: For help with all issues that relate to the File Exchange System, send an e-mail message to [itmbssup@microsoft.com](mailto:itmbssup@microsoft.com).
