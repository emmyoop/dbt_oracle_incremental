
-- Use the `ref` function to select from other models

{{ config(materialized='incremental') }}

select *
from {{ ref('debug_table') }}
where id = 1
