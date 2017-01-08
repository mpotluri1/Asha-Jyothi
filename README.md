# Asha-Jyothi

This website infrastructure which is basically designed from wordpess

This Architecure has

1 -- VPC
3 -- Public Subnets in three regions
3 -- Private Subnets in three regions
1 -- Internet gateway to route the traffic from outside to instances in public subnets
1 -- NAT Gateway to Route the traffic outbound only from Private subnet instances

Route Tables are configured properly for the routing the traffic.

Note :  This is Base layer of infrastructure which doesnt contain any instance deployments