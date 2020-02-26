-- 테이블 3개 만들기 Book, Orders, Customer 
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

INSERT INTO Book VALUES(1,'축구의 역사','굿스포츠',7000);
INSERT INTO Book VALUES(2,'축구아는 여자','나무수',13000);
INSERT INTO Book VALUES(3,'축구의 이해','대한미디어',22000);
INSERT INTO Book VALUES(4,'골프 바이블','대한미디어',35000);
INSERT INTO Book VALUES(5,'피겨 교본','굿스포츠',8000);
INSERT INTO Book VALUES(6,'역도 단계별기술','굿스포츠',6000);
INSERT INTO Book VALUES(7,'야구의 추억','이상미디어',20000);
INSERT INTO Book VALUES(8,'야구를 부탁해','이상미디어',13000);
INSERT INTO Book VALUES(9,'올림픽 이야기','삼성당',7500);
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

INSERT INTO Customer VALUES(5,'박세리','대한민국 대전',NULL);
INSERT INTO Customer VALUES(1,'박지성','영국 맨처스타','000-5000-001');
INSERT INTO Customer VALUES(2,'김연아','대한민국 서울','000-6000-001');
INSERT INTO Customer VALUES(3,'장민란','대한민국 강원도','000-7000-001');
INSERT INTO Customer VALUES(4,'추신수','미국 클리브랜드','000-8000-001');

-- 데이터 추출 문제 -- 

--1. 서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오 .

--(1) 도서번호가 1인 도서의 이름 
  SELECT  BOOKNAME FROM Book  WHERE BOOKID=1;
--(2) 가격이 20,000원 이상인 도서의 이름 
  SELECT BOOKNAME FROM Book WHERE PRICE>=20000;
--(3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성) 
  SELECT SUM(saleprice) FROM Orders WHERE custid=1;
--(4) 박지성의 구매한 도서의 수 ( 박지성의 고객번호는 1번으로 놓고 작성) 
   SELECT COUNT (*) FROM Orders WHERE custid=1;

--2. 서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오 

--(1) 서점 도서의 총 개수 
    SELECT COUNT( *) FROM Book;
--(2) 서점에 도서를 출고하는 출판사의 총 개수 
    SELECT COUNT(DISTINCT( Publisher)) FROM Book ;
--(3) 모든 고객의 이름, 주소 
   SELECT name,address FROM Customer;
--(4) 2014년 7월 4일 ~ 7월 7일 사이에 주문 받는 도서의 주문번호 
   SELECT orderid FROM Orders WHERE orderdate>='2014-07-04' AND orderdate<='2014-07-07';
--(5) 2014년 7월 4일 ~ 7월 7일 사이에 주문 받는 도서를 제외한 도서의 주문번호 
   SELECT orderid FROM Orders WHERE orderdate <='2014-07-04' OR orderdate>='2014-07-07';
--(6) 성이 '김'씨 고객의 이름과 주소 
   SELECT address FROM Customer WHERE name LIKE '김%';
--(7) 성이 '김'씨 이고 이름이 '아'로 끝나는 고객의 이름 과 주소 
   SELECT address FROM Customer WHERE name LIKE '김%아';  
   

--3. 서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오

-- (5) 박지성이 구매한 도서의 출판사 수 
    SELECT COUNT(DISTINCT publisher) FROM Orders,Customer,Book 
    Where Customer.custid = orders.custid 
    AND orders.bookid =book.bookid
    AND Customer.name LIKE '박지성';
-- (6) 박지성이 구매한 도서의 이름, 가격, 정가 와 판매 가격의 차이 
    SELECT price+5000 FROM Book;
-- (7) 박지성이 구매하지 않은 도서의 이름 
       SELECT DISTINCT bookname FROM Orders,Customer,Book 
       WHERE Customer.custid=orders.custid 
       AND orders.bookid = book.bookid
       AND Customer.name NOT LIKE '박지성'

--4. 서점의 운영자와 경영자가 요구하는  다음 질문에 대해 SQL 문을 작성하시오 

-- (8) 주문하지 않은 고객의 이름(부속질의 사용) 
    
-- (9) 주문 금액의 총액과 주문의 평균 금액 
      SELECT SUM(saleprice), AVG(saleprice) FROM Orders;
-- (10) 고객의 이름과 고객별 구매액 
       SELECT custid,  Customer.name, Orders.saleprice FROM Customer,Orders 
       WHERE Customer.custid =Orders.custid
       GROUP BY custid;
       
--(11)  고객의 이름과 고객이 구매한 도서 목록 
      SELECT Customer.name,book.bookname FROM Orders,Customer,Book 
      Where Customer.custid = orders.custid 
      AND orders.bookid =book.bookid;
--(12) 도서의 가격 (Book 테이블) 과 판매가격(Order 테이블) 의 차이가 가장 많은 주문 
        
--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더높은 고객의 이름 
       SELECT *FROM Orders;
       SELECT * FROM Book;
       
       SELECT Customer.name FROM Orders,Customer,Book 
      Where Customer.custid = orders.custid 
      AND orders.bookid =book.bookid
      AND AVG ( orders.(saleprice))>AVG(Book.(saleprice));

--- SQL의 기초 ---- 

SELECT * FROM Book WHERE publisher IN('굿스포츠','대한미디어');
-- 굿스포츠와 대한 미디어가 들어가는 출판사를  출력 -- 
SELECT * FROM Book WHERE publisher NOT IN('굿스포츠','대한미디어');
-- 굿스포츠와 대한미디어가 제외되는 출판사를 출력 -- 
SELECT SUM(saleprice),AVG(saleprice),MAX(saleprice) FROM Orders;
-- 판매액의 총합, 평균,----

SELECT  custid ,SUM(saleprice )FROM Orders GROUP BY custid
HAVING SUM(saleprice) >=20000;
--  오더 테이블에서 고객아이디를 기준으로 묶인 고객 아이디 와 판매의 총합을 구한다 (판매액이 2만원 이상) .

SELECT * FROM Orders WHERE SUM(saleprice) > 10000;

SELECT custid, Sum(saleprice) FROM Orders WHERE saleprice>7000
GROUP BY custid;

-- 내부조인
SELECT * FROM Orders, Customer,Book WHERE Customer.custid = orders.custid;

SELECT Book.bookname FROM Orders,Customer,Book 
Where Customer.custid = orders.custid 
AND orders.bookid =book.bookid
AND Customer.name LIKE '박지성';


