---
title: How to recover from a Golden gMSA attack
description: Describes how to repair compromised gMSAs after a Golden gMSA attack
ms.date: 2/1/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
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

The description in that article is accurate. The approach to resolving the problem is to replace the Microsoft Key Distribution Service (kdssvc.dll, also known as KDS) root key object and all gMSAs that use the compromised KDS root key object.

## More information

In a successful attack on a gMSA, the attacker obtains all the important attributes of the KDS root key object and the **Sid** and **msds-ManagedPasswordID** attributes of a gMSA object.

The **msds-ManagedPasswordID** attribute is present only on a writable copy of the domain. Therefore, if a domain controller's database is exposed, only the domain that the domain controller hosts is open to the Golden gMSA attack. However, if the attacker can authenticate to a domain controller of a different domain in the forest, the attacker might have sufficient permissions to get the contents of **msds-ManagedPasswordID**. The attacker could then use this information to craft an attack against gMSAs in additional domains.

To protect additional domains of your forest after one domain has been exposed, you have to replace all the gMSAs in the exposed domain before the attacker can use the information. Usually, you don't know the details of what was exposed. Therefore, we suggest that you apply the resolution to all domains of the forest.

## Resolution

To resolve this problem, use one of the following approaches, depending on your situation. Both approaches involve creating a new KDS root key object and restarting **Microsoft Key Distribution Service** on all the domain controllers of the domain.

### Case 1: You have reliable information about what information was exposed and when

If you know that the exposure occurred before a certain date, and this date is earlier than the oldest gMSA password that you have, you can resolve the problem without re-creating the gMSAs.

> [!NOTE]  
> You do not have to manually repair gMSAs that were created after the Active Directory Domain Services (AD DS) database exposure ended. The attacker does not know the details of these accounts, and the passwords for these accounts will regenerate based on the new KDS root key object.

In the domain that holds the gMSAs that you want to repair, follow these steps:

1. Take a domain controller offline, and isolate it from the network.
1. Restore the domain controller from a backup that was created at about the time the AD DS database was exposed.
1. Run an authoritative restore operation on the domain's **Managed Service Accounts** container. Make sure that the restore operation includes all the container's child objects that might be associated with this domain controller. This step rolls back the last password update status. The next time that a service retrieves the password, the password updates to a new password that's based on the new KDS root key object.
1. On a different domain controller, follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key) to create a new KDS root key object.
1. On all the domain controllers, restart **Microsoft Key Distribution Service**.
1. Create a new gMSA. Make sure that the new gMSA uses the new KDS root key object to create the value for the **msDS-ManagedPasswordId** attribute.
1. Check the **msDS-ManagedPasswordId** value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS root key object.  

   For example, assume that the KDS root key object has the following **CN**.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot that shows the value of the cn attribute of a KDS root key object.":::  

   A gMSA that's created by using this object has an **msDS-ManagedPasswordId** value that resembles the following.  

   :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key cn attribute.":::  

   In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that is the same as the original GUID.

   If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

1. Delete the old KDS root key object.
1. Reconnect the restored domain controller and bring it online.  
   Now the authoritative restore and all the other changes, including the restored gMSAs, replicate. This action rolls the passwords of the restored gMSAs, creating new passwords that are based on the new KDS root key object.

### Case 2: You don't know details of the KDS root key object exposure, and you can’t wait for passwords to roll

If you don't know what information was exposed or when it was exposed, such an exposure might be part of a complete exposure of your Active Directory forest. This can create a situation in which the attacker can run offline attacks on all passwords. In this case, consider running a Forest Recovery, or resetting all account passwords. Recovering the gMSAs to a clean state is part of this activity.

During the following process, you have to create a new KDS root key object. Then, you use this object to replace all the gMSAs in the domains of the forest that use the exposed KDS root key object.

> [!NOTE]  
> The following steps resemble the procedure that's in [Getting Started with Group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts). However, there are a few important changes.

Follow these steps:

1. Disable all the existing gMSA accounts. To do this, for each account, set the **userAccountControl** attribute to **4098** (this value combines **workstation type** and **disabled**).
1. Use a single domain controller to follow these steps:
   1. Follow the steps in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key.md) to create a new KDS root key object.
   1. Restart **Microsoft Key Distribution Service**. After it restarts, the service picks up the new object.
   1. Edit the existing gMSAs to remove the service principle names (SPNs) and DNS host names.
   1. Create new gMSAs to replace the existing gMSAs.
1. Check the new gMSAs to make sure that they use the new KDS root key object. To do this, follow these steps:
   1. Note the **CN** (GUID) value of the KDS root key object.
   1. Check the **msDS-ManagedPasswordId** value of the first gMSA that you created. The value of this attribute is binary data that includes the GUID of the matching KDS root key object.  

      For example, assume that the KDS root key object has the following **CN**.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/kds-root-key-cn.png" alt-text="Screenshot of the value of the cn attribute of a KDS root key object.":::  

      A gMSA that's created by using this object has an **msDS-ManagedPasswordId** value that resembles the image.  

      :::image type="content" source="media/recover-from-golden-gmsa-attack/gmsa-pwid-data.png" alt-text="Screenshot of the value of the msDS-ManagedPasswordId attribute of a gMSA object, showing how it includes the pieces of the KDS root key CN attribute.":::  

      In this value, the GUID data starts at offset 24. The parts of the GUID are in a different sequence. In this image, the red, green, and blue sections identify the reordered parts. The orange section identifies the part of the sequence that is the same as the original GUID.

      If the first gMSA that you created uses the new KDS root key, all subsequent gMSAs also use the new key.

1. Update the appropriate services to use the new gMSAs.
1. Delete the old gMSAs that used the old KDS root key object.
1. Delete the old KDS root key object.

## References

[Group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
