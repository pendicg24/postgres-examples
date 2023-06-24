create extension if not exists pgrowlocks;
create table table_1 (
   id SERIAL primary key,
   name VARCHAR not null
);

insert into table_1
select i, 'name' || i
from generate_series(1, 200) AS i;
