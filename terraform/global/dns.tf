resource "aws_route53_zone" "darthdataditch" {
  name = "darthdataditch.jftr.info"
}

output "darthdataditch_zone_id" {
  value = aws_route53_zone.darthdataditch.zone_id
}

output "darthdataditch_name_servers" {
  value = aws_route53_zone.darthdataditch.name_servers
}

output "darthdataditch_zone_name" {
  value = aws_route53_zone.darthdataditch.name
}