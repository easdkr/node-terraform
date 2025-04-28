# API Gateway
resource "aws_apigatewayv2_api" "api" {
  name          = "${var.app_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "app" {
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "http://${var.instance_dns_name}:3000/test"
  integration_method = "ANY" # 모든 HTTP 메서드 허용
}

resource "aws_apigatewayv2_route" "test" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /test"
  target    = "integrations/${aws_apigatewayv2_integration.app.id}"
}
