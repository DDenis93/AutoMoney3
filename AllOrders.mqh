bool AllOrders()
{  
if(AO_ORDERS[0] > 0)
   Print("Пришли в открытый ордер бай");      
if(AO_ORDERS[1] > 0)
   Print("Пришли в открытый ордер селл");
 
return(true);
}