output "vpc" {
  value = aws_default_vpc.default
}

output "subnet" {
  value = {
    public_a  = aws_subnet.public_a
    public_b  = aws_subnet.public_b
    private_a = aws_subnet.private_a
    private_b = aws_subnet.private_b
  }
}

