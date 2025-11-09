# Troubleshooting Guide: Unable to Submit Prospective Vendor Registration Request

## Symptom
- User cannot submit a **Prospective Vendor Registration Request (PVRR)** in Dynamics 365 Finance and Operations.
- Vendor registration wizard fails or does not proceed.

## Cause
- Vendor already exists in the system, causing duplication issues.
- Vendor contact missing under **Vendor collaboration > All contacts**.
- Incorrect user provisioning steps followed.

## Resolution
- **If Vendor Already Exists:**
  1. Navigate to **Vendor collaboration > All contacts**.
  2. Select the appropriate contact.
  3. Click **Provision vendor user** to link the existing vendor without creating a duplicate PVRR.
<img width="1117" height="520" alt="image" src="https://github.com/user-attachments/assets/578d30d4-4c77-4a86-85d6-e639360dfd4f" />

- **If Vendor Contact Does NOT Exist:**
  1. Go to **System administration > Users** and delete the existing user record.
  2. Re-invite the vendor using **Procurement and Sourcing > Vendor collaboration requests > Prospective vendor request registration**.
  3. This recreates the user and vendor contact.
<img width="1237" height="573" alt="image" src="https://github.com/user-attachments/assets/f4239479-e861-4467-8317-2cb31777b112" />
<img width="1597" height="506" alt="image" src="https://github.com/user-attachments/assets/f7f2e07f-c017-47fb-a63a-9fc03d2cb0d3" />

- **Important:** After recreating, follow your configured vendor request approval process (auto/manual).
- Refer to official documentation: [Onboard vendors - Supply Chain Management | Dynamics 365 | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/vendor-onboarding).
