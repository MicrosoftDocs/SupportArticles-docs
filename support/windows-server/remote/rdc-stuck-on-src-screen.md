---
title: Remote desktop connection is stuck
description: Fixes an issue when remote desktop may stick on the Securing remote connection screen.
ms.date: 04/03/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, ryhayash, mmiura, jarrettr, v-isboua, warrenw
ms.custom:
- sap:remote desktop services and terminal services\web access (includes remoteapp and desktop connections)
- pcy:WinComm User Experience
---
# Remote desktop connection is sometimes stuck on the Securing remote connection screen

This article provides a solution to the issue in which the remote desktop connection stays in the connecting to status.

_Original KB number:_ &nbsp; 2915774

## Symptoms

Assume a scenario in which you use a remote desktop connection for operating system Windows 7 or later versions. In this scenario, Remote desktop connection is stuck for several seconds when it displays the following texts:

> Remote Desktop Connection  
Connecting to:  
Securing remote connection...

:::image type="content" source="media/rdc-stuck-on-src-screen/remote-desktop-connection.png" alt-text="The connection process of a remote desktop." border="false":::

## Cause

Remote desktop connection uses the highest possible security level encryption method between the source and destination.

Authentication is performed by using self-signed certificates (default behavior), or a certificate issued by a certification authority installed on the Remote Desktop Session Host server (RD Session Host).

If you use a self-signed certificate, the system tries to retrieve the trusted certification authority list from the Internet to check the publish and revocation status of the certificate. Therefore, the **Securing remote connection** screen may appear for a while.

## Workaround

To work around this behavior, use either of the following methods:

### Method 1

- If you're using a self-signed certificate, import the certificate to the source. To do this, follow these steps on the destination:

  1. Sign in as an administrator in the destination, select **Start**, enter *mmc* in the **Search programs and files** box and run Microsoft Management Console.
  2. On the **File** menu, select the **Add/Remove Snap-in** option.
  3. From the list of **Available snap-ins**, select **Certificates** and then select the **Add** button.
  4. On the **Certificate Snap-in** screen, select the **Computer account** check box and then select **Next**.
  5. On the **Select Computer** screen, select **Local Computer** and then select the **Finish** button.
  6. Go back to the **Add/Remove Snap-In** dialog box and then select the **OK** button.
  7. In the left pane of the console window, expand **Console Route** > **Certificates (Local Computer)** > **Remote Desktop** > **Certificates**.
  8. Double-click the Certificate in the middle pane to open it.
  9. On the **Detail** tab, select the **Copy to File...** button.
  10. The **Certificate Export Wizard** will open. Leave the default settings and then save the file in any folder.
  11. Copy the exported file to the source computer.

- Then follow these steps on the source:

  1. Sign in as an administrator in the source, select **Start**, enter *mmc* in the **Search programs and files** box, and run the mmc.exe.
  2. Select the **File** menu and then select the **Add/Remove Snap-in** option.
  3. From the list of **Available snap-ins**, select **Certificates** and then select the **Add** button.
  4. On the **Certificate Snap-in** screen, select the **Computer account** check box and then select **Next**.
  5. On the **Select Computer** screen, select **Local Computer** and then select the **Finish** button.
  6. Go back to the **Add/Remove Snap-In** dialog box and then select the **OK** button.
  7. In the left pane of the console window, expand **Certificates (Local Computer)** > **Trusted Root Certification Authorities** > **Certificates**. Right-click to select **All Tasks**, and then select **Import...** from the menu.
  8. The **Certificate Import Wizard** will open. Follow the instructions in the wizard to start the import.

      1. In the **Certificate file to import** window, specify the file that was copied from the destination computer.
      2. In the **Certificate store** window, verify that:

         - **Place all certificates in the following store** is selected
         - **Certificate Store** lists **Trusted Root Certification Authorities**.

  > [!NOTE]
  > By default, the self-signed certificate expires in six months. If it has expired, the certificate will be recreated. You must import the recreated certificate to the source again.

### Method 2

Deploy a Group Policy to the client to turn off Automatic Root Certificates Update. To create a Group Policy, follow these steps on a Windows Server computer that is used for Group Policy management in the same Active Directory domain as the RD Session Host and client:

1. Open the Group Policy Management Console (GPMC) by using the following steps:

   1. Press the Windows key+<kbd>R</kbd> to open the **Run** box. 
   2. Type **Gpmc.msc** in the **Run** box, and then select **OK**. 
      
      > [!NOTE]
      > GPMC is installed by default on domain controllers and on any Windows Server or client that has the Remote Server Administration Tools installed.
      
2. Create a new Group Policy Object (GPO) or select an existing GPO to change.
3. Right-click the selected GPO, select **Edit**, and browse to the following Group Policy:  

   **Computer Configuration** > **Administrative Templates** > **System** > **Internet Communication Management** > **Internet Communication settings**

4. In the details pane, double-click **Turn off Automatic Root Certificates Update**, and then select **Enabled**.

    > [!WARNING]
    > Turning off Automatic Root Certificates Update means you need to update any client or server when a new root certificate update is rolled out. 
