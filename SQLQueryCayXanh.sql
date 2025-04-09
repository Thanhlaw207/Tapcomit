CREATE DATABASE QuanLyCayXanhTp;
GO
USE QuanLyCayXanhTp;
GO
-- Bảng MucDoNghiemTrong
CREATE TABLE MucDoNghiemTrong (
    MucDo_ID INT PRIMARY KEY,
    TenMucDo NVARCHAR(100)
);

-- Bảng NguoiDung
CREATE TABLE NguoiDung (
    UserID INT PRIMARY KEY,
    UserName NVARCHAR(100),
    Password NVARCHAR(100),
    Email NVARCHAR(100),
    HoVaTen NVARCHAR(100),
    SDT NVARCHAR(20),
    VaiTro NVARCHAR(50),
    ThoiGianTaoTK DATETIME,
    ThoiGianCapNhat DATETIME
);

-- Bảng LoaiCay
CREATE TABLE LoaiCay (
    SpeciesID INT PRIMARY KEY,
    TenLoai NVARCHAR(100),
    MoTa NVARCHAR(255),
    TanSuatTuoiNuoc INT,
    NhuCauBonPhan NVARCHAR(100),
    NhuCauAnhSang NVARCHAR(100),
    GhiChu NVARCHAR(255)
);

-- Bảng CayXanh
CREATE TABLE CayXanh (
    TreeID INT PRIMARY KEY,
    TenCay NVARCHAR(100),
    SpeciesID INT,
    ChieuCao FLOAT,
    DuongKinh FLOAT,
    ViTri NVARCHAR(255),
    TinhTrangHienTai NVARCHAR(100),
    NgayTrong DATE,
    ThoiGianCapNhat DATETIME,
    FOREIGN KEY (SpeciesID) REFERENCES LoaiCay(SpeciesID)
);

-- Bảng KeHoachChamSoc
CREATE TABLE KeHoachChamSoc (
    PlanID INT PRIMARY KEY,
    ManagerID INT,
    MoTa NVARCHAR(255),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    ThoiGianTaoKeHoach DATETIME,
    FOREIGN KEY (ManagerID) REFERENCES NguoiDung(UserID)
);

-- Bảng NhiemVu
CREATE TABLE NhiemVu (
    TaskID INT PRIMARY KEY,
    TreeID INT,
    EmployeeID INT,
    PlanID INT,
    MoTa NVARCHAR(255),
    NgayGiaoNhiemVu DATE,
    NgayHoanThanh DATE,
    TrangThai NVARCHAR(50),
    GhiChu NVARCHAR(255),
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID),
    FOREIGN KEY (EmployeeID) REFERENCES NguoiDung(UserID),
    FOREIGN KEY (PlanID) REFERENCES KeHoachChamSoc(PlanID)
);

-- Bảng LoaiNhiemVu
CREATE TABLE LoaiNhiemVu (
    TaskTypeID INT PRIMARY KEY,
    TenNhiemVu NVARCHAR(100),
    MoTa NVARCHAR(255)
);

-- Bảng NhiemVu_LoaiNhiemVu
CREATE TABLE NhiemVu_LoaiNhiemVu (
    TaskID INT,
    TaskTypeID INT,
    GhiChu NVARCHAR(255),
    PRIMARY KEY (TaskID, TaskTypeID),
    FOREIGN KEY (TaskID) REFERENCES NhiemVu(TaskID),
    FOREIGN KEY (TaskTypeID) REFERENCES LoaiNhiemVu(TaskTypeID)
);

-- Bảng PhuongAnChamSoc
CREATE TABLE PhuongAnChamSoc (
    ProposalID INT PRIMARY KEY,
    TreeID INT,
    EmployeeID INT,
    PlanID INT,
    MoTa NVARCHAR(255),
    NgayBatDauApDung DATE,
    NgayKetThuc DATE,
    TrangThaiPheDuyet NVARCHAR(50),
    NgayPheDuyet DATE,
    NguoiPheDuyet INT,
    GhiChu NVARCHAR(255),
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID),
    FOREIGN KEY (EmployeeID) REFERENCES NguoiDung(UserID),
    FOREIGN KEY (PlanID) REFERENCES KeHoachChamSoc(PlanID)
);

-- Bảng SuCo
CREATE TABLE SuCo (
    IssueID INT PRIMARY KEY,
    TreeID INT,
    MucDo_ID INT,
    NgayBaoCao DATE,
    TrangThai NVARCHAR(50),
    NgayGiaiQuyet DATE,
    NguoiGiaiQuyet INT,
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID),
    FOREIGN KEY (MucDo_ID) REFERENCES MucDoNghiemTrong(MucDo_ID),
    FOREIGN KEY (NguoiGiaiQuyet) REFERENCES NguoiDung(UserID)
);

-- Bảng SuCo_NguoiDung (nhiều người liên quan)
CREATE TABLE SuCo_NguoiDung (
    IssueID INT,
    EmployeeID INT,
    GhiChu NVARCHAR(255),
    PRIMARY KEY (IssueID, EmployeeID),
    FOREIGN KEY (IssueID) REFERENCES SuCo(IssueID),
    FOREIGN KEY (EmployeeID) REFERENCES NguoiDung(UserID)
);

-- Bảng YeuCauHoTro
CREATE TABLE YeuCauHoTro (
    RequestID INT PRIMARY KEY,
    EmployeeID INT,
    TaskID INT,
    MoTa NVARCHAR(255),
    MucDoUuTien INT,
    NgayYeuCau DATE,
    NgayPheDuyet DATE,
    TrangThaiXuLy NVARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES NguoiDung(UserID),
    FOREIGN KEY (TaskID) REFERENCES NhiemVu(TaskID),
    FOREIGN KEY (MucDoUuTien) REFERENCES MucDoNghiemTrong(MucDo_ID)
);

-- Bảng LichSuTinhTrang
CREATE TABLE LichSuTinhTrang (
    StatusHistoryID INT PRIMARY KEY,
    TreeID INT,
    TinhTrang NVARCHAR(255),
    NgayCapNhat DATE,
    NguoiCapNhat INT,
    GhiChu NVARCHAR(255),
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID),
    FOREIGN KEY (NguoiCapNhat) REFERENCES NguoiDung(UserID)
);

-- Bảng LichSuChamSoc
CREATE TABLE LichSuChamSoc (
    HistoryID INT PRIMARY KEY,
    TreeID INT,
    EmployeeID INT,
    TaskID INT,
    StatusHistoryID INT,
    NgayThucHien DATE,
    ThoiGianThucHien TIME,
    GhiChu NVARCHAR(255),
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID),
    FOREIGN KEY (EmployeeID) REFERENCES NguoiDung(UserID),
    FOREIGN KEY (TaskID) REFERENCES NhiemVu(TaskID),
    FOREIGN KEY (StatusHistoryID) REFERENCES LichSuTinhTrang(StatusHistoryID)
);

-- Bảng ThongBao
CREATE TABLE ThongBao (
    ThongBao_ID INT PRIMARY KEY,
    UserID INT,
    TreeID INT,
    NoiDung NVARCHAR(255),
    LoaiThongBao NVARCHAR(100),
    DoiTuong_ID INT,
    ThoiGianTB DATETIME,
    TrangThaiDoc BIT,
    FOREIGN KEY (UserID) REFERENCES NguoiDung(UserID),
    FOREIGN KEY (TreeID) REFERENCES CayXanh(TreeID)
);
