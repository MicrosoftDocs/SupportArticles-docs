---
title: Change AD FS 2.0 service communications
description: Contains the steps to change the Active Directory Federation Services 2.0 service communications certificate.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, roberg, willfid
ms.custom: sap:Windows Security Technologies\Active Directory Federation Services (AD FS) non-Azure-O365 issues, csstroubleshoot
---
# How to change the AD FS 2.0 service communications certificate after it expires

This article provides the steps to change the Active Directory Federation Services 2.0 service communications certificate.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2921805

## Symptoms  

A user wants to know how to change the Active Directory Federation Services (AD FS) 2.0 service communications certificate after it expires or for other reasons.

## Resolution

Replacing an existing AD FS 2.0 server service certificate is a multistep process.

## Step 1

Install the new certificate into the local computer certificate store. To do it, follow these steps:

1. Select **Start**, and then select **Run**.
2. Type **MMC**.
3. On the **File** menu, select **Add/Remove Snap-in**.
4. In the **Available snap-ins** list, select **Certificates**, and then select **Add**. The Certificates Snap-in Wizard starts.
5. Select **Computer account**, and then select **Next**.
6. Select **Local computer: (the computer this console is running on)**, and then select **Finish**.
7. Select **OK**.
8. Expand **Console Root\Certificates (Local Computer)\Personal\Certificates**.
9. Right-click **Certificates**, select **All Tasks**, and then select **Import**.

## Step 2

Add to the AD FS service account the permissions to access the private key of the new certificate. To do it, follow these steps:

1. With the local computer certificate store still open, select the certificate that was imported.
2. Right-click the certificate, select **All Tasks**, and then select **Manage Private Keys**.
3. Add the account that is running the **ADFS Service**, and then give the account at least read permissions.

    > [!NOTE]
    > If you do not have the option to manage private keys, you may have to run the following command:

    ```console
    certutil -repairstore my *
    ```

## Step 3

Bind the new certificate to the AD FS website by using IIS Manager. To do it, follow these steps:

1. Open the Internet Information Services (IIS) Manager snap-in.
2. Browse to **Default Web Site**.
3. Right-click **Default Web Site**, and then select **Edit Bindings**.
4. Select **HTTPS**, and then select **Edit**.
5. Select the correct certificate under the SSL certificate heading.
6. Select **OK**, and then select **Close**.  

## Step 4

Configure the AD FS Server service to use the new certificate. To do it, follow these steps:

1. Open AD FS 2.0 Management.
2. Browse to **AD FS 2.0\Service\Certificates**.
3. Right-click **Certificates**, and then select **Set Service Communications Certificate**.
4. Select the new certificate from the certificate selection UI.
5. Select **OK**.

    > [!NOTE]
    > You may see a dialog box that contains the following message:  
    > The certificate key length is less than 2048 bits. Certificates with key sizes less than 2048 bits might present a security risk and are not recommended. Do you want to continue?

    After you read the message, select **Yes**. Another dialog box appears. It contains the following message:
    > Ensure that the private key for the chosen certificate is accessible to the service account for this Federation Service on each server in the farm.

    It was already done in step 2. Select **OK**.  

Still need help? Go to [Office 365 Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
