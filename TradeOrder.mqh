bool TradeOrder()
{
bool EURUSD_BAY = true;
bool EURUSD_SELL = true;
bool GBPUSD_BAY = true;
bool GBPUSD_SELL = true;
bool AUDUSD_BAY = true;
bool AUDUSD_SELL = true;
bool EURRUB_BAY = true;
bool EURRUB_SELL = true;
bool USDJPY_BAY = true;
bool USDJPY_SELL = true;
bool USDCHF_BAY = true;
bool USDCHF_SELL = true;
bool USDCAD_BAY = true;
bool USDCAD_SELL = true;
bool i = true;

if(ticketTradeOrder_EURUSD_BAY !=0)
   {i = false;}
if(ticketTradeOrder_EURUSD_SELL !=0)
   {i = false;}
if(ticketTradeOrder_GBPUSD_BAY !=0)
   {i = false;}
if(ticketTradeOrder_GBPUSD_SELL !=0)
   {i = false;}
if(ticketTradeOrder_AUDUSD_BAY !=0)
   {i = false;}
if(ticketTradeOrder_AUDUSD_SELL !=0)
   {i = false;}
if(ticketTradeOrder_EURRUB_BAY !=0)
   {i = false;}
if(ticketTradeOrder_EURRUB_SELL !=0)
   {i = false;}
if(ticketTradeOrder_USDJPY_BAY !=0)
   {i = false;}
if(ticketTradeOrder_USDJPY_SELL !=0)
   {i = false;}
if(ticketTradeOrder_USDCHF_BAY !=0)
   {i = false;}
if(ticketTradeOrder_USDCHF_SELL !=0)
   {i = false;}
if(ticketTradeOrder_USDCAD_BAY !=0)
   {i = false;}
if(ticketTradeOrder_USDCAD_SELL !=0)
   {i = false;}

return(i);
}