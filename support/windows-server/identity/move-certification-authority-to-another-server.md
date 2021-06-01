---
title: How to move a certification authority to another server
description: Describes how to move a certification authority (CA) to a different server in Windows Server 2003 and in Windows 2000 Server.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, dhook
ms.prod-support-area-path: Active Directory Certificate Services
ms.technology: windows-server-active-directory
---
# How to move a certification authority to another server

This article describes how to move a certification authority (CA) to a different server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 298138

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Summary

Certification authorities (CAs) are the central component of the public key infrastructure (PKI) of an organization. The CAs are configured to exist for many years or decades, during which time the hardware that hosts the CA is probably upgraded.

To move a CA from a server that is running Windows 2000 Server to a server that is running Windows Server 2003, you must first upgrade the CA server that is running Windows 2000 Server to Windows Server 2003. Then you can follow the steps that are outlined in this article.

Make sure that the %Systemroot% of the target server matches the %Systemroot% of the server from which the system state backup is taken.

You must change the path of the CA files when you install the CA server components so that they match the location of the backup. For example, if you back up from the D:\\Winnt\\System32\\Certlog folder, you must restore the backup to the D:\\Winnt\\System32\\Certlog folder. You cannot restore the backup to the C:\\Winnt\\System32\\Certlog folder. After you restore the backup, you can move the CA database files to the default location.

If you try to restore the backup, and the %Systemroot% of the backup and the target server do not match, you may receive the following error message:

> Restore of an incremental image cannot be performed before you perform restore from a full image. The directory name is invalid. 0x8007010b (WIN32/HTTP:267)

Moving Certificate Services from a 32-bit operating system to a 64-bit operating system or vice-versa may fail with one of the following error messages:

> The expected data does not exist in this directory.

> Restore of incremental image cannot be performed before performing restore from a full image 0x8007010b (WIN32/HTTP:267)

Database format changes from the 32-bit version to the 64-bit version cause incompatibilities, and the restore is blocked. This resembles the move from Windows 2000 to Windows Server 2003 CA. However, there is no upgrade path from a 32-bit version of Windows Server 2003 to a 64-bit version. Therefore, you cannot move an existing 32-bit database to a 64-bit database on a Windows Server 2003-based computer. However, you can upgrade from Windows Server 2003 CA (running on Windows Server 2003 x86) to Windows Server 2008 R2 CA (running on Windows Server 2008 R2 x64). This upgrade is supported.

An x64-based version of Windows Server 2003 R2 CD2 only updates 64-bit versions of Windows Server 2003 that are based on the EM64T architecture or on the AMD64 architecture.

## Back up and restore the certification authority keys and database in Windows Server 2003

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Note the certificate templates that are configured in the Certificate Templates folder in the Certification Authority snap-in. The Certificate Templates settings are stored in Active Directory. They are not automatically backed up. You must manually configure the Certificate Templates settings on the new CA to maintain the same set of templates.

    > [!NOTE]
    > The Certificate Templates folder exists only on an enterprise CA. Stand-alone CAs do not use certificate templates. Therefore, this step does not apply to a stand-alone CA.

2. Use the Certification Authority snap-in to back up the CA database and private key. To do this, follow these steps:
    1. In the Certification Authority snap-in, right-click the CA name, click **All Tasks**, and then click **Back up CA** to start the Certification Authority Backup Wizard.
    2. Click **Next**, and then click **Private key and CA certificate**.
    3. Click **Certificate database and certificate database log**.
    4. Use an empty folder as the backup location. Make sure that the backup folder can be accessed by the new server.
    5. Click **Next**. If the specified backup folder does not exist, the Certification Authority Backup Wizard creates it.
    6. Type and then confirm a password for the CA private key backup file.
    7. Click **Next**, and then verify the backup settings. The following settings should be displayed:
        - **Private Key and CA Certificate**  
        - **Issued Log and Pending Requests**  
    8. Click **Finish**.

3. Save the registry settings for this CA. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
    2. Locate and then right-click the following registry subkey:  
       `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration`
    3. Click **Export**.
    4. Save the registry file in the CA backup folder that you defined in step 2d.

4. Remove Certificate Services from the old server.

    > [!NOTE]
    > This step removes objects from Active Directory. Do not perform this step out of order. If removal of the source CA is performed after installation of the target CA (step 6 in this section), the target CA will become unusable.

5. Rename the old server, or permanently disconnect it from the network.

6. Install Certificate Services on the new server. To do this, follow these steps.

    > [!NOTE]
    > The new server must have the same computer name as the old server.

    1. In Control Panel, double-click **Add or Remove Programs**.
    2. Click **Add/Remove Windows Components**, click **Certificate Services** in the Windows Components Wizard, and then click **Next**.
    3. In the **CA Type** dialog box, click the appropriate CA type.
    4. Click **Use custom settings to generate the key pair and CA certificate**, and then click **Next**.
    5. Click **Import**, type the path of the .P12 file in the backup folder, type the password that you chose in step 2f, and then click **OK**.
    6. In the **Public and Private Key Pair** dialog box, verify that **Use existing keys** is checked.
    7. Click **Next** two times.
    8. Accept the Certificate Database Settings default settings, click **Next**, and then click **Finish** to complete the Certificate Services installation.
7. Stop the Certificate Services service.

8. Locate the registry file that you saved in step 3, and then double-click it to import the registry settings. If the path that is shown in the registry export from the old CA differs from the new path, you must adjust your registry export accordingly. By default, the new path is C:\\Windows in Windows Server 2003.

9. Use the Certification Authority snap-in to restore the CA database. To do this, follow these steps:

    1. In the Certification Authority snap-in, right-click the CA name, click **All Tasks**, and then click **Restore CA**.

        The Certification Authority Restore Wizard starts.
    2. Click **Next**, and then click **Private key and CA certificate**.
    3. Click **Certificate database and certificate database log**.
    4. Type the backup folder location, and then click **Next**.
    5. Verify the backup settings. The **Issued Log** and **Pending Requests** settings should be displayed.
    6. Click **Finish**, and then click **Yes** to restart Certificate Services when the CA database is restored.

    You may receive the following error during the restore CA process if the CA backup folder is not in the correct folder structure format:

    > \---------------------------  
    Microsoft Certificate Services  
    \---------------------------
    >
    > The expected data does not exist in this directory.  
    Please choose a different directory. The directory name is invalid. 0x8007010b (WIN32/HTTP: 267)  

    The correct folder structure is as follows:

    - C:\\Ca_Backup\\CA_NAME.p12
    - C:\\Ca_Backup\\Database\\certbkxp.dat
    - C:\\Ca_Backup\\Database\\edb#####.log
    - C:\\Ca_Backup\\Database\\CA_NAME.edb

    Where C:\\Ca_Backup is the folder you chose during the Backup CA phase in step 2.

10. In the Certification Authority snap-in, manually add or remove certificate templates to duplicate the Certificate Templates settings that you noted in step 1.

## Back up and restore the certification authority keys and database in Windows 2000 Server

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Note the certificate templates that are configured in the Certificate Templates folder in the Certification Authority snap-in. The Certificate Templates settings are stored in Active Directory. They are not automatically backed up. You must manually configure the Certificate Templates settings on the new CA to maintain the same set of templates.

    > [!NOTE]
    > The Certificate Templates folder exists only on an enterprise CA. Stand-alone CAs do not use certificate templates. Therefore, this step does not apply to a stand-alone CA.

2. Use the Certification Authority snap-in to back up the CA database and private key. To do this, follow these steps:

    1. In the Certification Authority snap-in, right-click the CA name, click **All Tasks**, and then click **Back up CA** to start the Certification Authority Backup Wizard.
    2. Click **Next**, and then click **Private key and CA certificate**.
    3. Click **Issued certificate log and pending certificate request queue.**  
    4. Use an empty folder as the backup location. Make sure that the backup folder can be accessed by the new server.
    5. Click **Next**. If the specified backup folder does not exist, the Certification Authority Backup Wizard creates it.
    6. Type and then confirm a password for the CA private key backup file.
    7. Click **Next** two times, and then verify the backup settings. The following settings should be displayed:
        - **Private Key and CA Certificate**  
        - **Issued Log and Pending Requests**  
    8. Click **Finish**.

3. Save the registry settings for this CA. To do this, follow these steps:

    1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
    2. Locate and then right-click the following registry subkey:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration`
    3. Click **Configuration**, and then click **Export Registry File** on the **Registry** menu.
    4. Save the registry file in the CA backup folder that you defined in step 2d.

4. Remove Certificate Services from the old server.

    > [!NOTE]
    > This step removes objects from Active Directory. Do not perform this step out of order. If removal of the source CA is performed after installation of the target CA (step 6 in this section), the target CA will become unusable.

5. Rename the old server, or permanently disconnect it from the network.

6. Install Certificate Services on the new server. To do this, follow these steps.

    > [!NOTE]
    > The new server must have the same computer name as the old server.

    1. In Control Panel, double-click Add/Remove Programs.
    2. Click **Add/Remove Windows Components**, click **Certificate Services** in the Windows Components Wizard, and then click **Next**.
    3. In the **Certification Authority Type** dialog box, click the appropriate CA type.
    4. Click **Advanced Options**, and then click **Next**.
    5. In the **Public and Private Key Pair** dialog box, click **Use existing keys**, and then click **Import**.
    6. Type the path of the .P12 file in the backup folder, type the password that you chose in step 2f, and then click **OK**.
    7. Click **Next**, type a CA description if appropriate, and then click **Next.**  
    8. Accept the Data Storage Location default settings, click **Next**, and then click **Finish** to complete the Certificate Services installation.

7. Stop the Certificate Services service.

8. Locate the registry file that you saved in step 3, and then double-click it to import the registry settings.

9. Use the Certification Authority snap-in to restore the CA database. To do this, follow these steps:

    1. In the Certification Authority snap-in, right-click the CA name, click **All Tasks**, and then click **Restore CA**.

        The Certification Authority Restore Wizard starts.
    2. Click **Next**, and then click **Issued certificate log and pending certificate request queue**.
    3. Type the backup folder location, and then click **Next**.
    4. Verify the backup settings. The following settings should be displayed:
        - **Issued Log**  
        - **Pending Requests**  
    5. Click **Finish**, and then click **Yes** to restart Certificate Services when the CA database is restored.

10. In the Certification Authority snap-in, manually add or remove certificate templates to duplicate the Certificate Templates settings that you noted in step 1.

## More information

For more information about upgrade and migration scenarios for Windows Server 2003 and Windows Server 2008, see the "Active Directory Certificate Services Upgrade and Migration Guide" white paper. To see the white paper, see [Active Directory Certificate Services Upgrade and Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc742515(v=ws.10)).
