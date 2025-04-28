output "api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = aws_apigatewayv2_api.api.api_endpoint
}

output "stage_url" {
  description = "Default stage invoke URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}
