# AWS Certificate Manager (ACM) Terraform module

A Terraform module which requests and validates ACM certificates on AWS, using DNS validation with Route53.

## Usage

```hcl
module "acm_ops" {
  source = "modules/aws_acm_certificate"
  domain_names = ["ops.acme.net", "*.ops.acme.net"]
  zone_id = "${data.aws_route53_zone.external.id}"
  providers = {
    "aws.acm" = "aws",
    "aws.route53" = "aws",
  }
}

module "acm_marketing" {
  source = "modules/aws_acm_certificate"
  domain_names = ["acme.com", "*.acme.com"]
  zone_id = "${data.aws_route53_zone.acme.id}"
  providers = {
    "aws.acm" = "aws.marketing",
    "aws.route53" = "aws.ops",
  }
}
```

## Providers

| Name | Description |
|------|-------------|
| aws.acm | AWS provider to use for issuing the certificate |
| aws.route53 | AWS provider to use for publishing validation records to Route53 |

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
