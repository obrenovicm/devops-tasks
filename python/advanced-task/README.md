Run : python3 server.py to start the server
Endpoints:
GET /menu -> List the menu
POST /order -> Create order
GET /order/{order_id} -> Check order status
DELETE /order/{order_id} -> Cancel order if status is not ready

ADMIN Endpoints:
POST /menu -> Add pizza to the menu
DELETE /admin/menu/{pizza_id} -> Delete pizza from the menu
DELETE /admin/order/{order_id} -> Cancel order regardless of status

Check .sh files for usage on client side.
