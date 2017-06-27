CREATE OR REPLACE PACKAGE PKG_MST AUTHID CURRENT_USER IS
       
      /**************************************************************************
       -- Summary : ִ�й��������ϵά���洢����
       --           MST_ORG �� MST_ORG_REF
      **************************************************************************/
      PROCEDURE PROC_ORG_CASE; 
END;



CREATE OR REPLACE PACKAGE BODY PKG_MST IS
       
      /**************************************************************************
       -- Summary : ִ�й��������ϵά���洢����
       --           MST_ORG �� MST_ORG_REF
      **************************************************************************/
      PROCEDURE PROC_ORG_CASE IS 
            TYPE IDX_ORG_TABLE IS TABLE OF VARCHAR2(32) INDEX BY BINARY_INTEGER;  --���������
            V_ORG_LIST IDX_ORG_TABLE;   --���������ͱ��� 
            V_I BINARY_INTEGER;         --����һ��ineger���� ����ѭ������        
      BEGIN
            DELETE FROM MST_ORG_REF;  --ɾ��ȫ��
            --װ�����ݵ������ͱ�����ȥ
            SELECT ORG_ID BULK COLLECT INTO V_ORG_LIST FROM MST_ORG  
                   START WITH PARENT_ID IS NULL
                   CONNECT BY PRIOR ORG_ID = PARENT_ID;
            --ȡ�õ�һ������ֵ
            V_I := V_ORG_LIST.FIRST;    
            WHILE V_I IS NOT NULL LOOP
                 DECLARE 
                      V_ORGID MST_ORG.ORG_ID%TYPE := V_ORG_LIST(V_I);
                      --����һ���α�
                      CURSOR CUR_ORG_TREE IS
                             SELECT * FROM MST_ORG
                                      START WITH ORG_ID = V_ORGID     
                                      CONNECT BY PRIOR ORG_ID = PARENT_ID;
                      V_OT CUR_ORG_TREE%ROWTYPE;
                 BEGIN
                      -- FORѭ��
                      FOR V_OT IN CUR_ORG_TREE LOOP
                          INSERT INTO MST_ORG_REF VALUES(V_OT.ORG_ID, V_ORGID);
                      END LOOP;       
                 END; 
                 -- ���±���                
                 V_I := V_ORG_LIST.NEXT(V_I);                 
            END LOOP;         
      END;


END;


