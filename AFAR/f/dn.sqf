private _ch=currentChannel;
r_ptt=[_this,_ch];
if(_ch==(ch9+5))then{_ch enableChannel[true,true]}else{_ch enableChannel[false,false]};
if(lifeState r_p isEqualTo"INCAPACITATED")exitWith{r_dn_=false;r_up_=false;5 enableChannel r_dCH;setCurrentChannel 5;};
if((!alive r_p)||(!isAbleToBreathe r_p)||(isObjectHidden r_p))exitWith{
if(!isAbleToBreathe r_p)then{[r_p,0]remoteExecCall["setPlayerVONVolume"];5 enableChannel[false,false];
{_x enableChannel[false,false]}count r_CH+[0];
[_this,_ch]remoteExecCall["r_out2"];
if(_ch in r_CH)then{playSound"in2"};titleText["I need a rebreather to talk underwater","PLAIN DOWN"];titleFadeOut 6;if([]call BIS_fnc_admin>0)then{setCurrentChannel 5}};
if(alive r_p)then{(ch9+5)enableChannel[false,false]}else{(ch9+5)enableChannel[true,true]};
r_up_=false;r_dn_=false;};

switch(_ch)do{
case 0:{[r_p,0]remoteExecCall["setPlayerVONVolume"]};
case 1:{if(r_sideCH)then{1 enableChannel r_sCH}};
case 2:{2 enableChannel r_cCH};
case 3:{3 enableChannel r_grCH};
case 4:{4 enableChannel r_vCH};
case 5:{5 enableChannel r_dCH};
case(ch6+5):{(ch6+5)enableChannel r_mCH};
case(ch7+5):{(ch7+5)enableChannel r_mCH};
case(ch8+5):{(ch8+5)enableChannel r_mCH};
case(ch9+5):{(ch9+5)enableChannel[false,false]};
};

r_dn_=true;r_up_=false;
switch(_this)do{
case 0:{r_dn=false};
case 1:{_this call S_In};
case 2:{_this call C_In};
case 3:{_this call G_In};
case 4:{_this call V_In};
case 5:{_this call D_In};
case 7:{r_dn=false;setCurrentChannel 5;titleText["<a font='PuristaBold' align='center' color='#FF0000' size='2' shadow='2'>VoiceOverNet</a><br/><a align='center' color='#929292' size='1.5' shadow='2'>Use the PushToTalk keybind instead!</a>","PLAIN",-1,true,true];titleFadeOut 6;};
default{
switch(_ch)do{
case 1:{_this call S_In};
case 2:{_this call C_In};
case 3:{_this call G_In};
case 4:{_this call V_In};
case 5:{_this call D_In};
case(ch6+5):{_this call M_In};
case(ch7+5):{_this call M_In};
case(ch8+5):{_this call M_In};
case(ch9+5):{r_dn_=false}}}}