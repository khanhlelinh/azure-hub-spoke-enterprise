# KHO LƯU TRỮ DỮ LIỆU ĐA NGÀNH (NẰM TRONG SPOKE 2)

# 1. Cơ sở dữ liệu SQL (Dành cho Kế toán / Nhân sự)
resource "azurerm_mssql_server" "sql_server" {
  name                         = "baoyen-sql-server-prod"
  resource_group_name          = azurerm_resource_group.baoyen_rg.name
  location                     = azurerm_resource_group.baoyen_rg.location
  version                      = "12.0"
  administrator_login          = "baoyensqladmin"
  administrator_login_password = "P@ssw0rd1234!"
}

resource "azurerm_mssql_database" "erp_db" {
  name           = "BaoYen-ERP-DB"
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 500
  sku_name       = "S2"
}

# 2. Data Lake / Kho dữ liệu thô (Dành cho bản vẽ CAD, GPS, Camera xe khách)
resource "azurerm_storage_account" "datalake_storage" {
  name                     = "baoyendatalakeprod"
  resource_group_name      = azurerm_resource_group.baoyen_rg.name
  location                 = azurerm_resource_group.baoyen_rg.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # Phân tán 3 trung tâm dữ liệu chống thảm họa
  
  # Bật tính năng Data Lake Gen 2 (Phân cấp thư mục lớn)
  is_hns_enabled           = true 

  tags = {
    purpose = "Construction CAD and Bus CCTV Storage"
  }
}

# Thùng chứa Bản vẽ Xây dựng
resource "azurerm_storage_container" "cad_container" {
  name                  = "construction-cad-files"
  storage_account_name  = azurerm_storage_account.datalake_storage.name
  container_access_type = "private"
}

# Thùng chứa Dữ liệu Vận tải
resource "azurerm_storage_container" "cctv_container" {
  name                  = "bus-cctv-gps-data"
  storage_account_name  = azurerm_storage_account.datalake_storage.name
  container_access_type = "private"
}
