# Deploy ToadLester with Terraform

Bespoke module to install [ToadLester](https://github.com/maroda/toadlester) alongside [Monteverdi](https://github.com/maroda/monteverdi) in an AWS ECS Fargate cluster using DNSimple for DNS.

## Requirements

This app is configured to run on AWS ECS Fargate using the smallest container size available (cpu=256, memory=512).

The following authentication must be set up for the module to work:

- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` for ECS operations
- `DNSIMPLE_TOKEN` for DNS operations

## Deployment

> _Coming soon: GitHub Actions deployments_

There is no automated process or centralized state yet, so this is currently run locally.

Run `tf plan` to make sure the changes are to your liking, and `tf apply` to make them happen. The result will end up something like this:

```terraform
Apply complete! Resources: 36 added, 0 changed, 0 destroyed.

Outputs:

app_lb_dns = "toadlester-1398318254.us-west-2.elb.amazonaws.com"
bucket_name = "toadlester"
certificate = "rainbowq.net"
qnet_lb_dns = "monteverdi-1982795887.us-west-2.elb.amazonaws.com"
www-cname = "monteverdi-1982795887.us-west-2.elb.amazonaws.com"
```

### ToadLester Settings

See configurations in `toadlester.tf` to make changes using the ToadLester terraform provider.

### Monteverdi Configuration

> _Terraform provider in development_

## Testing
### ToadLester API

Hit the metrics endpoints for ToadLester by using the AWS DNS name (CNAME coming soon):
```shell
$ curl http://toadlester-1398318254.us-west-2.elb.amazonaws.com:8899/rand/all
ExpMetric: 3.0085e+07
FloatMetric: 64409399.6718
IntMetric: 12417998

$ curl http://toadlester-1398318254.us-west-2.elb.amazonaws.com:8899/metrics
Metric_exp_up: 2.3e+00
Metric_exp_down: 1.6e+01
Metric_float_up: 9.5
Metric_float_down: 36.4
Metric_int_up: 5
Metric_int_down: 10

$ curl http://toadlester-1398318254.us-west-2.elb.amazonaws.com:8899/series/int/up
Metric_int_up: 6
```

### Monteverdi Frontend

> Monteverdi is not yet pre-configured to consume ToadLester.

Browse to <https://www.rainbowq.net> for the Monteverdi app.

ToadLester itself has no front-end, it exists only to emit metrics.
These metrics are consumed by [Monteverdi](https://github.com/maroda/monteverdi), which is installed in the same cluster with ToadLester.

When properly configured, Monteverdi will scrape the metrics from ToadLester's endpoints and display the pulse patterns on the front page.
