output "bucket_name" {
  description = "Ephemeral application data"
  value = aws_s3_bucket.appdata.id
}

output "certificate" {
  description = "Domain holding the TLS cert"
  value = data.dnsimple_certificate.apexcert.domain
}

output "cname-www" {
  description = "Endpoint CNAME for www service"
  value = dnsimple_zone_record.www.value
}

output "cname-toadlester" {
  description = "Endpoint CNAME for toadlester service"
  value = dnsimple_zone_record.toadlester.value
}

output "monteverdi" {
  description = "FQDN for the Monteverdi GUI"
  value = dnsimple_zone_record.www.qualified_name
}

output "toadlester" {
  description = "FQDN for the ToadLester API"
  value = dnsimple_zone_record.toadlester.qualified_name
}

output "lb_dns_toadlester" {
  description = "ToadLester load balancer endpoint"
  value = aws_lb.applb.dns_name
}

output "lb_dns_monteverdi" {
  description = "Monteverdi load balancer endpoint"
  value = aws_lb.qnetlb.dns_name
}

output "endpoint_toadlester" {
  value = data.toadlester_type.current.endpoint
}

output "current_type_settings" {
  value = data.toadlester_type.current.config
}
