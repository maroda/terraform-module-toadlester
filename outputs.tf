output "bucket_name" {
  description = "Ephemeral application data"
  value = aws_s3_bucket.appdata.id
}

output "certificate" {
  description = "Domain holding the TLS cert"
  value = data.dnsimple_certificate.apexcert.domain
}

output "www-cname" {
  description = "Endpoint CNAME for www service"
  value = dnsimple_zone_record.www.value
}

output "app_lb_dns" {
  description = "ToadLester load balancer endpoint"
  value = aws_lb.applb.dns_name
}

output "qnet_lb_dns" {
  description = "Monteverdi load balancer endpoint"
  value = aws_lb.qnetlb.dns_name
}