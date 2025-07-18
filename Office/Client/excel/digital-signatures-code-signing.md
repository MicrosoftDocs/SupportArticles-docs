---
title: Digital signatures and code signing in workbooks in Excel
description: Provides general information about digital signatures and code signing in workbooks in Excel 2003 and in later versions of Excel.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Excel 2007
  - Excel 2003
ms.date: 05/26/2025
---

# Description of digital signatures and code signing in workbooks in Excel

## Summary

In Microsoft Office Excel 2003 and in later versions of Excel, you can digitally sign a workbook or code sign your macro project. This ensures that you were the last person to make changes to the workbook or macro project.

## More information

### What is a digital certificate?

Digital certificates and signatures help to assure you that the file that you are about to use comes from a reliable source. They help to assure you that the file has not been tampered with.

A digital certificate is an ID that a file carries with it. To validate a signature, a certifying authority validates information about the creator of the file and then issues the digital certificate. The digital certificate contains information about the person to whom the certificate was issued, as well as information about the certifying authority that issued it. When a digital certificate is used to sign a file, this ID is stored with the file in a verifiable form so that it can be displayed to a user.

### What is a digital signature?

Excel uses digital signatures on the workbook contents to help ensure that the workbook has not been modified and saved since it was signed. Digital signatures can also help you distinguish workbooks and macros created by a reliable source from undesirable and potentially damaging workbooks or macro code (viruses).

A digital signature is a public certificate plus the value of the signed data as encrypted by a private key. The value is a number that a cryptographic algorithm generates for any data that you want to sign. This algorithm makes it nearly impossible to change the data without changing the resulting value. So, by encrypting the value instead of the data, a digital signature helps a user to verify the data was not changed.

### What happens when I use a digital signature?

You can view and edit signed Excel workbooks, although you cannot modify and save a signed workbook without invalidating the signature. For example, you can sign a file and other users can view the file. As long as the file remains signed, others will know it came from you and has not been modified.

Digital signing a workbook is different from code signing a Visual Basic for Applications (VBA) macro project. You can digitally sign the workbook for content and you can also code sign your VBA macro project in the same workbook.

### What Excel files can I digitally sign?

You can digitally sign any Excel workbook or Excel template. However, Excel versions that are earlier than Microsoft Excel 2002 do not recognize the digital signature.

If you digitally sign a shared workbook, Excel will not retain the digital signature because more than one person can make changes to the workbook. Additionally, you cannot code sign a macro project, because Excel will not allow you to create or make changes to macro projects in a workbook after it has been set up as shared workbook.

### How can I obtain a digital signature?

To obtain a digital signature, you first have to have a digital certificate.

You can obtain a digital certificate or a code signing ID from a commercial certification authority or from your internal security administrator or information technology (IT) professional.

A certification authority can issue you a digital certificate or code signing ID for no charge. The certification authority does an in-depth identification check before it issues a digital certificate.

For more information about how to obtain a digital signature or code signing ID, visit the following Microsoft Web site:

[Microsoft Trusted Root Certificate Programs](/security/trusted-root/release-notes)

You can create your own digital certificate for personal use or testing purposes with the SelfCert.exe tool that is provided in Microsoft Office. However, this certificate is not authenticated by a Certificate Authority (CA).

### How do I add a digital signature to a workbook?

To add a digital signature to your workbook, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007

1. Click the **Microsoft Office Button**, point to **Prepare**, and then click **Add a Digital Signature**.
2. Click **OK**.

    If the workbook has changed and is not yet saved, or if it is not saved in the Excel 2007 workbook format, you receive the following message:

    > Before you can add signatures, you must save the workbook in a format that supports digital signatures.  
    > Do you want to save the workbook as a Microsoft Office Excel Workbook?

3. Click **Yes** to display the **Save As** dialog box. You must save the file in the **Excel Workbook (*.xlsx)** format to add the digital signature.
4. After you save the workbook, the **Get a Digital ID** dialog box is displayed. Select the type of digital ID that you want to use, and then click **OK**.

After you complete the necessary steps for the type of digital ID that you selected, your Excel workbook is now signed.

> [!NOTE]
>
> - If you save your workbook after you add the digital ID, the digital ID will be removed. For example, when you click the **Microsoft Office Button** and then click **Save As** after you digitally sign your workbook, you receive the following message:
>
>   Saving a copy of this workbook will invalidate all of the signatures in the copy.
>
>   Do you want to continue? If you click **Yes**, the digital ID will be removed from the copy of the workbook.
> - When you close and then reopen the signed workbook, the Excel title bar will display the words **[Read-Only]** (in brackets) after the workbook name. Additionally, the digital ID icon appears in the status bar, and the Signatures task pane appears to indicate that a digital signature has been added to the workbook.
>
>   To verify that changes have not occurred in the signed workbook, verify that a signer appears in the Signature task pane.

#### Excel 2003

1. On the **Tools** menu, click **Options**.
2. On the **Security** tab, click **Digital Signatures**.
3. Click **Add**.

    If the workbook has changed and is not yet saved, or if it is not saved in the Excel 2003 workbook format, you receive the following message:

    > This workbook must be saved as a Microsoft Excel workbook before it can be digitally signed. Do you want to save the workbook?
4. Click **Yes** to display the **Save As** dialog box. You must save the file in the Microsoft Excel Workbook format to add the digital signature.
5. After you save the workbook, the **Select Certificate** dialog box is displayed. Select the certificate that you want to use, and then click **OK**.
6. Click **OK** to close the **Digital Signatures** dialog box.

Your Excel workbook is now signed.

> [!NOTE]
>
> - If you save your workbook after you add the digital signature, the digital signature will be removed. For example, when you click
**Save** on the **File** menu after you digitally sign your workbook, you receive the following message:
>
>   Saving will remove all digital signatures in the workbook.
>
>   Do you want to continue?If you click **Yes**, the digital signatures will be removed from your workbook.
> - When you close and reopen the signed workbook, the Excel title bar will display the words **[Signed, unverified]** (in brackets) after the workbook name. This indicates that a digital signature has been added to the workbook.

To verify that changes have not occurred in the signed workbook, follow these steps:

1. On the **Tools** menu, click **Options**.
2. On the **Security** tab, click **Digital Signatures**.
3. On the **Signatures** tab, if a signer is listed in the **The following have digitally signed this document** list, you can be assured that the file has not been changed since the digital signature was added to the file.

### How do I code sign a macro project?

To code sign your Visual Basic for Applications macro project, follow these steps:

1. Open the workbook that contains the macro project that you want to sign.
2. Press ALT+F11 to open the Visual Basic Editor.
3. In the Project Explorer, select the project that you want to sign.
4. On the **Tools** menu, click **Digital Signature**.
5. Do one of the following:

    - If you have not previously selected a digital certificate, or if you want to use another one, click **Choose**, select the certificate, and then click **OK** two times.
    - To use the current certificate, click **OK**.
