provider "toadlester" {
  // base_url = "http://${aws_lb.applb.dns_name}:${var.port}"
  base_url = "http://${dnsimple_zone_record.toadlester.qualified_name}:${var.port}"
}

// Data //

// Always check the current config endpoint after resources have been applied.
// This ensures the output reports the actual current configuration.
data "toadlester_type" "current" {
  depends_on = [toadlester.exp-limit, toadlester.exp-mod, toadlester.exp-size, toadlester.exp-tail,
    toadlester.float-limit, toadlester.float-mod, toadlester.float-size, toadlester.float-tail,
    toadlester.int-limit, toadlester.int-mod, toadlester.int-size, toadlester.int-tail]
}

// Resources //

// Integer, Float, and Exponential settings for Limit, Mod, Size, and Tail.
// When running this alongside the deployment of ToadLester itself:
// each resource must use a `depends_on` so the settings are created last,
// (after the service is running with a load balancer) and destroyed first.

// Integer Loop //
// Integer range Limit
resource "toadlester" "int-limit" {
  depends_on = [aws_lb.applb]
  name  = "INT_LIMIT"
  value = var.tl_int_limit
  algo  = "up"
}

// Integer Limit Modifier
resource "toadlester" "int-mod" {
  depends_on = [aws_lb.applb]
  name  = "INT_MOD"
  value = var.tl_int_mod
  algo  = "up"
}

// Integer loop Size
resource "toadlester" "int-size" {
  depends_on = [aws_lb.applb]
  name  = "INT_SIZE"
  value = var.tl_int_size
  algo  = "up"
}

// Integer Tail is not used
resource "toadlester" "int-tail" {
  depends_on = [aws_lb.applb]
  name  = "INT_TAIL"
  value = "1"
  algo  = "up"
}

// Float Loop //
// Float range Limit
resource "toadlester" "float-limit" {
  depends_on = [aws_lb.applb]
  name  = "FLOAT_LIMIT"
  value = var.tl_float_limit
  algo  = "up"
}

// Float Limit Modifier
resource "toadlester" "float-mod" {
  depends_on = [aws_lb.applb]
  name  = "FLOAT_MOD"
  value = var.tl_float_mod
  algo  = "up"
}

// Float loop Size
resource "toadlester" "float-size" {
  depends_on = [aws_lb.applb]
  name  = "FLOAT_SIZE"
  value = var.tl_float_size
  algo  = "up"
}

// Float decimal Tail
resource "toadlester" "float-tail" {
  depends_on = [aws_lb.applb]
  name  = "FLOAT_TAIL"
  value = var.tl_float_tail
  algo  = "up"
}

// Exponent Loop //
// Exponent range Limit
resource "toadlester" "exp-limit" {
  depends_on = [aws_lb.applb]
  name  = "EXP_LIMIT"
  value = var.tl_exp_limit
  algo  = "up"
}

// Exponent Limit Modifier
resource "toadlester" "exp-mod" {
  depends_on = [aws_lb.applb]
  name  = "EXP_MOD"
  value = var.tl_exp_mod
  algo  = "up"
}

// Exponent loop Size
resource "toadlester" "exp-size" {
  depends_on = [aws_lb.applb]
  name  = "EXP_SIZE"
  value = var.tl_exp_size
  algo  = "up"
}

// Exponent decimal Tail
resource "toadlester" "exp-tail" {
  depends_on = [aws_lb.applb]
  name  = "EXP_TAIL"
  value = var.tl_exp_tail
  algo  = "up"
}
