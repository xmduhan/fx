//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                      Copyright � 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+

#include <common.mqh>

double a;

void LoadParameter(){
	// ... 加载交易参数 ... 
	double a = ConfigGetDouble("a",100);
	Print("a=",a);
}

void CheckForOpen(){
	// ... 开仓逻辑 ... 
	Print("CheckForOpen() is called ,LotsSize=",GetLotSize());
	
}

void CheckForClose(){
	// ... 平仓逻辑 ... 
	Print("CheckForClose() is called ");
}

int init() {
	// 调用init()开始事件
	OnInitBegin(WindowExpertName());
	
	// 读取相关参数
	LoadParameter();
	
	// 调用init()结束事件
	OnInitEnd();
}

int deinit(){	
    // 调用deinit()开始事件
	OnDeinitBegin();
	
	// 调用deinit()结束事件
	OnDeinitEnd();
}

void start()
{	
	// 如果初始化失败，不进行任何动作
	if(!IsInitialized()) return;
		
	// 发送start()开始事件
	OnStartBegin();
	
		
	// 判断如果时间周期发生变化重新加载配置参数	
	static int LastPeriod = 0;
	if (LastPeriod != 0 && LastPeriod != Period()){
		// 重新加载交易参数
		LoadParameter();
	}
	LastPeriod = Period();
	
	
	// 调用交易逻辑
	if (GetTradingAllowed()){
		CheckForOpen();
	}
	CheckForClose();		
	
	
	// 发送start()结束事件
	OnStartEnd();	
}  


