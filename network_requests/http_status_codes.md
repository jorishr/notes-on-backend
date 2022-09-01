# HTTP Request Status Codes
You don't have to memorize the individual codes but do understand the ranges:
```
1xx	
//-> informational: request received/in process

2xx	
//-> success: received, understood, accepted
200	//-> OK
201	//-> OK created

3xx	
// redirect/further action required

4xx
// client side error, request does not hold necessary info
400	//-> bad request
401	//-> unauthorized
404	//-> not found

5xx:	
//-> server side error: failed to fullfil a valid client request
500	//-> internal server error
```