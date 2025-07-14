---
title: An internal error has occurred
description: Helps troubleshoot An internal error has occurred error when connecting to a remote machine.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:remote desktop services and terminal services\web access (includes remoteapp and desktop connections)
- pcy:WinComm User Experience
---
# "An internal error has occurred" when connecting to a remote machine

This article helps troubleshoot the "An internal error has occurred" error when connecting to a remote machine.

When you use a direct Remote Desktop Protocol (RDP) connection to connect to a Windows machine, the connection fails with the "An internal error has occurred" error. The error occurs before or after entering credentials on the Remote Desktop connection application.

> [!NOTE]
> If the connection stops responding for up to one minute before the error appears, and then succeeds on the second attempt, the cause might be the capacity to open the audio to retrieve settings.
>
> In this case, a blocking call prevents the client from sending the needed information to the server. After around one minute, the connection succeeds because the remote machine resets the connection.
>
> To resolve this issue, disable the Windows Audio service on the remote machine and optionally on the source machine if necessary.

## Verify if the error is related to the network

Use the following steps to check if you can connect to the server through a web console (for example, Hyper-V):

1. Type *mstsc* in the **Run** box.
2. In the **Remote Desktop Connection** application, type *localhost* in the **Computer** box and select **Connect**.

If the error no longer occurs, it's related to the network. Contact Microsoft Support for further assistance.

If the error persists, the problem is with the server. Move to the next troubleshooting step.

## Verify if the error is related to the encryption negotiation

The issue usually occurs when the source and destination machines negotiate the security protocols, ciphers, or other encryption configurations. To verify if the error is related to the encryption negotiation, run the following commands to adjust the `UserAuthentication` and `SecurityLayer` values to `0` on the affected machine:

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

```console
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v SecurityLayer /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v UserAuthentication /t REG_DWORD /d 0 /f
```

> [!IMPORTANT]
> At the end of the troubleshooting session, configure these settings to the recommended values by using the following commands:
>
> ```console
> reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v SecurityLayer /t REG_DWORD /d 2 /f
> reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v UserAuthentication /t REG_DWORD /d 1 /f
> ```

If you can connect to the remote machine after running the commands, the issue might be related to either:

- The renewal of a Remote Desktop self-signed certificate
- The security protocol negotiation

To narrow the possible causes, check if you can re-create the Remote Desktop self-signed certificate by following these steps:

1. Open the Certificates Microsoft Management Console (MMC) snap-in. When you're prompted to select the certificate store to manage, select **Computer account**, and then select the affected computer.
2. In the **Certificates** folder under **Remote Desktop**, delete the RDP self-signed certificate.
3. Restart the Remote Desktop Services service on the affected computer.
4. Refresh the Certificates snap-in.
5. If the RDP self-signed certificate hasn't been re-created, go to [Remote Desktop self-signed certificate](#remote-desktop-self-signed-certificate).
6. If the RDP self-signed certificate has been re-created, go to [Security protocol negotiation](#security-protocol-negotiation).

## Remote Desktop self-signed certificate

If the issue is related to the renewal of a Remote Desktop self-signed certificate, use the following methods to troubleshoot the issue.

### Check registry configurations

Open Registry Editor and make sure these keys are set as follows:

- `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations`  
    The `SelfSignedCertStore` value name has the `Remote Desktop` value data.
- `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`  
    The `ProgramData` value name has the `%SystemDrive%\ProgramData` value data.

### Check services

Make sure the following services are running, as they're needed to generate the certificate:

- The certificate propagation service (CertPropSvc)
- The CNG key isolation service (KeyIso)
- The cryptographic services (CryptSvc)
- The Remote Desktop Configuration service (SessionEnv)

> [!NOTE]
> If any of the preceding services fails to start, check if there's a problem with its dependencies on system event logs from the Service Control Manager source.

### Check MachineKeys permissions

1. Go to *C:\\ProgramData\\Microsoft\\Crypto\\RSA\\* on the affected computer.
2. Right-click **MachineKeys**, and then select **Properties** > **Security** > **Advanced**.
3. Make sure that only the following permissions are configured:

    - **Builtin\\Administrators**: **Full control**
    - **Everyone**: **Read**, **Write**

4. Restart the Remote Desktop Services service and confirm that the certificate is re-created.

### Check permissions of the RDP machine key

1. Go to *C:\\ProgramData\\Microsoft\\Crypto\\RSA\\MachineKeys* on the affected computer.
2. Right-click the key starting with **f686aace6942fb7f7ceb231212eef4a4**, and then select **Properties** > **Security** > **Advanced**.
3. Change the **Owner** to someone with administrative rights to the machine.
4. Close and reopen the **Advanced Security Settings** window.
5. Make sure that only the following permissions are configured:

    |Principal  |Type  |Access  |Inherited from  |
    |---------|---------|---------|---------|
    |Network service     |Allow         |Read         |None         |
    |System     |Allow         |Full control         |None         |

6. Restart the Remote Desktop Services service and confirm that the certificate is re-created.

### Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.

## Security protocol negotiation

If the issue is related to the security protocol negotiation, use the following methods to troubleshoot the issue.

### Check registry configurations

Check the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`

- Check if the `SSLCertificateSHA1HashValue` value exists and whether the value data matches the **Thumbprint** value. The **Thumbprint** value can be found in the **Details** tab of the certificate under **Remote Desktop** > **Certificates** in the *certlm.msc* console. If they don't match, delete the `SSLCertificateSHA1HashValue` value, restart the system, and test again.

    > [!IMPORTANT]
    > Don't apply this step if the server has the Remote Desktop Connection Broker role installed.
- Make sure the `fAllowSecProtocolNegotiation` value is set to **1**.
- Make sure the `MinEncryptionLevel` value is set to **3**. For more information, see [Encryption Levels](/openspecs/windows_protocols/ms-rdpbcgr/f1c7c93b-94cc-4551-bb90-532a0185246a).

### Check the configuration of the SSL Cipher Suite Order policy

Check if there's a [policy for configuring ciphers](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order). Set the following policy setting to **Not configured** if it exists:

**Computer Configuration** > **Administrative Templates** > **Network** > **SSL Configuration Settings** - **SSL Cipher Suite Order**

> [!NOTE]
> After setting the policy to **Not configured**, delete the following registry value if it exists:  
> `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002` - `Functions`.

### Replace the SCHANNEL subkey

1. Export the following subkey on a functioning machine with the same Windows version:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL`
2. Back up the existing key on the affected machine. Then, delete it and replace it with the subkey exported from the functioning machine.

### Replace the Cryptography SSL subkey

1. Export the following subkey on a functioning machine with the same Windows version:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`
2. Back up the existing key on the affected machine. Then, delete it and replace it with the subkey exported from the functioning machine.

### Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
