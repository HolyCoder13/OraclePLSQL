drop table t1;

create table t1(c1 numeric);

CREATE OR REPLACE PROCEDURE cw1
(
  p_param IN NUMBER DEFAULT 1000000,
  p_table IN VARCHAR2 DEFAULT 't1',
  p_column IN VARCHAR2 DEFAULT 'c1'
)
IS
BEGIN
  
  BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || p_table;
  EXCEPTION
    WHEN OTHERS THEN
      EXECUTE IMMEDIATE 'CREATE TABLE ' || p_table || ' (' || p_column || ' NUMBER)';
  END;

  
  BEGIN
    EXECUTE IMMEDIATE 'SELECT ' || p_column || ' FROM ' || p_table || ' WHERE ROWNUM = 1';
  EXCEPTION
    WHEN OTHERS THEN
      EXECUTE IMMEDIATE 'ALTER TABLE ' || p_table || ' ADD ' || p_column || ' NUMBER';
  END;

  
  EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || p_table;

  
  FOR i IN 1..p_param LOOP
    INSERT INTO t1 (c1) VALUES (i);
  END LOOP;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eror: ' || SQLERRM);
END;

BEGIN
  cw1(100, 't1', 'c1');
END;