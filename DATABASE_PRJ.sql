
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1) ,
    Username VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    FullName VARCHAR(100),
    Role VARCHAR(50),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Services (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
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
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100) NOT NULL,
    ManagerID INT,
    Address TEXT,
    EmptyRoom INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1) ,
    DepartmentID INT,
    RoomNumber VARCHAR(50) NOT NULL,
	[Status] [nvarchar](50),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE UserRooms (
    UserRoomID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    RoomID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Bill (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    RoomID INT,
    GuestID INT,
    TotalCost DECIMAL(10,2),
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Users(UserID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
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
    DormServiceID INT PRIMARY KEY IDENTITY(1,1) ,
    DormID INT,
    ServiceID INT,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
	DepartmentID INT,
	FOREIGN KEY ( DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Users ( Username, PasswordHash, Email, FullName, Role, RegistrationDate)
VALUES 
('user1', '1', 'user1@example.com', N'Nguyen Van A', 'User', GETDATE()),
( 'user2', '2', 'user2@example.com', N'Tran Thi B', 'Manager', GETDATE()),
( 'user3', '3', 'user3@example.com', N'Le Van C', 'User', GETDATE()),
( 'user4', '4', 'user4@example.com', N'Pham Thi D', 'User', GETDATE()),
( 'user5', '5', 'user5@example.com', N'Hoang Van E', 'Manager', GETDATE()),
( 'user6', '6', 'user6@example.com', N'Phan Van G', 'Manager', GETDATE()),
( 'user7', '7', 'user7@example.com', N'Ly Thi H', 'Manager', GETDATE()),
( 'user8', '8', 'user8@example.com', N'Pham Thi K', 'Manager', GETDATE());

-- Thêm dữ liệu vào bảng Services
INSERT INTO Services (ServiceName, ServiceDescription, Price)
VALUES 
(N'Internet', N'Cung cap ket noi Internet', 100.00),
(N'Don phong', N'Dich vu don phong', 50.00),
(N'Giat ui', N'Dich vu gia quan ao', 30.00),
(N'Gui xe', N'Dich vu gui xe', 20.00),
(N'Dien', N'Chi phi su dung dien', 200.00);

-- Thêm dữ liệu vào bảng UserServices
INSERT INTO UserServices (UserServiceID, UserID, ServiceID, CreatedDate, Status)
VALUES 
(1, 1, 1, GETDATE(), 'Active'),
(2, 2, 3, GETDATE(), 'Pending'),
(3, 3, 2, GETDATE(), 'Active'),
(4, 4, 4, GETDATE(), 'Cancelled'),
(5, 5, 5, GETDATE(), 'Active');

-- Thêm dữ liệu vào bảng Departments
INSERT INTO Departments (DepartmentName, ManagerID, Address, EmptyRoom, Price)
VALUES 
(N'KTX A', 2, N'123 Duong A, Ha Noi', 5, 500.00),
(N'KTX B', 5, N'456 Duong B, Ha Noi', 3, 600.00),
(N'KTX C', 6, N'789 Duong C, Ha Noi', 1, 700.00),
(N'KTX D', 7, N'101 Duong D, Ha Noi', 3, 800.00),
(N'KTX E', 8, N'202 Duong E, Ha Noi', 2, 900.00);

-- Thêm dữ liệu vào bảng Rooms
INSERT INTO Rooms (DepartmentID, RoomNumber, Status)
VALUES 
(1, '101A', N'Occupied'),
(1, '102A', N'Available'),
(1, '103A', N'Available'),
(1, '104A', N'Available'),
(1, '105A', N'Available'),
(2, '201B', N'Occupied'),
(2, '205B', N'Available'),
(2, '207B', N'Available'),
(3, '301C', N'Available'),
(4, '401D', N'Available'),
(4, '402D', N'Available'),
(4, '404D', N'Available'),
(5, '506D', N'Available'),
(5, '501D', N'Available');

-- Thêm dữ liệu vào bảng UserRooms
INSERT INTO UserRooms (UserID, RoomID, StartDate, EndDate, Status)
VALUES 
(1, 1, '2024-01-01', '2024-06-30', 'Occupied'),
(2, 4, '2024-02-01', '2024-07-31', 'Occupied'),
(3, 3, '2024-03-01', '2024-08-31', 'Reserved'),
(4, 5, '2024-04-01', '2024-09-30', 'Occupied'),
(5, 2, '2024-05-01', '2024-10-31', 'Pending');

-- Thêm dữ liệu vào bảng Bill
INSERT INTO Bill ( RoomID, GuestID, TotalCost, CreateDate, PaymentStatus)
VALUES 
( 1, 1, 500.00, GETDATE(), 'Paid'),
( 2, 2, 600.00, GETDATE(), 'Unpaid'),
( 3, 3, 700.00, GETDATE(), 'Paid'),
( 4, 4, 800.00, GETDATE(), 'Pending'),
( 5, 5, 900.00, GETDATE(), 'Paid');

-- Thêm dữ liệu vào bảng Payment
INSERT INTO Payment (BillID, PaymentDate)
VALUES 
( 1, GETDATE()),
( 3, GETDATE()),
( 5, GETDATE()),
( 4, GETDATE()),
( 2, GETDATE());



-- Thêm dữ liệu vào bảng DormService
INSERT INTO DormService ( DormID, ServiceID, DepartmentID)
VALUES 
( 1, 1, 1),
( 2, 2, 2),
( 3, 3, 3),
( 4, 4, 4),
( 5, 5, 5);
