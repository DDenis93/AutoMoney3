double mAO[];
int hAO;
void AO()
{ 
double PricesMAX_AO[35] = {
  maxAO.XAUUSD,
  maxAO.AUDJPY,
  maxAO.USDJPY,
  maxAO.EURJPY,
  maxAO.CHFJPY,
  maxAO.GBPJPY,
  maxAO.EURRUB,
  maxAO.USDRUB,
  maxAO.XAGUSD,
  maxAO.EURUSD,
  maxAO.GBPUSD,
  maxAO.USDCHF,
  maxAO.NZDUSD,
  maxAO.USDCAD,
  maxAO.AUDUSD,
  maxAO.AUDNZD,
  maxAO.AUDCHF,
  maxAO.GBPNZD,
  maxAO.EURAUD,
  maxAO.EURCAD,
  maxAO.EURGBP,
  maxAO.EURCHF,
  maxAO.EURNZD,
  maxAO.USDSGD,
  maxAO.GBPCAD,
  maxAO.GBPAUD,
  maxAO.EURNOK,
  maxAO.AUDCAD,
  maxAO.GBPCHF,
  maxAO.USDSEK,
  maxAO.USDMXN,
  maxAO.USDNOK,
  maxAO.EURSEK,
  maxAO.USDDKK,
  maxAO.USDZAR
};

double PricesMIN_AO[35] = {
  minAO.XAUUSD,
  minAO.AUDJPY,
  minAO.USDJPY,
  minAO.EURJPY,
  minAO.CHFJPY,
  minAO.GBPJPY,
  minAO.EURRUB,
  minAO.USDRUB,
  minAO.XAGUSD,
  minAO.EURUSD,
  minAO.GBPUSD,
  minAO.USDCHF,
  minAO.NZDUSD,
  minAO.USDCAD,
  minAO.AUDUSD,
  minAO.AUDNZD,
  minAO.AUDCHF,
  minAO.GBPNZD,
  minAO.EURAUD,
  minAO.EURCAD,
  minAO.EURGBP,
  minAO.EURCHF,
  minAO.EURNZD,
  minAO.USDSGD,
  minAO.GBPCAD,
  minAO.GBPAUD,
  minAO.EURNOK,
  minAO.AUDCAD,
  minAO.GBPCHF,
  minAO.USDSEK,
  minAO.USDMXN,
  minAO.USDNOK,
  minAO.EURSEK,
  minAO.USDDKK,
  minAO.USDZAR
};

int ALLorders2 = OrdersTotal();                             // общее количество ОТЛОЖЕННЫХ ордеров
if(ALLorders2 == 0)
{
   ALLorders2 = 1;
   //Print("Нет ордеров - присваиваем значение 1");
}
string ALOrders[];                                          // создаем динамический массив
ArrayResize(ALOrders,ALLorders2);                           // устанавливаем размер массива равным количеству ордеров
//Print("Всего отложенных ордеров = ",ALLorders2);            // 90 к примеру

for(int q=0; q<ALLorders2 ; q++)                            // пробегаем по количеству ордеров
{
   ulong ticket=OrderGetTicket(q);                          // копируем тикет ордера 1
   if(ticket != 0)                                          // ордер успешно скопирован
   {
      string commente = OrderGetString(ORDER_COMMENT);      // достаем из ордера комментарий
      ALOrders[q] = commente;                               // записываем комментарий в динамический массив
      //Print("Есть ордер с комментарием - ",commente);
      
   }                                                        // записали все комментарии и заполнили массив 
   else
   {
      ALOrders[q] = "RANDOM";
      //Print("Нет ордера, присваиваем комментарий RANDOM - ",ALOrders[q]);
   }
} // закрыли цикл заполнения массива коментариями    

for(int i=0;i<34;i++)
{ //Print("Заходим в цикл FOR");
         MqlTradeRequest request3;
         MqlTradeResult result3;
   if(i == AO_NewBar[i])                                    // переходим к анализу сигнала
   {
      hAO = iAO(Symbols[i],PERIOD());
      CopyBuffer(hAO,0,0,6,mAO);
      ArraySetAsSeries(mAO,true);
      if(mAO[1] > mAO[2] &&
         mAO[2] > mAO[3] &&
         mAO[3] > mAO[4] &&
         mAO[4] < mAO[5] &&
      (iHigh(Symbols[i],PERIOD(),0) < iHigh(Symbols[i],PERIOD(),1)))
      {  
         // перебираем отложенные ордера на соответствие комментарию
         bool newOrderAOBuy = true;
         bool activeOrderAOBuy = true;
         for(int Y=0;Y<ALLorders2;Y++)   // если есть сигнал по конкретной валюте
         {
            //Print("Проверяем все отложенные ордера на соответствие комментарию");
            if(ALOrders[Y] == (Symbols[i]+"_AO_BUY"))
            {
               newOrderAOBuy = false;
            }
         }
         // перебираем действующие ордера на соответствие комментарию
         
         int activeBuy=PositionsTotal();
         for(int A=0;A<activeBuy;A++)
         {
            string comentAOactiveBuy = PositionGetString(POSITION_COMMENT);
            if(comentAOactiveBuy == (Symbols[i]+"_AO_BUY"))
            {
               activeOrderAOBuy = false;
            }
         }
            if((newOrderAOBuy == true) && (activeOrderAOBuy == true))
            {
               MqlTradeRequest requestBay={};
               MqlTradeResult resultBay={0};
               requestBay.action = TRADE_ACTION_PENDING;
               requestBay.symbol = Symbols[i]; //+
               requestBay.volume = lot;
               requestBay.type = ORDER_TYPE_BUY_STOP;

               if((i == 0) && (OpenOrderPriceXAUUSD == true)) // XAUUSD .2
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_XAUUSD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_XAUUSD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
     /*          if((i == 1) && (OpenOrderPriceAUDJPY == true)) // AUDJPY .3
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_AUDJPY*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_AUDJPY*Point(),3);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 2) && (OpenOrderPriceUSDJPY == true)) // USDJPY .3
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDJPY*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDJPY*Point(),3);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 3) && (OpenOrderPriceEURJPY == true)) // EURJPY .3
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURJPY*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURJPY*Point(),3);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 4) && (OpenOrderPriceCHFJPY == true)) // CHFJPY .3
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_CHFJPY*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_CHFJPY*Point(),3);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 5) && (OpenOrderPriceGBPJPY == true)) // GBPJPY .3
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPJPY*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPJPY*Point(),3);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 6) && (OpenOrderPriceEURRUB == true)) // EURRUB .4
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURRUB*Point(),4);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURRUB*Point(),4);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 7) && (OpenOrderPriceUSDRUB == true)) // USDRUB .4
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDRUB*Point(),4);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDRUB*Point(),4);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 8) && (OpenOrderPriceXAGUSD == true)) // XAGUSD .4
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_XAGUSD*Point(),4);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_XAGUSD*Point(),4);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 9) && (OpenOrderPriceEURUSD == true)) // EURUSD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURUSD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURUSD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 10) && (OpenOrderPriceGBPUSD == true)) // GBPUSD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPUSD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPUSD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 11) && (OpenOrderPriceUSDCHF == true)) // USDCHF .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDCHF*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDCHF*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 12) && (OpenOrderPriceNZDUSD == true)) // NZDUSD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_NZDUSD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_NZDUSD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 13) && (OpenOrderPriceUSDCAD == true)) // USDCAD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDCAD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDCAD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 14) && (OpenOrderPriceAUDUSD == true)) // AUDUSD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_AUDUSD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_AUDUSD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 15) && (OpenOrderPriceAUDNZD == true)) // AUDNZD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_AUDNZD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_AUDNZD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 16) && (OpenOrderPriceAUDCHF == true)) // AUDCHF .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_AUDCHF*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_AUDCHF*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 17) && (OpenOrderPriceGBPNZD == true)) // GBPNZD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPNZD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPNZD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 18) && (OpenOrderPriceEURAUD == true)) // EURAUD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURAUD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURAUD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 19) && (OpenOrderPriceEURCAD == true)) // EURCAD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURCAD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURCAD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 20) && (OpenOrderPriceEURGBP == true)) // EURGBP .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURGBP*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURGBP*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 21) && (OpenOrderPriceEURCHF == true)) // EURCHF .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURCHF*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURCHF*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 22) && (OpenOrderPriceEURNZD == true)) // EURNZD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURNZD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURNZD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 23) && (OpenOrderPriceUSDSGD == true)) // USDSGD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDSGD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDSGD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 24) && (OpenOrderPriceGBPCAD == true)) // GBPCAD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPCAD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPCAD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 25) && (OpenOrderPriceGBPAUD == true)) // GBPAUD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPAUD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPAUD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 26) && (OpenOrderPriceEURNOK == true)) // EURNOK .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURNOK*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURNOK*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 27) && (OpenOrderPriceAUDCAD == true)) // AUDCAD .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_AUDCAD*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_AUDCAD*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 28) && (OpenOrderPriceGBPCHF == true)) // GBPCHF .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_GBPCHF*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_GBPCHF*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 29) && (OpenOrderPriceUSDSEK == true)) // USDSEK .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDSEK*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDSEK*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 30) && (OpenOrderPriceUSDMXN == true)) // USDMXN .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDMXN*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDMXN*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 31) && (OpenOrderPriceUSDNOK == true)) // USDNOK .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDNOK*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDNOK*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 32) && (OpenOrderPriceEURSEK == true)) // EURSEK .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_EURSEK*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_EURSEK*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 33) && (OpenOrderPriceUSDDKK == true)) // USDDKK .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDDKK*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDDKK*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
               if((i == 34) && (OpenOrderPriceUSDZAR == true)) // USDZAR .5
               {
                  requestBay.price = NormalizeDouble(PricesMAX_AO[i]+OP_USDZAR*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesMIN_AO[i]-SL_USDZAR*Point(),5);
                  requestBay.comment = Symbols[i] + "_AO_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY AO 0 ", Symbols[i]+"_AO_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_BUY - ",resultBay.order);
                  }
               }
     */       }//else если ктакого комментария нет, то переходим к открытию нужного ордера 
      }//if анализ АО
//*********************************************** --- ПРОДАЖА --- ************************************************      
      hAO = iAO(Symbols[i],PERIOD());
      CopyBuffer(hAO,0,0,6,mAO);
      ArraySetAsSeries(mAO,true);
      if(mAO[1] < mAO[2] &&
         mAO[2] < mAO[3] &&
         mAO[3] < mAO[4] &&
         mAO[4] > mAO[5] &&
      (iLow(Symbols[i],PERIOD(),0) > iLow(Symbols[i],PERIOD(),1)))
      {
        // перебираем отложенные ордера на соответствие комментарию
         bool newOrderAOSell = true;
         bool activeOrderAOSell = true;
         for(int Y=0;Y<ALLorders2;Y++)   // если есть сигнал по конкретной валюте
         {
            if(ALOrders[Y] == (Symbols[i]+"_AO_SELL")) // отсюда неправильно работает цикл
            {
               newOrderAOSell = false;
            }
         }
         // перебираем действующие ордера на соответствие комментарию
         //MqlTradeRequest request4;
         //MqlTradeResult result4;
         int activeSell=PositionsTotal();
         for(int AA=0;AA<activeSell;AA++)
         {
            string comentAOactiveSell = PositionGetString(POSITION_COMMENT);
            if(comentAOactiveSell == (Symbols[i]+"_AO_SELL"))
            {
               activeOrderAOSell = false;
            }
         }
            if((newOrderAOSell == true) && (activeOrderAOSell == true))  // если ктакого комментария нет, то переходим к открытию нужного ордера
            {
               MqlTradeRequest requestSell={};
               MqlTradeResult resultSell={0};
               requestSell.action = TRADE_ACTION_PENDING;
               requestSell.symbol = Symbols[i];
               requestSell.volume = lot;
               requestSell.type = ORDER_TYPE_SELL_STOP;
      
               if((i == 0) && (OpenOrderPriceXAUUSD == true)) // XAUUSD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_XAUUSD*Point(),2);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_XAUUSD*Point(),2);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
      /*         if((i == 1) && (OpenOrderPriceAUDJPY == true)) // AUDJPY .3
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_AUDJPY*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_AUDJPY*Point(),3);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 2) && (OpenOrderPriceUSDJPY == true)) // USDJPY .3
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDJPY*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDJPY*Point(),3);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 3) && (OpenOrderPriceEURJPY == true)) // EURJPY .3
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURJPY*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURJPY*Point(),3);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 4) && (OpenOrderPriceCHFJPY == true)) // CHFJPY .3
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_CHFJPY*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_CHFJPY*Point(),3);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 5) && (OpenOrderPriceGBPJPY == true)) // GBPJPY .3
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPJPY*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPJPY*Point(),3);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 6) && (OpenOrderPriceEURRUB == true)) // EURRUB .4
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURRUB*Point(),4);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURRUB*Point(),4);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 7) && (OpenOrderPriceUSDRUB == true)) // USDRUB .4
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDRUB*Point(),4);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDRUB*Point(),4);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 8) && (OpenOrderPriceXAGUSD == true)) // XAGUSD .4
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_XAGUSD*Point(),4);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_XAGUSD*Point(),4);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 9) && (OpenOrderPriceEURUSD == true)) // EURUSD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURUSD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURUSD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 10) && (OpenOrderPriceGBPUSD == true)) // GBPUSD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPUSD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPUSD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 11) && (OpenOrderPriceUSDCHF == true)) // USDCHF .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDCHF*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDCHF*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 12) && (OpenOrderPriceNZDUSD == true)) // NZDUSD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_NZDUSD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_NZDUSD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 13) && (OpenOrderPriceUSDCAD == true)) // USDCAD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDCAD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDCAD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 14) && (OpenOrderPriceAUDUSD == true)) // AUDUSD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_AUDUSD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_AUDUSD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 15) && (OpenOrderPriceAUDNZD == true)) // AUDNZD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_AUDNZD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_AUDNZD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 16) && (OpenOrderPriceAUDCHF == true)) // AUDCHF .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_AUDCHF*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_AUDCHF*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 17) && (OpenOrderPriceGBPNZD == true)) // GBPNZD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPNZD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPNZD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 18) && (OpenOrderPriceEURAUD == true)) // EURAUD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURAUD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURAUD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 19) && (OpenOrderPriceEURCAD == true)) // EURCAD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURCAD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURCAD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 20) && (OpenOrderPriceEURGBP == true)) // EURGBP .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURGBP*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURGBP*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 21) && (OpenOrderPriceEURCHF == true)) // EURCHF .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURCHF*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURCHF*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 22) && (OpenOrderPriceEURNZD == true)) // EURNZD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURNZD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURNZD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 23) && (OpenOrderPriceUSDSGD == true)) // USDSGD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDSGD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDSGD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 24) && (OpenOrderPriceGBPCAD == true)) // GBPCAD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPCAD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPCAD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 25) && (OpenOrderPriceGBPAUD == true)) // GBPAUD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPAUD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPAUD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 26) && (OpenOrderPriceEURNOK == true)) // EURNOK .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURNOK*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURNOK*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 27) && (OpenOrderPriceAUDCAD == true)) // AUDCAD .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_AUDCAD*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_AUDCAD*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 28) && (OpenOrderPriceGBPCHF == true)) // GBPCHF .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_GBPCHF*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_GBPCHF*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 29) && (OpenOrderPriceUSDSEK == true)) // USDSEK .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDSEK*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDSEK*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 30) && (OpenOrderPriceUSDMXN == true)) // USDMXN .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDMXN*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDMXN*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 31) && (OpenOrderPriceUSDNOK == true)) // USDNOK .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDNOK*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDNOK*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 32) && (OpenOrderPriceEURSEK == true)) // EURSEK .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_EURSEK*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_EURSEK*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 33) && (OpenOrderPriceUSDDKK == true)) // USDDKK .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDDKK*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDDKK*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
               if((i == 34) && (OpenOrderPriceUSDZAR == true)) // USDZAR .2
               {
                  requestSell.price = NormalizeDouble(PricesMIN_AO[i]-OP_USDZAR*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesMAX_AO[i]+SL_USDZAR*Point(),5);
                  requestSell.comment = Symbols[i] + "_AO_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL AO 0 ", Symbols[i]+"_AO_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_AO_SELL - ",resultSell.order);
                  }
               }
      */      }//if анализ АО
         }
      }
   } //if есть новый бар 
};//главный файла