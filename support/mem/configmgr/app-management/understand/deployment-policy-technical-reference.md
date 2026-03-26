---
title: Application deployment policy technical reference
description: Troubleshooting application deployment policies technical reference for Configuration Manager.
ms.manager: dcscontentpm
audience: itpro
ms.date: 03/25/2026
ms.subservice: core-infra
ms.topic: troubleshooting
ms.collection: tier3
ms.custom: sap:Application Management\Application Deployment (Users)
---

# Application Deployment Policy

*Applies to: Configuration Manager (current branch)*

## Policy Creation

When you deploy an application, an instance of [SMS_ApplicationAssignment](/intune/configmgr/develop/reference/apps/sms_applicationassignment-server-wmi-class) class is created which represents the assignment of an application to a collection. This activity can be tracked in the SMSProv.log file.

```output
SMS Provider    PutInstanceAsync SMS_ApplicationAssignment~
SMS Provider    Auditing: User CONTOSO\Admin created an instance of class SMS_ApplicationAssignment.~
```

In the Configuration Manager database, this information is stored in the `CI_CIAssignments` table where `AssignmentType` 2 represents an application deployment. When the assignment is created, SMS Database Monitor component detects a change in the table then notifies Object Replication Manager to process the CI Assignment (CIA) policy. Object Replication Manager component then creates the policy for the application assignment in the database, which is stored in the `Policy` table in the database, and the Policy ID is based on the Application Unique ID. This activity can be tracked in the objreplmgr.log file by referencing the Assignment Unique ID, which can be obtained from the SQL query referenced in the [Before You Begin](app-deployment-technical-reference.md#before-you-begin) section.

```output
***** Processing Application Assignment {3AC57DFE-3F87-4C59-930B-B9F57CB41B91} *****
```

The policy for the application assignment can be seen in the database using a SQL query similar to the following example.

```sql
SELECT P.PolicyID, PA.PolicyAssignmentID, PA.PADBID, PA.IsTombstoned, PA.LastUpdateTime FROM Policy P
JOIN PolicyAssignment PA ON P.PolicyID = PA.PolicyID
WHERE P.PolicyID = '{3AC57DFE-3F87-4C59-930B-B9F57CB41B91}' -- Replace Assignment Unique ID
```

## Policy Targeting

After the policy is generated, the Policy Provider component assigns this policy to the resources in the collection that's targeted by the application deployment. The policy targeting information is stored in the `ResPolicyMap` table in the database. You can use the PADBID returned by the above query to track this activity in policypv.log. However, the PADBID recorded in the log may not always match the PADBID returned by the above query if multiple policies are getting processed simultaneously.

```output
~Policy or Policy Target Change Event triggered.
~Completed batch with beginning PADBID = 16778403 ending PADBID = 16778403.
```

> [!NOTE]  
> `ResPolicyMap` table does not contain any targeting information for applications that are deployed as **Available** to User collections. Software Center queries a list of these applications from the Management Point, and policy targeting information for these applications is generated dynamically when a user requests an application from Software Center.

## Next Steps

- [Application Deployment to Device Collections](device-deployment-technical-reference.md)
- [Application Deployment to User Collections](user-deployment-technical-reference.md)
