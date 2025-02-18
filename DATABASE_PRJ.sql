CREATE TABLE Users (
    UserID INT PRIMARY KEY ,
    Username VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    FullName VARCHAR(100),
    Role VARCHAR(50),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Services (
    ServiceID INT PRIMARY KEY ,
    ServiceName VARCHAR(100) NOT NULL,
    ServiceDescription TEXT,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE UserServices (
    UserServiceID INT PRIMARY KEY ,
    UserID INT,
    ServiceID INT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY ,
    DepartmentName VARCHAR(100) NOT NULL,
    ManagerID INT,
    Address TEXT,
    EmptyRoom INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY ,
    DepartmentID INT,
    RoomNumber VARCHAR(50) NOT NULL,
	[Status] [nvarchar](50),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE UserRooms (
    UserRoomID INT PRIMARY KEY,
    UserID INT,
    RoomID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Bill (
    BillID INT PRIMARY KEY,
    RoomID INT,
    GuestID INT,
    TotalCost DECIMAL(10,2),
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Users(UserID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BillID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BillID) REFERENCES Bill(BillID)
);

CREATE TABLE DormImage (
    ImageID INT PRIMARY KEY,
    DormID INT,
    ImageURL TEXT,
	DepartmentID INT,
	FOREIGN KEY ( DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE DormService (
    DormServiceID INT PRIMARY KEY,
    DormID INT,
    ServiceID INT,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
	DepartmentID INT,
	FOREIGN KEY ( DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Users (UserID, Username, PasswordHash, Email, FullName, Role, RegistrationDate)
VALUES 
(1, 'user1', '1', 'user1@example.com', N'Nguyễn Văn A', 'User', GETDATE()),
(2, 'user2', '2', 'user2@example.com', N'Trần Thị B', 'Manager', GETDATE()),
(3, 'user3', '3', 'user3@example.com', N'Lê Văn C', 'User', GETDATE()),
(4, 'user4', '4', 'user4@example.com', N'Phạm Thị D', 'User', GETDATE()),
(5, 'user5', '5', 'user5@example.com', N'Hoàng Văn E', 'Manager', GETDATE());

-- Thêm dữ liệu vào bảng Services
INSERT INTO Services (ServiceID, ServiceName, ServiceDescription, Price)
VALUES 
(1, N'Internet', N'Cung cấp kết nối internet tốc độ cao', 100.00),
(2, N'Dọn phòng', N'Dịch vụ dọn phòng hàng tuần', 50.00),
(3, N'Giặt ủi', N'Dịch vụ giặt quần áo', 30.00),
(4, N'Gửi xe', N'Dịch vụ giữ xe tháng', 20.00),
(5, N'Điện', N'Chi phí sử dụng điện hàng tháng', 200.00);

-- Thêm dữ liệu vào bảng UserServices
INSERT INTO UserServices (UserServiceID, UserID, ServiceID, CreatedDate, Status)
VALUES 
(1, 1, 1, GETDATE(), 'Active'),
(2, 2, 3, GETDATE(), 'Pending'),
(3, 3, 2, GETDATE(), 'Active'),
(4, 4, 4, GETDATE(), 'Cancelled'),
(5, 5, 5, GETDATE(), 'Active');

-- Thêm dữ liệu vào bảng Departments
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Address, EmptyRoom, Price)
VALUES 
(1, 'KTX A', 1, N'123 Đường A, Ha Noi', 10, 500.00),
(2, 'KTX B', 2, N'456 Đường B, Ha Noi', 8, 600.00),
(3, 'KTX C', 3, N'789 Đường C, Ha Noi', 5, 700.00),
(4, 'KTX D', 4, N'101 Đường D, Ha Noi', 3, 800.00),
(5, 'KTX E', 5, N'202 Đường E, Ha Noi', 2, 900.00);

-- Thêm dữ liệu vào bảng Rooms
INSERT INTO Rooms (RoomID, DepartmentID, RoomNumber,Status)
VALUES 
(1, 1, '101A', N'Available'),
(2, 1, '102A', N'Occupied'),
(6, 1, '103A', N'Available'),
(3, 2, '201B', N'Occupied'),
(7, 2, '205B', N'Available'),
(4, 3, '301C',N'Available'),
(5, 4, '401D',N'Available'),
(8, 4, '402D',N'Available'),
(9, 4, '404D',N'Available');

-- Thêm dữ liệu vào bảng UserRooms
INSERT INTO UserRooms (UserRoomID, UserID, RoomID, StartDate, EndDate, Status)
VALUES 
(1, 1, 1, '2024-01-01', '2024-06-30', 'Occupied'),
(2, 2, 2, '2024-02-01', '2024-07-31', 'Occupied'),
(3, 3, 3, '2024-03-01', '2024-08-31', 'Reserved'),
(4, 4, 4, '2024-04-01', '2024-09-30', 'Occupied'),
(5, 5, 5, '2024-05-01', '2024-10-31', 'Pending');

-- Thêm dữ liệu vào bảng Bill
INSERT INTO Bill (BillID, RoomID, GuestID, TotalCost, CreateDate, PaymentStatus)
VALUES 
(1, 1, 1, 500.00, GETDATE(), 'Paid'),
(2, 2, 2, 600.00, GETDATE(), 'Unpaid'),
(3, 3, 3, 700.00, GETDATE(), 'Paid'),
(4, 4, 4, 800.00, GETDATE(), 'Pending'),
(5, 5, 5, 900.00, GETDATE(), 'Paid');

-- Thêm dữ liệu vào bảng Payment
INSERT INTO Payment (PaymentID, BillID, PaymentDate)
VALUES 
(1, 1, GETDATE()),
(2, 3, GETDATE()),
(3, 5, GETDATE()),
(4, 4, GETDATE()),
(5, 2, GETDATE());



-- Thêm dữ liệu vào bảng DormService
INSERT INTO DormService (DormServiceID, DormID, ServiceID, DepartmentID)
VALUES 
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);
