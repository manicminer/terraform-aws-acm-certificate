# AWS Certificate Manager (ACM) Terraform module

A Terraform module which requests and validates ACM certificates on AWS, using DNS validation with Route53.

## Usage

```hcl
module "acm_ops" {
  source = "modules/aws_acm_certificate"
  domain_names = ["ops.acme.net", "*.ops.acme.net"]
  zone_id = "${data.aws_route53_zone.external.id}"
}

module "acm_marketing" {
  source = "modules/aws_acm_certificate"
  domain_names = ["acme.com", "*.acme.com"]
  zone_id = "${data.aws_route53_zone.acme.id}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain_names | List of one to ten domain names to associate with the certificate | list | `<list>` | yes |
| zone_id | Route53 zone ID of the zone in which to create validation records | string | `` | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the certificate |

## License

Apache License v2. See [LICENSE](LICENSE).
