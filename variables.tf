variable "domain_names" {
  description = "List of domains to associate with the new certificate. ACM currently supports up to 10 domains, any or all of which can contain wildcards. The first domain should be the primary domain"
  type = "list"
}

variable "zone_id" {
  description = "The Route53 zone ID in which to create validation records"
}
