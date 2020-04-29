---
title: Assign a private key to a new certificate
description: Describes how to recover a private key after you use the Certificates Management Console snap-in to delete the original certificate in IIS.
ms.date: 03/23/2020
ms.prod-support-area-path:
---
# How to assign a private key to a new certificate after deleting the original certificate in IIS

This article describes how to recover a private key after you use the Certificates Microsoft Management Console (MMC) snap-in to delete the original certificate in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 889651

## Summary

You delete the original certificate from the personal folder in the local computer's certificate store. This article assumes that you have the matching certificate file backed up as a PKCS#7 file, a .cer file, or a .crt file. When you delete a certificate on a computer that is running IIS, the private key is not deleted:

## Assign the existing private key to a new certificate

To assign the existing private key to a new certificate, you must use the Microsoft Windows Server version of Certutil.exe. To do this, follow these steps:

1. Sign in to the computer that issued the certificate request by using an account that has administrative permissions.
2. Click **Start**, click **Run**, type **mmc**, and then click **OK**.
3. On the **File** menu, click **Add/Remove Snap-in**.
4. In the **Add/Remove Snap-in** dialog box, click **Add**.
5. Click **Certificates**, and then click **Add**.
6. In the **Certificates snap-in** dialog box, click **Computer account**, and then click **Next**.
7. In the **Select Computer** dialog box, click **Local computer: (the computer this console is running on)**, and then click **Finish**.
8. Click **Close**, and then click **OK**.
9. In the Certificates snap-in, expand **Certificates**, right-click the **Personal** folder, point to **All Tasks**, and then click **Import**.
10. On the **Welcome to the Certificate Import Wizard** page, click **Next**.
11. On the **File to Import** page, click **Browse**.
12. In the **Open** dialog box, click the new certificate, click **Open**, and then click **Next**.
13. On the **Certificate Store** page, click **Place all certificates in the following store**, and then click **Browse**.
14. In the **Select Certificate Store** dialog box, click **Personal**, click **OK**, click **Next**, and then click **Finish**.
15. In the Certificates snap-in, double-click the imported certificate that is in the **Personal** folder.
16. In the **Certificate** dialog box, click the **Details** tab.
17. Click **Serial Number** in the **Field** column of the **Details** tab, highlight the serial number, and then write down the serial number.
18. Click **Start**, click **Run**, type **cmd**, and then click **OK**.
19. At the command prompt, type the following:

    ```console
    certutil -repairstore my "SerialNumber"
    ```

    *SerialNumber* is the serial number that you wrote down in step 17.
20. In the Certificates snap-in, right-click **Certificates**, and then click **Refresh**.

The certificate now has an associated private key.

You can now use the IIS MMC to assign the recovered keyset (certificate) to the web site that you want.
