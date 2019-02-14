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
| zone_id | Route53 zone ID of the zone in which to create validation records | string | `` | no |
| zone_ids | Map having domain names as keys, Route53 zone ID as values | string | `` | no |

Either one of `zone_id` or `zone_ids` should be specified. Use `zone_id` when your domain(s) are all contained in a single zone, e.g. for subdomains. Use `zone_ids` when you are issuing a cert for multiple domains served from different zones, e.g. different TLDs.

### Single zone example

```hcl
module "my_acm_certificate" {
  source = "..."
  domain_names = ["foo.net", "*.foo.net"]
  zone_id = "${data.aws_route53_zone.foo_net.zone_id}"
  providers = {
    "aws.acm" = "aws.us-east-1"
    "aws.route53" = "aws.us-east-1"
  }
}
```

### Multi zone example

Note that you'll need to specify a zone ID for each unique domain, including subdomains and wildcards

```hcl
module "my_acm_certificate" {
  source = "..."
  domain_names = ["foo.net", "*.foo.net", "bar.org", "foo.bar.org"]
  zone_ids = {
		"foo.net" = "${data.aws_route53_zone.foo_net.zone_id}"
		"*.foo.net" = "${data.aws_route53_zone.foo_net.zone_id}"
		"bar.org" = "${data.aws_route53_zone.bar_org.zone_id}"
		"foo.bar.org" = "${data.aws_route53_zone.bar_org.zone_id}"
	}
  providers = {
    "aws.acm" = "aws.us-east-1"
    "aws.route53" = "aws.us-east-1"
  }
}
```

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the certificate |

## Known Issues

Due to Terraform insisting on [evaluating both sides of a ternary statement][tf_11574], currently the map lookup for `zone_ids` has a defualt value, so if you omit a domain from this attribute, your plan will pass but you'll get a `NoSuchHostedZone` error when applying. If this happens, you can add the missing domain then re-plan and re-apply safely.

## License

Apache License v2. See [LICENSE](LICENSE).

[tf_11574]: https://github.com/hashicorp/terraform/issues/11574 
