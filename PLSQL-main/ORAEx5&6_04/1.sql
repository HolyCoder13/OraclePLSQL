create table t1(c1 numeric);
drop table t1;
CREATE OR REPLACE PROCEDURE cw1
(
  param IN NUMBER DEFAULT 1000000,
  table_name IN VARCHAR2 DEFAULT 't1',
  column_name IN VARCHAR2 DEFAULT 'c1'
)
IS
BEGIN
  -- Check if table
  BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || table_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,'Table '||table_name||' does not exist!');
  END;

  -- Check if column
  BEGIN
    EXECUTE IMMEDIATE 'SELECT ' || column_name || ' FROM ' || table_name || ' WHERE ROWNUM = 1';
  EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'Column '||column_name||' from '|| table_name||' does not exist' );
  END;

  -- Clear table of data
  EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || table_name;

  -- Insert data into table
  FOR i IN 1..param LOOP
     EXECUTE IMMEDIATE 'INSERT INTO ' || table_name || ' (' || column_name || ') VALUES (' || i || ')';
  END LOOP;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


--Proper
BEGIN
  cw1(100, 't1', 'c1');
END;

--Error example
BEGIN
  cw1(100, 't1', 'c111');
END;

select * from t1;