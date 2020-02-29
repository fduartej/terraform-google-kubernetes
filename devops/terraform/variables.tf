## Reemplazar el ID de proyecto en la cual se realizará
## el despliegue.

variable "project_id" {
    default = "xyz-company"
}

variable "service_account_credentials" {
    default = "credentials.json"
}

variable "vpc_dev" {
    type    = "map"
    default = {
        "name"        = "vpcdev01"
        "description" = "Red de Ambiente de Desarrollo"    
    }    
}
variable "vpc_prd" {
    type    = "map"
    default = {
        "name"        = "vpcprd01"
        "description" = "Red de Ambiente de Producción"    
    }    
}
variable "subnet_dev" {
    type    = "map"
    default = {    
        "name"        = "snetuse1dev01"
        "description" = "Subnet de Desarrollo"
        "iprange"     = "10.242.2.0/23"
        "region"      = "us-east1"
    }
}
variable "subnet_prd" {
    type    = "map"
    default = {    
        "name"        = "snetuse1prd01"
        "description" = "Subnet de Producción"
        "iprange"     = "10.242.10.0/23"
        "region"      = "us-east1"
    }
}

variable "gke_dev" {
    type = "map"
    default = {
        "name"         = "keuse1dev01"
        "location"     = "us-east1-b"
        "podsrange"    = "10.242.64.0/20"
        "servicerange" = "10.242.80.0/20"
    }
}

variable "gke_prd" {
    type = "map"
    default = {
        "name"         = "keuse1prd01"
        "location"     = "us-east1"
        "podsrange"    = "10.242.128.0/20"
        "servicerange" = "10.242.144.0/20"
    }
}

variable "node_pool_dev" {
    type = "map"
    default = {
        "name"         = "node-pool-dev"
        "location"     = "us-east1-b"
        "nodecount"    = "1"
        "machinetype"  = "n1-standard-1"
        "disktype"     = "pd-standard"
        "disksize"     = 50
    }
} 

variable "node_pool_prd" {
    type = "map"
    default = {
        "name"         = "node-pool-prd"
        "location"     = "us-east1"
        "nodecount"    = "1"
        "machinetype"  = "n1-standard-2"
        "disktype"     = "pd-ssd"
        "disksize"     = 50
    }
}

variable "cloudsql_dev" {
    type = "map"
    default = {
        "name"      = "sqluse1dev01"
        "version"   = "MYSQL_5_7"
        "region"    = "us-east1"
        "disktype"  = "PD_SSD"
        "disksize"  = 50
        "tier"      = "db-n1-standard-1"
    }
}

variable "cloudsql_prd" {
    type = "map"
    default = {
        "name"      = "sqluse1prd01"
        "version"   = "MYSQL_5_7"
        "region"    = "us-east1"
        "disktype"  = "PD_SSD"
        "disksize"  = 100
        "tier"      = "db-n1-standard-1" 
    }
}

variable "cloudsql_dev_user" {
    type = "map"
    default = {
        "name"      = "root"
        "password"  = "abc"
    }
}

variable "cloudsql_prd_user" {
    type = "map"
    default = {
        "name"      = "root"
        "password"  = "abc"
    }
}

variable "storage_dev" {
    type = "map"
    default = {
        "name" = "vedigitalstorusdev01"
        "location" = "US"
        "storageclass" = "STANDARD"
    }  
}

variable "storage_prd" {
    type = "map"
    default = {
        "name" = "vedigitalstorusprd01"
        "location" = "US"
        "storageclass" = "STANDARD"
    }  
}
