---
title: "Troubleshoot enterprise knowledge sources"
description: "Reference to troubleshoot enterprise data used as knowledge sources in custom agents."
ms.date: 05/27/2025
ms.topic: troubleshooting-problem-resolution
author: rakrish84
ms.author: rchetla
ms.reviewer: erickinser
manager: kjette
ms.search.region: USA
ms.custom: sap:Knowledge\Enterprise data via Graph connectors
---

# Troubleshoot enterprise knowledge sources

Enterprise data knowledge sources provide the ability for makers to apply data sources using [real-time knowledge connectors](/microsoft-copilot-studio/knowledge-real-time-connectors), such as Salesforce, ServiceNow Knowledge, ZenDesk, and Azure SQL Server.

## Design time errors

When adding or editing a knowledge source (such as adding tables or previewing data), you might encounter one of the following errors. The following guidelines help you mitigate these errors:

### Connection not found

- **Error message**: The configured connection is no longer present.

- **Possible issue**: The connection was possibly removed from the maker portal.

- **Mitigation**: Verify that the connections are valid for all the appropriate knowledge sources and reconfigure as needed.

### Unauthorized access

- **Error message**: Credentials are missing or not valid for the connection.

- **Possible issue**: The credentials were modified or are no longer valid.

- **Mitigation**: Reconnect to one or more knowledge sources on the **Knowledge** page or in the maker portal.

### Unable to connect to Service Now instance

- **Error message**: We can't connect to your ServiceNow instance because it's currently in hibernation mode.

- **Possible issue**: The ServiceNow instance might be hibernating.

- **Mitigation**: Sign in to your ServiceNow instance directly, then try again.

### No tables found

- **Error message:** We couldn't find any tables for the given connection.

- **Possible issue:** The knowledge source might not have queryable tables.

- **Mitigation:** Verify that the knowledge source has queryable tables, then try again.

### Connection firewall 

- **Error message:** Unable to connect to the knowledge source due to firewall issues. 

- **Possible issue:** The firewall rules are blocking the connection. 

- **Mitigation:** Create appropriate firewall rules to enable access.

### Bad gateway 

- **Error message:** Unable to establish connection to the knowledge source. 

- **Possible issue:** The instance isn't accessible, or gateway settings and **Deny Public Network Access** settings are incorrect. 

- **Mitigation:**
  - Ensure instance accessibility: Verify that the instance you're trying to connect to is up and running. Check for any network issues or maintenance activities affecting the instance.
  - Verify gateway settings: Access the gateway configuration settings, then ensure that the gateway is correctly configured to allow connections to the instance. Also check for any misconfigurations or errors in the gateway settings.
  - Check **Deny Public Network Access** settings: Navigate to the security settings of the instance. Ensure that the **Deny Public Network Access** option isn't turned on if public access is required. Then adjust the settings to allow necessary network access. ‌

### APIM connection doesn't exist 

- **Error message:** The configured connection is no longer active. 

- **Possible issue:** The connection configuration was lost or isn't valid. 

- **Mitigation:** Reconfigure the connection for the knowledge source and try again.

### Forbidden access 

- **Error message:** Access to the requested resource is forbidden. 

- **Possible issue:** The user doesn't have the necessary permissions to access the resource. 

- **Mitigation:** Verify that the user has the correct permissions and roles assigned. If necessary, update the permissions in the user management settings or contact the administrator for access. 
 
#### What is a Queryable Table?

A queryable table is one that can be queried or accessed to retrieve data. In the context of databases and knowledge sources, a queryable table typically holds structured data that can be included in search queries and data retrieval operations.

#### Non-Queryable tables

There are predefined sets of tables that are intentionally excluded from the allowed tables, since they generally contain unstructured or text-based data. To use these tables, you must use the **Your connections** option when connecting to the knowledge source. This option provides access to the unstructured data. For more information, go to [Unstructured data as a knowledge source](/microsoft-copilot-studio/knowledge-unstructured-data) and [Add unstructured data as a knowledge source](/microsoft-copilot-studio/knowledge-add-unstructured-data).

The following tables require the use of the **Your connections** option.

- **ServiceNow**: Knowledge Article

- **Zendesk**: Articles

- **Salesforce**:

  - Knowledge Article
  - Knowledge Article Version
    
  > [!NOTE]
  > At the table level, the `Queryable` property determines whether a table can be queried. In addition, the following Salesforce table types are unqueryable:
  > - Article Version History
  > - Article View Statistics
  > - Article Vote Statistics
  > - Account Change Event

## Content moderation errors

Before responses are returned to your agent's users, a [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) check is performed to ensure the quality and appropriateness of the agent's response. If a user's query is deemed unanswerable by the content moderation system, the request fails. When a request fails due to content moderation, the user's query doesn't meet the criteria for a valid and answerable question. The following guidelines help to determine if a query is likely to fail or pass the content moderation check.

### Queries that pass

- **Database queries**: Questions involving the retrieval of data from a database. For example: "What are the sales figures for Q1 2024?"

### Queries that fail

- **Data modification**: Requests to change or update data. For example: "Update the status of ticket #12345 to 'Resolved.'"

- **Text search**: Queries requiring searches for specific text within documents or records. For example: "Find all emails containing the words the word 'urgent.'"

- **Support questions**: Queries regarding general support-related questions. For example: "How do I reset my password?"

- **How-to questions**: Queries requesting instructions or step-by-step guides. For example: "How do I create a new user in Salesforce?"

- **Unstructured data questions**: Queries trying to analyze unstructured data in enterprise knowledge sources. For example: "What's the status of my VPN - invoke KB articles in ServiceNow."

### Content moderation FAQ

The answers to these frequently asked questions (FAQ) provide further insight into how content moderation affects queries to enterprise knowledge sources.

#### Why did my query fail content moderation?

Your query might contain elements that aren't supported, such as requests for data modification or text searches.

#### How do I get a detailed error message when a query fails?

Currently, it's not possible to receive a detailed error message due to content moderation. Review the types of queries being used to ensure you're using a passing query.

#### How do I improve my query to pass content moderation?

Ensure that your queries are focused on retrieving data from the connected databases. Queries shouldn't be based on text searches, data modification, or support questions.
