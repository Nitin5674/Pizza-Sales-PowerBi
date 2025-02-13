
use [Pizza DB]
SELECT * from pizza_sales
select sum(total_price) / count( DISTINCT order_id) as Avg_Order_Value from pizza_sales

select sum(quantity) as total_pizza_sold from pizza_sales

select count(distinct order_id) as total_orders from pizza_sales

select cast(cast(sum(quantity) as decimal(10,2)) / 
cast( count(distinct order_id) as decimal(10,2)) as decimal(10,2)) 
as Avg_pizza_per_ordeer from pizza_sales

select datename(dw, order_date) as order_day , count (distinct order_id)
as total_orders from pizza_sales group by datename(dw, order_date) 

select datename(month, order_date) as month_name, count(distinct order_id)
as total_orders from pizza_sales group by datename(month, order_date) order by 
total_orders desc


select pizza_category , sum(total_price) as total_sales , sum(total_price) * 100 / (select  sum(total_price) 
from pizza_sales where month(order_date)=1 ) as pct  from pizza_sales where month(order_date) = 1  group by pizza_category 


SELECT 
    total_physical_memory_kb / 1024 AS Total_Physical_Memory_MB,
    available_physical_memory_kb / 1024 AS Available_Physical_Memory_MB,
    system_memory_state_desc
FROM sys.dm_os_sys_memory;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'max server memory (MB)', 4096;  -- Adjust based on system capacity
RECONFIGURE;


SELECT TOP 10
    total_worker_time / execution_count AS Avg_CPU_Time,
    total_logical_reads / execution_count AS Avg_Logical_Reads,
    total_physical_reads / execution_count AS Avg_Physical_Reads,
    execution_count,
    text AS QueryText
FROM sys.dm_exec_query_stats
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
ORDER BY Avg_Physical_Reads DESC;

SELECT
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    user_seeks, user_scans, user_lookups
FROM sys.dm_db_index_usage_stats us
JOIN sys.indexes i ON i.object_id = us.object_id AND i.index_id = us.index_id
ORDER BY user_scans DESC;


SELECT 
    total_physical_memory_kb / 1024 AS Total_Physical_Memory_MB,
    available_physical_memory_kb / 1024 AS Available_Physical_Memory_MB,
    system_memory_state_desc
FROM sys.dm_os_sys_memory;


SELECT TOP 10 
    r.session_id,
    r.status,
    r.cpu_time,
    r.memory_usage * 8 AS Memory_Usage_KB,
    r.total_elapsed_time / 1000 AS Elapsed_Time_Sec,
    s.text AS Query_Text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) s
ORDER BY r.memory_usage DESC;

EXEC sp_configure 'max server memory';

