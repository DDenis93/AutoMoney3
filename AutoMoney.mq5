//+------------------------------------------------------------------+
//|                                                    AutoMoney.mq5 |
//|                                                            Denis |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Denis"
#property link      ""
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
// Файлы проверки ошибок с MQL5
///#include <CheckMoneyForTrade.mqh> // Нехватка средств для проведения торговой операции
//#include <CheckVolumeValue.mqh>   // Неправильные объемы в торговых операциях
//#include <IsNewOrderAllowed.mqh>  // Ограничение на количество отложенных ордеров
// Ограничение на количество лотов по одному символу - внедрить
// Установка уровней TakeProfit и StopLoss в пределах минимального уровня SYMBOL_TRADE_STOPS_LEVEL - внедрить
// Попытка модификации ордера или позиции в пределах уровня заморозки SYMBOL_TRADE_FREEZE_LEVEL - внедрить
// Ошибки, возникающие при работе с символами с недостаточной историей котировок
// Выход за пределы мссива (array out of range)
// Отправка запроса на модификацию уровней без фактического их изменения
// Попытка импорта скомпилированных файлов (даже EX$/EX5) и DLL
// Обращение к пользовательским индикаторам через iCustom()
// Передача недопустимого параметра в функцию (ошибки времени выполнения)
// Access violation
// Потребление ресурсов процессора памяти

// Мои файлы
//#include <Errors.mqh>
//#include <ErrorsServer.mqh>
//#include <Signal.mqh>
//#include <AllOrders.mqh>
//#include <AllTradeOrders.mqh>
//#include <TradeOrder.mqh>
#include <OrdersModifyActive.mqh>
#include <OrdersModifyPerspective.mqh>
#include <TimeServer.mqh>
#include <Balance.mqh>
//#include <OpenOrderNews.mqh>
#include <News.mqh>
#include <OrdersClose.mqh>
#include <AO.mqh>
#include <AO_Trade.mqh>
//#include <Lot.mqh>
#include <NewBar.mqh>
#include <NewBars.mqh>
#include <WhatMoney.mqh>
#include <Price.mqh>

struct AOindicator
{                  // открытие ордера
  ulong XAUUSD[2]; // +100 + спред
  ulong AUDJPY[2]; // +124 пипса в обе стороны (100+спред24))
  ulong USDJPY[2]; // +100 + спред 18
  ulong EURJPY[2]; // +100 + спред
  ulong CHFJPY[2]; // +100 + спред
  ulong GBPJPY[2]; // +100 + спред
  ulong EURRUB[2]; // стоп + 4500
  ulong USDRUB[2]; // стоп + 4500
  ulong XAGUSD[2]; // +100 + спред, только 4 пункта на конце
  ulong EURUSD[2]; // +100 + спред
  ulong GBPUSD[2];
  ulong USDCHF[2];
  ulong NZDUSD[2];
  ulong USDCAD[2];
  ulong AUDUSD[2];
  ulong AUDNZD[2];
  ulong AUDCHF[2];
  ulong GBPNZD[2];
  ulong EURAUD[2];
  ulong EURCAD[2];
  ulong EURGBP[2];
  ulong EURCHF[2];
  ulong EURNZD[2];
  ulong USDSGD[2];
  ulong GBPCAD[2];
  ulong GBPAUD[2];
  ulong EURNOK[2]; //мин 500п открытие
  ulong AUDCAD[2]; //мин 500п открытие, +100 + спред плавающий большой
  ulong GBPCHF[2]; //мин 500п открытие, +100 + спред плавающий большой
  ulong USDSEK[2]; //мин 500п открытие
  ulong USDMXN[2]; //мин 500п открытие
  ulong USDNOK[2]; //мин 500п открытие
  ulong EURSEK[2]; //мин 500п открытие
  ulong USDDKK[2]; //мин 300п открытие
  ulong USDZAR[2]; //открытие от 1000
};
   AOindicator AO_Order;

struct Price
{
double XAUUSD; //.2
double AUDJPY; //.3
double USDJPY; //.3
double EURJPY; //.3
double CHFJPY; //.3
double GBPJPY; //.3
double EURRUB; //.4
double USDRUB; //.4
double XAGUSD; //.4
double EURUSD; //.5
double GBPUSD; //.5
double USDCHF; //.5
double NZDUSD; //.5
double USDCAD; //.5
double AUDUSD; //.5
double AUDNZD; //.5
double AUDCHF; //.5
double GBPNZD; //.5
double EURAUD; //.5
double EURCAD; //.5
double EURGBP; //.5
double EURCHF; //.5
double EURNZD; //.5
double USDSGD; //.5
double GBPCAD; //.5
double GBPAUD; //.5
double EURNOK; //.5
double AUDCAD; //.5
double GBPCHF; //.5
double USDSEK; //.5
double USDMXN; //.5
double USDNOK; //.5
double EURSEK; //.5
double USDDKK; //.5
double USDZAR; //.5
};
   Price bid;
   Price ask;
   Price minAO;
   Price maxAO;
   Price raznica1;
   Price raznica2;
   Price _NewBar1;
   Price _NewBar2;
   
bool XAUUSD = true;
bool AUDJPY = true;
bool USDJPY = true;
bool EURJPY = true;
bool CHFJPY = true;
bool GBPJPY = true;
bool EURRUB = true;
bool USDRUB = true;
bool XAGUSD = true;
bool EURUSD = true;
bool GBPUSD = true;
bool USDCHF = true;
bool NZDUSD = true;
bool USDCAD = true;
bool AUDUSD = true;
bool AUDNZD = true;
bool AUDCHF = true;
bool GBPNZD = true;
bool EURAUD = true;
bool EURCAD = true;
bool EURGBP = true;
bool EURCHF = true;
bool EURNZD = true;
bool USDSGD = true;
bool GBPCAD = true;
bool GBPAUD = true;
bool EURNOK = true;
bool AUDCAD = true;
bool GBPCHF = true;
bool USDSEK = true;
bool USDMXN = true;
bool USDNOK = true;
bool EURSEK = true;
bool USDDKK = true;
bool USDZAR = true;

bool priceXAUUSD = false;
bool priceAUDJPY = false;
bool priceUSDJPY = false;
bool priceEURJPY = false;
bool priceCHFJPY = false;
bool priceGBPJPY = false;
bool priceEURRUB = false;
bool priceUSDRUB = false;
bool priceXAGUSD = false;
bool priceEURUSD = false;
bool priceGBPUSD = false;
bool priceUSDCHF = false;
bool priceNZDUSD = false;
bool priceUSDCAD = false;
bool priceAUDUSD = false;
bool priceAUDNZD = false;
bool priceAUDCHF = false;
bool priceGBPNZD = false;
bool priceEURAUD = false;
bool priceEURCAD = false;
bool priceEURGBP = false;
bool priceEURCHF = false;
bool priceEURNZD = false;
bool priceUSDSGD = false;
bool priceGBPCAD = false;
bool priceGBPAUD = false;
bool priceEURNOK = false;
bool priceAUDCAD = false;
bool priceGBPCHF = false;
bool priceUSDSEK = false;
bool priceUSDMXN = false;
bool priceUSDNOK = false;
bool priceEURSEK = false;
bool priceUSDDKK = false;
bool priceUSDZAR = false;

double spreadXAUUSD = 0.0;
double spreadAUDJPY = 0.0;
double spreadUSDJPY = 0.0;
double spreadEURJPY = 0.0;
double spreadCHFJPY = 0.0;
double spreadGBPJPY = 0.0;
double spreadEURRUB = 0.0;
double spreadUSDRUB = 0.0;
double spreadXAGUSD = 0.0;
double spreadEURUSD = 0.0;
double spreadGBPUSD = 0.0;
double spreadUSDCHF = 0.0;
double spreadNZDUSD = 0.0;
double spreadUSDCAD = 0.0;
double spreadAUDUSD = 0.0;
double spreadAUDNZD = 0.0;
double spreadAUDCHF = 0.0;
double spreadGBPNZD = 0.0;
double spreadEURAUD = 0.0;
double spreadEURCAD = 0.0;
double spreadEURGBP = 0.0;
double spreadEURCHF = 0.0;
double spreadEURNZD = 0.0;
double spreadUSDSGD = 0.0;
double spreadGBPCAD = 0.0;
double spreadGBPAUD = 0.0;
double spreadEURNOK = 0.0;
double spreadAUDCAD = 0.0;
double spreadGBPCHF = 0.0;
double spreadUSDSEK = 0.0;
double spreadUSDMXN = 0.0;
double spreadUSDNOK = 0.0;
double spreadEURSEK = 0.0;
double spreadUSDDKK = 0.0;
double spreadUSDZAR = 0.0;

bool OpenOrderPriceXAUUSD = false; // для открытия ордера разрешение пользователя
bool OpenOrderPriceAUDJPY = false;
bool OpenOrderPriceUSDJPY = false;
bool OpenOrderPriceEURJPY = false;
bool OpenOrderPriceCHFJPY = false;
bool OpenOrderPriceGBPJPY = false;
bool OpenOrderPriceEURRUB = false;
bool OpenOrderPriceUSDRUB = false;
bool OpenOrderPriceXAGUSD = false;
bool OpenOrderPriceEURUSD = false;
bool OpenOrderPriceGBPUSD = false;
bool OpenOrderPriceUSDCHF = false;
bool OpenOrderPriceNZDUSD = false;
bool OpenOrderPriceUSDCAD = false;
bool OpenOrderPriceAUDUSD = false;
bool OpenOrderPriceAUDNZD = false;
bool OpenOrderPriceAUDCHF = false;
bool OpenOrderPriceGBPNZD = false;
bool OpenOrderPriceEURAUD = false;
bool OpenOrderPriceEURCAD = false;
bool OpenOrderPriceEURGBP = false;
bool OpenOrderPriceEURCHF = false;
bool OpenOrderPriceEURNZD = false;
bool OpenOrderPriceUSDSGD = false;
bool OpenOrderPriceGBPCAD = false;
bool OpenOrderPriceGBPAUD = false;
bool OpenOrderPriceEURNOK = false;
bool OpenOrderPriceAUDCAD = false;
bool OpenOrderPriceGBPCHF = false;
bool OpenOrderPriceUSDSEK = false;
bool OpenOrderPriceUSDMXN = false;
bool OpenOrderPriceUSDNOK = false;
bool OpenOrderPriceEURSEK = false;
bool OpenOrderPriceUSDDKK = false;
bool OpenOrderPriceUSDZAR = false;

string Symbols[35] = {
  "XAUUSDrfd",
  "AUDJPYrfd",
  "USDJPYrfd",
  "EURJPYrfd",
  "CHFJPYrfd",
  "GBPJPYrfd",
  "EURRUBrfd",
  "USDRUBrfd",
  "XAGUSDrfd",
  "EURUSDrfd",
  "GBPUSDrfd",
  "USDCHFrfd",
  "NZDUSDrfd",
  "USDCADrfd",
  "AUDUSDrfd",
  "AUDNZDrfd",
  "AUDCHFrfd",
  "GBPNZDrfd",
  "EURAUDrfd",
  "EURCADrfd",
  "EURGBPrfd",
  "EURCHFrfd",
  "EURNZDrfd",
  "USDSGDrfd",
  "GBPCADrfd",
  "GBPAUDrfd",
  "EURNOKrfd",
  "AUDCADrfd",
  "GBPCHFrfd",
  "USDSEKrfd",
  "USDMXNrfd",
  "USDNOKrfd",
  "EURSEKrfd",
  "USDDKKrfd",
  "USDZARrfd"
};

input int OP_XAUUSD = 20;/* // 20-60
input int OP_AUDJPY = 20;
input int OP_USDJPY = 20;
input int OP_EURJPY = 20;
input int OP_CHFJPY = 20;
input int OP_GBPJPY = 20;
input int OP_EURRUB = 20;
input int OP_USDRUB = 20;
input int OP_XAGUSD = 20;
input int OP_EURUSD = 20;
input int OP_GBPUSD = 20;
input int OP_USDCHF = 20;
input int OP_NZDUSD = 20;
input int OP_USDCAD = 20;
input int OP_AUDUSD = 20;
input int OP_AUDNZD = 20;
input int OP_AUDCHF = 20;
input int OP_GBPNZD = 20;
input int OP_EURAUD = 20;
input int OP_EURCAD = 20;
input int OP_EURGBP = 20;
input int OP_EURCHF = 20;
input int OP_EURNZD = 20;
input int OP_USDSGD = 20;
input int OP_GBPCAD = 20;
input int OP_GBPAUD = 20;
input int OP_EURNOK = 20;
input int OP_AUDCAD = 20;
input int OP_GBPCHF = 20;
input int OP_USDSEK = 20;
input int OP_USDMXN = 20;
input int OP_USDNOK = 20;
input int OP_EURSEK = 20;
input int OP_USDDKK = 20;
input int OP_USDZAR = 20;*/

input int SL_XAUUSD = 300;/*  // 250-400
input int SL_AUDJPY = 300;
input int SL_USDJPY = 300;
input int SL_EURJPY = 300;
input int SL_CHFJPY = 300;
input int SL_GBPJPY = 300;
input int SL_EURRUB = 300; // Стоп лосс рубль +4500 / остальные +100 пунктов
input int SL_USDRUB = 300;
input int SL_XAGUSD = 300;
input int SL_EURUSD = 300;
input int SL_GBPUSD = 300;
input int SL_USDCHF = 300;
input int SL_NZDUSD = 300;
input int SL_USDCAD = 300;
input int SL_AUDUSD = 300;
input int SL_AUDNZD = 300;
input int SL_AUDCHF = 300;
input int SL_GBPNZD = 300;
input int SL_EURAUD = 300;
input int SL_EURCAD = 300;
input int SL_EURGBP = 300;
input int SL_EURCHF = 300;
input int SL_EURNZD = 300;
input int SL_USDSGD = 300;
input int SL_GBPCAD = 300;
input int SL_GBPAUD = 300;
input int SL_EURNOK = 300;
input int SL_AUDCAD = 300;
input int SL_GBPCHF = 300;
input int SL_USDSEK = 300;
input int SL_USDMXN = 300;
input int SL_USDNOK = 300;
input int SL_EURSEK = 300;
input int SL_USDDKK = 300;
input int SL_USDZAR = 300;*/

input int TS_XAUUSD = 300;  // 950
input int TS_AUDJPY = 300;
input int TS_USDJPY = 300;
input int TS_EURJPY = 300;
input int TS_CHFJPY = 300;
input int TS_GBPJPY = 300;
input int TS_EURRUB = 300; 
input int TS_USDRUB = 300;
input int TS_XAGUSD = 300;
input int TS_EURUSD = 300;
input int TS_GBPUSD = 300;
input int TS_USDCHF = 300;
input int TS_NZDUSD = 300;
input int TS_USDCAD = 300;
input int TS_AUDUSD = 300;
input int TS_AUDNZD = 300;
input int TS_AUDCHF = 300;
input int TS_GBPNZD = 300;
input int TS_EURAUD = 300;
input int TS_EURCAD = 300;
input int TS_EURGBP = 300;
input int TS_EURCHF = 300;
input int TS_EURNZD = 300;
input int TS_USDSGD = 300;
input int TS_GBPCAD = 300;
input int TS_GBPAUD = 300;
input int TS_EURNOK = 300;
input int TS_AUDCAD = 300;
input int TS_GBPCHF = 300;
input int TS_USDSEK = 300;
input int TS_USDMXN = 300;
input int TS_USDNOK = 300;
input int TS_EURSEK = 300;
input int TS_USDDKK = 300;
input int TS_USDZAR = 300;

//input int TrallStop     = 500;  // Трейлинг основные
//input int TrallStopRUB  = 500; // Трейлинг рубль, скорее тоже +4500
double lot = 1;

//********************************************************************* из github
// основные переменные
enum PERIOD {PERIOD_M5};       // общий таймфрейм программы

int AO_NewBar[35];
int signalAO = 0;              // количество сигналов AO
bool  AO_SIGNAL[2];            // используется в AO.mqh
int OpenOrder = 0;             // переменная для swith из АО
double Max_EURRUB_BAY_AO;      // максимум для покупки по NZDUSD
double Min_EURRUB_BAY_AO;      // минимум  для покупки по NZDUSD
double Max_EURRUB_SELL_AO;     // максимум для продажи по NZDUSD
double Min_EURRUB_SELL_AO;     // минимум  для продажи по NZDUSD

int caseLotAO;                 // кейс на рассчет лота
int caseWhatMoney;             // кейс рассчета денег
long spread;
int creditEURRUB = 20;
int creditEURUSD = 40;
//*********************************************************************
//переменные времени
int TimePeriod = 0;
string RealTimeServer;
string RealTimeYear;
string RealTimeMonth;
string RealTimeHor;
string RealTimeMinut;
string RealTimeNews;

double balance;
double RealFreeBalance;
bool count = true;
double balances;                // общий баланс счета
double balanceFreeMargin;       // свободная маржа
int CreditPlecho;               // кредитное плече счета


bool b;
int ab = 0;
//+------------------------------------------------------------------+
//| Expert start function                                            |
//+------------------------------------------------------------------+
int OnInit()
  {
   Balance();              // проверка наличия денег !? зачем она тут - убрать
   NewBar();               // инициализация текущих баров
   Price();
   Sleep(3000);
   
   //caseOrder = 1;
   //OpenOrder();
   //AO();
   //OrdersClose();
   //OrdersModifyPerspective();
 
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
//-----------------------------------------------
// присваиваем текущие bid и ask цены переменным
   Price();
//-----------------------------------------------
// модифицируем действующие ордера
   OrdersModifyActive();
//-----------------------------------------------
// инициализируем переменные времени сервера
   RealTimeServer = TimeToString(TimeCurrent());
   RealTimeYear   = RealTimeServer.Substr(0,4);
   RealTimeMonth  = RealTimeServer.Substr(5,2);
   RealTimeHor    = RealTimeServer.Substr(11,2);
   RealTimeMinut  = RealTimeServer.Substr(14,2);
   RealTimeNews   = TimeToString(TimeCurrent()+60).Substr(14,2);
//-----------------------------------------------
// удаляем неактивировавшиеся отложенные ордера
   if((RealTimeMinut == "53") ||
   (RealTimeMinut == "17"))  //дополнительно для тестов
   
   {OrdersModifyPerspective();}
/*
if((RealTimeMinut == "01") || 
   /*(RealTimeMinut == "11") ||
   (RealTimeMinut == "16") ||
   (RealTimeMinut == "21") ||
   (RealTimeMinut == "26") ||
   (RealTimeMinut == "31") ||
   (RealTimeMinut == "41") ||
   (RealTimeMinut == "46") ||
   (RealTimeMinut == "51") ||
   //(RealTimeMinut == "56") ||
   (RealTimeMinut == "29")  //дополнительно для тестов
   )
   {OrdersModifyPerspective();}
*/
/* ****************************** для новостей
if((RealTimeMinut == "04") || 
   (RealTimeMinut == "09") ||
   (RealTimeMinut == "14") ||
   (RealTimeMinut == "19") ||
   (RealTimeMinut == "24") ||
   (RealTimeMinut == "29") ||
   (RealTimeMinut == "34") ||
   (RealTimeMinut == "39") ||
   (RealTimeMinut == "44") ||
   (RealTimeMinut == "49") ||
   (RealTimeMinut == "54") ||  //дополнительно для тестов
   (RealTimeMinut == "59")
   )
   {OrdersModifyPerspective();}
 */
//----------------------------------------------- открытие торговой сессии США
//----------------------------------------------- индикатор АО
   AO_Trade();
//----------------------------------------------- новости
/*
if(News() == true)
   {
      OpenOrderNews();
   }
*/
//----------------------------------------------- удаление ордеро по рублю при открытии рынка
/*if((RealTimeHor == "07") && (RealTimeMinut == "10"))
   {
      if(AccountInfoDouble(ACCOUNT_PROFIT) > 5000)
      {
           OrdersClose();
      }
   }*/ 
//----------------------------------------------- удаление ордеров по рублю при закрытии рынка
/*
if((RealTimeHor == "18") && (RealTimeMinut == "40"))
   {
      OrdersClose();
      if((Balance() == true) && (AccountInfoDouble(ACCOUNT_PROFIT)>=0))
         {
            MqlTradeRequest request2 = {};
            MqlTradeResult result2 = {};
            //int total2=OrdersTotal();
            int total1=PositionsTotal();
            if(total1 < 1)
            {caseOrder = 1;
             OpenOrder();
             Sleep(10000);
             }
         }
   }*/
}
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---
  }
//+------------------------------------------------------------------+