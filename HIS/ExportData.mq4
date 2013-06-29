

/***************************************************
 *            导出所经历时间周期的数据             *
 ***************************************************/

string exportfile;

int init(){
  exportfile = "TB_UBE_"+Symbol()+"_M"+Period()+".csv";  
  int handle;
  handle=FileOpen(exportfile,FILE_READ|FILE_WRITE|FILE_CSV ,","); 
  if(handle>0){
    FileSeek(handle, 0, SEEK_END);
    FileWrite(handle,"Time,Open,Close,High,Low,Volume,Ask,Bid");
    FileClose(handle );    
  } 
}

// 数据日志
void datalog(string msg){
    int handle;
    string timestamp = TimeToStr(TimeCurrent());
    handle=FileOpen(exportfile,FILE_READ|FILE_WRITE|FILE_CSV ,",");  
    if(handle>0)
    {
      FileSeek(handle, 0, SEEK_END);
      FileWrite(handle,timestamp, msg);     
      FileClose(handle );
    }  
}

/***************************************************
 *                    主题程序结构                 *
 ***************************************************/

// 处理每根线的第1帧
int onFirstTick(){
  // 记录交易关键数据
  datalog( 
    Open[1]+ "," +Close[1] + "," + High[1] + "," + Low[1]+ "," + Volume[1] + "," + Ask + "," + Bid
  );
  // Time,Open,Close,High,Low,Volume,Ask,Bid
}

// 处理每一帧
int onEveryTick(){

}

// 检查是否是棒线的第1帧
bool isFirstTick(){
  static double LastVolume= -1 ;  
  if (Volume[0] >= LastVolume && LastVolume != -1 ){
    LastVolume = Volume[0];    
    return(false);
  }
  LastVolume = Volume[0];  
  return(true);
}

// 主程序
int start()
{ 
  if(isFirstTick()) {
    onFirstTick();  
  }
  onEveryTick();  
}





//+------------------------------------------------------------------+