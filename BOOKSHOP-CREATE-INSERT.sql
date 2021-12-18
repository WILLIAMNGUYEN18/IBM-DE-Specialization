-- Drop the tables in case they exist

DROP TABLE BookShop;
DROP TABLE BookShop_AuthorDetails;

-- Create the table

CREATE TABLE BookShop (
	BOOK_ID VARCHAR(4) NOT NULL, 
	TITLE VARCHAR(100) NOT NULL, 
	AUTHOR_NAME VARCHAR(30) NOT NULL, 
	AUTHOR_BIO VARCHAR(250),
	AUTHOR_ID INTEGER NOT NULL, 
	PUBLICATION_DATE DATE NOT NULL, 
	PRICE_USD DECIMAL(6,2) CHECK(Price_USD>0) NOT NULL
	);





-- Insert sample data into the table

INSERT INTO BookShop VALUES
('B101', 'Introduction to Algorithms', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123 , '2001-09-01', 125),
('B201', 'Structure and Interpretation of Computer Programs', 'Harold Abelson', 'Harold Abelson, Ph.D., is Class of 1922 Professor of Computer Science and Engineering in the Department of Electrical Engineering and Computer Science at MIT and a fellow of the IEEE.', 456, '1996-07-25', 65.5),
('B301', 'Deep Learning', 'Ian Goodfellow', 'Ian J. Goodfellow is a researcher working in machine learning, currently employed at Apple Inc. as its director of machine learning in the Special Projects Group. He was previously employed as a research scientist at Google Brain.', 369, '2016-11-01', 82.7),
('B401', 'Algorithms Unlocked', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123, '2013-05-15', 36.5),
('B501', 'Machine Learning: A Probabilistic Perspective', 'Kevin P. Murphy', '', 157, '2012-08-24', 46);

-- enforcing 2NF by moving authorID and name outside of bookshop
CREATE TABLE BookShop_AuthorDetails 
AS 
(SELECT DISTINCT AUTHOR_ID, AUTHOR_NAME, AUTHOR_BIO FROM BookShop) 
WITH DATA;

-- removing redundant information
ALTER TABLE BookShop
DROP COLUMN AUTHOR_NAME
DROP COLUMN AUTHOR_BIO;
-- Retrieve all records from the table

SELECT * FROM BookShop;
SELECT * FROM BookShop_AuthorDetails;

-- Call Sysproc.admin_cmd ('reorg Table BookShop');

--setting primary key for each table
ALTER TABLE BookShop
ADD PRIMARY KEY (BOOK_ID);

ALTER TABLE BookShop_AuthorDetails
ADD PRIMARY KEY (AUTHOR_ID);

-- setting foreign key
ALTER TABLE BookShop
ADD CONSTRAINT fk_BookShop FOREIGN KEY (AUTHOR_ID)
    REFERENCES BookShop_AuthorDetails(AUTHOR_ID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;