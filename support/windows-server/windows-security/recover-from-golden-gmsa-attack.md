---
title: How to recover from a Golden gMSA attack
description: Describes how to repair compromised gMSAs after a Golden gMSA attack.
ms.date: 09/19/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate, herbertm, juriviere
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
keywords: gMSA, golden gMSA, kds root key object
---

# How to recover from a Golden gMSA attack

This article describes an approach to repairing the credentials of a group Managed Service Account (gMSA) that are affected by a domain controller database exposure incident.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

## Symptoms

For a description of a Golden gMSA attack, see the following Semperis article:

   > [Introducing the Golden GMSA Attack](https://www.semperis.com/blog/golden-gmsa-attack/)

The description in the above article is accurate. The approach for resolving the problem is to replace the Microsoft Key Distribution Service (*kdssvc.dll*, also known as KDS) root key object and all gMSAs that use the compromised KDS Root Key object.

## More information

In a successful attack on a gMSA, the attacker obtains all the important attributes of the KDS Root Key object and the `Sid` and `msds-ManagedPasswordID` attributes of a gMSA object.

The `msds-ManagedPasswordID` attribute is present only on a writable copy of the domain. Therefore, if a domain controller's database is exposed, only the domain that the domain controller hosts is open to the Golden gMSA attack. However, if the attacker can authenticate to a domain controller of a different domain in the forest, the attacker might have sufficient permissions to get the contents of `msds-ManagedPasswordID`. The attacker could then use this information to craft an attack against gMSAs in additional domains.

To protect additional domains of your forest after one domain has been exposed, you have to replace all the gMSAs in the exposed domain before the attacker can use the information. Usually, you don't know the details of what was exposed. Therefore, it's suggested to apply the resolution to all domains of the forest.

As a proactive measure, auditing can be used to track the exposure of the KDS Root Key object. A system access control list (SACL) with successful reads can be placed on the Master Root Keys container, which allows auditing of successful reads on the `msKds-RootKeyData` attribute of the `msKds-ProvRootKey` class. This action determines the object's exposure landscape regarding a Golden gMSA attack.

> [!NOTE]
> Auditing only helps to detect an online attack on the KDS Root Key data.

You can consider setting the `ManagedPasswordIntervalInDays` parameter to 15 days or choosing an appropriate value when creating a gMSA, as the `ManagedPasswordIntervalInDays` value becomes read-only after a gMSA is created.

In case of compromise, this setting can reduce the next rolling time.

It will reduce the theoretical number of gMSA to be recreated between the date of the restored backup and the end of the database exposure, or at least, the risk window duration until these gMSAs roll, if you stick with [Scenario 1](#scenario-1-you-have-reliable-information-about-what-information-was-exposed-and-when).

Here's an example scenario:

1. After a database exposure, you perform the recovery in "Day D."
2. The restored backup is from D-15.

   > [!NOTE]
   > D-15 means the day that's 15 days before "Day D."

3. The gMSA `ManagedPasswordIntervalInDays` value is 15.
4. gMSAs exist and have rolled D-1.
5. Newer gMSAs have been created from D-10.
6. The compromise happens on D-5, and some gMSAs have been created on this date.

Here are the results:

1. gMSAs created between D and D-5 aren't concerned<sup>*</sup>.
2. gMSAs created between D-15 (backup restored) and D-5 (compromise)<sup>*</sup> must be recreated, or the risk windows must be assumed if you can wait from D+5 up to D+10. For example:

      - On D+5, gMSAs created on D-10 must be recreated.
      - On D+10, gMSAs created on D-5 must be recreated.

      <sup>*</sup>Depends on the exact time of compromise or backup.

Here's an example timeline:

:::image type="content" source="media/recover-from-golden-gmsa-attack/gmsas-timeline.png" alt-text="Diagram of an example gMSAs timeline." lightbox="media/recover-from-golden-gmsa-attack/gmsas-timeline.png":::

For debugging, you can review the event IDs for the System, Security, Directory Services, and Security-Netlogon event log.

For more information about a compromise, see [Use Microsoft and Azure security resources to help recover from systemic identity compromise](/azure/security/fundamentals/recover-from-identity-compromise#on-premises-remediation-activities).

## Resolution

To resolve this problem, use one of the following approaches, depending on your situation. The approaches involve creating a new KDS Root Key object and restarting Microsoft Key Distribution Service on all the domain controllers of the domain.

### Scenario 1: You have reliable information about what information was exposed and when

If you know that the exposure occurred before a certain date, and this date is earlier than the oldest gMSA password that you have, you can resolve the problem without re-creating the gMSAs, as shown in the procedure below.

The approach is to create a new KDS Root Key object that's unknown to the attacker. When the gMSAs roll their password, they will move to using the new KDS Root Key object. To fix gMSAs that have recently rolled their password using the old KDS Root Key, an authoritative restore is required to force a password update immediately after the restore.

> [!NOTE]
>  
> - You don't have to manually repair gMSAs that were created after the Active Directory Domain Services (AD DS) database exposure ended. The attacker doesn't know the details of these accounts, and the passwords for these accounts will regenerate based on the new KDS Root Key object.
> - You should consider the gMSA object in "maintenance mode" until the procedure is completed, and ignore possible errors that are reported with the accounts in the System, Security, Directory Services, and Security-Netlogon event log.
> - The guide assumes that the gMSAs are child objects of the **Managed Service Accounts** container. If you have moved the accounts to custom parent containers, you need to run the steps related to the **Managed Service Accounts** container on the gMSA in these containers.
> - An authoritative restore rolls back all attributes to the state they were in at the time of the backup, including the accounts that are allowed to retrieve the gMSA credentials (`PrincipalsAllowedToRetrieveManagedPassword`).

In the domain holding the gMSAs that you want to repair, follow these steps:

1. Take a domain controller offline, and isolate it from the network.
2. Restore the domain controller from a backup that was created before the AD DS database exposure.

   If the password interval for the gMSAs is longer than the age of the backup, you may decide to tolerate the window where the previous key material still works. If you can't wait that long, and the matching older backup is missing too many gMSAs, you need to switch the plan to [Scenario 2](#scenario-2-you-dont-know-the-details-of-the-kds-root-key-object-exposure-and-you-cant-wait-for-passwords-to-roll).

3. Run an authoritative restore operation on the domain's **Managed Service Accounts** container. Make sure that the restore operation includes all the containers' child objects that might be associated with this domain controller. This step rolls back the last password update status. The next time a service retrieves the password, the password will be updated to a new one based on the new KDS Root Key object.
4. Stop and disable the Microsoft Key Distribution Service on the restored domain controller.
5. On a different domain controller, follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.

   > [!NOTE]
   > In the production environment, you need to wait 10 hours to ensure the new KDS Root Key is available. Check the `EffectiveTime` attribute to know when the new KDS Root Key will be usable.

6. Restart the Microsoft Key Distribution Service on all the domain controllers.
7. Create a new gMSA. Make sure that the new gMSA uses the new KDS Root Key object to create the value for the `msds-ManagedPasswordID` attribute.

   > [!NOTE]
   > This step is optional, but it allows you to validate that the new KDS Root Key is currently in use and used in the Microsoft Key Distribution Service.

8. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.  

   For example, assume that the KDS Root Key object has the following `CN`.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot that shows the value of the CN attribute of a KDS Root Key object.":::  

   A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the following.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::  

   In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that's the same as the original GUID.

   If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

9. Disable and stop the Microsoft Key Distribution Service on all domain controllers.
10. Reconnect and bring the restored domain controller back online. Make sure the replication is working.

      Now, the authoritative restore and all the other changes (including the restored gMSAs) are replicated.
11. Re-enable and start Microsoft Key Distribution Service on all the domain controllers. The secrets of the restored gMSAs will roll, and new passwords will be created based on the new KDS Root Key object upon request.

      > [!NOTE]
      > If the gMSAs are restored but not used, and they have the `PrincipalsAllowedToRetrieveManagedPassword` parameter populated, you can run the `Test-ADServiceAccount` cmdlet on the restored gMSA using a principal that's allowed to retrieve the password. If a password change is needed, this cmdlet will then roll the gMSAs to the new KDS Root Key.

12. Verify that all gMSAs have rolled.

      > [!NOTE]
      > The gMSA without the `PrincipalsAllowedToRetrieveManagedPassword` parameter populated will never roll.

13. Delete the old KDS Root Key object and verify the replications.
14. Restart the Microsoft Key Distribution Service on all the domain controllers.

### Scenario 2: You don't know the details of the KDS Root Key object exposure, and you can't wait for passwords to roll

If you don't know what information was exposed or when it was exposed, such an exposure might be part of a complete exposure of your Active Directory forest. This can create a situation in which the attacker can run offline attacks on all passwords. In this case, consider running a Forest Recovery, or resetting all account passwords. Recovering the gMSAs to a clean state is part of this activity.

During the following process, you have to create a new KDS Root Key object. Then, you use this object to replace all the gMSAs in the domains of the forest that use the exposed KDS Root Key object.

> [!NOTE]  
> The following steps resemble the procedure that's in [Getting Started with Group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts). However, there are a few important changes.

Follow these steps:

1. Disable all the existing gMSAs, and mark them as accounts to be removed. To do this, for each account, set the `userAccountControl` attribute to **4098** (this value combines **WORKSTATION_TRUST_ACCOUNT** and **ACCOUNTDISABLE (disabled)** flags).

   You may use a PowerShell script like this to set the accounts:

   ```powershell
    $Domain = (Get-ADDomain).DistinguishedName
    $DomainGMSAs = (Get-ADObject -Searchbase "$Domain" -LdapFilter 'objectclass=msDS-GroupManagedServiceAccount').DistinguishedName
    ForEach ($GMSA In $DomainGMSAs)
    {
        Set-ADObject "$GMSA" -Add @{ adminDescription='cleanup-gsma' } -Replace @{ userAccountControl=4098 }
    }
    ```

2. Use a single domain controller and follow these steps:
   1. Follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.
   2. Restart the Microsoft Key Distribution Service. After it restarts, the service picks up the new object.
   3. Back up DNS host names and service principal names (SPNs) associated with each gMSA marked to be removed.
   4. Edit the existing gMSAs to remove the SPNs and DNS host names.
   5. Create new gMSAs to replace the existing gMSAs. They also need to be configured with the DNS host names and SPNs you just removed.

      > [!NOTE]
      > You also need to review all permission entries using the directly removed gMSA SIDs, as they aren't resolvable anymore. When replacing an access control entry (ACE), consider using groups to manage gMSA permission entries.

3. Check the new gMSAs to make sure that they use the new KDS Root Key object. To do this, follow these steps:
   1. Note the `CN` (GUID) value of the KDS Root Key object.
   2. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.  

      For example, assume that the KDS Root Key object has the following `CN`.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot of the value of the CN attribute of a KDS Root Key object.":::  

      A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the image.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::  

      In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that's the same as the original GUID.

      If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

4. Update the appropriate services to use the new gMSAs.
5. Delete the old gMSAs that used the old KDS Root Key object by using the following cmdlet:

    ```powershell
    $Domain = (Get-ADDomain).DistinguishedName
    $DomainGMSAs = (Get-ADObject -Searchbase "$Domain" -LdapFilter '(&(objectClass=msDS-GroupManagedServiceAccount)(adminDescription=cleanup-gsma))').DistinguishedName
    ForEach ($GMSA In $DomainGMSAs)
    {
        Remove-ADObject "$GMSA" -Confirm:$False
    }
    ```

6. Delete the old KDS Root Key object and verify the replications.
7. Restart the Microsoft Key Distribution Service on all the domain controllers.

### Scenario 3: Resignation of a domain administrator, no information was stolen at the time, and you can wait for passwords to roll

If a highly privileged member with domain administrators or equivalent rights resigns, there's no proof of the KDS Root Key exposure at the time, and you can afford a time window for password rolling. You don't have to recreate the gMSAs.

As a preventive measure, the KDS Root Key must be rolled to prevent any post-exploitation attacks. For example, a former domain administrator has turned out to be a rogue and kept some backups.

A new KDS Root Key object is created, and gMSAs will roll naturally.

> [!NOTE]
> For a compromise related to a domain administrator, refer to [Scenario 1](#scenario-1-you-have-reliable-information-about-what-information-was-exposed-and-when) or [Scenario 2](#scenario-2-you-dont-know-the-details-of-the-kds-root-key-object-exposure-and-you-cant-wait-for-passwords-to-roll) according to what has been exposed, and follow the [On-premises remediation activities](/azure/security/fundamentals/recover-from-identity-compromise#on-premises-remediation-activities) in "Use Microsoft and Azure security resources to help recover from systemic identity compromise".

In the domain holding the gMSAs that you want to roll, follow these steps:

1. On a domain controller, follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS Root Key object.

      > [!NOTE]
      > In the production environment, you need to wait 10 hours to ensure the new KDS Root Key is available. Check the `EffectiveTime` attribute to know when the new KDS Root Key will be usable.

2. Restart the Microsoft Key Distribution Service on all the domain controllers.
3. Create a new gMSA. Make sure that the new gMSA uses the new KDS Root Key object to create the value for the `msds-ManagedPasswordID` attribute.

      > [!NOTE]
      > This step is optional, but it allows you to validate that the new KDS Root Key is currently in use and used in the Microsoft Key Distribution Service.

4. Check the `msds-ManagedPasswordID` value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS Root Key object.

      For example, assume that the KDS Root Key object has the following `CN`.

      :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot of the value of the CN attribute of a KDS Root Key object.":::  

      A gMSA that's created by using this object has an `msds-ManagedPasswordID` value that resembles the following image.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::

      In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that's the same as the original GUID.

      If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

5. Depending on the next password roll, the secrets of the gMSAs will naturally roll, and new passwords will be created based on the new KDS Root Key object upon request.

      > [!NOTE]
      > If used gMSAs have rolled, but unused gMSAs with the same roll interval haven't, and they have the `PrincipalsAllowedToRetrieveManagedPassword` parameter populated, you can run the `Test-ADServiceAccount` cmdlet. It uses a principal that's allowed to retrieve the gMSA password, and this step then moves the gMSA to the new KDS Root Key.

6. Verify that all gMSAs have rolled.

      > [!NOTE]
      > The gMSA without the `PrincipalsAllowedToRetrieveManagedPassword` parameter will never roll.

7. After all the gMSAs have rolled to the new KDS Root Key object, delete the old KDS Root Key object and verify the replications.
8. Restart the Microsoft Key Distribution Service on all the domain controllers.

## References

[Group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
