1. Create one application loadbalancer and it should spread across 3 avz's
2. loadbalancer should be in public subnets 
3. Create three servers 1 per avz let say server1,server2,interview in diff subnets 
4. Install apache in each server and when ever we hit individual server it has to says its server name in the browser
	ex: If I hit server1 then it should  say I am server1 and for server2 it should say server2 
	Note: This has to be automated no manual work 
5. Add these servers as target groups to the Loadbalancer 
6. When we hit the loadbalancer with context as /server1 or /server2 or /interview we should get response 
7. Auto register the servers to the route53 private dns with zone name as dvstech.com 
   servers should get resolve their names as server1.dvstech.com,server2.dvstech.com,interview.dvstech.com
   
