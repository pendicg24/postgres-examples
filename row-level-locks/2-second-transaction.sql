-- 1 - Will be waiting for "for update" lock until it's released
-- Even if only one row is locked from all requested ones, it must wait for the lock release
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 2 - Doesn't require "for update" lock
begin;
select * from table_1 where name ilike 'name10%';
commit;

-- 3 - Will be waiting for "for update" lock until it's released
-- Even if only one row is locked from all requested ones, it must wait for the lock release
-- The same is valid for "for key share" and "for share"
begin;
select * from table_1 where name ilike 'name10%' for key share;
commit;

-- 4 - Will be waiting for "for key share" lock until it's released
-- Even if only one row is locked from all requested ones, it must wait for the lock release
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 5 - Will retrieve rows as "for key share" and "for share" are not mutually exclusive
begin;
select * from table_1 where name ilike 'name10%' for share;
commit;

-- 6 - insert will try to acquire "for key share" lock, but will be unable to do it,
-- as the other transaction took "for update" lock, which is mutually exclusive with
-- the above one
create table table_2 (
   id SERIAL primary key,
   table_1_id int,
   constraint fk_table_1_id
      foreign key(table_1_id)
	  references table_1(id)
);

begin;
insert into table_2 values (2, 10);
commit;

drop table table_2;

-- 7 - insert will try to acquire "for key share" lock and will success to obtain it,
-- as it's not mutually exlusive with "for no key update" lock
create table table_2 (
   id SERIAL primary key,
   table_1_id int,
   constraint fk_table_1_id
      foreign key(table_1_id)
	  references table_1(id)
);

begin;
insert into table_2 values (2, 10);
commit;

drop table table_2;
