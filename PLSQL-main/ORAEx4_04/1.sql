create table t1(c1 numeric);

CREATE OR REPLACE PROCEDURE cw1
(
  p_param IN NUMBER DEFAULT 1000000,
  p_table_name IN VARCHAR2 DEFAULT 't1',
  p_column_name IN VARCHAR2 DEFAULT 'c1'
)
IS
BEGIN

  -- Clear table of data
  EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || p_table_name;

  -- Insert data into table
  FOR i IN 1..p_param LOOP
    EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || ' (' || p_column_name || ') VALUES (' || i || ')';
  END LOOP;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

BEGIN
  cw1(10, 't1', 'c1');
END;
