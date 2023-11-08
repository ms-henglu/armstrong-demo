# Armstrong Demo

This is a demo repo of the Armstrong for API Test solution. 

Armstrong generates test scenarios based on the swagger specification and the swagger examples. The test scenarios are in Terraform HCL format, which is able to describe a complicated scenario in a simple way.

It contains the following demos:

### 1. automation/stable/2022-08-08:
This is a simple demo. Armstrong generates a valid scenario which covers all the operations. 

### 2. monitor/stable/2022-06-01:
The scenario generated is missing an implicit dependency. When running the test scenario, the test will fail.

The fix is https://github.com/ms-henglu/armstrong-demo/commit/9b573f862c0a632e6e506a07e4772abd4b0063d4#diff-7f1d5bfbf2c71a38f5b34937d78a99ba6ccbf643e44fd22ea83be67d118fb45e

### 3. purview/stable/2021-12-01:
The swagger contains multiple resource types, Armstrong will generate scenarios for each resource type.

The fix is https://github.com/ms-henglu/armstrong-demo/commit/2d4159a7a39565267f903374e9eb9f22468b57c5