---
title: Scripts to View the Certificate Information in the msDS-KeyCredentialLink Attribute
description: This article introduces a script to view the certificate information in the msDS-KeyCredentialLink attribute from AD user objects.
ms.date: 02/13/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: takondo
ms.custom:
- sap:user logon and profiles\user profiles
- pcy:WinComm Directory Services
---
# Scripts: View the certificate information in the msDS-KeyCredentialLink attribute from AD user objects

The **msDS-KeyCredentialLink** attribute can be viewed in PowerShell. However, the value is in binary format and can't be read. This script helps you do the following things:

- Enumerate all users in Active Directory (AD) that have a non-null value in **msDS-KeyCredentialLink**.
- Extract the bcrypt-sha256 key ID hash of each certificate saved in **msDS-KeyCredentialLink** and save it to a file.

You can then use the saved information to check whether the expected values are in the user's **msDS-KeyCredentialLink** attribute.

## Script

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

After you run the script, the results are saved in the file **C:\temp\KeyCredentialLink-report.txt**.

```powershell
$outputfile = "C:\temp\KeyCredentialLink-report.txt"
New-Item -ItemType file -Path $outputfile -Force | Out-Null

"Report generated on " + (Get-Date) | Out-File $outputfile 

# Enumerate all AD users that has a msds-KeyCredentialLink value
foreach ($user in (Get-ADUser -LDAPFilter '(msDS-KeyCredentialLink=*)' -Properties "msDS-KeyCredentialLink")) {

    # For each user, output the UPN, DN, and all key IDs in msDS-KeyCredentialLink
    "===========`nUser: $($user.UserPrincipalName)`nDN: $($user.DistinguishedName)" | Out-File $outputfile -Append
    "KeyCredialLink Entries:" | Out-File $outputfile -Append
    "   Source|Usage|DeviceID                            |KeyID" | Out-File $outputfile -Append
    "   -------------------------------------------------------------------" | Out-File $outputfile -Append

    foreach ($blob in ($user."msDS-KeyCredentialLink")) {
        $KCLstring = ($blob -split ':')[2]
        
        # Check that the entries are version 2
        if ($KCLstring.Substring(0, 8) -eq "00020000") {
            $curIndex = 8   
            
            # Parse all KeyCredentialLink entries from the hex string
            while ($curIndex -lt $KCLstring.Length) {

                # Read the length, reverse the byte order to account for endianess, then convert to an int
                # The length is in bytes, so multiply by 2 to get the length in characters
                $strLength = ($KCLstring.Substring($curIndex, 4)) -split '(?<=\G..)(?!$)'
                [array]::Reverse($strLength)
                $kcle_Length = ([convert]::ToInt16(-join $strLength, 16)) * 2
            
                # Read the identifier and value
                $kcle_Identifier = $KCLstring.Substring($curIndex + 4, 2)
                $kcle_Value = $KCLstring.Substring($curIndex + 6, $kcle_Length)
            
                switch ($kcle_Identifier) {
                    # KeyID 
                    '01' {
                        $KeyID = $kcle_Value
                    }

                    # KeyUsage
                    '04' {
                        switch ($kcle_Value) {
                            '01' { $Usage = "NGC  " }
                            '07' { $Usage = "FIDO " }
                            '08' { $Usage = "FEK  " }
                            Default { $Usage = $kcle_Value }
                        }
                    }

                    # Source
                    '05' {
                        switch ($kcle_Value) {
                            '00' { $Source = "AD    " }
                            '01' { $Source = "Entra " }
                            Default { $Source = $kcle_Value }
                        }
                    }
                    
                    # DeviceID
                    '06' {
                        $tempByteArray = $kcle_Value -split '(?<=\G..)(?!$)'
                        $DeviceID = [System.Guid]::new($tempByteArray[3..0] + $tempByteArray[5..4] + $tempByteArray[7..6] + $tempByteArray[8..16] -join "")
                    }
                }

                $curIndex += 6 + $kcle_Length
            }

            # Save the data to file
            "   $Source|$Usage|$DeviceID|$KeyID" | Out-File $outputfile -Append
        }
    }
}
```

## Script sample output and analysis

Here's a sample output of the script:

```output
User: user1@contoso.com
DN: CN=user1,OU=MyOU,DC=contoso,DC=com
KeyCredialLink Entries:
   Source|Usage|DeviceID                            |KeyID
   -------------------------------------------------------------------
   Entra |NGC  |8a763ab0-0f6f-44f3-99ae-599a6aaca45b|FD68391824C44158B23C5605F567A588D02C4B2962AC96B789EDBCE091CF5067
   Entra |NGC  |9cf88f41-1e1e-462b-87d5-6938410ea82c|E91EF4E058513155A3F7E7E5B3E34951ADE923FFD0A7C24BB9957510F007E2F3
   Entra |NGC  |d04581fc-d1c8-45fc-a5ad-192bc649574f|E60B476088CC5CDF6FB75454CFA6E17C3059D51F2CA1E414E1554715BE6C0527
===========
User: user2@contoso.com
DN: CN=user2,OU=MyOU,DC=contoso,DC=com
KeyCredialLink Entries:
   Source|Usage|DeviceID                            |KeyID
   ---------------------------
   Entra |NGC  |c8fcc7a6-8f3f-4ec7-a90b-49c6988ba3a4|32EF67B902CB498710F0091F5B10B6A4A2F05D621B748B8150E08FA3048F227F
```

Each `KeyCredentialLink` entry represents a certificate. The output contains the following information:

- `Source`: The source of the certificate. This information can either be from Microsoft Entra ID or on-premises AD.
- `Usage`: The defined usage of the certificate. This information can be NGC (WHfB), FIDO, or FEK (File Encryption Key).
- `DeviceID`: The ID of the computer where the certificate was created. This information is the Device ID in Microsoft Entra ID and the objectGUID in AD.
- `KeyID`: The bcrypt-sha256 key ID hash of the certificate.

The matching certificate should be found in the user's personal certificate store on the computer with the matching `DeviceID`. To find the certificate being used on the client, you can run `certutil -v -user -store my` from a PowerShell or command prompt to dump detailed certificate information from the user's personal store. In this example, you should find a self-signed certificate where the subject and issuer are the same and in the form of `CN=<User SID>/login.windows.net/<Tenant ID>/<user UPN>`. Once you find this certificate, check the bcrypt-sha256 key ID hash. This hash value should match one of the entries in the **msDS-KeyCredentialLink** attribute.

Here's an excerpt from user2@contoso.com's certificate store:

```output
> certutil -v -user -store my
my "Personal"
================ Certificate 0 ================
X509 Certificate:
Version: 3
Serial Number: 184621…
Signature Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.11 sha256RSA
    Algorithm Parameters:
    05 00
Issuer:
    CN=S-1-5-21-394…7436/login.windows.net/ccf…83a/user2@contoso.com

  :

Signature Algorithm:
    Algorithm ObjectId: 1.2.840.113549.1.1.11 sha256RSA
    Algorithm Parameters:
    05 00
Signature: UnusedBits=0
    0000  19 17 8f 65 c1 e3 f1 0a  3b 62 90 7f fa 94 13 ad
 // snip
    00f0  a2 e3 72 54 a5 0a 84 30  9e 8b 81 19 d3 61 46 58
Signature matches Public Key
Root Certificate: Subject matches Issuer
Key Id Hash(rfc-sha1): 9a546…
Key Id Hash(sha1): d66eb…
Key Id Hash(bcrypt-sha1): 7f4a0…
Key Id Hash(bcrypt-sha256): 32ef67b902cb…
```

## Reference

[Key Credential Link Structures](/openspecs/windows_protocols/ms-adts/de61eb56-b75f-4743-b8af-e9be154b47af)
