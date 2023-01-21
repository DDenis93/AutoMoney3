bool AllTradeOrders()
{
switch(step)
{
case 1:   if(ticketTradeOrder_EURUSD_BAY  != 0)
            return(false); break;
case 2:   if(ticketTradeOrder_EURUSD_SELL != 0)
            return(false); break;
case 3:   if(ticketTradeOrder_GBPUSD_BAY  != 0)
            return(false); break;
case 4:   if(ticketTradeOrder_GBPUSD_SELL != 0)
            return(false); break;
case 5:   if(ticketTradeOrder_AUDUSD_BAY  != 0)
            return(false); break;
case 6:   if(ticketTradeOrder_AUDUSD_SELL != 0)
            return(false); break;
case 7:   if(ticketTradeOrder_NZDUSD_BAY  != 0)
            return(false); break;
case 8:   if(ticketTradeOrder_NZDUSD_SELL != 0)
            return(false); break;
case 9:   if(ticketTradeOrder_USDJPY_BAY  != 0)
            return(false); break;
case 10:  if(ticketTradeOrder_USDJPY_SELL != 0)
            return(false); break;
case 11:  if(ticketTradeOrder_USDCHF_BAY  != 0)
            return(false); break;
case 12:  if(ticketTradeOrder_USDCHF_SELL != 0)
            return(false); break;                                                                                                                           
case 13:  if(ticketTradeOrder_USDCAD_BAY  != 0)
            return(false); break;
case 14:  if(ticketTradeOrder_USDCAD_SELL != 0)
            return(false); break;
}
return(true);
}