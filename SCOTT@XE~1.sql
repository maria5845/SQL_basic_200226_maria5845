-- ���̺� 3�� ����� Book, Orders, Customer 
CREATE TABLE Book(
      bookid NUMBER(8),
      bookname VARCHAR2(40),
      publisher VARCHAR2(40),
      price NUMBER(8) );

CREATE TABLE Orders(
    orderid NUMBER(8),
    custid NUMBER(8),
    bookid NUMBER(8),
    saleprice NUMBER(8),
    orderdate DATE
);

CREATE TABLE Customer(
  custid NUMBER(8),
  name VARCHAR(40),
  address VARCHAR(40),
  phone VARCHAR(40)  );

INSERT INTO Book VALUES(1,'�౸�� ����','�½�����',7000);
INSERT INTO Book VALUES(2,'�౸�ƴ� ����','������',13000);
INSERT INTO Book VALUES(3,'�౸�� ����','���ѹ̵��',22000);
INSERT INTO Book VALUES(4,'���� ���̺�','���ѹ̵��',35000);
INSERT INTO Book VALUES(5,'�ǰ� ����','�½�����',8000);
INSERT INTO Book VALUES(6,'���� �ܰ躰���','�½�����',6000);
INSERT INTO Book VALUES(7,'�߱��� �߾�','�̻�̵��',20000);
INSERT INTO Book VALUES(8,'�߱��� ��Ź��','�̻�̵��',13000);
INSERT INTO Book VALUES(9,'�ø��� �̾߱�','�Ｚ��',7500);
INSERT INTO Book VALUES(10,'Olympic Champions','Pearson',13000);

INSERT INTO Orders VALUES(1,1,1,6000,'2014-07-01');
INSERT INTO Orders VALUES(2,1,3,21000,'2014-07-03');
INSERT INTO Orders VALUES(3,2,5,8000,'2014-07-03');
INSERT INTO Orders VALUES(4,3,6,6000,'2014-07-04');
INSERT INTO Orders VALUES(5,4,7,20000,'2014-07-05');
INSERT INTO Orders VALUES(6,1,2,12000,'2014-07-07');
INSERT INTO Orders VALUES(7,4,8,13000,'2014-07-07');
INSERT INTO Orders VALUES(8,4,10,12000,'2014-07-08');
INSERT INTO Orders VALUES(9,2,10,7000,'2014-07-09');
INSERT INTO Orders VALUES(10,3,8,13000,'2014-07-10');

INSERT INTO Customer VALUES(5,'�ڼ���','���ѹα� ����',NULL);
INSERT INTO Customer VALUES(1,'������','���� ��ó��Ÿ','000-5000-001');
INSERT INTO Customer VALUES(2,'�迬��','���ѹα� ����','000-6000-001');
INSERT INTO Customer VALUES(3,'��ζ�','���ѹα� ������','000-7000-001');
INSERT INTO Customer VALUES(4,'�߽ż�','�̱� Ŭ���귣��','000-8000-001');

-- ������ ���� ���� -- 

--1. ������ ���� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ� .

--(1) ������ȣ�� 1�� ������ �̸� 
  SELECT  BOOKNAME FROM Book  WHERE BOOKID=1;
--(2) ������ 20,000�� �̻��� ������ �̸� 
  SELECT BOOKNAME FROM Book WHERE PRICE>=20000;
--(3) �������� �� ���ž�(�������� ����ȣ�� 1������ ���� �ۼ�) 
  SELECT SUM(saleprice) FROM Orders WHERE custid=1;
--(4) �������� ������ ������ �� ( �������� ����ȣ�� 1������ ���� �ۼ�) 
   SELECT COUNT (*) FROM Orders WHERE custid=1;

--2. ������ ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ� 

--(1) ���� ������ �� ���� 
    SELECT COUNT( *) FROM Book;
--(2) ������ ������ ����ϴ� ���ǻ��� �� ���� 
    SELECT COUNT(DISTINCT( Publisher)) FROM Book ;
--(3) ��� ���� �̸�, �ּ� 
   SELECT name,address FROM Customer;
--(4) 2014�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� �޴� ������ �ֹ���ȣ 
   SELECT orderid FROM Orders WHERE orderdate>='2014-07-04' AND orderdate<='2014-07-07';
--(5) 2014�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� �޴� ������ ������ ������ �ֹ���ȣ 
   SELECT orderid FROM Orders WHERE orderdate <='2014-07-04' OR orderdate>='2014-07-07';
--(6) ���� '��'�� ���� �̸��� �ּ� 
   SELECT address FROM Customer WHERE name LIKE '��%';
--(7) ���� '��'�� �̰� �̸��� '��'�� ������ ���� �̸� �� �ּ� 
   SELECT address FROM Customer WHERE name LIKE '��%��';  
   

--3. ������ ���� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�

-- (5) �������� ������ ������ ���ǻ� �� 
    SELECT COUNT(DISTINCT publisher) FROM Orders,Customer,Book 
    Where Customer.custid = orders.custid 
    AND orders.bookid =book.bookid
    AND Customer.name LIKE '������';
-- (6) �������� ������ ������ �̸�, ����, ���� �� �Ǹ� ������ ���� 
    SELECT price+5000 FROM Book;
-- (7) �������� �������� ���� ������ �̸� 
       SELECT DISTINCT bookname FROM Orders,Customer,Book 
       WHERE Customer.custid=orders.custid 
       AND orders.bookid = book.bookid
       AND Customer.name NOT LIKE '������'

--4. ������ ��ڿ� �濵�ڰ� �䱸�ϴ�  ���� ������ ���� SQL ���� �ۼ��Ͻÿ� 

-- (8) �ֹ����� ���� ���� �̸�(�μ����� ���) 
    
-- (9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ� 
      SELECT SUM(saleprice), AVG(saleprice) FROM Orders;
-- (10) ���� �̸��� ���� ���ž� 
       SELECT custid,  Customer.name, Orders.saleprice FROM Customer,Orders 
       WHERE Customer.custid =Orders.custid
       GROUP BY custid;
       
--(11)  ���� �̸��� ���� ������ ���� ��� 
      SELECT Customer.name,book.bookname FROM Orders,Customer,Book 
      Where Customer.custid = orders.custid 
      AND orders.bookid =book.bookid;
--(12) ������ ���� (Book ���̺�) �� �ǸŰ���(Order ���̺�) �� ���̰� ���� ���� �ֹ� 
        
--(13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� ������ ���� �̸� 
       SELECT *FROM Orders;
       SELECT * FROM Book;
       
       SELECT Customer.name FROM Orders,Customer,Book 
      Where Customer.custid = orders.custid 
      AND orders.bookid =book.bookid
      AND AVG ( orders.(saleprice))>AVG(Book.(saleprice));

--- SQL�� ���� ---- 

SELECT * FROM Book WHERE publisher IN('�½�����','���ѹ̵��');
-- �½������� ���� �̵� ���� ���ǻ縦  ��� -- 
SELECT * FROM Book WHERE publisher NOT IN('�½�����','���ѹ̵��');
-- �½������� ���ѹ̵� ���ܵǴ� ���ǻ縦 ��� -- 
SELECT SUM(saleprice),AVG(saleprice),MAX(saleprice) FROM Orders;
-- �Ǹž��� ����, ���,----

SELECT  custid ,SUM(saleprice )FROM Orders GROUP BY custid
HAVING SUM(saleprice) >=20000;
--  ���� ���̺��� �����̵� �������� ���� �� ���̵� �� �Ǹ��� ������ ���Ѵ� (�Ǹž��� 2���� �̻�) .

SELECT * FROM Orders WHERE SUM(saleprice) > 10000;

SELECT custid, Sum(saleprice) FROM Orders WHERE saleprice>7000
GROUP BY custid;

-- ��������
SELECT * FROM Orders, Customer,Book WHERE Customer.custid = orders.custid;

SELECT Book.bookname FROM Orders,Customer,Book 
Where Customer.custid = orders.custid 
AND orders.bookid =book.bookid
AND Customer.name LIKE '������';


