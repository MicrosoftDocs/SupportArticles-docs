---
title: High CPU when you execute a BRE policy
description: This article describes that when you use a Business Rules Engine policy within an orchestration or using the Business Rules Framework to execute a BRE policy, the process executing the policy might experience high CPU.
ms.date: 07/14/2020
ms.prod-support-area-path: Performance
---
# High CPU when you execute a BRE policy

This article provides information that when you use a Business Rules Engine (BRE) policy within an orchestration or using the Business Rules Framework to execute a BRE policy, the process executing the policy might experience high CPU.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 2498797

## Example for the high CPU scenario
  
There is an example that an ASMX web service might use the `Microsoft.RuleEngine.Policy` class to execute a BRE policy. In this scenario, there is slow performance and the w3wp.exe process is using high CPU. If the policy is executing within an orchestration, the btsntsvc.exe or btsntsvc64.exe process will use high CPU.

## BRE has some settings that can impact performance

|Property|Description|
|---|---|
|CacheEntries|Maximum number of entries in the rule engine cache. The default is 32 (decimal).<br/>Recommendation: This rule engine cache impacts parallel policy executions. For example, assume there are two policies: Policy1 and Policy2. Policy1 could be executed a maximum of 10 times in parallel and Policy2 could be executed five times in parallel. This value could be set to 15 (10 + 5).  <br/>If there are a high number of policies and you're unsure of how many times they could be executed in parallel, you can try setting this value to the number of policies as a starting value. For example, if you have 200 policies, try setting this value to 200 (decimal) to see if it impacts CPU usage.  <br/>If there are <32 policies, then the default value of 32 (decimal) is typically fine.|
|CacheTimeout|Time in seconds that an entry is maintained in the update service cache. The default is 3600 seconds (1 hour). If the cache entry is not referenced within 1 hour, the entry is deleted. <br/>Recommendation: If a policy is invoked regularly, then the default value of 3600 seconds should be set. If a policy is invoked less frequently, like every 2 hours, then this value can be increased to >2 hours.|
|CachePruneInterval|Interval after which the pruning logic runs. The default is 60 seconds (1 minute). Every 60 seconds, the cache checks for items that are expired and cleans them. This value is also crossed with CacheTimeout value. <br/>Recommendation: The default value should be fine for most scenarios. It can be increased if you expect less number of items in the cache and the CacheTimeout value is large.|
|PollingInterval|Time in seconds that the Update Service checks the Rule Engine database for an update. The default is 60 seconds (1 minute). <br/>Recommendation: If the policies never or rarely get updated, this value can be increased. Otherwise, the default value is sufficient.|
|TranslationTimeout|Time in milliseconds that can be used to translate a ruleset. The default is 60,000 ms (1 minute). <br/>Recommendation: If it takes <1 minute to translate a ruleset, decreasing this value doesn't have any impact on performance. If your policy execution fails with a translation timeout exception, then definitely increase this value. This is more of a check to ensure that policy translation doesn't take too much time. Typically, the default value is sufficient.|
|SqlTimeout|Time out value for SQL commands to access the rule store. The default value is -1. Possible values:  <br/>< 0 - Uses the .NET default value of 30 seconds<br/>= 0 - Unlimited timeout<br/>> 0 - Maximum time for a query before it times out <br/> Recommendation: Typically, the default value is fine. If you expect a SQL command to execute longer, the value can be increased.|
|StaticSupport|Provides the ability to invoke static functions that can be called directly in a rule. The default value is 0. Possible values:  <br/>0 - Static support is disabled. The static method is called only when an instance of the .NET class is asserted. <br/>1 - An object instance is not required. The static method is called when the rule is evaluated or executed. <br/>2 - An object instance is not required. The static method is called at the policy translation time if all parameters are constant. This is a performance optimization because the static method is called only once even though it is used in multiple rules in conditions. Static methods used as actions will not be executed at the translation time, but static methods used as parameters may be executed. <br/>Recommendation: To enable Static support, set this value to 1 or 2 using the descriptions above. <br/> Note. This is not a performance setting and changing it may break existing policies. The link below provides more information:  [MS BRE: Controlling rule side effects](http://geekswithblogs.net/cyoung/articles/111169.aspx) |
|||

These settings can be set in the registry or a .config file. The registry settings are global for all applications that host a rule engine instance. Registry location:
  
- 32-bit server: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\BusinessRules\3.0`
- 64-bit server: `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\BusinessRules\3.0`

> [!NOTE]
> To add the `StaticSupport` key, right-click the registry key above, point to **New**, and then select **DWORD** value. For **Name**, type *StaticSupport*.

Setting these values in an application configuration file will override the values in the registry. If the policy is being executed within an IIS worker process, the *web.config* file can be modified. If the policy is being executed within a BizTalk orchestration, the *BTSNTSvc.exe.config* or *BTSNTSvc64.exe.config* file can modified. Following is the Sample.config:

```xml
<configuration>  
    <configSections>  
        <section name="Microsoft.RuleEngine" type="System.Configuration.SingleTagSectionHandler" />  
    </configSections>  
    <Microsoft.RuleEngine  
        UpdateServiceHost="localhost"  
        UpdateServicePort="3132"  
        UpdateServiceName="RemoteUpdateService"  
        CacheEntries="32"  
        CacheTimeout="3600"  
        PollingInterval="60"  
        TranslationTimeout="3600"  
        CachePruneInterval="60"  
        DatabaseServer="(localhost)"  
        DatabaseName="BizTalkRuleEngineDb"  
        SqlTimeout="-1"  
        StaticSupport="1" />
</configuration>
```

## The Maximum Execution Loop Depth property has a default value of 65536, which determines how many times a rule can be reevaluated

In a forward-chaining scenario, the execution loop can execute 65,536 times before an exception is thrown.  
Looping can also occur when an `Assert()` or `Update()` function executes. `Maximum Execution Loop Depth` can be modified to the approximate maximum number of times you expect the execution to loop. In many scenarios, it is best to decrease this value to prevent the policy execution from entering an infinite loop. This is essentially putting a hard stop to the number of rule firings that can happen during policy execution. For example, if you want to stop the looping at 200, set this value *200*.  
Once the policy is published, the `Maximum Execution Loop Depth` property cannot be modified. The only option is to create a new version of the policy and modify the value; which can be done in the Properties Window in Business Rule Composer.

## Consider the design of the policies, specifically using Assert and Update  

|Function|Description|
|---|---|
| Assert| The Assert function adds a new object instance into the rule engine's working memory to be evaluated. The engine processes each instance according to the conditions and actions that are written against the type of the instance, using the match-conflict resolution-action phases. |
| Update| The Update function reasserts an *existing* object into the rule engine's working memory to be reevaluated, based on the new data and state. When you update an existing object, only conditions that use the updated fact are reevaluated, and actions are added to the agenda if these conditions are evaluated to true. The Update function causes *all* the rules using the updated facts to be reevaluated. As a result, the Update function calls can be expensive, especially if there are a large number of rules. <br/>Recommendation: As a troubleshooting step, you can remove the UPDATE in attempt to resolve the high CPU. This may return different results but if it corrects the CPU usage, you have a good idea of where to focus your troubleshooting efforts. |
|||

For more information on Assert and Update, visit the link: [Effect of Engine Control Functions on Business Rule Execution - Part1](/archive/blogs/brajens/effect-of-engine-control-functions-on-business-rule-execution-part1)

## Additional design best practices

- If different policy objects are created, be sure they are disposed.
- If a single request can generate multiple threads for execution, be sure to load-test with a high number of requests.
- The `TypedDataTable` binding is best used when the size of the data set is small, typically <10. The `TypedDataTable` binding is a wrapper to a `DataTable` in ADO.Net, which represents one table of in-memory data. `TypedDataTable` objects are disconnected data objects, so there is no active database connection.
- The `DataConnection` binding is best used when the size of the data set is large, typically >=10. The `DataConnection` binding is a wrapper to a `DataSet` in ADO.Net, which represents a complete set of data, including related tables, constraints, and relationships among the tables. `DataConnection` objects are closed by the BRE runtime.
