// программа для работы робота в ходе новых тиков
bool NewBars()
{ bool NewBarAO = false;
_NewBar1.XAUUSD = iOpen("XAUUSDrfd",PERIOD(),0);         // цена открытия текущего    бара
_NewBar2.XAUUSD = iOpen("XAUUSDrfd",PERIOD(),1);         // цена открытия предыдущего бара
raznica2.XAUUSD = _NewBar1.XAUUSD - _NewBar2.XAUUSD;     // разница в пунктах между текущим и предыдущими барами
   if(raznica1.XAUUSD != raznica2.XAUUSD)                // если цены открытия баров не равны
     {raznica2.XAUUSD  = raznica1.XAUUSD;                // записываем новое значение в первую переменную
      AO_NewBar[0] = 0;
      NewBarAO = true;
     }
   else
     {AO_NewBar[0] = -1;}
//*******************************************************
_NewBar1.AUDJPY = iOpen("AUDJPYrfd",PERIOD(),0);
_NewBar2.AUDJPY = iOpen("AUDJPYrfd",PERIOD(),1);
raznica2.AUDJPY = _NewBar1.AUDJPY - _NewBar2.AUDJPY;
   if(raznica1.AUDJPY != raznica2.AUDJPY)
     {raznica2.AUDJPY  = raznica1.AUDJPY;
      AO_NewBar[1] = 1;
      NewBarAO = true;
     }
   else
     {AO_NewBar[1] = 0;}
//******************************************************* //
_NewBar1.USDJPY = iOpen("USDJPYrfd",PERIOD(),0);
_NewBar2.USDJPY = iOpen("USDJPYrfd",PERIOD(),1);
raznica2.USDJPY = _NewBar1.USDJPY - _NewBar2.USDJPY;
   if(raznica1.USDJPY != raznica2.USDJPY)
     {raznica2.USDJPY  = raznica1.USDJPY;
      AO_NewBar[2] = 2;
      NewBarAO = true;
     }
   else
     {AO_NewBar[2] = 0;}
//*******************************************************
_NewBar1.EURJPY = iOpen("EURJPYrfd",PERIOD(),0);
_NewBar2.EURJPY = iOpen("EURJPYrfd",PERIOD(),1);
raznica2.EURJPY = _NewBar1.EURJPY - _NewBar2.EURJPY;
   if(raznica1.EURJPY != raznica2.EURJPY)
     {raznica2.EURJPY  = raznica1.EURJPY;
      AO_NewBar[3] = 3;
      NewBarAO = true;
     }
   else
     {AO_NewBar[3] = 0;}
//*******************************************************
_NewBar1.CHFJPY = iOpen("CHFJPYrfd",PERIOD(),0);
_NewBar2.CHFJPY = iOpen("CHFJPYrfd",PERIOD(),1);
raznica2.CHFJPY = _NewBar1.CHFJPY - _NewBar2.CHFJPY;
   if(raznica1.CHFJPY != raznica2.CHFJPY)
     {raznica2.CHFJPY  = raznica1.CHFJPY;
      AO_NewBar[4] = 4;
      NewBarAO = true;
     }
   else
     {AO_NewBar[4] = 0;}
//*******************************************************
_NewBar1.GBPJPY = iOpen("GBPJPYrfd",PERIOD(),0);
_NewBar2.GBPJPY = iOpen("GBPJPYrfd",PERIOD(),1);
raznica2.GBPJPY = _NewBar1.GBPJPY - _NewBar2.GBPJPY;
   if(raznica1.GBPJPY != raznica2.GBPJPY)
     {raznica2.GBPJPY  = raznica1.GBPJPY;
      AO_NewBar[5] = 5;
      NewBarAO = true;
     }
   else
     {AO_NewBar[5] = 0;}
//*******************************************************
_NewBar1.EURRUB = iOpen("EURRUBrfd",PERIOD(),0);
_NewBar2.EURRUB = iOpen("EURRUBrfd",PERIOD(),1);
raznica2.EURRUB = _NewBar1.EURRUB - _NewBar2.EURRUB;
   if(raznica1.EURRUB != raznica2.EURRUB)
     {raznica2.EURRUB  = raznica1.EURRUB;
      AO_NewBar[6] = 6;
      NewBarAO = true;
     }
   else
     {AO_NewBar[6] = 0;}
//*******************************************************
_NewBar1.USDRUB = iOpen("USDRUBrfd",PERIOD(),0);
_NewBar2.USDRUB = iOpen("USDRUBrfd",PERIOD(),1);
raznica2.USDRUB = _NewBar1.USDRUB - _NewBar2.USDRUB;
   if(raznica1.USDRUB != raznica2.USDRUB)
     {raznica2.USDRUB  = raznica1.USDRUB;
      AO_NewBar[7] = 7;
      NewBarAO = true;
     }
   else
     {AO_NewBar[7] = 0;}
//*******************************************************
_NewBar1.XAGUSD = iOpen("XAGUSDrfd",PERIOD(),0);
_NewBar2.XAGUSD = iOpen("XAGUSDrfd",PERIOD(),1);
raznica2.XAGUSD = _NewBar1.XAGUSD - _NewBar2.XAGUSD;
   if(raznica1.XAGUSD != raznica2.XAGUSD)
     {raznica2.XAGUSD  = raznica1.XAGUSD;
     AO_NewBar[8] = 8;
      NewBarAO = true;
     }
   else
     {AO_NewBar[8] = 0;}
//*******************************************************
_NewBar1.EURUSD = iOpen("EURUSDrfd",PERIOD(),0);
_NewBar2.EURUSD = iOpen("EURUSDrfd",PERIOD(),1);
raznica2.EURUSD = _NewBar1.EURUSD - _NewBar2.EURUSD;
   if(raznica1.EURUSD != raznica2.EURUSD)
     {raznica2.EURUSD  = raznica1.EURUSD;
      AO_NewBar[9] = 9;
      NewBarAO = true;
     }
   else
     {AO_NewBar[9] = 0;}
//*******************************************************
_NewBar1.GBPUSD = iOpen("GBPUSDrfd",PERIOD(),0);
_NewBar2.GBPUSD = iOpen("GBPUSDrfd",PERIOD(),1);
raznica2.GBPUSD = _NewBar1.GBPUSD - _NewBar2.GBPUSD;
   if(raznica1.GBPUSD != raznica2.GBPUSD)
     {raznica2.GBPUSD  = raznica1.GBPUSD;
      AO_NewBar[10] = 10;
      NewBarAO = true;
     }
   else
     {AO_NewBar[10] = 0;}
//*******************************************************
_NewBar1.USDCHF = iOpen("USDCHFrfd",PERIOD(),0);
_NewBar2.USDCHF = iOpen("USDCHFrfd",PERIOD(),1);
raznica2.USDCHF = _NewBar1.USDCHF - _NewBar2.USDCHF;
   if(raznica1.USDCHF != raznica2.USDCHF)
     {raznica2.USDCHF  = raznica1.USDCHF;
      AO_NewBar[11] = 11;
      NewBarAO = true;
     }
   else
     {AO_NewBar[11] = 0;}
//*******************************************************
_NewBar1.NZDUSD = iOpen("NZDUSDrfd",PERIOD(),0);
_NewBar2.NZDUSD = iOpen("NZDUSDrfd",PERIOD(),1);
raznica2.NZDUSD = _NewBar1.NZDUSD - _NewBar2.NZDUSD;
   if(raznica1.NZDUSD != raznica2.NZDUSD)
     {raznica2.NZDUSD  = raznica1.NZDUSD;
      AO_NewBar[12] = 12;
      NewBarAO = true;
     }
   else
     {AO_NewBar[12] = 0;}
//*******************************************************
_NewBar1.USDCAD = iOpen("USDCADrfd",PERIOD(),0);
_NewBar2.USDCAD = iOpen("USDCADrfd",PERIOD(),1);
raznica2.USDCAD = _NewBar1.USDCAD - _NewBar2.USDCAD;
   if(raznica1.USDCAD != raznica2.USDCAD)
     {raznica2.USDCAD  = raznica1.USDCAD;
      AO_NewBar[13] = 13;
      NewBarAO = true;
     }
   else
     {AO_NewBar[13] = 0;}
//*******************************************************
_NewBar1.AUDUSD = iOpen("AUDUSDrfd",PERIOD(),0);
_NewBar2.AUDUSD = iOpen("AUDUSDrfd",PERIOD(),1);
raznica2.AUDUSD = _NewBar1.AUDUSD - _NewBar2.AUDUSD;
   if(raznica1.AUDUSD != raznica2.AUDUSD)
     {raznica2.AUDUSD  = raznica1.AUDUSD;
      AO_NewBar[14] = 14;
      NewBarAO = true;
     }
   else
     {AO_NewBar[14] = 0;}
//*******************************************************
_NewBar1.AUDNZD = iOpen("AUDNZDrfd",PERIOD(),0);
_NewBar2.AUDNZD = iOpen("AUDNZDrfd",PERIOD(),1);
raznica2.AUDNZD = _NewBar1.AUDNZD - _NewBar2.AUDNZD;
   if(raznica1.AUDNZD != raznica2.AUDNZD)
     {raznica2.AUDNZD  = raznica1.AUDNZD;
      AO_NewBar[15] = 15;
      NewBarAO = true;
     }
   else
     {AO_NewBar[15] = 0;}
//*******************************************************
_NewBar1.AUDCHF = iOpen("AUDCHFrfd",PERIOD(),0);
_NewBar2.AUDCHF = iOpen("AUDCHFrfd",PERIOD(),1);
raznica2.AUDCHF = _NewBar1.AUDCHF - _NewBar2.AUDCHF;
   if(raznica1.AUDCHF != raznica2.AUDCHF)
     {raznica2.AUDCHF  = raznica1.AUDCHF;
      AO_NewBar[16] = 16;
      NewBarAO = true;
     }
   else
     {AO_NewBar[16] = 0;}
//*******************************************************
_NewBar1.GBPNZD = iOpen("GBPNZDrfd",PERIOD(),0);
_NewBar2.GBPNZD = iOpen("GBPNZDrfd",PERIOD(),1);
raznica2.GBPNZD = _NewBar1.GBPNZD - _NewBar2.GBPNZD;
   if(raznica1.GBPNZD != raznica2.GBPNZD)
     {raznica2.GBPNZD  = raznica1.GBPNZD;
      AO_NewBar[17] = 17;
      NewBarAO = true;
     }
   else
     {AO_NewBar[17] = 0;}
//*******************************************************
_NewBar1.EURAUD = iOpen("EURAUDrfd",PERIOD(),0);
_NewBar2.EURAUD = iOpen("EURAUDrfd",PERIOD(),1);
raznica2.EURAUD = _NewBar1.EURAUD - _NewBar2.EURAUD;
   if(raznica1.EURAUD != raznica2.EURAUD)
     {raznica2.EURAUD  = raznica1.EURAUD;
      AO_NewBar[18] = 18;
      NewBarAO = true;
     }
   else
     {AO_NewBar[18] = 0;}
//*******************************************************
_NewBar1.EURCAD = iOpen("EURCADrfd",PERIOD(),0);
_NewBar2.EURCAD = iOpen("EURCADrfd",PERIOD(),1);
raznica2.EURCAD = _NewBar1.EURCAD - _NewBar2.EURCAD;
   if(raznica1.EURCAD != raznica2.EURCAD)
     {raznica2.EURCAD  = raznica1.EURCAD;
      AO_NewBar[19] = 19;
      NewBarAO = true;
     }
   else
     {AO_NewBar[19] = 0;}
//*******************************************************
_NewBar1.EURGBP = iOpen("EURGBPrfd",PERIOD(),0);
_NewBar2.EURGBP = iOpen("EURGBPrfd",PERIOD(),1);
raznica2.EURGBP = _NewBar1.EURGBP - _NewBar2.EURGBP;
   if(raznica1.EURGBP != raznica2.EURGBP)
     {raznica2.EURGBP  = raznica1.EURGBP;
      AO_NewBar[20] = 20;
      NewBarAO = true;
     }
   else
     {AO_NewBar[20] = 0;}
//*******************************************************
_NewBar1.EURCHF = iOpen("EURCHFrfd",PERIOD(),0);
_NewBar2.EURCHF = iOpen("EURCHFrfd",PERIOD(),1);
raznica2.EURCHF = _NewBar1.EURCHF - _NewBar2.EURCHF;
   if(raznica1.EURCHF != raznica2.EURCHF)
     {raznica2.EURCHF  = raznica1.EURCHF;
      AO_NewBar[21] = 21;
      NewBarAO = true;
     }
   else
     {AO_NewBar[21] = 0;}
//*******************************************************
_NewBar1.EURNZD = iOpen("EURNZDrfd",PERIOD(),0);
_NewBar2.EURNZD = iOpen("EURNZDrfd",PERIOD(),1);
raznica2.EURNZD = _NewBar1.EURNZD - _NewBar2.EURNZD;
   if(raznica1.EURNZD != raznica2.EURNZD)
     {raznica2.EURNZD  = raznica1.EURNZD;
      AO_NewBar[22] = 22;
      NewBarAO = true;
     }
   else
     {AO_NewBar[22] = 0;}
//*******************************************************
_NewBar1.USDSGD = iOpen("USDSGDrfd",PERIOD(),0);
_NewBar2.USDSGD = iOpen("USDSGDrfd",PERIOD(),1);
raznica2.USDSGD = _NewBar1.USDSGD - _NewBar2.USDSGD;
   if(raznica1.USDSGD != raznica2.USDSGD)
     {raznica2.USDSGD  = raznica1.USDSGD;
      AO_NewBar[23] = 23;
      NewBarAO = true;
     }
   else
     {AO_NewBar[23] = 0;}
//*******************************************************
_NewBar1.GBPCAD = iOpen("GBPCADrfd",PERIOD(),0);
_NewBar2.GBPCAD = iOpen("GBPCADrfd",PERIOD(),1);
raznica2.GBPCAD = _NewBar1.GBPCAD - _NewBar2.GBPCAD;
   if(raznica1.GBPCAD != raznica2.GBPCAD)
     {raznica2.GBPCAD  = raznica1.GBPCAD;
      AO_NewBar[24] = 24;
      NewBarAO = true;
     }
   else
     {AO_NewBar[24] = 0;}
//*******************************************************
_NewBar1.GBPAUD = iOpen("GBPAUDrfd",PERIOD(),0);
_NewBar2.GBPAUD = iOpen("GBPAUDrfd",PERIOD(),1);
raznica2.GBPAUD = _NewBar1.GBPAUD - _NewBar2.GBPAUD;
   if(raznica1.GBPAUD != raznica2.GBPAUD)
     {raznica2.GBPAUD  = raznica1.GBPAUD;
      AO_NewBar[25] = 25;
      NewBarAO = true;
     }
   else
     {AO_NewBar[25] = 0;}
//*******************************************************
_NewBar1.EURNOK = iOpen("EURNOKrfd",PERIOD(),0);
_NewBar2.EURNOK = iOpen("EURNOKrfd",PERIOD(),1);
raznica2.EURNOK = _NewBar1.EURNOK - _NewBar2.EURNOK;
   if(raznica1.EURNOK != raznica2.EURNOK)
     {raznica2.EURNOK  = raznica1.EURNOK;
      AO_NewBar[26] = 26;
      NewBarAO = true;
     }
   else
     {AO_NewBar[26] = 0;}
//*******************************************************
_NewBar1.AUDCAD = iOpen("AUDCADrfd",PERIOD(),0);
_NewBar2.AUDCAD = iOpen("AUDCADrfd",PERIOD(),1);
raznica2.AUDCAD = _NewBar1.AUDCAD - _NewBar2.AUDCAD;
   if(raznica1.AUDCAD != raznica2.AUDCAD)
     {raznica2.AUDCAD  = raznica1.AUDCAD;
      AO_NewBar[27] = 27;
      NewBarAO = true;
     }
   else
     {AO_NewBar[27] = 0;}
//*******************************************************
_NewBar1.GBPCHF = iOpen("GBPCHFrfd",PERIOD(),0);
_NewBar2.GBPCHF = iOpen("GBPCHFrfd",PERIOD(),1);
raznica2.GBPCHF = _NewBar1.GBPCHF - _NewBar2.GBPCHF;
   if(raznica1.GBPCHF != raznica2.GBPCHF)
     {raznica2.GBPCHF  = raznica1.GBPCHF;
      AO_NewBar[28] = 28;
      NewBarAO = true;
     }
   else
     {AO_NewBar[28] = 0;}
//*******************************************************
_NewBar1.USDSEK = iOpen("USDSEKrfd",PERIOD(),0);
_NewBar2.USDSEK = iOpen("USDSEKrfd",PERIOD(),1);
raznica2.USDSEK = _NewBar1.USDSEK - _NewBar2.USDSEK;
   if(raznica1.USDSEK != raznica2.USDSEK)
     {raznica2.USDSEK  = raznica1.USDSEK;
      AO_NewBar[29] = 29;
      NewBarAO = true;
     }
   else
     {AO_NewBar[29] = 0;}
//*******************************************************
_NewBar1.USDMXN = iOpen("USDMXNrfd",PERIOD(),0);
_NewBar2.USDMXN = iOpen("USDMXNrfd",PERIOD(),1);
raznica2.USDMXN = _NewBar1.USDMXN - _NewBar2.USDMXN;
   if(raznica1.USDMXN != raznica2.USDMXN)
     {raznica2.USDMXN  = raznica1.USDMXN;
      AO_NewBar[30] = 30;
      NewBarAO = true;
     }
   else
     {AO_NewBar[30] = 0;}
//*******************************************************
_NewBar1.USDNOK = iOpen("USDNOKrfd",PERIOD(),0);
_NewBar2.USDNOK = iOpen("USDNOKrfd",PERIOD(),1);
raznica2.USDNOK = _NewBar1.USDNOK - _NewBar2.USDNOK;
   if(raznica1.USDNOK != raznica2.USDNOK)
     {raznica2.USDNOK  = raznica1.USDNOK;
      AO_NewBar[31] = 31;
      NewBarAO = true;
     }
   else
     {AO_NewBar[31] = 0;}
//*******************************************************
_NewBar1.EURSEK = iOpen("EURSEKrfd",PERIOD(),0);
_NewBar2.EURSEK = iOpen("EURSEKrfd",PERIOD(),1);
raznica2.EURSEK = _NewBar1.EURSEK - _NewBar2.EURSEK;
   if(raznica1.EURSEK != raznica2.EURSEK)
     {raznica2.EURSEK  = raznica1.EURSEK;
      AO_NewBar[32] = 32;
      NewBarAO = true;
     }
   else
     {AO_NewBar[32] = 0;}
//*******************************************************
_NewBar1.USDDKK = iOpen("USDDKKrfd",PERIOD(),0);
_NewBar2.USDDKK = iOpen("USDDKKrfd",PERIOD(),1);
raznica2.USDDKK = _NewBar1.USDDKK - _NewBar2.USDDKK;
   if(raznica1.USDDKK != raznica2.USDDKK)
     {raznica2.USDDKK  = raznica1.USDDKK;
      AO_NewBar[33] = 33;
      NewBarAO = true;
     }
   else
     {AO_NewBar[33] = 0;}
//*******************************************************
_NewBar1.USDZAR = iOpen("USDZARrfd",PERIOD(),0);
_NewBar2.USDZAR = iOpen("USDZARrfd",PERIOD(),1);
raznica2.USDZAR = _NewBar1.USDZAR - _NewBar2.USDZAR;
   if(raznica1.USDZAR != raznica2.USDZAR)
     {raznica2.USDZAR  = raznica1.USDZAR;
      AO_NewBar[34] = 34;
      NewBarAO = true;
     }
   else
     {AO_NewBar[34] = 0;}
//*******************************************************

return(NewBarAO);

}