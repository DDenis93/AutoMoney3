bool OpenOrderNews(){

double PricesASK[35] = {
  ask.XAUUSD,
  ask.AUDJPY,
  ask.USDJPY,
  ask.EURJPY,
  ask.CHFJPY,
  ask.GBPJPY,
  ask.EURRUB,
  ask.USDRUB,
  ask.XAGUSD,
  ask.EURUSD,
  ask.GBPUSD,
  ask.USDCHF,
  ask.NZDUSD,
  ask.USDCAD,
  ask.AUDUSD,
  ask.AUDNZD,
  ask.AUDCHF,
  ask.GBPNZD,
  ask.EURAUD,
  ask.EURCAD,
  ask.EURGBP,
  ask.EURCHF,
  ask.EURNZD,
  ask.USDSGD,
  ask.GBPCAD,
  ask.GBPAUD,
  ask.EURNOK,
  ask.AUDCAD,
  ask.GBPCHF,
  ask.USDSEK,
  ask.USDMXN,
  ask.USDNOK,
  ask.EURSEK,
  ask.USDDKK,
  ask.USDZAR
};

double PricesBID[35] = {
  bid.XAUUSD,
  bid.AUDJPY,
  bid.USDJPY,
  bid.EURJPY,
  bid.CHFJPY,
  bid.GBPJPY,
  bid.EURRUB,
  bid.USDRUB,
  bid.XAGUSD,
  bid.EURUSD,
  bid.GBPUSD,
  bid.USDCHF,
  bid.NZDUSD,
  bid.USDCAD,
  bid.AUDUSD,
  bid.AUDNZD,
  bid.AUDCHF,
  bid.GBPNZD,
  bid.EURAUD,
  bid.EURCAD,
  bid.EURGBP,
  bid.EURCHF,
  bid.EURNZD,
  bid.USDSGD,
  bid.GBPCAD,
  bid.GBPAUD,
  bid.EURNOK,
  bid.AUDCAD,
  bid.GBPCHF,
  bid.USDSEK,
  bid.USDMXN,
  bid.USDNOK,
  bid.EURSEK,
  bid.USDDKK,
  bid.USDZAR
};

int ALLordersNews = OrdersTotal();                             // общее количество ОТЛОЖЕННЫХ ордеров
if(ALLordersNews == 0)
{
   ALLordersNews = 1;
   //Print("Нет ордеров - присваиваем значение 1");
}
string ALOrders[];                                          // создаем динамический массив
ArrayResize(ALOrders,ALLordersNews);                           // устанавливаем размер массива равным количеству ордеров
//Print("Всего отложенных ордеров = ",ALLorders2);            // 90 к примеру

for(int q=0; q<ALLordersNews ; q++)                            // пробегаем по количеству ордеров
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
   if(i == AO_NewBar[i])                                    // переходим к анализу сигнала
   { // перебираем отложенные ордера на соответствие комментарию
   
         bool newOrderNews = true;
         bool activeOrderNews = true;
         for(int Y=0;Y<ALLordersNews;Y++)   // если есть сигнал по конкретной валюте
         {
            //Print("Проверяем все отложенные ордера на соответствие комментарию");
            if(ALOrders[Y] == (Symbols[i]+"_NEWS_BUY")) // отсюда неправильно работает цикл
            {
               //Print("Такой отложенный ордер на BUY уже есть!!! ", Symbols[i]+"_NEWS_BUY");
               newOrderNews = false;
            }
         }
         // перебираем действующие ордера на соответствие комментарию
         MqlTradeRequest request3;
         MqlTradeResult result3;
         int active=PositionsTotal();
         for(int A=0;A<active;A++)
         {
            string comentNewsActive = PositionGetString(POSITION_COMMENT);
            if(comentNewsActive == (Symbols[i]+"_NEWS_BUY"))
            {
               activeOrderNews = false;
            }
         }
            if((newOrderNews == true) && (activeOrderNews == true))
            {
               MqlTradeRequest requestBay={};
               MqlTradeResult resultBay={0};
               requestBay.action = TRADE_ACTION_PENDING;
               requestBay.symbol = Symbols[i]; //+
               requestBay.volume = lot;
               requestBay.type = ORDER_TYPE_BUY_STOP;

               if((i == 0) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice1*Point(),2);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),2);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 0 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i >= 1) && (i <= 5) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice1*Point(),3);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),3);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 1-5 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i >= 6) && (i <= 7) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice2*Point(),4);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLossRUB*Point(),4);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 6-7 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i == 8) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice1*Point(),4);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),4);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 8 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i >= 9) && (i <= 25) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice1*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),5);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 9-25 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i >= 26) && (i <= 32) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice3*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),5);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 26-32 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i == 33) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice4*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),5);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 33 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
               if((i == 34) && (OpenOrderPrice == true))
               {
                  requestBay.price = NormalizeDouble(PricesASK[i]+OpenPrice5*Point(),5);
                  requestBay.sl = NormalizeDouble(PricesBID[i]-StopLoss*Point(),5);
                  requestBay.comment = Symbols[i] + "_NEWS_BUY";
                  if(!OrderSend(requestBay,resultBay))
                  PrintFormat("Error open order BUY NEWS 34 ", Symbols[i]+"_NEWS_BUY - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_BUY - ",resultBay.order);
                  }
               }
            }//else если ктакого комментария нет, то переходим к открытию нужного ордера 
      }//if анализ АО
   } //if есть новый бар
         
         
   //**********************************************************************************   
Print("Пришли к открытию продажи Новости");
for(int i=1;i<34;i++)
{
   if(i == AO_NewBar[i])                                    // переходим к анализу сигнала
   {
         bool newOrderNews = true;
         bool activeOrderNews = true;
         for(int Y=0;Y<ALLordersNews;Y++)   // если есть сигнал по конкретной валюте
         {
            //Print("Проверяем все отложенные ордера на соответствие комментарию");
            if(ALOrders[Y] == (Symbols[i]+"_NEWS_SELL")) // отсюда неправильно работает цикл
            {
               //Print("Такой отложенный ордер на BUY уже есть!!! ", Symbols[i]+"_NEWS_BUY");
               newOrderNews = false;
            }
         }
         // перебираем действующие ордера на соответствие комментарию
         MqlTradeRequest request4;
         MqlTradeResult result4;
         int active=PositionsTotal();
         for(int A=0;A<active;A++)
         {
            string comentNewsActive = PositionGetString(POSITION_COMMENT);
            if(comentNewsActive == (Symbols[i]+"_NEWS_SELL"))
            {
               //Print("Такой активный ордер на BUY уже есть!!! ", Symbols[i]+"_NEWS_BUY");
               activeOrderNews = false;
            }
         }
            if((newOrderNews == true) && (activeOrderNews == true))  // если ктакого комментария нет, то переходим к открытию нужного ордера
            {
               MqlTradeRequest requestSell={};
               MqlTradeResult resultSell={0};
               requestSell.action = TRADE_ACTION_PENDING;
               requestSell.symbol = Symbols[i];
               requestSell.volume = lot;
               requestSell.type = ORDER_TYPE_SELL_STOP;
      
               if((i == 0) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice1*Point(),2);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),2);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 0 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i >= 1) && (i <= 5) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice1*Point(),3);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),3);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 1-5 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i >= 6) && (i <= 7) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice2*Point(),4);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLossRUB*Point(),4);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 6-7 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i == 8) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice1*Point(),4);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),4);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 8 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i >= 9) && (i <= 25) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice1*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),5);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 9-25 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i >= 26) && (i <= 32) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice3*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),5);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 26-32 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i == 33) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice4*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),5);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 33 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
               if((i == 34) && (OpenOrderPrice == true))
               {
                  requestSell.price = NormalizeDouble(PricesBID[i]-OpenPrice5*Point(),5);
                  requestSell.sl = NormalizeDouble(PricesASK[i]+StopLoss*Point(),5);
                  requestSell.comment = Symbols[i] + "_NEWS_SELL";
                  if(!OrderSend(requestSell,resultSell))
                  PrintFormat("Error open order SELL NEWS 34 ", Symbols[i]+"_NEWS_SELL - %d", GetLastError());
                  else 
                  {
                     Print("Ticket order ",Symbols[i]+"_NEWS_SELL - ",resultSell.order);
                  }
               }
            }//else если ктакого комментария нет, то переходим к открытию нужного ордера
      }//if анализ АО
   } //if есть новый бар

return(true);
};