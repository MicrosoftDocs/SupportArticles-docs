---
title: How to recover from a Golden gMSA attack
description: Describes how to repair compromised gMSAs after a Golden gMSA attack.
ms.date: 03/20/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
ms.technology: windows-server-security
keywords: gMSA, golden gMSA, kds root key object
---

# How to recover from a Golden gMSA attack

This article describes an approach to repairing the credentials of a group Managed Service Account (gMSA) that are affected by a domain controller database exposure incident.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

## Symptoms

For a description of a Golden gMSA attack, see the following Semperis article:

   > [Introducing the Golden GMSA Attack](https://www.semperis.com/blog/golden-gmsa-attack/)

The description in the above article is accurate. The approach for resolving the problem is to replace the Microsoft Key Distribution Service (kdssvc.dll, also known as KDS) root key object and all gMSAs that use the compromised KDS Root Key object.

## More information

In a successful attack on a gMSA, the attacker obtains all the important attributes of the KDS Root Key object and the `Sid` and `msds-ManagedPasswordID` attributes of a gMSA object.

The `msds-ManagedPasswordID` attribute is present only on a writable copy of the domain. Therefore, if a domain controller's database is exposed, only the domain that the domain controller hosts is open to the Golden gMSA attack. However, if the attacker can authenticate to a domain controller of a different domain in the forest, the attacker might have sufficient permissions to get the contents of `msds-ManagedPasswordID`. The attacker could then use this information to craft an attack against gMSAs in additional domains.

To protect additional domains of your forest after one domain has been exposed, you have to replace all the gMSAs in the exposed domain before the attacker can use the information. Usually, you don't know the details of what was exposed. Therefore, it's suggested to apply the resolution to all domains of the forest.

As a proactive measure, auditing can be used to track the exposure of the KDS Root Key object. A system access control list (SACL) with successful reads can be placed on the Master Root Keys container, which allows auditing of successful reads on the `msKds-ProvRootKey` attribute. This action determines the object's exposure landscape regarding a Golden gMSA attack.

> [!NOTE]
> Auditing only helps to detect an online attack on the KDS Root Key data.

You can consider setting the `ManagedPasswordIntervalInDays` parameter to 15 days or choosing an appropriate value when creating a gMSA, as the `ManagedPasswordIntervalInDays` value after gMSA creation becomes a read-only value.

In case of compromise, this setting allows to reduce the next rolling time.

It will reduce the theorical number of gMSA to be recreated between the date of the restored backup and the end of the database exposure, or at least, the risk window duration until these gMSA rolls, if you stick with the Case 1.

Here's an example scenario:

1. After a database exposure, you are performing the recovery in "Day D."
2. The restored backup is from the day that is 15 days before "Day D" (D-15).
3. The gMSA `ManagedPasswordIntervalInDays` value is 15.
4. The gMSA exists and has rolled one day before "Day D" (D-1).
5. Newer gMSA has been created from the day that is 10 days before "Day D" (D-10).
6. The compromise happens in five days before "Day D" (D-5), and some gMSAs have been created at this date.

Here are the results:

1. The gMSA created between "Day D" and five days before "Day D" (D-5) aren't concerned<sup>*</sup>.
2. The gMSA created between 15 days before "Day D" (D-15) (backup restored) and five days before "Day D" (D-5) (compromise)<sup>*</sup> must be recreated, or the risk windows must be assumed if you can wait from five days after "Day D" (D+5) up to 10 days after "Day D" (D+10). For example:

      -	On five days after "Day D" (D+5), gMSAs created on 10 days before "Day D" (D-10) must be recreated.
      -	On 10 days after "Day D" (D+10), gMSAs created on five days before "Day D" (D-5) must be recreated.

      <sup>*</sup>: Depending on the compromise or backup exact time.

About debugging, you can review Event IDs for System, Security, Directory Services, and Security-Netlogon Eventlog.

For more information about a compromise, see [Use Microsoft and Azure security resources to help recover from systemic identity compromise](/azure/security/fundamentals/recover-from-identity-compromise#on-premises-remediation-activities).


## Resolution

To resolve this problem, use one of the following approaches, depending on your situation. Both approaches involve creating a new KDS Root Key object and restarting **Microsoft Key Distribution Service** on all the domain controllers of the domain.

### Case 1: You have reliable information about what information was exposed and when

If you know that the exposure occurred before a certain date, and this date is earlier than the oldest gMSA password that you have, you can resolve the problem without re-creating the gMSAs, as shown in the procedure below.

The gMSA password was rolled after the exposure, and a new KDS Root Key object is created that isn't known by the attacker.

> [!NOTE]  
> You do not have to manually repair gMSAs that were created after the Active Directory Domain Services (AD DS) database exposure ended. The attacker does not know the details of these accounts, and the passwords for these accounts will regenerate based on the new KDS Root Key object.

You should consider the gMSA object in “maintenance mode“ until the procedure is completed, and ignore possible errors that are reported with the accounts in System, Security, Directory Services, and Security-Netlogon event log.

In the domain that holds the gMSAs that you want to repair, follow these steps:

1. Take a domain controller offline, and isolate it from the network.
2. Restore the domain controller from a backup that was created prior to the AD DS database exposure.

   If the password interval for the gMSAs is longer than the age of the backup, you may decide to tolerate the window where the previous key material still works. If you can't wait this long and the matching older backup is missing too many gMSAs, you need to switch the plan to case 2.

3. Run an authoritative restore operation on the domain's **Managed Service Accounts** container. Make sure that the restore operation includes all the container's child objects that might be associated with this domain controller. This step rolls back the last password update status. The next time that a service retrieves the password, the password updates to a new password that's based on the new KDS Root Key object.
4. Stop and disable the Microsoft Key Distribution Service on the restored domain controller.
5. On a different domain controller, follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.

   > [!NOTE]
   > In the production environment, you need to wait 10 hours to ensure the new KDS Root Key is available. Check the `EffectiveTime` attribute to know when the new KDS Root Key will be usable.

6. On all the domain controllers, restart **Microsoft Key Distribution Service**.
7. Create a new gMSA. Make sure that the new gMSA uses the new KDS Root Key object to create the value for the `msds-ManagedPasswordID` attribute.

   > [!NOTE]
   > This step is optional, but it allows to validate the new KDS Root Key is currently in use and cached on the *kdssvc.dll* file.

8. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.  

   For example, assume that the KDS Root Key object has the following `CN`.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot that shows the value of the CN attribute of a KDS Root Key object.":::  

   A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the following.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::  

   In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that is the same as the original GUID.

   If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

9. Disable and stop the Microsoft Key Distribution Service on all domain controllers.
10. Reconnect the restored domain controller and bring it online. Make sure the replication is working.

      Now the authoritative restore and all the other changes, including the restored gMSAs, replicate.
11. Reenable and start Microsoft Key Distribution Service on all the domain controllers. The secrets of the restored gMSAs will roll, new passwords will be created based on the new KDS Root Key object when requested.

      > [!NOTE]
      > If the gMSA is restored but not used, and they have the `PrincipalsAllowedToRetrieveManagedPassword` parameter populated, you can run the `Test-ADServiceAccount` cmdlet using a principal that is allowed to trigger internal API, and roll the gMSA to the new KDS Root Key.
12. Verify that all gMSAs have rolled.

      > [!NOTE]
      > The gMSA without the `PrincipalsAllowedToRetrieveManagedPassword` parameter populated will never roll.
13. Delete the old KDS Root Key object and verify the replications.
14. Restart the Microsoft Key Distribution Service on all the domain controllers.

### Case 2: You don't know the details of the KDS Root Key object exposure, and you can't wait for passwords to roll

If you don't know what information was exposed or when it was exposed, such an exposure might be part of a complete exposure of your Active Directory forest. This can create a situation in which the attacker can run offline attacks on all passwords. In this case, consider running a Forest Recovery, or resetting all account passwords. Recovering the gMSAs to a clean state is part of this activity.

During the following process, you have to create a new KDS Root Key object. Then, you use this object to replace all the gMSAs in the domains of the forest that use the exposed KDS Root Key object.

> [!NOTE]  
> The following steps resemble the procedure that's in [Getting Started with Group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts). However, there are a few important changes.

Follow these steps:

1. Disable all the existing gMSA accounts, and mark them as accounts to be removed. To do this, for each account, set the `userAccountControl` attribute to **4098** (this value combines **WORKSTATION_TRUST_ACCOUNT** and **ACCOUNTDISABLE (disabled)** flags.

   You may use a PowerShell script like this to set the accounts:

   ```powershell
    $Domain = (Get-ADDomain).DistinguishedName
    $DomainGMSAs = (Get-ADObject -Searchbase "$Domain" -LdapFilter 'objectclass=msDS-GroupManagedServiceAccount').DistinguishedName
    ForEach ($GMSA In $DomainGMSAs)
    {
        Set-ADObject "$GMSA" -Add @{ adminDescription='cleanup-gsma' } -Replace @{ userAccountControl=4098 }
    }
    ```

1. Use a single domain controller to follow these steps:
   1. Follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.
   1. Restart the Microsoft Key Distribution Service. After it restarts, the service picks up the new object.
   1.	Back up DNS host names and SPNs associated with each gMSA marked to be removed.
   1. Edit the existing gMSAs to remove the service principle names (SPNs) and DNS host names.
   1. Create new gMSAs to replace the existing gMSAs. They also need to be configured with the DNS host names and SPNs you just removed.

      > [!NOTE]
      > You also need to review all permissions entries using directly deleted gMSA SIDs, as they are not resolvable anymore. When replacing an access control entry (ACE), consider using Groups for managing gMSA permissions entries.

1. Check the new gMSAs to make sure that they use the new KDS Root Key object. To do this, follow these steps:
   1. Note the `CN` (GUID) value of the KDS Root Key object.
   1. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.  

      For example, assume that the KDS Root Key object has the following `CN`.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot of the value of the CN attribute of a KDS Root Key object.":::  

      A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the image.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::  

      In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that is the same as the original GUID.

      If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

1. Update the appropriate services to use the new gMSAs.
1. Delete the old gMSAs that used the old KDS Root Key object by using the following cmdlet:

    ```powershell
    $Domain = (Get-ADDomain).DistinguishedName
    $DomainGMSAs = (Get-ADObject -Searchbase "$Domain" -LdapFilter '(&(objectClass=msDS-GroupManagedServiceAccount)(adminDescription=cleanup-gsma))').DistinguishedName
    ForEach ($GMSA In $DomainGMSAs)
    {
        Remove-ADObject "$GMSA" -Confirm:$False
    }
    ```

1. Delete the old KDS Root Key object and verify the replications.
1. Restart the Microsoft Key Distribution Service on all the domain controllers.

## Case 3: Resignation of a domain administrator, no information was stolen at time and you can wait for passwords to roll

If a high privileged member who has domain administrators or equivalent rights resigns, there's no proof of the KDS Root Key exposure at time and you can afford a time window for password rolling. You don’t have to recreate the gMSAs.

As a preventive measure, the KDS Root Key needs to be rolled to prevent any post-exploitation attack. For example, the former domain administrator has turned out to be rogue and kept some backups.

A new KDS Root Key object is created and gMSAs will roll naturally.

> [!NOTE]
> For a compromise related to a domain administrator, refer to Case 1 or Case 2 according to what have been exposed, and follow [Use Microsoft and Azure security resources to help recover from systemic identity compromise](/azure/security/fundamentals/recover-from-identity-compromise#on-premises-remediation-activities).

In the domain that holds the gMSAs that you want to roll, follow these steps:

1. On a domain controller, follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.

      > [NOTE]
      > In the production environment, you need to wait 10 hours to ensure the new KDS Root Key is available. Check the `EffectiveTime` attribute to know when the new KDS Root Key will be usable.

2. On all the domain controllers, restart the Microsoft Key Distribution Service.
3. Create a new gMSA. Make sure that the new gMSA uses the new KDS Root Key object to create the value for the `msds-ManagedPasswordID` attribute.

      > [!NOTE]
      > This step is optional, but it allows to validate the new KDS Root Key is currently in use and cached on the *kdssvc.dll* file.
4. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.

      For example, assume that the KDS Root Key object has the following `CN`.

      :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot of the value of the CN attribute of a KDS Root Key object.":::  

      A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the following image.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::

      In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that is the same as the original GUID.
      
      If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.
 
5. Depending on the next password roll, the secrets of the gMSAs will naturally roll, and new passwords will be created based on the new KDS Root Key object when requested.

      > [!NOTE]
      > If used gMSAs have rolled, but unused gMSAs with the same roll interval haven't, and they have the  `PrincipalsAllowedToRetrieveManagedPassword` parameter populated, you can run the `Test-ADServiceAccount` cmdlet. It uses a principal that is allowed to trigger an internal API, and roll the gMSA to the new KDS Root Key.

6. Verify that all gMSAs have rolled.

      > [!NOTE]
      > The gMSA without the `PrincipalsAllowedToRetrieveManagedPassword` parameter will never roll.
7. After all the gMSAs have rolled to the new KDS Root Key object, delete the old KDS Root Key object and verify the replications.
8. Restart the Microsoft Key Distribution Service on all the domain controllers.

## References

[Group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
