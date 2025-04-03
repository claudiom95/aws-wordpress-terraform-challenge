package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/stretchr/testify/assert"
)

func TestWordPressDeployment(t *testing.T) {
	t.Parallel()

	fmt.Println("Setting up Terraform options")
	terraformOptions := &terraform.Options{
		TerraformDir: "../",

		Vars: map[string]interface{}{
			"db_password_blue":  os.Getenv("TF_VAR_db_password_blue"),
			"db_password_green": os.Getenv("TF_VAR_db_password_green"),
		},

		NoColor: true,
	}

	fmt.Println("Running terraform init and apply")
	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	fmt.Println("Getting ALB DNS output")
	albDNS := terraform.Output(t, terraformOptions, "alb_dns_name")
	url := "http://" + albDNS
	fmt.Printf("ALB URL: %s\n", url)

	fmt.Println("Waiting for WordPress to be up and responding with HTTP 200 + body check")
	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		url,
		nil,
		10, // retries
		10, // seconds between retries
		func(statusCode int, body string) bool {
			return statusCode == 200 && strings.Contains(body, "WordPress")
		},
	)

	fmt.Println("Final check: HTTP 200 response from ALB")
	statusCode, _, err := http_helper.HttpGetE(t, url, nil)
	assert.NoError(t, err)
	assert.Equal(t, 200, statusCode)

	fmt.Println("Test complete: WordPress is up and running")
}