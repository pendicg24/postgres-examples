-- 1 - Acquires a "for update" lock
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 2 - Acquires a "for update" lock
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 3 - Acquires a "for update" lock
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 4 - Acquires a "for key share" lock
begin;
select * from table_1 where name ilike 'name10%' for key share;
commit;

-- 5 - Acquires a "for key share" lock
begin;
select * from table_1 where name ilike 'name10%' for key share;
commit;

-- 6 - Acquires a "for update" lock
begin;
select * from table_1 where name ilike 'name10%' for update;
commit;

-- 7 - Acquires a "for no key update" lock
begin;
select * from table_1 where name ilike 'name10%' for no key update;
commit;
