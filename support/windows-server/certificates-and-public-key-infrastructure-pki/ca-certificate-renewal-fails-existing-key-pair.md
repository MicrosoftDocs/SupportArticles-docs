---
title: CA certificate renewal fails when using a KSP provider
description: Helps resolve an issue where the CA certificate renewal with the existing public and private key pair fails when using a KSP provider.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, flbelea, v-lianna
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Active Directory Certificate Services (ADCS), csstroubleshoot
---
# CA certificate renewal with the existing public and private key pair fails when using a KSP provider

This article helps resolve an issue in which the Certificate Authority (CA) certificate renewal with the existing public and private key pair fails when using a Key Storage Provider (KSP) provider.

In the Certification Authority snap-in, you right-click the CA and select **All Tasks** > **Renew CA Certificate**. Then, in the **Renew CA Certificate** dialog, when asked to generate a new public and private key pair, you select **No**, which means to reuse the existing key pair. In this case, you aren't prompted to save the request or send the request to an offline CA as expected. The CA service restarts automatically, and the renewal fails.

## The KeySpec value is 2

For a CA certificate using a KSP provider, the Key Specification (KeySpec) property is expected to have a `KeySpec` value of `0`. However, when the issue occurs, the `KeySpec` value is `2`, which causes the CA certificate renewal to fail.

## Update the KeySpec value from 2 to 0

To resolve this issue, update the `KeySpec` value from `2` to `0` by using the following steps:

1. Export the local machine store using the following command:

    ```console
    certutil -v -store my > c:\temp\machine.txt
    ```

2. Check the `KeySpec` values for all certificates used by the CA during the renewal. For example:

    ```output
    ================ Certificate 3 ================
    X509 Certificate:
    Version: 3
    Serial Number: 21000000044a30cdeaaaae7b08000000000004
    Signature Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.11 sha256RSA
    Algorithm Parameters:
    05 00
    
    Issuer:
    CN=ROOTCA-CA
    Name Hash(sha1): a07626ccaaaaabbbb562364300973304401cd3fb
    Name Hash(md5): 78ac82e59faaaabbbbe860f908f29b29
    
    NotBefore: <DateTime>
    NotAfter: <DateTime>
    
    Subject:
    CN=Contoso CA
    DC=Contoso
    DC=com
    ...
    Name Hash(sha1): 01aad90aaaabbbbf368a509eed47be8ea0a3b78d
    Name Hash(md5): 278a394aaaabbbbf27fbd177c498ca02
    Cert Hash(md5): 1b425aaaabbbbaf29c6747e9e0b6f093
    Cert Hash(sha1): 35599aaaabbbb0438686dd79915e943895d1e276
    Cert Hash(sha256): 96ebd75aaaabbbbb0db31f7a83891533eeada0351ce56b84f3918941c9cba610
    Signature Hash: f905cf5aaaabbbb2548c592c593ee6864c9c2dc3ec305da3f4d6751a6ff17afd
    ...
    CERT_KEY_PROV_INFO_PROP_ID(2):
    Key Container = Contoso CA
    Unique container name: 944d5680aaaabbbb95b1cb4f50ba2b71_6e4d3030-8aae-40f0-9282-d69ccdd4ff34
    Provider = Microsoft Software Key Storage Provider
    ProviderType = 0
    Flags = 20 (32)
    CRYPT_MACHINE_KEYSET -- 20 (32)
        KeySpec = 2 -- AT_SIGNATURE
    ```

3. If the `KeySpec` value is `2 -- AT_SIGNATURE`, change it to `0 -- XCN_AT_NONE`:

    1. [Back up the CA and private keys](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486805%28v=ws.11%29#backing-up-a-ca-database-and-private-key).
    2. Create a file with the `.inf` extension. The contents of the file (*KeyProv.inf*) resemble:

        ```output
        [Properties]
        2 = "{text}" ; Add Key Provider Information property
        _continue_="Container = CONTAINER_NAME&"   // Replace the "CONTAINER_NAME" with the CA Key Container name of the certificate that has the Serial Number "21000000044a30cdeaaaae7b08000000000004"; Keep the sign '&' in the end;
        _continue_="Provider = Microsoft Software Key Storage Provider&"
        _continue_="ProviderType = 0&"
        _continue_="Flags = 0x20&"
        _continue_="KeySpec = 0"
        ```

    3. Run the following command using the certificate serial number where the `KeySpec` value is `2`:

        ```console
        certutil -repairstore my "21000000044a30cdeaaaae7b08000000000004" KeyProv.inf
        ```

        > [!NOTE]
        > You can check the hash for each CA certificate in the CA properties by selecting each certificate and selecting **View Certificate** on the **General** tab. Then, on the **Details** tab, select **Serial number**.

4. Re-execute the following command, and then check if the `KeySpec` value is `0`:

    ```console
    certutil -v -store my > c:\temp\machine-new.txt
    ```

5. Use the preceding steps for each of the other CA certificates with a `KeySpec` value of `2`.

Once all the CA certificates have a `KeySpec` value of `0`, you can try to renew the CA certificate again with the existing key pair.

## More information

For certificates whose keys are generated using Cryptography Next Generation (CNG) providers, there's no concept of key specification, and the `KeySpec` value is always `0`.

`KeySpec` values and associated meanings:

|Keyspec value  |Value  |Meaning  |
|---------|---------|---------|
|`0`     |`AT_NONE`         |The certificate is a CNG certificate.         |
|`1`     |`AT_KEYEXCHANGE`         |For a legacy CAPI (non-CNG) certificate, the key can be used for signing and decryption.         |
|`2`     |`AT_SIGNATURE`         |For a legacy CAPI (non-CNG) certificate, the key can be used only for signing.         |
