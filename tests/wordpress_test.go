package test

import (
	"fmt"
	"os"
    "os/exec"
    "strings"
    "testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/stretchr/testify/assert"
)

func getAlbDns(t *testing.T) string {
	cmd := exec.Command("terraform", "output", "alb_dns_name")
	outputBytes, err := cmd.CombinedOutput()
	if err != nil {
		t.Fatalf("Failed to get alb_dns_name: %s\nOutput: %s", err, string(outputBytes))
	}
	output := strings.TrimSpace(string(outputBytes))
	output = strings.Trim(output, "\"")
	return output
}

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

	// Initialize and apply
	fmt.Println("Running terraform init and apply")
	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	// Get ALB Public DNS output
	fmt.Println("Getting ALB DNS output")
	albDNS := getAlbDns(t)
	url := fmt.Sprintf("http://%s", albDNS)
	fmt.Printf("ALB URL: %s\n", url)


	// Give app time to fully boot
	fmt.Println("Waiting for WordPress to be up and responding with HTTP 200 + body check")
	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		url,
		nil,
		10,                 // Max retries
		10,                 // Wait between retries
		func(statusCode int, body string) bool {
			return statusCode == 200 && strings.Contains(body, "WordPress")
		},
	)

	// Optional final check for 200
	fmt.Println("Final check: HTTP 200 response from ALB")
	statusCode, _, err := http_helper.HttpGetE(t, url, nil)
    assert.NoError(t, err)
    assert.Equal(t, 200, statusCode)

	fmt.Println("Test complete: WordPress is up and running")
}