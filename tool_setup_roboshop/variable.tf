variable tools {
    default = {
        vault = {
            port = 8200
            volume_size = 20
            instance_type = "t3.small"
        }
    }
}

variable "zone_id" {
    default = "Z00485513VTKYH807UIM0"
}

variable "domain_name" {
    default = "sarthak1207.shop"
}