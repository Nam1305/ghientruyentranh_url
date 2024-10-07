---------------------------------------------DDL---------------------------------------------
CREATE TABLE Categories (
  category_id   int IDENTITY NOT NULL, 
  category_name varchar(255) NOT NULL, 
  PRIMARY KEY (category_id));
  -------------------------------------
CREATE TABLE Chapters (
  chapter_id     int IDENTITY NOT NULL, 
  story_id       int NOT NULL, 
  chapter_number varchar(255) NOT NULL, 
  title          varchar(255) NOT NULL, 
  created_at     datetime NOT NULL, 
  updated_at     datetime NOT NULL, 
  PRIMARY KEY (chapter_id));
  -------------------------------------

CREATE TABLE Chapters_Image (
  ImageID    int IDENTITY NOT NULL, 
  chapter_id int NOT NULL, 
  image_url  varchar(255) NOT NULL, 
  PageNumber int NOT NULL, 
  PRIMARY KEY (ImageID));
  -------------------------------------

CREATE TABLE Comments (
  comment_id int IDENTITY NOT NULL, 
  user_id    int NOT NULL, 
  story_id   int NOT NULL, 
  chapter_id int NOT NULL, 
  content    varchar(1000) NULL, 
  created_at datetime NOT NULL, 
  PRIMARY KEY (comment_id));
  -------------------------------------

CREATE TABLE Favorites (
  user_id  int NOT NULL, 
  story_id int NOT NULL, 
  added_at datetime NOT NULL);
  -------------------------------------

CREATE TABLE Ratings (
  rating_id  int IDENTITY NOT NULL, 
  user_id    int NOT NULL, 
  story_id   int NOT NULL, 
  rating     int NOT NULL, 
  created_at datetime NOT NULL, 
  PRIMARY KEY (rating_id));
  -------------------------------------

CREATE TABLE Reports (
  report_id  int IDENTITY NOT NULL, 
  user_id    int NOT NULL, 
  comment_id int NOT NULL, 
  story_id   int NOT NULL, 
  reason     varchar(1000) NOT NULL, 
  created_at datetime NOT NULL, 
  PRIMARY KEY (report_id));
  -------------------------------------

CREATE TABLE Stories (
  story_id    int IDENTITY NOT NULL, 
  title       varchar(255) NOT NULL, 
  author      varchar(255) NOT NULL, 
  description varchar(5000) NULL, 
  cover_image varchar(255) NOT NULL, 
  status      varchar(255) NOT NULL, 
  created_at  datetime NOT NULL, 
  updated_at  datetime NOT NULL, 
  like_count  int NOT NULL, 
  PRIMARY KEY (story_id));
  -------------------------------------

CREATE TABLE story_categories (
  story_id    int NOT NULL, 
  category_id int NOT NULL, 
  PRIMARY KEY (story_id, 
  category_id));
  -------------------------------------

CREATE TABLE Users (
  user_id    int IDENTITY NOT NULL, 
  username   varchar(255) NOT NULL, 
  email      varchar(255) NOT NULL, 
  password   varchar(10) NOT NULL, 
  avatar     varchar(255) NULL, 
  role       varchar(255) NOT NULL, 
  created_at datetime NOT NULL, 
  updated_at datetime NOT NULL, 
  vip        int NOT NULL, 
  PRIMARY KEY (user_id));
  -------------------------------------

ALTER TABLE Chapters ADD CONSTRAINT FKChapters224263 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE story_categories ADD CONSTRAINT FKstory_cate722913 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE story_categories ADD CONSTRAINT FKstory_cate597472 FOREIGN KEY (category_id) REFERENCES Categories (category_id);
ALTER TABLE Favorites ADD CONSTRAINT FKFavorites489155 FOREIGN KEY (user_id) REFERENCES Users (user_id);
ALTER TABLE Favorites ADD CONSTRAINT FKFavorites344232 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE Comments ADD CONSTRAINT FKComments12116 FOREIGN KEY (user_id) REFERENCES Users (user_id);
ALTER TABLE Comments ADD CONSTRAINT FKComments845503 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE Comments ADD CONSTRAINT FKComments830005 FOREIGN KEY (chapter_id) REFERENCES Chapters (chapter_id);
ALTER TABLE Reports ADD CONSTRAINT FKReports952430 FOREIGN KEY (user_id) REFERENCES Users (user_id);
ALTER TABLE Reports ADD CONSTRAINT FKReports181418 FOREIGN KEY (comment_id) REFERENCES Comments (comment_id);
ALTER TABLE Ratings ADD CONSTRAINT FKRatings958054 FOREIGN KEY (user_id) REFERENCES Users (user_id);
ALTER TABLE Ratings ADD CONSTRAINT FKRatings180148 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE Reports ADD CONSTRAINT FKReports185772 FOREIGN KEY (story_id) REFERENCES Stories (story_id);
ALTER TABLE Chapters_Image ADD CONSTRAINT FKChapters_I919581 FOREIGN KEY (chapter_id) REFERENCES Chapters (chapter_id);

---------------------------------------------INSERT DATA------------------------------------------------------------

-- Bước 1: Chèn vào các bảng không có khóa ngoại
INSERT INTO Users (username, email, password, avatar, role, created_at, updated_at, vip) 
VALUES ('JohnDoe', 'john@example.com', 'password12', NULL, 'user', GETDATE(), GETDATE(), 0);

INSERT INTO Stories (title, author, description, cover_image, status, created_at, updated_at, like_count) 
VALUES ('Story Title', 'Author Name', 'Description of the story', 'cover.jpg', 'ongoing', GETDATE(), GETDATE(), 0);

INSERT INTO Categories (category_name) 
VALUES ('Fantasy');

-- Bước 2: Chèn vào các bảng phụ thuộc vào khóa ngoại
INSERT INTO Chapters (story_id, chapter_number, title, created_at, updated_at) 
VALUES (1, 'Chapter 1', 'Chapter 1', GETDATE(), GETDATE());

-- Chèn dữ liệu vào bảng story_categories
INSERT INTO story_categories (story_id, category_id) 
VALUES (1, 1);

-- Chèn dữ liệu vào bảng Comments
INSERT INTO Comments (user_id, story_id, chapter_id, content, created_at) 
VALUES (1, 1, 1, 'Great chapter!', GETDATE());

-- Chèn dữ liệu vào bảng Ratings
INSERT INTO Ratings (user_id, story_id, rating, created_at) 
VALUES (1, 1, 5, GETDATE());

-- Chèn dữ liệu vào bảng Favorites
INSERT INTO Favorites (user_id, story_id, added_at) 
VALUES (1, 1, GETDATE());

-- Chèn dữ liệu vào bảng Reports
INSERT INTO Reports (user_id, comment_id, story_id, reason, created_at) 
VALUES (1, 1, 1, 'Inappropriate comment', GETDATE());

-- Chèn dữ liệu vào bảng Chapters_Image
INSERT INTO Chapters_Image (chapter_id, image_url, PageNumber) 
VALUES (1, 'image1.jpg', 1);

--SELECT
SELECT category_id, category_name 
  FROM Categories;
SELECT chapter_id, story_id, chapter_number, title, created_at, updated_at 
  FROM Chapters;
SELECT ImageID, chapter_id, image_url, PageNumber 
  FROM Chapters_Image;
SELECT comment_id, user_id, story_id, chapter_id, content, created_at 
  FROM Comments;
SELECT user_id, story_id, added_at 
  FROM Favorites;
SELECT rating_id, user_id, story_id, rating, created_at 
  FROM Ratings;
SELECT report_id, user_id, comment_id, story_id, reason, created_at 
  FROM Reports;
SELECT story_id, title, author, description, cover_image, status, created_at, updated_at, like_count 
  FROM Stories;
SELECT story_id, category_id 
  FROM story_categories;
SELECT user_id, username, email, password, avatar, role, created_at, updated_at, vip 
  FROM Users;



--drop 
ALTER TABLE Chapters DROP CONSTRAINT FKChapters224263;
ALTER TABLE story_categories DROP CONSTRAINT FKstory_cate722913;
ALTER TABLE story_categories DROP CONSTRAINT FKstory_cate597472;
ALTER TABLE Favorites DROP CONSTRAINT FKFavorites489155;
ALTER TABLE Favorites DROP CONSTRAINT FKFavorites344232;
ALTER TABLE Comments DROP CONSTRAINT FKComments12116;
ALTER TABLE Comments DROP CONSTRAINT FKComments845503;
ALTER TABLE Comments DROP CONSTRAINT FKComments830005;
ALTER TABLE Reports DROP CONSTRAINT FKReports952430;
ALTER TABLE Reports DROP CONSTRAINT FKReports181418;
ALTER TABLE Ratings DROP CONSTRAINT FKRatings958054;
ALTER TABLE Ratings DROP CONSTRAINT FKRatings180148;
ALTER TABLE Reports DROP CONSTRAINT FKReports185772;
ALTER TABLE Chapters_Image DROP CONSTRAINT FKChapters_I919581;
DROP TABLE Categories;
DROP TABLE Chapters;
DROP TABLE Chapters_Image;
DROP TABLE Comments;
DROP TABLE Favorites;
DROP TABLE Ratings;
DROP TABLE Reports;
DROP TABLE Stories;
DROP TABLE story_categories;
DROP TABLE Users;
