DROP DATABASE BookStoreManagement
GO

CREATE DATABASE BookStoreManagement
GO

USE BookStoreManagement
GO

CREATE TABLE [tblCustomer]
(
	customerID VARCHAR(50) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	[Password] VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	[Address] NVARCHAR(200),
	Phone VARCHAR(20) NOT NULL,
	Point INT NOT NULL,
	[Status] BIT,
	[Delete] BIT NOT NULL,
	PRIMARY KEY (customerID),
);

CREATE TABLE [tblStaff]
(
	staffID VARCHAR(10) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	[Role] NVARCHAR(30) NOT NULL,
	Phone VARCHAR(20),
	[Date-of-birth] DATE,
	[Status] BIT,
	[Delete] BIT NOT NULL,
	PRIMARY KEY (staffID),
);

CREATE TABLE [tblPromotion]
(
	promotionID INT IDENTITY(1,1) NOT NULL,
	staffID VARCHAR(10) NOT NULL,
	[Date-start] DATE NOT NULL,
	[Date-end] DATE NOT NULL,
	[Description] NVARCHAR(500),
	Condition DECIMAL(10,2),
	Discount FLOAT,
	[Status] BIT,
	PRIMARY KEY (promotionID),
	FOREIGN KEY (staffID) REFERENCES [tblStaff](staffID),
);

CREATE TABLE [tblOrder]
(
	orderID INT IDENTITY(1,1) NOT NULL,
	customerID VARCHAR(50),
	staffID VARCHAR(10),
	promotionID INT,
	[Date] DATE NOT NULL,
	[Delivery-cost] DECIMAL(10,2),
	Total DECIMAL(10,2) NOT NULL,
	[Description] NVARCHAR(300),
	[Status] BIT,
	[Delete] BIT,
	PRIMARY KEY (orderID),
	FOREIGN KEY (customerID) REFERENCES [tblCustomer](customerID),
	FOREIGN KEY (staffID) REFERENCES [tblStaff](staffID),
	FOREIGN KEY (promotionID) REFERENCES [tblPromotion](promotionID),
);

CREATE TABLE [tblCategory]
(
  categoryID VARCHAR(10) NOT NULL,
  Name NVARCHAR(50) NOT NULL,
  [Status] BIT,
  PRIMARY KEY (categoryID),
);

CREATE TABLE [tblPublisher]
(
	publisherID VARCHAR(10) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	[Status] BIT,
	PRIMARY KEY (publisherID),
);

CREATE TABLE [tblReview]
(
	reviewID INT IDENTITY(1,1) NOT NULL,
	Rate FLOAT NOT NULL,
	Times INT NOT NULL,
	[Status] BIT,
	PRIMARY KEY (reviewID),
);

CREATE TABLE [tblReviewDetail]
(
	reviewDetailID INT IDENTITY(1,1) NOT NULL,
	reviewID INT NOT NULL,
	customerID VARCHAR(50) NOT NULL,
	[Description] NVARCHAR(MAX),
	Rate FLOAT NOT NULL,
	[Date] DATE NOT NULL,
	[Status] BIT,
	PRIMARY KEY (reviewDetailID),
	FOREIGN KEY (reviewID) REFERENCES [tblReview](reviewID),
	FOREIGN KEY (customerID) REFERENCES [tblCustomer](customerID),
);

CREATE TABLE [tblBook]
(
	ISBN VARCHAR(17) NOT NULL,
	Name NVARCHAR(150) NOT NULL,
	publisherID VARCHAR(10) NOT NULL,
	categoryID VARCHAR(10) NOT NULL,
	reviewID INT NOT NULL,	
	[Author-name] NVARCHAR(50),
	Price DECIMAL(10,2) NOT NULL,
	[Description] NVARCHAR(MAX),
	[Image] VARCHAR(500) NOT NULL,
	Quantity INT NOT NULL,
	[Status] BIT,
	PRIMARY KEY (ISBN),
	FOREIGN KEY (publisherID) REFERENCES [tblPublisher](publisherID),
	FOREIGN KEY (categoryID) REFERENCES [tblCategory](categoryID),
	FOREIGN KEY (reviewID) REFERENCES [tblReview](reviewID),
);

CREATE TABLE [tblOrderDetail]
(
	detailID INT IDENTITY(1,1) NOT NULL,
	orderID INT NOT NULL,
	ISBN VARCHAR(17) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	publisherID VARCHAR(10) NOT NULL,
	categoryID VARCHAR(10) NOT NULL,	
	[Author-name] NVARCHAR(50),
	Price DECIMAL(10,2),
	Quantity INT NOT NULL,
	Total DECIMAL(10,2) NOT NULL,
	[Status] BIT,
	PRIMARY KEY (detailID),
	FOREIGN KEY (orderID) REFERENCES [tblOrder](orderID),
	FOREIGN KEY (ISBN) REFERENCES [tblBook](ISBN),
);

CREATE TABLE [tblBookRequest]
(
	requestID INT IDENTITY(1,1) NOT NULL,
	staffID VARCHAR(10) NOT NULL,
	[Date] DATE NOT NULL,
	[Status] BIT NOT NULL,
	[Delete] BIT,
	PRIMARY KEY (requestID),
	FOREIGN KEY (staffID) REFERENCES [tblStaff](staffID),
);

CREATE TABLE [tblBRequestDetail]
(
	requestDetailID INT IDENTITY(1,1) NOT NULL,
	requestID INT NOT NULL,
	ISBN VARCHAR(17) NOT NULL,
	publisherID VARCHAR(10) NOT NULL,
	categoryID VARCHAR(10) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	[Author-name] NVARCHAR(50),
	Quantity INT NOT NULL,
	[Status] BIT,
	[Delete] BIT,
	PRIMARY KEY (requestDetailID),
	FOREIGN KEY (requestID) REFERENCES [tblBookRequest](requestID),
	FOREIGN KEY (ISBN) REFERENCES [tblBook](ISBN),
);

CREATE TABLE [tblBookResponse]
(
	responseID INT IDENTITY(1,1) NOT NULL,
	requestID INT NOT NULL,
	staffID VARCHAR(10) NOT NULL,
	[Date] DATE NOT NULL,
	[Status] BIT,
	[Delete] BIT,
	PRIMARY KEY (responseID),
	FOREIGN KEY (requestID) REFERENCES [tblBookRequest](requestID),
);

CREATE TABLE [tblBResponseDetail]
(
	responseDetailID INT IDENTITY(1,1) NOT NULL,
	responseID INT NOT NULL,
	ISBN VARCHAR(17) NOT NULL,
	publisherID VARCHAR(10) NOT NULL,
	categoryID VARCHAR(10) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	[Author-name] NVARCHAR(50),
	Quantity INT NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
	[Status] BIT,
	[Delete] BIT,
	PRIMARY KEY (responseDetailID),
	FOREIGN KEY (responseID) REFERENCES [tblBookResponse](responseID),
	FOREIGN KEY (ISBN) REFERENCES [tblBook](ISBN),
);

--Insert data for tblCustomer
INSERT INTO [tblCustomer](customerID,Name,[Password],Email,[Address],Phone,Point,[Status],[Delete]) 
VALUES ('cus1',N'Phạm Quốc Thịnh','U/Cqtosk2xat5slgQ5ZWyw==','thinhphamquoc9999@gmail.com',N'Hiệp Thành, Quận 12,TP HCM','0938081927',0,0,0)

--Insert data for tblStaff
INSERT INTO [tblStaff](staffID,Name,[Password],[Role],Phone,[Date-of-birth],[Status],[Delete]) 
VALUES ('ad1',N'Tui là Admin','U/Cqtosk2xat5slgQ5ZWyw==',N'Admin','093696969','2002-10-12',0,0)

INSERT INTO [tblStaff](staffID,Name,[Password],[Role],Phone,[Date-of-birth],[Status],[Delete]) 
VALUES ('st1',N'Tui là nhân viên','U/Cqtosk2xat5slgQ5ZWyw==',N'Staff','093696969','2003-10-12',0,0)

INSERT INTO [tblStaff](staffID,Name,[Password],[Role],Phone,[Date-of-birth],[Status],[Delete])
VALUES ('del1',N'Tui là deliverer','U/Cqtosk2xat5slgQ5ZWyw==',N'Deliverer','0123456789','2003-05-03',0,0)

--Insert data for tblOrder
INSERT INTO [tblOrder](customerID,staffID,[Date],[Delivery-cost],Total,[Description],[Status],[Delete])
VALUES ('cus1','del1','2022-05-03',20000,255000,'',0,0)

--Insert data for tblCategory
INSERT INTO [tblCategory](categoryID,Name,[Status]) VALUES
('C1',N'Văn học',1),
('C2',N'Tác phẩm kinh điển',1),
('C3',N'Tiểu thuyết',1),
('C4',N'Tâm lý',1),
('C5',N'Kinh tế',1),
('C6',N'Lịch sử',1),
('C7',N'Tự truyện hồi kí',1),
('C8',N'Kỹ năng sống',1),
('C9',N'Tôn giáo',1),
('C10',N'Tiểu thuyết trinh thám',1)


--Insert data for tblPublisher
INSERT INTO [tblPublisher](publisherID,Name,[Status]) VALUES
('P1',N'NXB Văn Học',1),
('P2',N'NXB Hội Nhà Văn',1),
('P3',N'NXB Trẻ',1),
('P4',N'NXB Thế Giới',1),
('P5',N'NXB Dân Trí',1),
('P6',N'NXB Phụ Nữ Việt Nam',1),
('P7',N'NXB Công Thương',1),
('P8',N'NXB Lao Động',1),
('P9',N'NXB Kim Đồng',1)

--Insert data for tblReview
INSERT INTO[tblReview](Rate,Times,[Status]) VALUES
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1),
(0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1), (0,0,1)

--Insert data for tblBook
--1
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049549090',N'Lục Vân Tiên','P1','C1',1,N'Nguyễn Đình Chiểu',235000,'https://salt.tikicdn.com/cache/w1200/media/catalog/product/5/_/5.u5552.d20170929.t183543.444888.jpg',100,1,N'Lục Vân Tiên là một tác phẩm truyện thơ nôm nổi tiếng của Nguyễn Đình Chiểu, được sáng tác theo thể lục bát vào đầu những năm 50 của thế kỷ 19 và được Trương Vĩnh Ký cho xuất bản lần đầu tiên vào năm 1889. Đây là một trong những sáng tác có vị trí cao của văn học miền Nam Việt Nam. Tác phẩm được dịch giả Abel des Michels chuyển ngữ sang tiếng Pháp với tên gọi Lục Vân Tiên cổ tích truyện- Histoire de Luc Van Tien năm 1899.

Truyện Lục Vân Tiên (mà người miền Nam thường gọi là thơ Lục Vân Tiên) là một cuốn tiểu thuyết về luân lý, cốt bàn đạo làm người với quan niệm văn dĩ tải đạo. Tác giả muốn đem gương người xưa mà khuyên người ta về cương thường - đạo nghĩa.')
--2
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043282085',N'Truyện Kiều (Tái Bản)','P1','C1',2,N'Nguyễn Du',54000,'https://product.hstatic.net/1000237375/product/bia_900x900_dbb77079df0641a5a3c1e4a8064fa6ab_master.jpg',100,1,N'Nói tới văn học cổ điển Việt Nam, trước hết chúng ta phải nhắc đến đại thi hào Nguyễn Du và kiệt tác Truyện Kiều của ông. Viết Truyện Kiều, Nguyễn Du chỉ khiêm nhường coi đó là những "ời quê góp nhặt dông dài". Nhưng, thực tế đã cho thấy, bất chấp quy luật và sự sàng lọc nghiệt ngã của thời gian, Truyện Kiều đã khẳng định sức sống bất tử của một tác phẩm bất hủ. Tác phẩm Truyện Kiều, nguyên tên là Đoạn trường tân thanh, từ khi ra đời đến nay, khoảng 200 năm, trong lịch sử Văn học Việt Nam, chưa có tác phẩm nào được các nhà khảo cứu, phê bình, x uất bản quan tâm đến nó, từ nội dung, hình thức, lẫn văn bản và thời điểm sáng tác đặc biệt đến như vậy. Một trong nguyên nhân chính là vì bản gốc của Nguyễn Du sáng tác không còn nữa.')
--3
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049696398',N'Hai số phận','P1','C2',3,N'Jeffrey Archer',126000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_179484.jpg',100,1,N'Hai số phận (có tên gốc tiếng Anh là: Kane and Abel) là một cuốn tiểu thuyết được sáng tác vào năm 1979 bởi nhà văn người Anh Jeffrey Archer. Tựa đề Kane and Abel dựa theo câu chuyện của anh em: Cain và Abel trong Kinh Thánh Cựu Ước.

Hai số phận của hai con người này hoàn toàn khác nhau, một người sinh ra trong nghèo khó nhưng lại rất may mắn, một người sinh ra trong giàu có nhưng lại rất nỗ lực. Hai con người ai cũng phải trải qua những biến cố, mất mát và trải nghiệm sống để mà có thể đi đến thành công.

Tác phẩm được xuất bản tại Vương quốc Anh vào năm 1979 và tại Hoa Kỳ vào tháng 2 năm 1980, cuốn sách phổ biến thành công trên thế giới. Sách đạt danh hiệu sách bán chạy nhất theo danh sách của tờ New York Times và năm 1985 nó được đưa lên chương trình truyền hình miniseries của CBS với tên là Kane & Abel bắt đầu với Peter Strauss vai Rosnovski và Sam Neill vai Kane.')
--4
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049868597',N'Đồi Gió Hú','P1','C2',4,N'Emily Dronte',93000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_48045.jpg',100,1,N'Đồi Gió Hú, câu chuyện cổ điển về tình yêu ngang trái và tham vọng chiếm hữu, cuốn tiểu thuyết dữ dội và bí ẩn về Catherine Earnshaw, cô con gái nổi loạn của gia đình Earnshaw, với gã đàn ông thô ráp và điên rồ mà cha cô mang về nhà rồi đặt tên là Heathcliff, được trình diễn trên cái nền đồng truông, quả đồi nước Anh cô quạnh và đơn sơ không kém gì chính tình yêu của họ. Từ nhỏ đến lớn, sự gắn bó của họ ngày càng trở nên ám ảnh. Gia đình, địa vị xã hội, và cả số phận rắp tâm chống lại họ, bản tính dữ dội và ghen tuông tột độ cũng huỷ diệt họ, vậy nên toàn bộ thời gian hai con người yêu nhau đó đã sống trong thù hận và tuyệt vọng, mà cái chết chỉ có ý nghĩa khởi đầu. Một khởi đầu mới để hai linh hồn mãnh liệt đó dược tự do tái ngộ, Khi những cơn gió hoang vắng và điên cuồng tràn về quanh các lâu đài trong Đồi gió hú...

Cuốn tiểu thuyết duy nhất của Emily Bronte, là cuốn sách đã tới tay công chúng với nhiều lời bình trái ngược vào năm 1847, một năm trước khi nữ tác giả qua đời ở tuổi ba mươi. Thông qua mối tình giữa Cathy và Heathcliff, với bối cảnh là đồng quê Yorkshire hoang vu trống trải, Đồi gió hú đã tạo nên cả một thế giới riêng với xu hướng bỏ qua lề thói, vươn tới thi ca cũng như tới những chiều sâu tăm tối của lòng người, giúp tác phẩm trở thành một trong những tiểu thuyết vĩ đại nhất, bi thương nhất mà con người từng viết ra về nỗi đam mê cháy bỏng.')
--5
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043068122',N'Cây Cam Ngọt Của Tôi','P2','C3',5,N'José Mauro de Vasconcelos',81000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_217480.jpg',100,1,N'“Vị chua chát của cái nghèo hòa trộn với vị ngọt ngào khi khám phá ra những điều khiến cuộc đời này đáng số một tác phẩm kinh điển của Brazil.”

- Booklist

“Một cách nhìn cuộc sống gần như hoàn chỉnh từ con mắt trẻ thơ… có sức mạnh sưởi ấm và làm tan nát cõi lòng, dù người đọc ở lứa tuổi nào.”

- The National

Hãy làm quen với Zezé, cậu bé tinh nghịch siêu hạng đồng thời cũng đáng yêu bậc nhất, với ước mơ lớn lên trở thành nhà thơ cổ thắt nơ bướm. Chẳng phải ai cũng công nhận khoản “đáng yêu” kia đâu nhé. Bởi vì, ở cái xóm ngoại ô nghèo ấy, nỗi khắc khổ bủa vây đã che mờ mắt người ta trước trái tim thiện lương cùng trí tưởng tượng tuyệt vời của cậu bé con năm tuổi.

Có hề gì đâu bao nhiêu là hắt hủi, đánh mắng, vì Zezé đã có một người bạn đặc biệt để trút nỗi lòng: cây cam ngọt nơi vườn sau. Và cả một người bạn nữa, bằng xương bằng thịt, một ngày kia xuất hiện, cho cậu bé nhạy cảm khôn sớm biết thế nào là trìu mến, thế nào là nỗi đau, và mãi mãi thay đổi cuộc đời cậu.
Mở đầu bằng những thanh âm trong sáng và kết thúc lắng lại trong những nốt trầm hoài niệm, Cây cam ngọt của tôi khiến ta nhận ra vẻ đẹp thực sự của cuộc sống đến từ những điều giản dị như bông hoa trắng của cái cây sau nhà, và rằng cuộc đời thật khốn khổ nếu thiếu đi lòng yêu thương và niềm trắc ẩn. Cuốn sách kinh điển này bởi thế không ngừng khiến trái tim người đọc khắp thế giới thổn thức, kể từ khi ra mắt lần đầu năm 1968 tại Brazil.')
--6
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786041116313',N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh','P3','C3',6,N'Nguyễn Nhật Ánh',96000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2199.jpg',100,1,N'Ta bắt gặp trong Tôi Thấy Hoa Vàng Trên Cỏ Xanh một thế giới đấy bất ngờ và thi vị non trẻ với những suy ngẫm giản dị thôi nhưng gần gũi đến lạ. Câu chuyện của Tôi Thấy Hoa Vàng Trên Cỏ Xanh có chút này chút kia, để ai soi vào cũng thấy mình trong đó, kiểu như lá thư tình đầu đời của cu Thiều chẳng hạn... ngây ngô và khờ khạo.

Nhưng Tôi Thấy Hoa Vàng Trên Cỏ Xanh hình như không còn trong trẻo, thuần khiết trọn vẹn của một thế giới tuổi thơ nữa. Cuốn sách nhỏ nhắn vẫn hồn hậu, dí dỏm, ngọt ngào nhưng lại phảng phất nỗi buồn, về một người cha bệnh tật trốn nhà vì không muốn làm khổ vợ con, về một người cha khác giả làm vua bởi đứa con tâm thầm của ông luôn nghĩ mình là công chúa,... Những bài học về luân lý, về tình người trở đi trở lại trong day dứt và tiếc nuối.

Tôi Thấy Hoa Vàng Trên Cỏ Xanh lắng đọng nhẹ nhàng trong tâm tưởng để rồi ai đã lỡ đọc rồi mà muốn quên đi thì thật khó. ©

“Tôi thấy hoa vàng trên cỏ xanh” truyện dài mới nhất của nhà văn vừa nhận giải văn chương ASEAN Nguyễn Nhật Ánh - đã được Nhà xuất bản Trẻ mua tác quyền và giới thiệu đến độc giả cả nước.

Cuốn sách viết về tuổi thơ nghèo khó ở một làng quê, bên cạnh đề tài tình yêu quen thuộc, lần đầu tiên Nguyễn Nhật Ánh đưa vào tác phẩm của mình những nhân vật phản diện và đặt ra vấn đề đạo đức như sự vô tâm, cái ác. 81 chương ngắn là 81 câu chuyện nhỏ của những đứa trẻ xảy ra ở một ngôi làng: chuyện về con cóc Cậu trời, chuyện ma, chuyện công chúa và hoàng tử, bên cạnh chuyện đói ăn, cháy nhà, lụt lội,... “Tôi thấy hoa vàng trên cỏ xanh” hứa hẹn đem đến những điều thú vị với cả bạn đọc nhỏ tuổi và người lớn bằng giọng văn trong sáng, hồn nhiên, giản dị của trẻ con cùng nhiều tình tiết thú vị, bất ngờ và cảm động trong suốt hơn 300 trang sách. Cuốn sách, vì thế có sức ám ảnh, thu hút, hấp dẫn không thể bỏ qua.')
--7
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786047763092',N'Thiên Tài Bên Trái, Kẻ Điên Bên Phải','P4','C4',7,N'Cao Minh',125000,'https://cdn0.fahasa.com/media/catalog/product/b/_/b_a-thi_n-t_i-b_n-tr_i-k_-_i_n-b_n-ph_i_1.jpg',100,1,N'NẾU MỘT NGÀY ANH THẤY TÔI ĐIÊN, THỰC RA CHÍNH LÀ ANH ĐIÊN ĐẤY!

Hỡi những con người đang oằn mình trong cuộc sống, bạn biết gì về thế giới của mình? Là vô vàn thứ lý thuyết được các bậc vĩ nhân kiểm chứng, là luật lệ, là cả nghìn thứ sự thật bọc trong cái lốt hiển nhiên, hay những triết lý cứng nhắc của cuộc đời?

Lại đây, vượt qua thứ nhận thức tẻ nhạt bị đóng kín bằng con mắt trần gian, khai mở toàn bộ suy nghĩ, để dòng máu trong bạn sục sôi trước những điều kỳ vĩ, phá vỡ mọi quy tắc. Thế giới sẽ gọi bạn là kẻ điên, nhưng vậy thì có sao? Ranh giới duy nhất giữa kẻ điên và thiên tài chẳng qua là một sợi chỉ mỏng manh: Thiên tài chứng minh được thế giới của mình, còn kẻ điên chưa kịp làm điều đó. Chọn trở thành một kẻ điên để vẫy vùng giữa nhân gian loạn thế hay khóa hết chúng lại, sống mãi một cuộc đời bình thường khiến bạn cảm thấy hạnh phúc hơn?

Thiên tài bên trái, kẻ điên bên phải là cuốn sách dành cho những người điên rồ, những kẻ gây rối, những người chống đối, những mảnh ghép hình tròn trong những ô vuông không vừa vặn… những người nhìn mọi thứ khác biệt, không quan tâm đến quy tắc. Bạn có thể đồng ý, có thể phản đối, có thể vinh danh hay lăng mạ họ, nhưng điều duy nhất bạn không thể làm là phủ nhận sự tồn tại của họ. Đó là những người luôn tạo ra sự thay đổi trong khi hầu hết con người chỉ sống rập khuôn như một cái máy. Đa số đều nghĩ họ thật điên rồ nhưng nếu nhìn ở góc khác, ta lại thấy họ thiên tài. Bởi chỉ những người đủ điên nghĩ rằng họ có thể thay đổi thế giới mới là những người làm được điều đó.

Chào mừng đến với thế giới của những kẻ điên.')
--8
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043140156',N'Tâm Lý Học Về Tiền','P5','C4',8,N'Morgan Housel',132000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_220008.jpg',100,1,N'Tiền bạc có ở khắp mọi nơi, nó ảnh hưởng đến tất cả chúng ta, và khiến phần lớn chúng ta bối rối. Mọi người nghĩ về nó theo những cách hơi khác nhau một chút. Nó mang lại những bài học có thể được áp dụng tới rất nhiều lĩnh vực trong cuộc sống, như rủi ro, sự tự tin, và hạnh phúc. Rất ít chủ đề cung cấp một lăng kính phóng to đầy quyền lực giúp giải thích vì sao mọi người lại hành xử theo cách họ làm hơn là về tiền bạc. Đó mới là một trong những chương trình hoành tráng nhất trên thế giới.

Chúng ta hiếm khi lâm vào hoàn cảnh nợ ngập đầu ư? Biết tiết kiệm để dành cho lúc khốn khó hơn ư? Chuẩn bị sẵn sàng cho việc nghỉ hưu? Có những cái nhìn thiết thực về mối quan hệ giữa tiền và hạnh phúc của chúng ta hơn phải không?

Chúng ta đều làm những điều điên rồ với tiền bạc, bởi vì chúng ta đều còn khá mới mẻ với trò chơi này và điều có vẻ điên rồ với bạn lại có khi hợp lý với tôi. Nhưng không ai là điên rồ cả – chúng ta đều đưa ra các quyết định dựa trên những trải nghiệm độc đáo riêng có mang vẻ hợp lý với mình ở bất cứ thời điểm nào.

Mục đích của cuốn sách này là sử dụng những câu chuyện ngắn để thuyết phục bạn rằng những kỹ năng mềm còn quan trọng hơn khía cạnh lý thuyết của đồng tiền. Thông qua một tập hợp những thử nghiệm và sai lầm của nhiều năm chúng ta đã học được cách trở thành những nông dân giỏi giang hơn, những thợ sửa ống nước nhiều kỹ năng hơn, và những nhà hóa học tiên tiến hơn. Nhưng liệu việc thử nghiệm và sai lầm có dạy chúng ta trở nên giỏi hơn trong cách quản lý tài chính cá nhân của chính mình không?

Nhiều tiền không liên quan nhiều đến việc bạn thông minh như thế nào mà lại liên quan lớn đến cách bạn hành xử. Và cách hành xử thì rất khó để uốn nắn, ngay cả đối với những người thực sự thông minh.

Một thiên tài không kiểm soát được cảm xúc của anh ta có thể dẫn tới một thảm họa tài chính. Điều ngược lại cũng đúng. Những người bình thường không có kiến thức về tài chính có thể trở nên giàu có nếu họ nắm trong tay những kỹ năng hành xử không liên quan đến những thước đo chính thống về trí thông minh.

Sự thành công trong tài chính không phải là một lĩnh vực khoa học khó nhằn. Nó là một kỹ năng mềm, nơi mà cách bạn hành xử quan trọng hơn điều mà bạn biết. Trong “Tâm lý học về tiền”, tác giả từng đoạt giải thưởng Morgan Housel chia sẻ 19 câu chuyện ngắn khám phá những cách kỳ lạ mà mọi người nghĩ về tiền bạc và dạy bạn cách hiểu rõ hơn về một trong những chủ đề quan trọng nhất của cuộc sống.')
--9
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786041108264',N'Gã Nghiện Giày - Tự Truyện Của Nhà Sáng Lập Nike','P3','C5',9,N'Phil Knight',160000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8934974150961.jpg',100,1,N'Gã Nghiện Giày - Tự Truyện Của Nhà Sáng Lập NIKE

Một câu chuyện cuốn hút, và truyền cảm hứng.... 24 tuổi, lấy bằng MBA ở Đại học Stanford, trăn trở với những câu hỏi lớn của cuộc đời, băn khoăn không biết tiếp tục làm việc cho một tập đoàn lớn hay tạo dựng sư nghiệp riêng cho mình... 24 tuổi, năm 1962, Phil Knight quyết định rằng con đường khác thường mới là lựa chọn duy nhất dành cho ông... Rồi ông khoác ba lô đi đến Tokyo, Hongkong, Bangkok, Việt Nam, Calcutta, Kathmandu, Bombay, Cairo, Jerusalem, Rome, Florence, Milan, Venice, Paris,, Munich, Vienna, London, Hy Lạp... Để rồi khi về lại quê nhà ở bang Oregon, ông quyết định mở công ty nhập khẩu giày chạy từ Nhật. Ban đầu chỉ một đôi để thử, rồi vài chục đôi, bán tại tầng hầm của gia đình bố mẹ Phil. Đam mê, quyết tâm, dám chấp nhận thất bại, vượt qua nhiều chông gai từ chuyện thiếu vốn, đến chuyện cạnh tranh từ đối thủ nhập khẩu khác… Phil Knight đã đưa công ty nhập khẩu giày ra đời với 50 đô-la mượn của bố phát triển đến doanh nghiệp có doanh số hơn 1 triệu đô-la chỉ 10 năm sau đó, năm 1972.

Nhưng không may, đối tác Nhật Bản trở chứng, đứng trước nguy cơ phải giải tán công ty mình dày công thành lập, ông và cộng sự đã chuyển hướng sang sản xuất giày, từ đó logo và thương hiệu Nike ra đời.

Ông không đưa ra bí quyết, chiến lược, hay bước hành động dành cho các bạn trẻ mê kinh doanh, các chủ doanh nghiệp đang dồn hết tâm sức cho đứa con doanh nghiệp của mình; nhưng qua câu chuyện và cách xử lý của ông, người đọc sẽ học được rất nhiều những bài học quý giá về gầy dựng doanh nghiệp, vượt qua khó khăn và thất bại không thể tránh khỏi, để từ đó có tư duy kinh doanh cho riêng mình. Đó là những câu chuyện là nhân sự (chọn được người để cùng mình bước lên hành trình xây dựng công ty đầy gian nan), dòng tiền, về làm ăn với các đối tác, khi bị đối thủ tấn công, rồi mặt bằng, rồi biến động tỉ giá, rồi cả những sự vụ pháp lý có liên quan…

Con đường Phil Knight cùng những gã nghiện giày khác xây dựng thương hiệu Nike đầy chông gai, những cuộc “chiến đấu” bất tận và cả thất bại, và Knight đã chia sẻ thẳng thắn tất cả trong quyển sách này. Ông không giấu giếm, kể cả những chuyện xấu của ông, ví dụ như một lần lục cặp tài liệu của đối tác Nhật Bản!

Bằng giọng văn mộc mạc, câu ngắn gọn, người đọc như bị lôi cuốn vào câu chuyện truyền cảm hứng này.')
--10
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786047740796',N'Homo Deus - Lược Sử Tương Lai','P4','C6',10,N'Yuval Noah Harari',179000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_176929.jpg',100,1,N'Homo sapiens có phải là một dạng sống siêu đẳng, hay chỉ là một tay đầu gấu địa phương? Làm thế nào con người lại tin rằng họ không chỉ đã kiểm soát thế giới, mà còn mang lại ý nghĩa cho nó? Công nghệ sinh học và trí thông minh nhân tạo đe doạ loài người ra sao? Sinh vật nào có thể kế thừa loài người, và tôn giáo mới nào sẽ được sản sinh?

Với giọng kể cuốn hút và mới lạ, Harari sẽ dần gợi mở và trả lời những câu hỏi trê, nhờ phân tích chi tiết những luận điểm gây nhiều tranh cãi: chủ nghĩa nhân đạo là một dạng tôn giáo, thứ tôn giáo tôn thờ con người thay vì thần thánh; sinh vật là thuật toán… ông vẽ ra một viễn cảnh tương lai khi Sapiens thất thế và Dữ liệu giáo trở thành một hình mẫu. HOMO DEUS còn bàn sâu hơn về các năng lực mà con người đã tự trang bị để sinh tồn và tiến hoá thành một giống loài ngự trị trên trái đất, để rồi chính trong tiến trình hoàn thiện và nâng cấp các năng lực ấy chúng ta sẽ bị truất quyền kiểm soát bởi một sinh vật mới, mang tên Homo Deus.')
--11
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8936071674913',N'Danh Tướng','P5','C6',11,N'Yuval Noah Harari',475000,'https://cdn0.fahasa.com/media/catalog/product/b/i/bia-danh-tuong-web.jpg',100,1,N'Danh Tướng - Các Nhà Cầm Quân Vĩ Đại Nhất Trong Lịch Sử đưa ra cái nhìn mới về giới lãnh đạo quân sự, những người đã làm nên lịch sử bằng những trận chiến trên bộ, trên biển, cũng như trên không, từ Alexander Đại Đế, nhà chinh phạt lẫy lừng của thế kỉ 4 TCN, tới chư tướng dẫn dắt các chiến dịch ở Afghanistan và Iraq ngày nay.

Cuốn sách bao gồm thông tin tiểu sử và hình ảnh tướng lãnh, bản đồ trận đánh và chi tiết sống động về các cuộc hành quân. Đây là cẩm nang bằng hình giúp bạn tìm hiểu về các thiên tài quân sự trên thế giới.

"Coi lính như con em, lính sẽ cùng ta vào thâm khê. Coi lính như con yêu, lính sẽ bên ta sống chết." - Binh pháp Tôn Tử')
--12
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8934974180944',N'Sinh Vào Ngày Xanh (Tái bản năm 2022)','P3','C7',12,N'Daniel Tammet',140000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/235/sinh-vao-ngay-xanh-tb-2022.jpg',100,1,N'Sinh Vào Ngày Xanh là tự truyện của một người tự kỷ, một trí tuệ phi thường – Daniel Tammet. Cuốn sách được phát hành năm 2006 và là sách bán chạy nhất của Sunday Times (Anh) và New York Times với hơn nửa triệu bản và dịch ra 18 thứ tiếng trên thế giới. Tammet là chủ đề chính của phim tài liệu ‘Brainman’, bộ phim đoạt giải Royal Television Society năm 2005 được trình chiếu trên 40 nước. Năm 2004, anh lập kỷ lục châu Âu khi nhớ và đọc ra chính xác 22.514 chữ số của dãy số Pi trong hơn năm giờ. Anh có khả năng học được một ngoại ngữ khó trong một tuần. Nhiều nhà thần kinh học hàng đầu thế giới đã và đang nghiên cứu về khả năng ngôn ngữ, toán học và trí nhớ siêu việt - những khả năng khác thường của Tammet, những điều này có thể là chìa khóa giúp vén mở bức màn bí mật về tự kỷ.')
--13
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786041084278',N'Harry Potter Và Chiếc Cốc Lửa - Tập 4 (Tái bản năm 2022)','P1','C1',13,N'J. K. Rowling',310000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/235/harry-potter-va-chiec-coc-lua-tap-4-tb-2022.jpg',100,1,N'Khi giải Quidditch Thế giới bị cắt ngang bởi những kẻ ủng hộ Chúa tể Voldemort và sự trở lại của Dấu hiệu hắc ám khủng khiếp, Harry ý thức được rõ ràng rằng, Chúa tể Voldemort đang ngày càng mạnh hơn. Và để trở lại thế giới phép thuật, Chúa tể hắc ám cần phải đánh bại kẻ duy nhất sống sót từ lời nguyền chết chóc của hắn - Harry Potter. Vì lẽ đó, khi Harry bị buộc phải bước vào giải đấu Tam Pháp thuật uy tín nhưng nguy hiểm, cậu nhận ra rằng trên cả chiến thắng, cậu phải giữ được mạng sống của mình.

‘Bốn năm của Harry cũng như của chúng tôi ở trường Hogwarts thật vui nhộn, một thế giới đầy hài hước cùng nhiều hoạt động thú vị.’')
--14
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786046990789',N'Những Thử Thách Của Apollo (Phần 1) - Sấm Truyền Bí Ẩn','P4','C6',14,N'Rick Riordan',113000,'https://nhasachphuongnam.com/images/thumbnails/600/600/detailed/234/nhung-thu-thach-cua-apollo-1-sam-truyen-bi-an-tb-2022.jpg',100,1,N'Làm sao để trừng phạt một vị thần bất tử? Bằng cách biến vị thần ấy thành kẻ phàm trần.

Sau khi khiến cho cha mình-thần Zeus nổi giận, Apollo bị tống cổ khỏi đỉnh Olympus. Yếu ớt và mất phương hướng, thần giáng xuống thành phố New York trong bộ dạng một cậu thiếu niên tầm thường. Giờ đây, thiếu những quyền năng thần thánh, vị thần bốn ngàn năm tuổi phải học cách sống sót trong thế giới hiện đại cho tới khi tìm được cách nào đó lấy lòng Zeus trở lại.

Nhưng Apollo có quá nhiều kẻ thù là các vị thần, lũ quái vật và cả những kẻ phàm trần. Tất cả đều ao ước được thấy cựu thần Olympus bị tiêu diệt mãi mãi. Apollo cần được giúp đỡ, và thần chỉ biết có duy nhất một nơi để tìm đến…một vùng đất của các á thần hiện đại có tên gọi Trại Con Lai.
----
Tác giả
Rick Riordan là tác giả có sách bán chạy nhất do tờ New York Times bình chọn cho Series truyện dành cho trẻ em Percy Jackson và các vị thần trên đỉnh Olympus và Series Tiểu thuyết trinh thám dành cho người lớn Tres Navarre. Ông có mười lăm năm giảng dạy môn tiếng Anh và lịch sử ở các trường trung học cơ sở công và tư ở San Francisco Bay Area ở California và Texas, từng nhận giải thưởng Giáo viên Ưu tú đầu tiên của trường vào năm 2002 do Saint Mary’s Hall trao tặng. Ông hiện đang sống ở San Antonio, Texas cùng vợ và hai con trai, dành toàn bộ thời gian cho sáng tác. 

Sấm truyền bí ẩn, thuộc series Những thử thách của Apollo, khởi đầu cho loạt tiểu thuyết thần thoại Hy Lạp mới viết cho lứa tuổi từ 8-12 của Rick Riordan. Series này tập trung chủ yếu vào thần Apollo, người đã bị cha mình, thần Zeus, tước đi các quyền năng thần thánh. Dĩ nhiên, từ đó sinh ra các cuộc phiêu lưu và những hành vi tai quái.')
--15
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8935210302243',N'Những Nhà Sáng Lập Siêu Đẳng - Dữ Liệu Tiết Lộ Điều Gì Về Các Công Ty Khởi Nghiệp Tỉ Đô','P5','C5',15,N'Ali Tamaseb',165000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/nhung-nha-sang-lap-sieu-dang.jpg',100,1,N'Điểm nổi bật đáng chú ý của Những nhà sáng lập siêu đẳng là tập dữ liệu có thể coi là lớn nhất từng được thu thập về các công ty khởi nghiệp, với mục đích so sánh các công ty khởi nghiệp trị giá hàng tỉ đô la với những công ty khởi nghiệp không thành công – 30.000 điểm dữ liệu trên rất nhiều yếu tố như số lượng đối thủ cạnh tranh, quy mô thị trường, tuổi của người sáng lập, xếp hạng trường đại học họ từng theo học, chất lượng của các nhà đầu tư, thời gian gây quỹ và còn nhiều hơn thế.')
--16
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043654387',N'Làm Tốt Hơn Với Nguồn Lực Ít Hơn','P4','C5',16,N'Jaideep Prabhu',220000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/lam-tot-hon-voi-nguon-luc-it-hon.jpg',100,1,N'Đổi mới sáng tạo tiết kiệm

Trong một thế giới siêu cạnh tranh và khan hiếm tài nguyên, chỉ những doanh nghiệp có thể phát triển và tiếp thị các giải pháp mới, sử dụng ít tài nguyên, tiết kiệm chi phí mà vẫn duy trì được chất lượng thì mới có thể thành công. Tuy nhiên có một điều mà chúng ta có thể chắc chắn: Cơn khát tiêu dùng với những sản phẩm có chất lượng ngày càng cao sẽ không ngừng gia tăng, đồng thời lượng tài nguyên cần thiết để thỏa mãn nhu cầu này sẽ luôn là hữu hạn.

Việc giải quyết sự mâu thuẫn này đang nhanh chóng trở thành một trong những thách thức lớn nhất của giới kinh doanh trong thời đại ngày nay. Chúng ta không còn có thể xem phương châm làm tốt hơn với ít nguồn lực hơn như là giải pháp ngắn hạn để đối phó với tình hình kinh tế khó khăn nữa, mà nó phải trở thành chiến lược kinh doanh dài hạn thiết yếu. Trong thực tại mới này, chấp nhận thì doanh nghiệp sẽ tiếp tục phát triển, chối bỏ thì doanh nghiệp ắt sẽ lụi tàn.

Cuốn sách Frugal Innovation – Làm Tốt Hơn Với Nguồn Lực Ít Hơn cung cấp những chỉ dẫn cần thiết để doanh nghiệp tiếp cận phương pháp đổi mới sáng tạo tiết kiệm đúng cách. Khi mà sự trỗi dậy của chủ nghĩa tiêu dùng từng xảy ra trong thế kỷ 20 nay không còn nữa. Cách sống cần kiệm, khát vọng, tính cá nhân hóa và những giới hạn của tự nhiên đều đòi hỏi chúng ta thì Frugal Innovation: How to do better with less lại ra đời đúng thời điểm. Tác giả Radjou và Prabhu đã vẽ ra một bức tranh sống động về cách thức doanh nghiệp có thể pha trộn các giá trị và chất lượng để mang lại sự cân bằng cá nhân và xã hội mà những người tiêu dùng của thế kỷ 21 mong muốn.

Trong cuốn sách này, Radjou và Prabhu đã cho thấy những bài học đến từ các quốc gia đang phát triển khi họ bắt đầu tạo ra những tác động đến quy trình đổi mới tại các doanh nghiệp lâu đời ở phương Tây. Cuốn sách đã mô tả đầy đủ sự chuyển đổi và một vài khó khăn gặp phải trong quá trình thực hiện đổi mới sáng tạo tiết kiệm, đồng thời liệt kê các giải pháp thiết thực cho các doanh nghiệp mong muốn đổi mới sáng tạo nhiều hơn với chi phí thấp hơn.')
--17
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8935235234727',N'Người Hướng Nội Trong Thế Giới Hướng Ngoại','P5','C8',17,N'Insook Nam',105000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/nguoi-huong-noi-trong-the-gioi-huong-ngoai.jpg',100,1,N'Bạn đã từng lo lắng bất an vì là người hướng nội? Đã từng cảm thấy mệt mỏi vì phải cố tỏ ra hoạt bát và hướng ngoại? Đã từng cảm thấy kiệt sức hay lạc lối vì con người mà bạn thể hiện với thế giới ngoài kia và con người thật sự bên trong mình khác nhau quá đỗi?

Nếu vậy, đây chính là cuốn sách dành riêng cho bạn.

Ép buộc mọi người phải trở nên hướng ngoại là một hình thức bạo lực xã hội. Những người hướng nội cũng hoàn toàn có thể dùng phương pháp của mình - theo cách thức thật dịu dàng, thật tinh tế - để lay động lòng người và rung chuyển toàn thế giới.

Bản thân cũng là một người hướng nội điển hình và phải chật vật tìm cách sinh tồn trong một xã hội dường như chỉ dành riêng cho người hướng ngoại, tác giả Insook Nam đã viết nên cuốn Người hướng nội trong thế giới hướng ngoại từ những trải nghiệm cá nhân và đem đến cho tất cả những người hướng nội một kim chỉ nam để có thể vừa sống là chính mình vừa đồng thời hòa hợp cùng thế giới.

Bạn không cần phủ nhận sự nhạy cảm vốn có của bản thân, cũng chẳng cần ghen tị với những người hướng ngoại có vẻ ngoài hào nhoáng, hãy cứ giữ nguyên tốc độ, nhịp điệu và phương pháp giao tiếp của riêng mình. Có thể sẽ hơi chậm một chút, hơi vụng về một chút, hơi cô đơn một chút, thế nhưng bạn sẽ nhận ra, sống là chính mình đem lại sự tự do và niềm hạnh phúc bạn mà chưa từng mường tượng.

Người hướng nội trong thế giới hướng ngoại sẽ giúp bạn làm được điều đó.')
--18
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043458497',N'Giao Tiếp Khiêm Nhường - Thu Phục Nhân Tâm','P4','C8',18,N'Edgar H. Schein',135000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/giao-tiep-khiem-nhuong-thu-phuc-nhan-tam.jpg',100,1,N'“Hỏi han khiêm nhường” quan trọng thế nào?

Chắc chắn ai trong chúng ta cũng mong muốn có những mối quan hệ tích cực hơn, muốn hiểu bản chất của tình hình hiện tại hoặc muốn trở nên có ích hơn. Tất nhiên là mọi người đều có lợi khi có được những mối quan hệ tốt đẹp, những cách tư duy mới và cuộc sống có nhiều giá trị hơn.

Tuy nhiên, những người ở vị trí lãnh đạo sẽ là đối tượng đặc biệt cần phải mài dũa những kỹ năng này, vì uy quyền và địa vị càng tăng thì việc đặt câu hỏi sẽ càng trở nên khó khăn hơn với họ. Văn hóa của chúng ta đề cao vai trò của người chỉ huy và lãnh đạo trong việc xác định hướng đi và quyết định chuẩn mực ứng xử của cả nhóm, mà những trọng trách này thường điều hướng đến hành vi nói hơn là hỏi.

Qua đó, họ chính là những người cần đến kỹ năng hỏi han khiêm nhường nhất, vì những nhiệm vụ phức tạp và sức ảnh hưởng lớn của họ đòi hỏi họ phải xây dựng những mối quan hệ tích cực, cởi mở và đáng tin cậy với cấp trên, cấp dưới và cả những người xung quanh. Như vậy, họ mới có thể tạo điều kiện cho đội nhóm của mình tiến bộ và hoàn thành nhiệm vụ một cách an toàn, hiệu quả hơn trước bối cảnh thế giới không ngừng thay đổi.

Sách “Giao tiếp khiêm nhường - Thu phục nhân tâm” sẽ giúp được gì trong giao tiếp hằng ngày?

Trong những chương đầu tiên, quyển sách này sẽ giải thích cặn kẽ về ý nghĩa thật sự của phương pháp hỏi han khiêm nhường trong cuộc sống thực tế hằng ngày.

Tiếp theo, quyển sách sẽ nhấn mạnh ý nghĩa của phương pháp này bằng cách so sánh hỏi han khiêm nhường với những hình thức đặt câu hỏi khác thường được áp dụng bởi các huấn luyện viên và những người mang trách nhiệm giúp đỡ người khác.

Quyển sách Humble Inquiry: The Gentle Art of Asking Instead of Telling này sẽ đào sâu vào những câu hỏi như: Những yếu tố văn hóa, xã hội và tâm lý nào đang cản trở chúng ta đón nhận và sử dụng phương pháp này? Nếu muốn hỏi han khiêm nhường thành công thì chúng ta phải quên đi những bài học nào và học lại những bài học nào? Nó cũng thảo luận về những tác động thường trực của văn hóa lên chúng ta, cũng như sẽ chứng minh cách mà văn hóa ngầm khuyến khích ta phát biểu ý kiến và cản trở việc hỏi han khiêm nhường.

Qua đó, quyển sách này cũng nói về những tương tác xã hội đang ngầm diễn ra trong những cuộc hội thoại của chúng ta, và phân tích kỹ hơn về những gì diễn ra trong nội tâm của chúng ta trong khoảng thời gian ngắn ngủi từ lúc quan sát sự việc đến lúc phản ứng lại. Mục đích của những thông tin này là để giúp bạn hiểu được vì sao bạn thường không sử dụng kỹ năng hỏi han khiêm nhường khi cần đến nó, cũng như những bài học mà có thể bạn phải quên đi hoặc học lại để cải thiện kỹ năng xử lý tình huống khi trò chuyện.

Quyển sách “Giao tiếp khiêm nhường - Thu phục nhân tâm” này chắc chắn sẽ kích thích trí tò mò của bạn và hướng dẫn bạn bắt đầu hành trình ứng dụng phương pháp hỏi han khiêm nhường. Mỗi người chúng ta sẽ có cách ứng dụng phương pháp hỏi han khiêm nhường khác nhau – không có một công thức duy nhất. Và hành trình đó sẽ bắt đầu từ đây.')
--19
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043654844',N'Đến Apple Học Về Sáng Tạo','P4','C5',19,N'Ali Tamaseb',180000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/den-apple-hoc-ve-sang-tao.jpg',100,1,N'Apple đã thành công như thế nào?

Ai cũng biết rằng Apple là một doanh nghiệp hàng nghìn tỷ đô. Vậy họ đã dùng phương thức nào, quy trình nào, cách đặt vấn đề ra sao, cách giải quyết vấn đề ra sao để Apple trở thành một đế chế hùng cường như ngày nay?

Trong cuốn sách “Đến Apple học về sáng tạo” này, tác giả Ken Kocienda - Kỹ sư phần mềm đã làm việc tại Apple 15 năm, sẽ kể chúng ta nghe về chặng đường của ông tại Apple, về nỗ lực của riêng tác giả trong việc tạo ra những phần mềm tuyệt vời cùng những câu chuyện và bài học mà ông đúc kết được qua bao trải nghiệm khi còn làm việc ở đây.

Nếu bạn muốn biết vì sao sản phẩm và văn hóa của Apple lại đặc biệt đến vậy, cảm giác khi thuyết trình trước Steve Jobs thật sự ra sao, hay bàn phím cảm ứng của điện thoại iPhone đã được thiết kế như thế nào, những trang sách tiếp theo sẽ đáp ứng trí tò mò của bạn.

Ngoài ra, tác giả sẽ kể bạn nghe về công việc của một kỹ sư phần mềm tại Apple, về cộng đồng những nhà phát triển phần mềm tại Apple, và bằng cách nào mà một nhóm nhỏ những kẻ hướng nội ham tìm tòi, bắt đầu chỉ với những ước mơ, mục tiêu, ý tưởng, lại có thể tạo ra được một trình duyệt web và một hệ điều hành điện thoại thông minh dùng màn hình cảm ứng được thế giới tin dùng.')
--20
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8935235235083',N'1 Năm Bằng 10 Năm - Bí Quyết Nâng Cấp Của Cải Và Sức Ảnh Hưởng Của Mỗi Người','P5','C8',20,N'Miêu Thúc',125000,'https://nhasachphuongnam.com/images/thumbnails/900/900/detailed/234/1-nam-bang-10-nam.jpg',100,1,N'Cuốn sách này là kim chỉ nam để nâng cao sức ảnh hưởng cá nhân và gia tăng của cải. Tác phẩm tập trung vào 2 trụ cột, đó là "đặt nền móng" và "nâng cao", với 17 hạng mục thâu tóm toàn bộ những kỹ năng nòng cốt cần có để phát triển cá nhân và tìm kiếm sự thịnh vượng.
Tất cả nội dung trong sách đều được tác giả tổng kết lại từ trải nghiệm thực tiễn của chính mình, được lượng lớn độc giả và các hội nhóm kinh doanh đánh giá cao.
Viết cho bạn, người chắc chắn có thể thành công, giữa thời đại mọi thứ đang thay đổi chóng mặt! Nâng cấp bản thân là mấu chốt để giải quyết tất cả vấn đề.')
--21
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786046967378',N'Những Cuộc Phiêu Lưu Của Huckleberry Finn','P1','C1',21,N'Mark Twain',83000,'https://salt.tikicdn.com/cache/w1200/media/catalog/product/n/h/nhung%20cuoc%20phieu%20luu%20cua%20huckleberry%20finn%20-%20copy.u547.d20160404.t160641.jpg',100,1,N'Ernest Hemingway từng nói: “Toàn bộ văn học Mỹ hiện đại đều thoát thai từ một cuốn sách của Mark Twain, đó là Những cuộc phiêu lưu của Huckleberry Finn”.

Sau những cuộc phiêu lưu cùng Tom Sawyer, Huck Finn được bà quả phụ Douglas đón về nuôi. Nhưng với bản tính ưa tự do, Huck không chịu nổi việc phải ăn vận sạch sẽ, học hành theo khuôn phép trưởng giả dù được sống giàu sang. Cộng thêm với việc người cha tưởng đã chết  đột ngột trở về tiếp tục hành hạ, gây rắc rối cho cậu, Huck quyết định cùng Jim – một nô lệ da đen bỏ trốn – cùng xuôi dòng Mississippi, bắt đầu những cuộc phiêu lưu mới.

Nhiều chuyện dở khóc dở cười đã xảy ra trong chuyến phiêu lưu. Không chỉ thế, Huck còn lâm vào những tình huống nguy hiểm khi bị cuốn vào cuộc tranh chấp giữa hai dòng họ với những cuộc đọ súng chết chóc... Nhưng cũng chính trong hoàn cảnh ngặt nghèo nhất, Huck đã nhận ra giá trị của cuộc sống để hướng về sự tự do và hết lòng giúp đỡ người nô lệ da đen tội nghiệp. Từ một cậu bé chỉ biết phá phách, Huck đã xác định rõ ràng mục đích sống, biết phân biệt đúng sai bằng trái tim thuần hậu và thoát khỏi những định kiến méo mó được nhồi nhét qua cách giáo dục sai trái.

Các nhà phê bình văn học đã đánh giá Những cuộc phiêu lưu của Huckleberry Finn là tiểu thuyết ưu tú nhất của Mark Twain, bởi tác giả đã vận dụng một cách nhuần nhuyễn phương ngữ của nhiều vùng, nhiều tầng lớp người để diễn tả những trạng huống tâm lý phức tạp, cũng như mô tả xuất sắc cảnh vật thiên nhiên. Tác phẩm này đã lọt vào danh sách những tiểu thuyết hay nhất mọi thời đại của văn học Mỹ, và rất nhiều lần được đưa lên màn ảnh.')
--22
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049959110',N'Chiến Binh Cầu Vồng','P2','C1',22,N'Andrea Hirata',109000,'https://salt.tikicdn.com/cache/750x750/ts/product/a1/ef/4f/0b39e40dca3827604c8bc4e867cc9423.jpg.webp',100,1,N'Một tác phẩm có tầm ảnh hưởng sâu rộng nhất Indonesia

“Thầy Harfan và cô Mus nghèo khổ đã mang đến cho tôi tuổi thơ đẹp nhất, tình bạn đẹp nhất, và tâm hồn phong phú, một thứ gì đó vô giá, thậm chí còn có giá trị hơn những khao khát mơ ước. Có thể tôi lầm, nhưng theo ý tôi, đây thật sự là hơi thở của giáo dục và linh hồn của một chốn được gọi là trường học.”
- (Trích tác phẩm)

***

Trong ngày khai giảng, nhờ sự xuất hiện vào phút chót của cậu bé thiểu năng trí tuệ Harun, trường Muhammadiyah may mắn thoát khỏi nguy cơ đóng cửa. Nhưng ước mơ dạy và học trong ngôi trường Hồi giáo ấy liệu sẽ đi về đâu, khi ngôi trường xập xệ dường như sẵn sàng sụp xuống bất cứ lúc nào, khi lời đe dọa đóng cửa từ viên thanh tra giáo dục luôn lơ lửng trên đầu, khi những cỗ máy xúc hung dữ đang chực chờ xới tung ngôi trường để dò mạch thiếc…? Và liệu niềm đam mê học tập của những Chiến binh Cầu vồng đó có đủ sức chinh phục quãng đường ngày ngày đạp xe bốn mươi cây số, rồi đầm cá sấu lúc nhúc bọn ăn thịt người, chưa kể sự mê hoặc từ những chuyến phiêu lưu chết người theo tiếng gọi của ngài pháp sư bí ẩn trên đảo Hải Tặc, cùng sức cám dỗ khôn cưỡng từ những đồng tiền còm kiếm được nhờ công việc cu li toàn thời gian

Chiến binh Cầu vồng có cả tình yêu trong sáng tuổi học trò lẫn những trò đùa tinh quái, cả nước mắt lẫn tiếng cười – một bức tranh chân thực về hố sâu ngăn cách giàu nghèo, một tác phẩm văn học cảm động truyền tải sâu sắc nhất ý nghĩa đích thực của việc làm thầy, việc làm trò và việc học.

Tác phẩm đã bán được trên năm triệu bản, được dịch ra 26 thứ tiếng, là một trong những đại diện xuất sắc nhất của văn học Indonesia hiện đại.')
--23
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786045364888',N'Totto-chan Bên Cửa Sổ','P2','C1',23,N'Kuroyanagi Tetsuko',98000,'https://salt.tikicdn.com/cache/750x750/ts/product/24/39/01/1718d16b33315c03026cee717adad4b3.jpg.webp',100,1,N'Không còn cách nào khác, mẹ đành đưa Totto-chan đến một ngôi trường mới, trường Tomoe. Đấy là một ngôi trường kỳ lạ, lớp học thì ở trong toa xe điện cũ, học sinh thì được thoả thích thay đổi chỗ ngồi mỗi ngày, muốn học môn nào trước cũng được, chẳng những thế, khi đã học hết bài, các bạn còn được cô giáo cho đi dạo. Đặc biệt hơn ở đó còn có một thầy hiệu trưởng có thể chăm chú lắng nghe Totto-chan kể chuyện suốt bốn tiếng đồng hồ! Chính nhờ ngôi trường đó, một Totto-chan hiếu động, cá biệt đã thu nhận được những điều vô cùng quý giá để lớn lên thành một con người hoàn thiện, mạnh mẽ.

Totto-chan bên cửa sổ là cuốn sách gối đầu giường của nhiều thế hệ trẻ em trên toàn thế giới suốt ba mươi năm nay. Sau khi xuất bản lần đầu vào năm 1981, cuốn sách đã gây được tiếng vang lớn không chỉ ở Nhật Bản mà còn trên toàn thế giới. Tính đến năm 2001, tổng số bản sách bán ra ở Nhật đã lên đến 9,3 triệu bản, trở thành một trong những cuốn sách bán chạy nhất trong lịch sử ngành xuất bản nước này. Cuốn sách đã được dịch ra 33 thứ tiếng khác nhau, như Anh, Pháp, Đức, Hàn Quốc, Trung Quốc…Khi bản tiếng Anh của Totto-chan được xuất bản tại Mỹ, tờ New York Times đã đăng liền hai bài giới thiệu trọn trang, một “vinh dự” hầu như không tác phẩm nào có được.')
--24
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786047747313',N'Con Đường Thoát Hạn','P4','C8',24,N'Seth M Siegel',169000,'https://salt.tikicdn.com/cache/w1200/media/catalog/product/c/o/con%20duong%20thoat%20han%20ban%20tieng%20viet.u2469.d20160823.t105118.805071.jpg',100,1,N'Nhắc đến Israel, người ta sẽ nghĩ ngay đến tinh thần "khởi nghiệp" của những người dân Do Thái bất diệt, bền bỉ. Dù ngoại cảnh có hỗn loạn đến đâu, dù thiên nhiên không ưu đãi cho họ nhiều điều kiện thuận lợi, Israel vẫn vươn lên mạnh mẽ qua biết bao hành trình khó khăn, khắc nghiệt từ những ngày đầu phục quốc cho đến khi xây dựng đời sống xã hội. Câu chuyện về "Quốc gia khởi nghiệp" Israel lại được kể tiếp trong những trang văn giản dị chứa đựng những thông điệp lớn lao trong tác phẩm "Con đường thoát hạn" - một anh hùng ca về "thung lũng Silicon" của thế giới.

Không giống như Việt Nam, Israel không sở hữu nguồn tài nguyên nước dồi dào và hệ thống sông ngòi, kênh rạch phong phú – mà ngược lại, có tới 60% diện tích là hoang mạc, lại bị bao vây ba bề bốn bên bởi những quốc gia thù địch. Thế nhưng, người Israel đã tìm ra cách tự “sản xuất” ra nước thông qua những biện pháp sáng tạo và liều lĩnh. Đó là Nước sạch được khử mặn từ nước biển, là nước lợ đã qua một hệ thống lọc phức tạp, thậm chí là nước thải sinh hoạt (nước cống) được xử lý tinh vi để có thể dùng tưới tiêu cho nông nghiệp hay cho những mục đích sinh hoạt thông thường khác... Năm 2013, người Israel đã tuyên bố : nguồn nước của họ không còn phụ thuộc vào thiên nhiên nữa ! Nước chính là cứu cánh, là phép màu mở ra cánh cửa nông nghiệp, kinh tế, ngoại giao cho Israel. Israel hiện sản xuất nước dư thừa cho nhu cầu nội tại và còn xuất khẩu đều đặn 24/7 sang cho các nước láng giềng, Palestine và Jordan, là vũ khí hòa bình của Israel cho tình trạng đối đầu Iran-Israel, Israel-Trung Quốc và một số các quốc gia khác, trở thành một « ngành kinh doanh toàn cầu », đòn bẩy cho kinh tế Israel phát triển.

Bằng những nghiên cứu tỉ mỉ và với hàng trăm cuộc phỏng vấn, Siegel đã mô tả sinh động cách mà Israel đã vượt qua các cuộc khủng hoảng nước của riêng mình, biến bất lợi thành lợi thế, đồng thời hỗ trợ các quốc gia khác trong việc xử lý và bảo tồn nguồn nước. Với 12 chương sách được bố cục một cách khoa học, cuốn sách kể về cả một lịch sử và hành trình thần kỳ của Israel trong hành trình chinh phục thiên nhiên, mang đến cho bạn những góc nhìn bao quát, một tư duy nhất quán, là kim chỉ nam về một nền quản trị nước đầy trí tuệ.

Cũng như lời của Shimon Tal, nguyên chủ nhiệm Ủy ban Nước Israel đã nói: "Cách thức quản lý nước của một quốc gia nói lên nhiều điều về quốc gia đó.", đây là câu chuyện không chỉ dành cho những người nghiên cứu về thủy lợi và nông nghiệp, nó còn là câu chuyện dành cho tất cả những người quan tâm về việc kiến tạo một tương lai phát triển và bền vững cho đất nước.')
--25
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043206258',N'Sao Chúng Ta Lại Ngủ','P8','C8',25,N'Matthew Walker',249000,'https://salt.tikicdn.com/cache/750x750/ts/product/5b/9b/72/693e8880ba84cf2c4a85dfc8081b4a5b.jpg.webp',100,1,N'Là cuốn sách về giấc ngủ đầu tiên được viết bởi chính một chuyên gia khoa học hàng đầu, giám đốc Trung tâm về Khoa học Giấc ngủ Con người của trường Đại học California, Berkeley, Sao chúng ta lại ngủ trở thành một cuộc khám phá mang tính đột phá về giấc ngủ, giải thích việc chúng ta có thể khai thác được sức mạnh biến đổi của giấc ngủ nhằm làm thay đổi cuộc sống của chúng ta trở nên tốt đẹp hơn như thế nào.
Giấc ngủ từ lâu đã trở thành một trong những khía cạnh quan trọng nhất song lại được hiểu đúng giá trị ít nhất về sự sống, sức khỏe và tuổi thọ của con người chúng ta – cho tới khi xuất hiện sự bùng nổ những cuộc khám phá mang tính khoa học trong hai thập kỉ qua đã bắt đầu soi rọi ánh sáng mới mẻ về chủ đề này. Giờ đây, chuyên gia giấc ngủ kiêm nhà khoa học thần kinh xuất sắc Matthew Walker sẽ giải thích thật cặn kẽ về tầm quan trọng to lớn của giấc ngủ, điều vốn tồn tại giữa bao chức năng hoạt động khác của cơ thể, giúp tăng cường khả năng học tập và ra quyết định, hiệu chỉnh lại cảm xúc, củng cố lại hệ miễn dịch và điều tiết sự thèm ăn của chúng ta. Với lối viết rõ ràng, cấu trúc trình bày vấn đề lôi cuốn, từ ngữ dứt khoát và dễ hiểu vô cùng, Sao chúng ta lại ngủ sẽ hoàn toàn làm biến đổi sự đánh giá và hiểu biết của độc giả về giấc ngủ và cả những giấc mơ.')
--26
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786047777167',N'Tư Duy Nhanh Và Chậm','P4','C5',26,N'Daniel Kahneman',239000,'https://salt.tikicdn.com/cache/750x750/ts/product/77/3c/9e/6deec49282e3416f38b46e57d1ffd79f.jpg.webp',100,1,N'Chúng ta thường tự cho rằng con người là sinh vật có lý trí mạnh mẽ, khi quyết định hay đánh giá vấn đề luôn kĩ lưỡng và lý tính.

Nhưng sự thật là, dù bạn có cẩn trọng tới mức nào, thì trong cuộc sống hàng ngày hay trong vấn đề liên quan đến kinh tế, bạn vẫn có những quyết định dựa trên cảm tính chủ quan của mình. “Tư duy nhanh và chậm”, cuốn sách nổi tiếng tổng hợp tất cả nghiên cứu được tiến hành qua nhiều thập kỷ của nhà tâm lý học từng đạt giải Nobel Kinh tế Daniel Kahneman sẽ cho bạn thấy những sư hợp lý và phi lý trong tư duy của chính bạn.

Cuốn sách được đánh giá là “kiệt tác” trong việc thay đổi hành vi của con người, Tư duy nhanh và chậm đã dành được vô số giải thưởng danh giá, lọt vào Top 11 cuốn sách kinh doanh hấp dẫn nhất.

Đã có rất nhiều cuốn sách nói về tính hợp lý và phi lý của con người trong tư duy, trong việc đánh giá và ra quyết định, nhưng Tư duy nhanh và chậm được Tạp chí Tài chính Mỹ đánh giá là “kiệt tác”.

Bạn nghĩ rằng bạn tư duy nhanh, hay chậm? Bạn tư duy và suy nghĩ theo lối “trông mặt bắt hình dong”, đánh giá mọi vật nhanh chóng bằng cảm quan, quyết định dựa theo cảm xúc hay tư duy một cách cẩn thận, chậm rãi nhưng logic hợp lý về một vấn đề. Tư duy nhanh và chậm sẽ đưa ra và lý giải hai hệ thống tư duy tác động đến con đường nhận thức của bạn.

Kahneman gọi đó là: hệ thống 1 và hệ thống 2. Hệ thống 1, còn gọi là cơ chế nghĩ nhanh, tự động, thường xuyên được sử dụng, cảm tính, rập khuôn và tiềm thức. Hệ thống 2, còn gọi là cơ chế nghĩ chậm, đòi hỏi ít nỗ lực, ít được sử dụng, dùng logic có tính toán và ý thức.

Trong một loạt thí nghiệm tâm lý mang tính tiên phong, Kahneman và Tversky chứng minh rằng, con người chúng ta thường đi đến quyết định theo cơ chế nghĩ nhanh hơn là ghĩ chậm. Phần lớn nội dung của cuốn sách chỉ ra những sai lầm của con người khi suy nghĩ theo hệ thống 1.

Kahneman chứng minh rằng chúng ta tệ hơn những gì chúng ta tưởng: đó là chúng ta không biết những gì chúng ta không biết! 

Cuốn sách đặc biệt đã dành được vô số giải thưởng danh giá: Sách khoa học hay nhất của Học viện Khoa học Quốc gia năm 2012, được tạp chí The New York Times bình chọn là sách hay nhất năm 2011, một trong những cuốn sách kinh tế xuất sắc năm 2011, chiến thắng giải thưởng cuốn sách được quan tâm nhất năm 2011 của tạp chí Los Algeles…

Tư duy nhanh và chậm đáp ứng hai tiêu chí của một cuốn sách hay, thứ nhất nó thách thức quan điểm của người đọc, thứ hai, nó không phải là những trang sách với những con chữ khô cứng mà nó vô cùng vui nhộn và hấp dẫn. Không nghi ngờ gì nữa, đây là cuốn sách hàn lâm dành cho tất cả mọi người!')
--27
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049316043',N'Hacker Lược Sử','P7','C8',27,N'Steven Levy',299000,'https://salt.tikicdn.com/cache/750x750/ts/product/a9/23/d7/7d8612e8ba7e475a5cbab2c6cae7dcc6.jpg.webp',100,1,N'Cuốn sách nói về những nhân vật, cỗ máy, sự kiện định hình cho văn hóa và đạo đức hacker từ những hacker đời đầu ở đại học MIT.

Câu chuyện hấp dẫn bắt đầu từ các phòng thí nghiệm nghiên cứu máy tính đầu tiên đến các máy tính gia đình.

Tập hợp tài liệu cập nhật từ các tin tặc nổi tiếng như Bill Gates, Mark Zuckerberg, Richard Stallman…

Những sự thật về cuộc sống và con đường trở thành “tin tặc” của những con người đã thay đổi lịch sử phát triển của ngành Công nghệ.

Cuốn  sách của Steven Levy ghi lại những chiến công của các tin tặc thời kỳ đầu trong cuộc cách mạng máy tính - những kẻ mê máy tính thông minh và lập dị từ cuối những năm 1950 đến đầu thập niên 1980, dám mạo hiểm, bẻ cong quy tắc và đẩy thế giới vào một hướng đi hoàn toàn mới.')
--28
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049768361',N'Những Cuộc Phiêu Lưu Của Tom Sawyer','P1','C1',28,N'Mark Twain',134000,'https://salt.tikicdn.com/cache/750x750/ts/product/9b/49/8d/732cfcfec6164bd960031e560927b4ba.jpg.webp',100,1,N'Mark Twain tên thật là Samuel Clemens(1835-1910) sinh trưởng ở miền Florida, thuộc bang Missouri, nước Mỹ, là một nhà văn trào phúng nổi tiếng. Tác phẩm của ông, với tính cách châm biếm sâu sắc với những nét miêu tả tâm lý xã hội cực kỳ khéo léo, đã trở thành vũ khí sắc bén đấu tranh chống lại sự áp bức thống trị của nhà cầm quyền phong kiến tư bản.
Ra đời năm 1876, hơn 100 năm nay, Những cuộc phiêu lưu của Tom Sawyer đã được người đọc ở nhiều lứa tuổi, nhiều dân tộc khác nhau yêu mến. Tác giả không chỉ thuật lại câu chuyện có hậu về chú Tom tinh nghịch, mà còn dựng nên một bức tranh hiện thực về cuộc sống của các nhân vật bé nhỏ trong truyện, đặc biệt đi sâu vào thế giới bên trong con người, miêu tả giản di và chính xác tâm lí trẻ em. Tác phẩm chứa đựng trong nó một chất thơ trong trẻo, được coi là một “khúc ca về tuổi thơ”.')
--29
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786047789467',N'Hành Trình Về Phương Đông','P4','C9',29,N'Baird T Spalding',118000,'https://salt.tikicdn.com/cache/750x750/ts/product/ae/39/8a/3da6ccb3b24dbae4a0f4ed1b75778467.jpg.webp',100,1,N'Hành Trình Về Phương Đông mở ra một chân trời mới về Đông Tây gặp nhau, để khoa học Minh triết hội ngộ, để Hiện đại Cổ xưa giao duyên, để Đất Trời là một. Thế giới, vì vậy đã trở nên hài hòa hơn, rộng mở, diệu kỳ hơn và, do đó, nhân văn hơn.

Hành Trình Về Phương Đông kể về những trải nghiệm của một đoàn khoa học gồm các chuyên gia hàng đầu của Hội Khoa Học Hoàng Gia Anh được cử sang Ấn Độ nghiên cứu về huyền học và những khả năng siêu nhiên của con người. Suốt hai năm trời rong ruổi khắp các đền chùa Ấn Độ, chúng kiến nhiều pháp luật, nhiều cảnh mê tín dị đoan, thậm chí lừa đảủa nhiều pháp sư, đạo sĩọ được tiếp xúc với những vị thế, họ được chứng kiến, trải nghiệm, hiểu biết sâu sắc về các khoa học cổ xưa và bí truyền của văn hóa Ấn Độ như Yoga, thiền định, thuật chiêm duyên, nghiệp báo, luật nhân quả, cõi sống và cõi chế

Đúng lúc một cuộc đối thoại cởi mở và chân thành đang sắp diễn ra với các đạo sĩ bậc thầy, thì đoàn nhận được tối hậu thu từ chính quyền Anh Quốc là phải ngừng ngay việc nghiên cứu, tức khắc hồi hương và bị buộc phải im lặng, không được phát ngôn về bất cứ điều gì mà họ đã chứng nghiệm. Sau cùng ba nhà khoa học trong đoàn đã chấp nhận bỏ lại tất cả sau lưng, ở lại Ấn Độ tiếp tục nghiên cứu và cuối cùng trở thành tu sĩ. Trong số đó có giáo sư Salding- tác giả hồi ký đặc biệt này.

Đúng lúc một cuộc đối thoại cởi mở và chân thành đang sắp diễn ra với các đạo sĩ bậc thầy, thì đoàn nhận được tối hậu thu từ chính quyền Anh Quốc là phải ngừng ngay việc nghiên cứu, tức khắc hồi hương và bị buộc phải im lặng, không được phát ngôn về bất cứ điều gì mà họ đã chứng nghiệm. Sau cùng ba nhà khoa học trong đoàn đã chấp nhận bỏ lại tất cả sau lưng, ở lại Ấn Độ tiếp tục nghiên cứu và cuối cùng trở thành tu sĩ. Trong số đó có giáo sư Salding - tác giả hồi ký đặc biệt này.')
--30
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786045990049',N'Blockchain Bản Chất Của Blockchain, Bitcoin, Tiền Điện Tử, Hợp Đồng Thông Minh Và Tương Lai Của Tiền Tệ','P8','C5',30,N'Mark Gates',110000,'https://salt.tikicdn.com/cache/750x750/ts/product/da/38/1f/9b221772de663643f808efe8ef1d25eb.jpg.webp',100,1,N'Tiền điện tử, với đại diện tiêu biểu nhất là Bitcoin, đang là mối quan tâm hàng đầu của giới tài chính toàn cầu. Khả năng thanh toán bằng tiền điện tử mở ra hàng loạt tiềm năng cho thương mại và thay đổi toàn diện thói quen tiêu dùng của con người. Hạt nhân của công nghệ hứa hẹn rung chuyển thế giới này được gọi là Blockchain. Blockchain được giới công nghệ đánh giá là phát kiến vĩ đại nhất sau khi mạng Internet ra đời. Ứng dụng phổ biến nhất của nó là các loại tiền điện tử nổi tiếng (Bitcoin, Ethereum, Ripple...) đang làm mưa làm gió trên thị trường. Nhưng nghịch lý là, lại rất ít người nắm được bản chất của tiền điện tử và Blockchain. Rốt cuộc, Blockchain là gì? Nó hoạt động như thế nào? Blockchain thật sự là một đột phá trong công nghệ hay chỉ là một trào lưu nhất thời? Blockchain có liên hệ như thế nào với Bitcoin? Liệu Blockchain có nắm giữ tiềm năng thay đổi thế giới?... Thực chất, những bài viết cung cấp thông tin về Blockchain và tiền điện tử không thiếu trên các website hay mạng xã hội, nhưng lại chưa đủ tính bao quát và còn khó tiếp thu. Đó là lý do cuốn sách “BLOCKCHAIN: Bản chất của Blockchain, Bitcoin, tiền điện tử, hợp đồng thông minh và tương lai của tiền tệ” của Mark Gates ra đời. Gates cung cấp một bản tóm lược dễ hiểu nhất, cung cấp nền tảng thiết yếu cho những người mới bắt đầu và cả những ai muốn nghiên cứu sâu hơn về công nghệ Blockchain và tiền điện tử. Đọc cuốn sách này, bạn sẽ hiểu được Blockchain dưới nhiều khía cạnh, trong đó không chỉ có những lời ngợi khen mà còn không thiếu các chỉ trích, bình luận trái chiều.')
--31
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049973949',N'Không Gia Đình','P1','C3',31,N'Hector Malot',185000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_47394.jpg',100,1,N'Không Gia Đình là tiểu thuyết nổi tiếng nhất trong sự nghiệp văn chương của Hector Malot. Hơn một trăm năm nay, tác phẩm giành giải thưởng của Viện Hàn Lâm Văn học Pháp này đã trở thành người bạn thân thiết của thiếu nhi và tất cả những người yêu mến trẻ khắp thế giới.

Tác phẩm đã ca ngợi sự lao động bền bỉ, tinh thần tự lập, chịu đựng gian khó, khích lệ tình bạn chân chính. Ca ngợi lòng nhân ái, tình yêu cuộc sống, ý chí vươn lên không ngừng… Không Gia Đình vì thế đã vượt qua biên giới nước Pháp và tồn tại lâu dài với thời gian.')
--32
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043236941',N'Những Người Phụ Nữ Bé Nhỏ','P1','C3',32,N'Louisa May Alcott',388000,'https://cdn0.fahasa.com/media/catalog/product/n/h/nh_ng-ng_i-ph_-n_-b_-nh_kkkkkkk-bc_1.jpg',100,1,N'Louisa May Alcott (1832-1888) - là tiểu thuyết gia người Mỹ, nổi danh với tiểu thuyết Những người phụ nữ bé nhỏ (1868) và các phần tiếp theo gồm Những chàng trai nhỏ (1871) và Những cậu bé của Jo (1886).

Sinh ra và lớn lên trong một gia đình trí thức và được dạy dỗ nghiêm khắc ở New England, Alcott có cơ hội tiếp xúc với nhiều học giả lừng danh như Ralph Waldo Emerson, Nathaniel Hawthorne, Henry David Thoreau… Khoảng thời gian gia đình  bà gặp khó khăn về tài chính đã tiếp thêm động lực để Alcott tập trung viết những câu chuyện lôi cuốn độc giả bao thế hệ. Bà đón nhận thành công đầu tiên vào năm 1860 với những truyện ngắn đăng trên tờ Atlantic Monthly với bút danh A. M. Barnard. Những sáng tác sau này của bà hướng đến motif người phụ nữ mạnh mẽ, độc lập và giàu trí tưởng tượng, điển hình như nhân vật Jo trong tác phẩm Những người phụ nữ bé nhỏ.

Louisa May Alcott còn là người theo chủ nghĩa bãi nô và nữ quyền, tư tưởng tiến bộ đó cũng được truyền tải sâu sắc qua hầu hết những trước tác của bà. Trong suốt cuộc đời, bà đã cống hiến hết mình cho các phong trào cải cách thay đổi định kiến về phụ nữ, đòi quyền bầu cử bình đẳng cho nữ giớ

Xuất bản lần đầu năm 1868, Những người phụ nữ bé nhỏ đã đưa tên tuổi Louisa May Alcott rực sáng trên văn đàn thế giới. Tác phẩm được xem là tiểu thuyết bán tự truyện, được nữ văn sĩ lấy cảm hứng và chất liệu từ cuộc sống thời thơ ấu của chính mình và ba người chị em của bà.

          Hơn 150 năm qua, câu chuyện về chị em nhà March vẫn luôn giữ được sức cuốn hút mãnh liệt, đưa cuốn tiểu thuyết Những người phụ nữ bé nhỏ trở thành một tác phẩm kinh điển của văn học Mỹ, làm say đắm biết bao thế hệ độc giả bởi nét cá tính hồn nhiên cùng những giá trị tư tưởng sâu sắc. Dưới ngòi bút tài hoa của Louisa May Alcott, bức tranh về gia đình nhà March hiện lên đa thanh đa sắc, khắc họa thành công quá trình trưởng thành của bốn cô gái từ lúc đương hoa cho đến khi trở thành những người phụ nữ đích thực: Meg xinh đẹp, thấu đáo; Jo mạnh mẽ, cá tính; Beth nhu mì, lặng lẽ; Amy cầu toàn, thanh lịch. Tác phẩm không chỉ giúp Alcott trang trải một phần cuộc sống khó khăn cho gia đình mà còn mang lại danh tiếng cho bà, bởi nó hàm chứa tư tưởng tươi mới, khác xa chuẩn mực đương thời…

          Trường thiên tiểu thuyết về bốn chị em nhà March đã trở thành biểu tượng cho tinh thần vượt lên trên mọi rào cản mà xã hội áp đặt cho người phụ nữ lúc bấy giờ, là nguồn cổ vũ lớn lao, nuôi dưỡng tâm hồn của mỗi cô gái dám tự tin khẳng định bản thân. Ai cũng có lựa chọn của riêng mình, độc thân hay kết hôn, an phận hay phấn đấu, bất luận ra sao, người phụ nữ luôn xứng đáng được viết nên câu chuyện của cuộc đời mình.')
--33
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786046937098',N'Bố Già (Bìa mềm)','P5','C3',33,N'Mario Puzo',110000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8936071673381.jpg',100,1,N'Thế giới ngầm được phản ánh trong tiểu thuyết Bố Già là sự gặp gỡ giữa một bên là ý chí cương cường và nền tảng gia tộc chặt chẽ theo truyền thống mafia xứ Sicily với một bên là xã hội Mỹ nhập nhằng đen trắng, mảnh đất màu mỡ cho những cơ hội làm ăn bất chính hứa hẹn những món lợi kếch xù. Trong thế giới ấy, hình tượng Bố già được tác giả dày công khắc họa đã trở thành bức chân dung bất hủ trong lòng người đọc. Từ một kẻ nhập cư tay trắng đến ông trùm tột đỉnh quyền uy, Don Vito Corleone là con rắn hổ mang thâm trầm, nguy hiểm khiến kẻ thù phải kiềng nể, e dè, nhưng cũng được bạn bè, thân quyến xem như một đấng toàn năng đầy nghĩa khí. Nhân vật trung tâm ấy đồng thời cũng là hiện thân của một pho triết lí rất “đời” được nhào nặn từ vốn sống của hàng chục năm lăn lộn giữa chốn giang hồ bao phen vào sinh ra tử, vì thế mà có ý kiến cho rằng “Bố Già là sự tổng hòa của mọi hiểu biết. Bố Già là đáp án cho mọi câu hỏi”.

Với cấu tứ hoàn hảo, cốt truyện không thiếu những pha hành động gay cấn, tình tiết bất ngờ và không khí kình địch đến nghẹt thở, Bố Già xứng đáng là đỉnh cao trong sự nghiệp văn chương của Mario Puzo. Và như một cơ duyên đặc biệt, ngay từ năm 1971-1972, Bố Già đã đến với bạn đọc trong nước qua phong cách chuyển ngữ hào sảng, đậm chất giang hồ của dịch giả Ngọc Thứ Lang.')
--34
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043234732',N'Bố Già (Bìa cứng)','P1','C3',34,N'Mario Puzo',250000,'https://cdn0.fahasa.com/media/catalog/product/z/2/z2611575615164_9f60c133cfed1c7bb3f59b247f-600.jpg',100,1,N'Thế giới ngầm được phản ánh trong tiểu thuyết Bố Già là sự gặp gỡ giữa một bên là ý chí cương cường và nền tảng gia tộc chặt chẽ theo truyền thống mafia xứ Sicily với một bên là xã hội Mỹ nhập nhằng đen trắng, mảnh đất màu mỡ cho những cơ hội làm ăn bất chính hứa hẹn những món lợi kếch xù. Trong thế giới ấy, hình tượng Bố già được tác giả dày công khắc họa đã trở thành bức chân dung bất hủ trong lòng người đọc. Từ một kẻ nhập cư tay trắng đến ông trùm tột đỉnh quyền uy, Don Vito Corleone là con rắn hổ mang thâm trầm, nguy hiểm khiến kẻ thù phải kiềng nể, e dè, nhưng cũng được bạn bè, thân quyến xem như một đấng toàn năng đầy nghĩa khí. Nhân vật trung tâm ấy đồng thời cũng là hiện thân của một pho triết lí rất “đời” được nhào nặn từ vốn sống của hàng chục năm lăn lộn giữa chốn giang hồ bao phen vào sinh ra tử, vì thế mà có ý kiến cho rằng “Bố Già là sự tổng hòa của mọi hiểu biết. Bố Già là đáp án cho mọi câu hỏi”.

Với cấu tứ hoàn hảo, cốt truyện không thiếu những pha hành động gay cấn, tình tiết bất ngờ và không khí kình địch đến nghẹt thở, Bố Già xứng đáng là đỉnh cao trong sự nghiệp văn chương của Mario Puzo. Và như một cơ duyên đặc biệt, ngay từ năm 1971-1972, Bố Già đã đến với bạn đọc trong nước qua phong cách chuyển ngữ hào sảng, đậm chất giang hồ của dịch giả Ngọc Thứ Lang.')
--35
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043077957',N'Những Người Khốn Khổ (Trọn Bộ 2 Tập)','P1','C2',35,N'Victor Hugo',499000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_237627.jpg',100,1,N'Những người khốn khổ là một tác phẩm chứa chan tinh thần lãng mạn cách mạng. Những nhân vật chính diện đều sáng ngời đức hào hiệp, hy sinh. Tác phẩm ghi lại những nét hiện thực về xã hội Pháp vào khoảng 1830. Cái xã hội tư sản tàn bạo được phản ánh trong những nhân vật phản diện như Javert, Thénardier. Tình trạng cùng khổ của người dân lao động cũng được mô tả bằng những cảnh thương tâm của một người cố nông sau trở thành tù phạm, một người mẹ, một đứa trẻ sống trong cảnh khủng khiếp của cuộc đời tối tăm, ngạt thở. Dưới ngòi bút của Hugo, Paris ngày cách mạng 1832 đã sống dậy, tưng bừng, anh dũng, một Paris nghèo khổ nhưng thiết tha yêu tự do.')
--36
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049937309',N'Chúa Ruồi','P1','C3',36,N'William Golding',88000,'https://cdn0.fahasa.com/media/catalog/product/c/h/chuaruoi.jpg',100,1,N'Trong một cuộc chiến tranh nguyên tử, mấy chục đứa trẻ chưa đến tuổi thiếu niên “may mắn” sống sót trên một hoang đảo sau khi chiếc máy bay chở chúng đi sơ tán bị trúng đạn. Chúng tập họp dưới bầu trời Nam Thái Bình Dương nắng gắt, chia sẻ gánh nặng và đặt niềm tin vào thủ lĩnh. Nhưng rồi, cái đói và thiên nhiên khắc nghiệt từng bước vắt kiệt bọn trẻ. Bản năng sinh tồn đã dần bóp nghẹt sự ngây thơ - từ đây thực tại của chúng tan hòa vào ác mộng.

Một câu truyện ngụ ngôn đau đớn và hãi hùng, ngập tràn những tư tưởng ẩn sâu dưới hàng hàng lớp lớp ẩn dụ và biểu tượng. Với Chúa ruồi, một câu chuyện phiêu lưu đầy ám ảnh, một kiệt tác văn học kinh điển, William Golding đã khiến các nhà phê bình văn học hao tổn giấy mực chỉ để tranh luận về một vấn đề: Có thực "nhân chi sơ tính bản thiện” hay chăng là… ngược lại?')
--37
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043231496',N'Sherlock Holmes Toàn Tập - Tập 1 (Bìa Cứng)','P1','C10',37,N'Arthur Conan Doyle',100000,'https://salt.tikicdn.com/cache/w1200/ts/product/fc/72/6b/c3fa449783cd2b97dfdc3c46bbc6fbbd.jpg',100,1,N'Bạn đang cầm trên tay tập truyện về nhân vật thám tử nổi danh nhất mọi thời đại – vị thám tử tài ba xuất hiện đầu tiên trong tác phẩm trinh thám kinh điển “Sherlock Holmes” của nhà văn Arthur Conan Doyle .

Hơn 100 năm kể từ khi ra đời nhân vật thám tử Sherlock Holmes với chiếc mũ phớt và làm khói thuốc bay ra từ chiếc tẩu , cùng trí thông minh , khả năng suy diễn logic và quan sát tinh tường đã trở thành hình tượng bất tử về thám tử tài trí và là một trong những nhân vật văn học được biết đến nhiều nhất trên toàn thế giới .')
--38
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043235173',N'Sherlock Holmes Toàn Tập - Tập 2 (Bìa Cứng)','P1','C10',38,N'Arthur Conan Doyle',145000,'https://salt.tikicdn.com/cache/w1200/ts/product/72/51/40/88c645222cbb18bbbb9578eabe112b98.jpg',100,1,N'Bạn đang cầm trên tay tập truyện về nhân vật thám tử nổi danh nhất mọi thời đại – vị thám tử tài ba xuất hiện đầu tiên trong tác phẩm trinh thám kinh điển “Sherlock Holmes” của nhà văn Arthur Conan Doyle .

Hơn 100 năm kể từ khi ra đời nhân vật thám tử Sherlock Holmes với chiếc mũ phớt và làm khói thuốc bay ra từ chiếc tẩu , cùng trí thông minh , khả năng suy diễn logic và quan sát tinh tường đã trở thành hình tượng bất tử về thám tử tài trí và là một trong những nhân vật văn học được biết đến nhiều nhất trên toàn thế giới .')
--39
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043235180',N'Sherlock Holmes Toàn Tập - Tập 3 (Bìa Cứng)','P1','C10',39,N'Arthur Conan Doyle',130000,'https://salt.tikicdn.com/cache/750x750/ts/product/98/fb/6b/8afaf7b08aa4c6e408181baf4c6fdeaa.jpg.webp',100,1,N'Bạn đang cầm trên tay tập truyện về nhân vật thám tử nổi danh nhất mọi thời đại – vị thám tử tài ba xuất hiện đầu tiên trong tác phẩm trinh thám kinh điển “Sherlock Holmes” của nhà văn Arthur Conan Doyle .

Hơn 100 năm kể từ khi ra đời nhân vật thám tử Sherlock Holmes với chiếc mũ phớt và làm khói thuốc bay ra từ chiếc tẩu , cùng trí thông minh , khả năng suy diễn logic và quan sát tinh tường đã trở thành hình tượng bất tử về thám tử tài trí và là một trong những nhân vật văn học được biết đến nhiều nhất trên toàn thế giới .')
--40
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043075892',N'Tiếng Gọi Của Hoang Dã','P1','C3',40,N'auname',50000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_10705.jpg',100,1,N'"Tiếng gọi của hoang dã" (The Call of the Wild) là một tiểu thuyết nổi tiếng thế giới của nhà văn Mỹ - Jack London.

Cốt truyện kể về một chú chó tên là Buck đã được thuần hóa, cưng chiều. Nhưng do một loạt các sự kiện xảy ra khi Buck bị bắt khỏi trang trại, để trở thành chó kéo xe ở khu vực Alaska lạnh giá; trong giai đoạn mọi người đổ xô đi tìm vàng thế kỷ 19, thiên nhiên nguyên thủy đã đánh thức bản năng của Buck. Buck trở lại cuộc sống hoang dã, Buck trở về rừng và sống chung với lũ sói.

Xuất bản lần đầu năm 1903, "Tiếng gọi của hoang dã" là một trong những tiểu thuyết "BEST SELLER" của nhà văn Jack London và được xem là tác phẩm hay nhất của ông. Tại sao tên cuốn sách lại là "Tiếng gọi của hoang dã" thay vì "Tiếng gọi nơi hoang dã" như các Nhà sách khác đã phát hành. Chúng tôi ra bản in lần này vì muốn đem lại đúng và chính xác nhất có thể tinh thần, câu chữ của tác giả: tên nhan đề nguyên gốc "The Call of the Wild" và giải thích tại sao "moose" là "nai sừng tấm" mà không phải là "nai sừng". Bên cạnh đó, bởi nhân vật chính là một chú chó, đôi khi người ta phân loại tiểu thuyết này là một tiểu thuyết dành cho thanh thiếu niên, phù hợp cho trẻ con, tuy vậy trong tác phẩm không thiếu những cảnh hành hạ súc vật, sự chết chóc hay tranh đoạt, và chứa đựng nhiều cảnh bạo lực "thô bạo". Qua đây, nhằm đáp ứng nhu cầu của đông đảo bạn đọc, Pandabooks cho phát hành ấn phẩm "Tiếng gọi của hoang dã" - Jack London. Hy vọng lần tái bản này sẽ làm hài lòng bạn đọc và khắc phục tốt những sai lạc trong cuốn sách in trước đây.')
--41
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043076394',N'Thể Xác Và Tâm Hồn (Bìa Cứng)','P1','C1',41,N'Maxence Van der Meersch',368000,'https://cdn0.fahasa.com/media/catalog/product/x/v/xvth.jpg',100,1,N'Xuất bản năm 1943, tác phẩm Thể xác và Tâm hồn thành công vang dội khi được vinh danh tại giải thưởng Viện Hàn lâm Pháp. Bộ tiểu thuyết được công chúng và giới phê bình văn học đánh giá cao, nhưng cũng đồng thời làm dấy lên tranh luận sôi nổi về những góc khuất của nghề Y được phơi bày trong tác phẩm.

Bức tranh hiện thực sâu sắc trong hoạt động y tế cũng như đời sống xã hội nước Pháp vào nửa đầu thế kỷ XX đã được tác giả khắc họa chân thực với những bất công trong xã hội, những tình yêu éo le, những cảnh đời ngang trái, những kẻ cơ hội, những bác sĩ cố chấ Và cả những tâm hồn cao thượng, những y bác sĩ tận tâm, dám hy sinh, dám dấn thân và đi đến tận cùng đức tin của mình!')
--42
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786046982944',N'Thép Đã Tôi Thế Đấy','P1','C1',42,N'auname',110000,'https://salt.tikicdn.com/cache/w1200/ts/product/57/9d/f1/f3395afd678d2e6a90e314479b865c00.jpg',100,1,N'Thép đã tôi thế đấy! không phải là một tác phẩm văn học chỉ nhìn đời mà viết. Tác giả sống với nó rồi mới viết nó. Nhân vật trung tâm Pavel chính là tác giả: Nicolai A. Ostrovsky. Là một chiến sĩ cách mạng tháng Mười, ông đã sống một cách nồng cháy nhất, như nhân vật Pavel của ông. Cũng không phải một cuốn tiểu thuyết tự thuật thường vì hứng thú hay lợi ích cá nhân mà viết. Ostrovsky viết Thép đã tôi thế đấy! trên giường bệnh, trong khi bại liệt và mù, bệnh tật tàn phá chín phần mười cơ thể. Chưa bao giờ có một nhà văn sáng tác trong những điều kiện gian khổ như vậy. Trong lòng người viết phải có một nhiệt độ cảm hứng nồng nàn không biết bao nhiêu mà kể. Nguồn cảm hứng ấy là sức mạnh tinh thần của người chiến sĩ cách mạng bị tàn phế, đau đớn đến cùng cực, không chịu nằm đợi chết, không thể chịu được xa rời chiến đấu, do đó phấn đấu trở thành một nhà văn và viết nên cuốn sách này. Càng yêu cuốn sách, càng kính trọng nhà văn, càng tôn quí phẩm chất của con người cách mạng.

Thép đã tôi thế đấy! có một địa vị đặc biệt trong lịch sử văn học Liên Xô và nền văn học tiên tiến thế giới. Cách mạng tháng Mười thắng lợi, cuộc chiến đấu vĩ đại chưa từng có bao giờ của nhân dân lao động trên một dải đất Liên bang Xô Viết rộng lớn hàng ngày đề ra và đòi hỏi không biết bao nhiêu là anh hùng. Nhân dân Liên Xô, nhân loại tiến bộ chờ đợi văn học phản ánh và đào sâu cho mình hình ảnh con người anh hùng mới ấy. Lần đầu tiên trong văn học, Ostrovsky thu gọn được hình ảnh con người mới trong nhân vật Pavel. Pavel không những khác hẳn với những anh hùng của các thời đại trước. Khác hẳn với những tác phẩm văn nghệ của những năm đầu cách mạng, thường ca ngợi lòng dũng cảm vô tổ chức, tả sức mạnh tràn trề, lớn khỏe của quầnchúng như một sức mạnh bột phát, tự nhiên. Thép đã tôi thế đấy! cho ta thấy từng con người trong một quần chúng rộng lớn nẩy nở như thế nào, dưới sự lãnh đạo của Đảng cộng sản. Thép đã tôi thế đấy! ghi lại cả một quá trình tôi thép, bước đường gian khổ trưởng thành của thế hệ thanh niên Xô viết đầu tiên.')
--43
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786046989233',N'Nhật Ký Của Một Người Thừa','P1','C2',43,N'Ivan Turcenev',82000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_7073.jpg',100,1,N'Tập truyện "Nhật ký của một con người thừa" gồm 5 truyện ngắn và truyện vừa: "Nhật ký của một con người thừa", "Ba bức chân dung", "Mumu", "Giấc mơ" và "Bài ca tình yêu chiến thắng". Trong đó "Nhật ký của một con người thừa", "Ba bức chân dung", "Mumu" thuộc mảng đề tài quen thuộc trong sáng tác của Turgenev mà độc giả Việt Nam từng biết đến qua "Bút ký người đi săn", "Mối tình đầu", "Đêm trước", "Cha và con" những câu chuyện tình yêu với kết thúc buồn, những con người có trí tuệ nhưng đáng tiếc là đã sống hoài, sống phí, những cuộc đời nông nô nhiều đắng cay và nước mắt,…; Còn ở "Giấc mơ", "Bài ca tình yêu chiến thắng" với nội dung hoang đường khác lạ cho thấy một phương diện khác trong cuộc kiếm tìm nghệ thuật của nhà văn giai đoạn cuối đời. Trong "Nhật ký của một con người thừa", Ivan Turgenev đã khắc họa trạng thái tâm lý - xã hội đặc biệt của nhân vật chính, mà sau này sẽ được giới phê bình sử dụng nhằm nói về một dạng nhân vật tiêu biểu không chỉ trong sáng tác Turgenev.

Trulkaturin trong "Nhật ký của một con người thừa" là sự tiếp nối với đường nét rõ hơn cho các bức phác thảo về kiểu nhân vật này trong một số tác phẩm trước đó của Turgenev, như "Steno" (1834), "Andrei Kolosov" (1844), "Hamlet huyện Sigrovsky" (1849) và một số truyện ngắn khác trong "Bút ký người đi săn". Turgenev khẳng định một trạng thái tinh thần phổ biến của xã hội quý tộc Nga thời đại đó, trạng thái của những con người có tâm hồn già trước tuổi, ưa mổ xẻ tâm tư của chính mình. Họ có thể khác biệt với đại bộ phận thanh niên quý tộc cùng thời, nhưng cũng không thể trở thành “anh hùng thời đại”. Họ bất lực lùi bước trước số phận ngay ở chỗ đáng lý cần nhiều nhất sự kiên định và quyết đoán, mải tranh cãi luận bàn vào những thời điểm đáng ra cần hành động nhất. Turgenev đã tinh tường bắt lấy ở các nhân vật đau khổ ấy những triệu chứng của “căn bệnh” đã bén rễ trong xã hội, “căn bệnh” của những con người loay hoay tìm kiếm nhưng không sao định vị được chỗ đứng của mình trong cộng đồng xã hội.')
--44
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786049699580',N'Những Câu Chuyện Về Khu Phố Nhỏ Ven Sông','P1','C2',44,N'Jan Neruda',115000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2351.jpg',100,1,N'“Những câu chuyện về khu phố nhỏ ven sông” (Povídky malostranské) từ lâu đã trở thành một bộ phận của truyền thuyết về Praha, trở thành một phần quen thuộc trong chương trình của điểm đến du lịch hấp dẫn. Các nhân vật và tích truyện của Neruda được đặt vào các địa điểm trên bản đồ thành phố. Có thể nói, hầu như trong tâm hồn người Séc nào cũng vang tiếng vọng của Những câu chuyện về khu phố nhỏ ven sông cả qua tên gọi của một bến tàu điện ngầm. Đó là bến tàu điện ngầm mang tên Malostranská, được đặt bên dưới một trong những dinh thự kiểu Baroque trên địa phận khu phố Malá Strana.
 
“Những câu chuyện về khu phố nhỏ ven sông” không chỉ gợi lại cái nhớ nhung man mác về một thế giới xa xưa và tốt đẹp đã qua, mà còn gợi lên một cuộc sống đầy nghịch lý thô bạo, còn nói về cái tàn nhẫn nhật thường, về sự ích kỉ và đồng thời cả về lòng cảm thông của con người. Các truyện có khi không có tích truyện rõ ràng, chúng nhấp nháy như từng hình ảnh nối tiếp nhau của cuốn phim về cuộc đời. Con mắt nhà báo của Neruda nhìn thấy hết từng chi tiết nhỏ và để ý đến những hành động cư xử bình thường mà - dưới góc độ không muốn lý tưởng hóa, cũng không đánh giá - có thể biểu hiện như những hành động cư xử thô bạo, lạ lùng và kì dị. Nhà văn và nhà báo Neruda không hề có ảo tưởng về mọi người, nhưng đã bị quyến rũ bởi những gì có thể xảy ra trong quan hệ của họ, bởi những điều không ngờ tới trong cư xử của họ. Neruda không đánh giá và cũng không giải thích - ông chỉ ghi chép lại, và có thể vì thế mà ông vẫn luôn luôn là người của hiện tại, đồng thời sáng tác của ông không chỉ gắn liền với Praha. Độc giả nào cũng có lần biết cái lạ lùng của cuộc sống bình thường. Những câu chuyện kì dị của hàng xóm láng giềng thường là bộ phận của cuộc sống chung giữa các thành viên của các cộng đồng, bất kể những cộng đồng ấy sống tại trung tâm châu Âu, hay một nơi nào đó ở châu Á.
 
 "Những câu chuyện về khu phố nhỏ ven sông" mang trong mình con mắt nhìn hai chiều về sự sống và cái chết, niềm vui và nỗi đau, về sự nhẫn tâm và lòng thương cảm, cái thờ ơ và sự sẻ chia, hồi ức ngây thơ của đứa trẻ và con mắt tinh tường của nhà báo. Đó là nhà báo muốn nhìn thấy những người dân chất phác, nghèo khó, không địa vị của thành phố mình, muốn viết về những cái bình thường có thật của cuộc sống, kể cả khi những cái đó không phải là điều dễ chịu. Khuynh hướng hiện thực và sự thiếu thốn về chủ nghĩa lý tưởng trong sáng tác làm giới phê bình thời đó phần nào có chỉ trích Neruda. Khi xuất bản "Những câu chuyện về khu phố nhỏ ven sông" (1878), ông đã muốn phản ứng lại sự phê bình đó và tự bình luận tác phẩm của mình một cách hài hước trong tiểu phẩm đăng ở nhật báo Dân tộc như sau: “Neruda chỉ viết về tầng lớp dưới, về tầng lớp xã hội, nơi mà tình cảm không bao giờ được thể hiện nhẹ nhàng và sự thật vẫn còn có giá trị hơn cái dối trá, cho dù nó có khôn khéo đến đâu... Các ý tưởng trong Những câu chuyện về khu phố nhỏ ven sông gập ghềnh nhấp nhô như con đường lát đá ở Constantinople, tản mạn phân tán như con chó con nhắng nhít, gai góc hung dữ như kẻ đi thu thuế...” Cái hương vị ngọt đắng trong mô tả hiện thực về con người ở Malá Strana cũng được thể hiện trong cách sử dụng ngôn ngữ.
 
Trong văn học truyền thống Séc, Neruda được coi là người đưa thứ tiếng Séc “không tắm rửa, không chải chuốt, từ đường phố” vào ngôn ngữ văn học, theo lời của F.X. Šalda, một trong những nhà lý luận và phê bình nổi tiếng nhất của văn học Séc hiện đại. Nhờ Neruda mà tiếng Séc phổ thông được đưa vào văn học. Nhưng ngôn ngữ trong Những câu chuyện về khu phố nhỏ ven sông không chỉ là tiếng Séc dân gian, mà ngược lại. Theo một chuyên gia về sáng tác của Neruda, thì Neruda cũng là người triệt để giữ gìn sự trong sáng của tiếng Séc. Ông là người cố gắng tạo ra một phong cách viết đặc biệt nhằm đưa tiếng Séc tách xa tiếng Đức hơn, bởi trong thế kỉ 19, ngay cả ở Séc, tiếng Đức là ngôn ngữ chiếm ưu thế về mặt văn hóa và có truyền thống văn học phong phú hơn, mạnh hơn nhiều. Mục đích là để giới thiệu tiếng Séc như một ngôn ngữ có nhiều mức độ, phong phú về khả năng diễn đạt, là ngôn ngữ sinh động sâu sắc, giàu tính biểu cảm, gợi cảm tinh tế, đồng thời là ngôn ngữ đầy nghịch lý. Ở đây, ngôn ngữ không chỉ là phương tiện chuyển tải tích truyện, mà chính bản thân ngôn ngữ là tích truyện của Malá Strana. Vì những điều đó mà Neruda là tác giả của ngày nay, vì những điều đó mà Neruda luôn mang đến cho người đọc nhiều niềm vui và hứng thú, nhưng đồng thời cũng làm cho người dịch sách trăn trở đắn đo bội phần khi chuyển ngữ.
 
Neruda không chỉ là nhà văn, ông còn là nhà thơ quan trọng nhất của thời đại mình. Nền thơ ca Séc không thể đi đến đỉnh cao ở thế kỉ thứ 20, nếu không có những cách tân trong thơ ca của ông. Nền báo chí Séc không thể có phong cách viết riêng trong thể loại tiểu phẩm sắc bén và hóm hỉnh về cuộc sống bình thường, về văn hóa và chính trị, nếu không có phong cách viết báo của ông. Neruda cũng là một trong những người tiêu biểu nhất trong cuộc chiến vì bản sắc dân tộc của văn hóa Séc và vì độc lập về văn hóa trong phạm vi nhà nước quân chủ Áo - Hung đa dân tộc đa ngôn ngữ ngày đó. Những câu chuyện về khu phố nhỏ ven sông vì vậy có thể là cuốn sách hướng dẫn tham quan Praha, là cánh cửa mở dẫn đến nền văn hóa Séc, nói cách khác là dẫn đến cả khu vực. Đến khu vực có một quá khứ vừa tàn bạo vừa lạc quan đầy kịch tính. Đến khu vực có cái vẻ vang trong quá khứ và cái vinh quang mới trong hiện tại, một khu vực bao giờ cũng đẹp, nơi có những con người có tính nết cư xử hoặc cộc cằn, hoặc thân thiện, giống như ở mọi nơi khác trên thế giới.')
--45
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8936071677167',N'Khát Vọng Sống','P1','C1',45,N'Irving Stone',195000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_26263.jpg',100,1,N'Thuật lại quãng đời ngắn ngủi nhưng rực cháy đam mê của Van Gogh, Khát vọng sống được xem là tiểu thuyết tiểu sử thành công nhất về cuộc đời các danh nhân. Tác giả của nó, Irving Stone, vốn là nhà viết kịch, khi lần đầu xem tranh của Van Gogh tại Paris đã gặp phải một trải nghiệm chưa từng có và quyết định viết một cuốn sách về danh họa này “nếu không, sẽ chẳng viết gì khác”. Để thực hiện mong muốn, Stone quay về New York viết báo và dành dụm nhuận bút để lần theo dấu chân của người họa sĩ qua các vùng đất tại Anh, Hà Lan, Bỉ, Pháp, gặp gỡ nhiều người và nghiên cứu hơn 650 thư từ giữa Van Gogh và người em, Theo Van Gogh. Năm 1934, tác phẩm ra đời và lập tức lọt vào danh sách bán chạy. Gây xúc động sâu sắc bởi nỗi cô đơn cùng cực, những khát vọng cùng cực với nghệ thuật, tình yêu và cuộc sống, tác phẩm đã góp phần làm nên danh tiếng bất tử của Van Gogh, người bấy giờ vẫn còn ít được biết đến tại Hoa Kỳ cũng như trên thế giới.')
--46
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786043235272',N'Những Tấm Lòng Cao Cả','P1','C3',46,N'Edmondo De Amicis',86000,'https://cdn0.fahasa.com/media/catalog/product/n/h/nhung_tam_long_cao_ca_tai_ban_2018_1_2019_01_03_02_09_21.jpg',100,1,N'Những tấm lòng cao cả (Cuore) ra đời từ những năm 80 của thế kỷ 19 đã làm cho tên tuổi nhà văn Edmondo De Amicis (1846 - 1908) trở nên nổi tiếng khắp thế giới.

Cho đến nay tác phẩm bất hủ này vẫn vang vọng và để lại dấu ấn đậm nét trong lòng người đọc đặc biệt là các em thiếu nhi ở các thời đại khác nhau.

Đó là một câu chuyện giản dị, với những con người bình thường nhất nhưng nhân cách của họ, mối quan hệ của họ, cùng những tấm lòng cao cả, thánh thiện của họ mãi là những bài học đạo đức sâu sắc và đáng quý.

Một cậu bé ngưòi Ý, Enrico, hằng ngày ghi lại những việc lớn nhỏ diễn ra trong đời học sinh của cậu, những cảm tưởng và suy nghĩ của cậu thành một cuốn nhật ký.')
--47
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786042274036',N'Truyện Ngắn Nguyễn Minh Châu','P9','C1',47,N'Nguyễn Minh Châu',78000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8935244877137.jpg',100,1,N'“Nguyễn Minh Châu thuộc số những nhà văn mở đường tinh anh và tài năng nhất của văn học nước ta hiện nay. Một nhà văn lớn bao giờ cũng nhất thiết là một nhân cách lớn. Và thường vẫn vậy, dường như tạo hóa bao giờ cũng dành cho những con người ấy một số phận rất khắc nghiệt như để mài giũa thêm cho càng sắc sảo và sáng rõ hơn tài năng và nhân cách ấy.” - Nhà văn NGUYÊN NGỌC

“Với ông, nhà văn không có nhiệm vụ nào cao quý hơn là diễn tả cho hết những rung động, những khắc khoải của con người trước đời sống và trong khi đối mặt với các vấn đề xã hội, nhà văn phải nắm bắt bằng được, để rồi diễn tả bằng được những bức xúc, những khao khát của nhân dân.” - Nhà phê bình VƯƠNG TRÍ NHÀN

“Khẳng định cái đẹp, chất thơ của đời sống, nhưng Nguyễn Minh Châu không thi vị hóa cuộc sống, không nhìn cuộc sống một chiều, dễ dãi. Cuối cùng, ông hiểu rằng cuộc sống, bao giờ cũng vậy, có cả ánh sáng và bóng tối, có cả dương và âm, rằng bản chất con người hoàn toàn không đơn giản; mỗi bước đi lên của xã hội, của cuộc sống cực kì chật vật, mâu thuẫn, đầy thăng trầm và nhiều khi rất đau đớn…” - TS. NGUYỄN VĂN HẠNH

“Cái đẹp trong quan niệm của Nguyễn Minh Châu bao giờ cũng ở các dạng hiện hữu, là cái được rút ra từ hiện thực, là cốt lõi tư tưởng của các quan hệ hiện thực, được chuyển hóa trong ý thức nghệ thuật và trở thành cái đẹp mang tính tư tưởng thẩm mĩ. Phải nói, càng ngày cái đẹp trong những tác phẩm của Nguyễn Minh Châu càng biện chứng.” - Nhà phê bình LÊ THÀNH NGHỊ

Nhằm giúp các bạn học sinh có một nền tảng kiến thức văn học phong phú, vững vàng, Nhà xuất bản Kim Đồng tổ chức biên soạn bộ sách Tủ sách Văn học trong nhà trường.

Bộ sách sẽ lần lượt giới thiệu tác phẩm của các tác giả thuộc nhiều trào lưu, thể loại, thời kì

Ngoài giá trị tư liệu học tập, hi vọng bộ sách còn giúp bồi dưỡng thêm tình yêu văn học, khích lệ tư duy sáng tạo giúp người đọc có được cho mình những nhận định khách quan và hợp lí.')
--48
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786042270823',N'Lớn Rồi Hết Sợ','P9','C1',48,N'Hồ Anh Thái',110000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8935244876321.jpg',100,1,N'“Trong cuốn sách này, tôi chia sẻ một ít kỉ niệm đã xa, ngoảnh lại nhìn qua màn sương ký ức để thấy lại mình thời thơ bé. Khi còn nhỏ, tôi từng sợ rất nhiều thứ, nhưng tôi lớn lên không còn sợ đám đông, không sợ bóng tối, không còn sợ độ cao.” – Nhà văn Hồ Anh Thái.

“Cuốn sách tái hiện quãng đời từ lúc niên thiếu cho đến khi trưởng thành của nhà văn. Tất cả đều được nhà văn kể bằng một giọng văn dí dỏm và hài hước. Khác với văn phong sâu lắng, giàu triết lý, pha chút giễu nhại mà người đọc vẫn quen thuộc lâu nay ở Hồ Anh Thái.” -

“Đọc mấy trang rồi gấp sách lại, ngẩn ngơ một lát. Rồi lại đọc tiếp. Và một mình thú vị một mình. Chuyện của Hồ Anh Thái, kém tôi đến hai giáp mà sao đọc xong lại rưng rưng đến ứa nước mắt. Mà sao lại thấy hiển hiện lên tất cả những gì mình đã trải qua, tất cả những gì một con người đã trải qua, tinh tế và thiết tha quá.” - Nhà văn MA VĂN KHÁNG

“Hồ Anh Thái là người viết hồi ký thông minh, biết kể như thế nào là đủ. Nhà văn đã dùng chính ngòi bút của mình để kể chuyện đời mình, bằng một giọng văn trong trẻo, hồn nhiên và dí dỏm.” Nhà phê bình văn học NGUYỄN THỊ MINH THÁI

Nhà văn HỒ ANH THÁI đã xuất bản gần năm mươi cuốn sách thuộc nhiều thể loại, sách đã được dịch ra hơn mười thứ tiếng, ấn hành ở nhiều nước. Tham dự nhiều sự kiện nhà văn quốc tế và ngồi sáng tác ở các trại viết nước ngoài. Được bầu là Chủ tịch Hội Nhà văn Hà Nội hai nhiệm kỳ.

Nhà ngoại giao, từng đi qua nhiều lục địa, được bổ nhiệm công tác ở Đại sứ quán Việt Nam tại một số nước.

Thỉnh giảng ở Đại học Washington và nhiều đại học nước ngoài.

“Người đọc thấy một Hồ Anh Thái vừa quen vừa lạ. Quen ở tầm văn hóa và giọng điệu trào lộng vốn là một thế mạnh của nhà văn. Lạ ở cuốn sách này khi gặp một Hồ Anh Thái trong sáng, dễ thương với những hồi ức về gia đình và tuổi thơ, qua đôi mắt của một người để dựng lại không khí của cả một thời bao cấp khó khăn, thiếu thốn nhưng cũng rất đẹp và đáng yêu, đáng nhớ.” Nhà nghiên cứu văn học LƯU KHÁNH THƠ.')
--49
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786042272049',N'Đoàn Binh Tây Tiến','P9','C1',49,N'Quang Dũng',45000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8935244872545.jpg',100,1,N'Có một “Tây Tiến” trong thơ và cũng có một “Tây Tiến” trong văn. Đó chính là những gì chứa đựng trong cuốn sách này!
Cảm xúc về một thời “Chiến trường đi chẳng tiếc đời xanh” của nhà thơ Quang Dũng trong bài thơ Tây Tiến dường như chưa đủ với ông. Tấm lòng thiết tha của tác giả những ngày hào hùng ấy đã dẫn đến thiên hồi ký “Đoàn Võ trang Tuyên truyền Biên khu Lào - Việt” (Đoàn binh Tây Tiến) ông viết mấy năm sau. Hơn là một phiên bản văn xuôi của bài thơ, tập hồi ký cho chúng ta biết thêm nhiều điều cụ thể về hoạt động của binh đoàn khi ấy, cũng như về các chiến sĩ Việt - Lào, những người cầm súng và cả những người cầm kèn trong Đoàn Võ trang Tuyên truyền cùng tham gia vào sứ mạng giải phóng đất nước mình và nước bạn khỏi ách thực dân xâm lược…
Sau gần bảy mươi năm, tập hồi ký của nhà thơ - chiến sĩ Quang Dũng về binh đoàn Tây Tiến năm xưa giờ đã trở thành những tư liệu văn nghệ và lịch sử vô giá, đóng góp vào di sản văn nghệ kháng chiến nước nhà.')
--50
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('9786042272704',N'Ngọn Cờ Lau','P9','C1',50,N'Tô Hoài và Nguyễn Hồng Anh',90000,'https://cdn0.fahasa.com/media/catalog/product/8/9/8935244873771.jpg',100,1,N'“Bộ Lĩnh mồ côi cha từ thuở nhỏ. Quan Thứ sử châu Hoan là Đinh Công Trứ − người sinh ra Bộ Lĩnh − mất đi, thì Bộ Lĩnh theo mẹ là Đàm Thị về Đại Hoàng ở với ông ngoại là Đàm Viên Ngoại. Cho đến năm Bộ Lĩnh lên mười hai tuổi thì Đàm Viên Ngoại cũng mất. Hai mẹ con phải đem nhau về Đại Hữu là quê hương của ông Đinh Công Trứ.”

Mời các em cùng đọc truyện để xem cậu bé mồ côi Đinh Bộ Lĩnh khi xưa đã trải qua những năm tháng ấu thơ ra sao mà sau lại trở thành vị hoàng đế khai sáng triều đại nhà Đinh trong lịch sử nước nhà nhé!')
--51
INSERT INTO [tblBook](ISBN,Name,publisherID,categoryID,reviewID,[Author-name],Price,[Image],Quantity,[Status],[Description])
VALUES ('8935212352895',N'Thượng Dương','P6','C3',51,N'Hoàng Yến',108000,'https://cdn0.fahasa.com/media/catalog/product/i/m/image_216250.jpg',100,1,N'Thượng Dương là cuốn tiểu thuyết lãng mạn được hư cấu dựa trên lịch sử. Bởi vậy, không phải tất cả những con người, địa danh và sự kiện trong này đều là thật. Hãy tạm thời gác lại lòng tôn sùng lịch sử, hãy tạm thời gạt bỏ lý trí và quan điểm cá nhân, hãy để tôi dẫn dắt bạn đi xuyên qua màn sương và bước vào câu chuyện mà cá nhân tôi tin là đã từng tồn tại. Những thật giả, thực hư sẽ được bật mí ngay sau khi bạn đã thưởng thức trọn vẹn cuốn sách này.

Lấy cảm hứng từ thảm án Thượng Dương cung, tiểu thuyết Thượng Dương sẽ lật mở bức màn bí ẩn che phủ lên cuộc đời vị Hoàng hậu bất hạnh nhất trong lịch sử Việt Nam. Theo sử sách, Dương Hoàng hậu không có con cái. Sau khi vua Lý Thánh Tông băng hà, bà trở thành Thái hậu nhiếp chính, giúp vua Nhân Tông trị quốc. Cuối cùng, bà bị Thái hậu Linh Nhân lật đổ và ép phải tuẫn táng cùng tiên đế. Vậy nhưng sự thật liệu có tàn nhẫn như sử sách?

“Này, nàng vừa cầu gì vậy?

Ta cầu mong được cùng người mình yêu bên nhau trọn một đời.

Còn ta, lại chỉ cầu nàng ấy trọn đời bình an!”

Thăng Long năm ấy có một mỹ nhân

Nhưng lại chẳng muốn khuynh thành.')

--Insert data for tblOrderDetail
INSERT INTO [tblOrderDetail](orderID,ISBN,Name,publisherID,categoryID,Price,Quantity,Total,[Status])
VALUES ('1','9786049549090',N'Lục Vân Tiên','P1','C1',235000,1,235000,1)

--Insert data for tblBookRequest
INSERT INTO [tblBookRequest](staffID,[Date],[Status],[Delete])
VALUES ('st1','2022-09-14',1,0)

--Insert data for tblBRequestDetail
INSERT INTO tblBRequestDetail(ISBN,requestID,publisherID,categoryID,Name,[Author-name],Quantity,[Status],[Delete])
VALUES ('9786049549090','1','P1','C1',N'Lục Vân Tiên',N'Nguyễn Đình Chiểu',10,1,0)

--Insert data for tblBookResponse
INSERT INTO tblBookResponse(requestID,staffID,[Date],[Status],[Delete])
VALUES ('1','st1','2022-09-14',1,0)

--Insert data for tblBResponseDetail
INSERT INTO tblBResponseDetail(ISBN,responseID,publisherID,categoryID,Name,[Author-name],Quantity,Price,[Status],[Delete])
VALUES ('9786049549090','1','P1','C1',N'Lục Vân Tiên',N'Nguyễn Đình Chiểu',10,200000,1,0)

CREATE FUNCTION [dbo].[ufn_removeMark] (@text nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
    SET @text = LOWER(@text)
    DECLARE @textLen int = LEN(@text)
    IF @textLen > 0
    BEGIN
        DECLARE @index int = 1
        DECLARE @lPos int
        DECLARE @SIGN_CHARS nvarchar(100) = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýđð'
        DECLARE @UNSIGN_CHARS varchar(100) = 'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyydd'
 
        WHILE @index <= @textLen
        BEGIN
            SET @lPos = CHARINDEX(SUBSTRING(@text,@index,1),@SIGN_CHARS)
            IF @lPos > 0
            BEGIN
                SET @text = STUFF(@text,@index,1,SUBSTRING(@UNSIGN_CHARS,@lPos,1))
            END
            SET @index = @index + 1
        END
    END
    RETURN @text
END