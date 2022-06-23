output "vpc" {
  value = aws_vpc.main
}

// Returns a list of subnet IDs
output "public_subnets" {
  value = [for subnet in aws_subnet.public: subnet.id]
}

output "private_subnets" {
  value = [for subnet in aws_subnet.private: subnet.id]
}
