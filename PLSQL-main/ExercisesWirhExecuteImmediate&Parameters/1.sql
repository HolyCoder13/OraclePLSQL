create table t1(id numeric(37), imie varchar2(50), nazwisko varchar2(50));
drop table t1;
create or replace procedure pr1(
    table_name in varchar2 default 't1'
)
is 
begin
execute immediate 'truncate table ' || table_name;
commit;
end;

create or replace procedure fill(
    table_name in varchar2 default 't1',
    column_name in varchar2 default 'id'
)
is
begin

for i in 1..20 loop
         EXECUTE IMMEDIATE 'INSERT INTO ' || table_name || ' (' || column_name || ') VALUES (' || i || ')';
    end loop;
end;

begin
    fill();
end;

begin
    pr1();
end;
select * from t1;


CREATE OR REPLACE PROCEDURE fill(
    p_table_name IN VARCHAR2 DEFAULT 't1',
    p_column_name IN VARCHAR2 DEFAULT 'id'
)
IS
    l_table_count NUMBER;
    l_column_count NUMBER;
BEGIN
    -- Check if the table exists
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM user_tables WHERE table_name = ''' || p_table_name || '''' INTO l_table_count;
    IF l_table_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Table ' || p_table_name || ' does not exist');
        RETURN;
    END IF;

    -- Check if the column exists
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM user_tab_columns WHERE table_name = ''' || p_table_name || ''' AND column_name = ''' || p_column_name || '''' INTO l_column_count;
    IF l_column_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Column ' || p_column_name || ' does not exist in table ' || p_table_name);
        RETURN;
    END IF;

    -- Insert data into the table
    FOR i IN 1..20 LOOP
        EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || ' (' || p_column_name || ') VALUES (' || i || ')';
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Data inserted successfully');
END;
