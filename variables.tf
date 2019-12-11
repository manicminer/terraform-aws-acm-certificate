variable "domain_names" {
  description = "List of domains to associate with the new certificate. ACM currently supports up to 10 domains, any or all of which can contain wildcards. The first domain should be the primary domain"
  type        = list(string)
}

variable "zone_id" {
  description = "The Route53 zone ID in which to create validation records"
  default     = ""
}

variable "zone_ids" {
  description = "Map of zone IDs indexed by domain name (when issuing a certificate spanning multiple zones)"
  type        = map(string)
  default = {
    "example.com" = "Z1234567890ABC"
  }
}

