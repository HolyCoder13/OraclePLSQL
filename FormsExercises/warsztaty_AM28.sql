

CREATE TABLE treetest

(

  ID      NUMBER(5),                         -- Unique identifiant

  LABEL   VARCHAR2(128 BYTE),                -- Tree label

  ICON    VARCHAR2(40 BYTE),                 -- Icon name

  MASTER  NUMBER(5),                         -- Parent ID

  STATUS  NUMBER(1)           DEFAULT 1,     -- Initial status of the node

  VALUE   VARCHAR2(128 BYTE)                 -- Dialog name to call   

)

SELECT STATUS, LEVEL, LABEL, ICON, VALUE

FROM treetest

CONNECT BY PRIOR ID = MASTER

START WITH MASTER IS NULL;


drop table productTree;

CREATE TABLE productTree

(

  prod_category      NUMBER(5),                         -- Unique identifiant

  prod_subcategory_id   VARCHAR2(120),                -- Tree label

  prod_subcategory_desc    VARCHAR2(40),                 -- Icon name

  prod_name  varchar2(50),                         -- Parent ID

  prod_desc  varchar2(250),
  
  STATUS NUMBER(1)           DEFAULT 1,     -- Initial status of the node
  
  MASTER NUMBER(2),

  VALUE   VARCHAR2(128 BYTE)                 -- Dialog name to call   

);

insert into producttree(prod_category,prod_subcategory_id,prod_subcategory_desc,prod_name,prod_desc) 
SELECT prod_id, prod_category, prod_subcategory, prod_name, substr(prod_desc,1,1999)
from PRODUCTS;

CONNECT BY PRIOR ID = MASTER

START WITH MASTER IS NULL


select distinct
prod_category_id as id, prod_category_desc as laber, null as icon, 0 as master, 1 as status, prod_category_id as value
from products
union
select distinct
prod_subcategory_id as id, prod_subcategory_desc as laber, null as icon, prod_category_id as master, 1 as status, prod_subcategory_id as value
from products
union
select 
prod_id as id, prod_desc as laber, null as icon, prod_subcategory_id as master, 1 as status, prod_id as value
from products

SELECT STATUS, LEVEL, LABEL, ICON, VALUE

FROM treetest

CONNECT BY PRIOR ID = master

START WITH MASTER = 0

--perpektywe z zapytania
--perspektyw kopiujemy zmieniamy na from nazwa naszej perspektywy

create view produkty as
select distinct
prod_category_id as id, prod_category_desc as laber, null as icon, 0 as master, 1 as status, prod_category_id as value
from products
union
select distinct
prod_subcategory_id as id, prod_subcategory_desc as laber, null as icon, prod_category_id as master, 1 as status, prod_subcategory_id as value
from products
union
select 
prod_id as id, prod_desc as laber, null as icon, prod_subcategory_id as master, 1 as status, prod_id as value
from products

SELECT STATUS, LEVEL, LABER, ICON, VALUE

FROM produkty

CONNECT BY PRIOR ID = master

START WITH MASTER = 0
