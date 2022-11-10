package main;
use strict;
use warnings;

sub ModbusGrowattSPH_Initialize($);

my %ModbusGrowattSPHdeviceInfo = (
    "timing" => {
        timeout     =>  2,
        commDelay   =>  0.2,
        sendDelay   =>  1,
    }, 
    "i" =>  {
        combine => 10,
    },
    "h" =>  {
        combine => 10,
    }    
);

my %ModbusGrowattSPHparseInfo = (
	'h1006' => { reading => 'VbatMin',
				 name => 'vbatMin',
                 poll => 'once', 
                 expr => '$val / 100',
                 format => '%.2f',                 
			},   
	'h1007' => { reading => 'VbatMax',
				 name => 'vbatMax',
                 poll => 'once',
                 expr => '$val / 100',
                 format => '%.2f',                 
			},          
	'i1' => { reading => 'PVPower',
				 name => 'Ppv',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},      
	'i3' => { reading => 'PV1Voltage',
				 name => 'Vpv1',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,
			}, 
	'i4' => { reading => 'PV1Current',
				 name => 'PV1Curr',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,
			},                                
	'i5' => { reading => 'PV1Power',
				 name => 'Ppv1',
                 unpack => 'I>',
                 expr => '$val / 10',
                 len => 2,
                 format => '%.1f',
                 poll => 1,               
			},
	'i7' => { reading => 'PV2Voltage',
				 name => 'Vpv2',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,
			}, 
	'i8' => { reading => 'PV2Current',
				 name => 'PV2Curr',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,
			},             
	'i9' => { reading => 'PV2Power',
				 name => 'Ppv2',
                 unpack => 'I>',
                 expr => '$val / 10',
                 len => 2,
                 format => '%.1f',
                 poll => 1,            
			},
    'i35' => { reading => 'GridOutputPower',
				 name => 'Pac',
                 unpack => 'I>',   
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,                
                 poll => 1,            
			},             
	'i37' => { reading => 'GridFrequency',
				 name => 'Fac',
                 unpack => 'S>',
                 expr => '$val / 100',
                 format => '%.2f',
                 poll => 1,           
			},            
	'i38' => { reading => 'GridVoltage1',
				 name => 'Vac1',
                 unpack => 'S>',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,        
			}, 
    'i40' => { reading => 'GridOutputWatt1',
				 name => 'Pac1',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,               
                 poll => 1,            
			},     
	'h88' => { reading => 'ModbusVersion',
				 name => 'mov',
                 expr => '$val / 100',
                 format => '%.2f',
                 poll => "once",            
			}, 
	'h608' => { reading => 'LoadFirstDischargeSoc',
				 name => 'lfds',
                 poll => "x60",
                 set => 1,
                 min => 10,
                 max => 100,       
			},            
	'h1037' => { reading => 'CTMode',
				 name => 'bCTMode',
                 poll => "once",
                 map => "0:WiredCT, 1:WirelessCT, 2:Meter",       
			},                     
	'h1044' => { reading => 'Priority',
				 name => 'prio',
                 poll => "once", 
                 map => "0:Load, 1:Battery, 2:Grid",           
			},                                                                     
	'i93' => { reading => 'InverterTemperature',
				 name => 'Temp1',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,    
			},            
    "i1000" => { reading => "InverterMode",
                 name => "mode",
                 map => "0:Waiting, 1:Self-test, 2:Reserved, 3:SysFault, 4:Flash, 5:PVBATOnline, 6:BatOnline, 7:PVOffline, 8:BatOffline", 
                 poll => 1,
            },        
	'i1009' => { reading => 'BatteryDischargePower',
				 name => 'pdischarge',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			}, 
	'i1011' => { reading => 'BatteryChargePower',
				 name => 'pcharge',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
    "i1013" => { reading => "BatteryVoltage",
                 name => "pvol",
                 poll => 1,
                 unpack => 's>',
                 expr => '$val / 10',
                 format => '%.1f',                
            },                                                                     
    "i1014" => { reading => "SOC",
                 name => "soc",
                 poll => 1, 
            },
	'i1021' => { reading => 'ACToUserTotal',
				 name => 'pactousertotal',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			}, 
	'i1029' => { reading => 'ACToGridTotal',
				 name => 'pactogridtotal',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1037' => { reading => 'LocalLoadTotal',
				 name => 'plocalloadtotal',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},                                   
	'i1067' => { reading => 'UPSFrequency',
				 name => 'upsFac',
                 unpack => 's>',
                 expr => '$val / 100',
                 format => '%.2f',       
			},            
	'i1068' => { reading => 'UPSVoltage',
				 name => 'upsVac1',
                 unpack => 's>',
                 expr => '$val / 10',
                 format => '%.1f',
                 poll => 1,         
			}, 
    'i1070' => { reading => 'UPSOutputWatt',
				 name => 'upsPac1',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,              
                 poll => 1,            
			},
    'i1080' => { reading => 'UPSLoad',
				 name => 'upsLoad',
                 expr => '$val / 10',
                 format => '%.1f',                                
                 poll => 1,           
			}, 
    'i1001' => { reading => 'SystemFault0',
				 name => 'sysFault0', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" MasterForceINVFault":"";
                          $v .= (($val & 2)==2)?" MasterForceSPFault":"";
                          $v .= (($val & 4)==4)?" BusVoltHigh_TZ":"";
                          $v .= (($val & 8)==8)?" BusVoltHigh_ISR":"";
                          $v .= (($val & 256)==256)?" GridZClossFault":"";
                          $v .= (($val & 2048)==2048)?" GFCIHigh":"";
                          $v .= (($val & 4096)==4096)?" GridR_VFault":"";
                          $v .= (($val & 8192)==8192)?" GridS_VFault":"";
                          $v .= (($val & 16384)==16384)?" GridT_VFault":"";
                          $v .= (($val & 32768)==32768)?" GridFFault":"";
                          $val .= " ${v}";',                                
                 poll => 1,           
			},
    'i1002' => { reading => 'SystemFault1',
				 name => 'sysFault1', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" RelayFault":"";
                          $v .= (($val & 2)==2)?" GFCIDamage":"";
                          $v .= (($val & 4)==4)?" GridR_VLowFault":"";
                          $v .= (($val & 8)==8)?" GridR_VHighFault":"";
                          $v .= (($val & 16)==16)?" GridS_VLowFault":"";
                          $v .= (($val & 32)==32)?" GridS_VHighFault":"";
                          $v .= (($val & 64)==64)?" GridT_VLowFault":"";
                          $v .= (($val & 128)==128)?" GridT_VHighFault":"";
                          $v .= (($val & 256)==256)?" INVCurrOCP_ISR":"";
                          $v .= (($val & 512)==512)?" INVCurrOCP_TZ":"";
                          $v .= (($val & 1024)==1024)?" DCIHigh":"";
                          $v .= (($val & 2048)==2048)?" reserved":"";
                          $v .= (($val & 4096)==4096)?" INVR_CurrOCP_Rms":"";
                          $v .= (($val & 8192)==8192)?" INVS_CurrOCP_Rms":"";
                          $v .= (($val & 16384)==16384)?" INVT_CurrOCP_Rms":"";
                          $v .= (($val & 32768)==32768)?" NoUtility":"";
                          $val .= " ${v}";',                               
                 poll => 1,           
			},
    'i1003' => { reading => 'SystemFault2',
				 name => 'sysFault2', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" GridFLowFault":"";
                          $v .= (($val & 2)==2)?" GridFHighFault":"";
                          $v .= (($val & 4)==4)?" GridVolt_Unbalance_Fault":"";
                          $v .= (($val & 8)==8)?" AC_PLL_Fault":"";
                          $v .= (($val & 16)==16)?" OverLoadFault":"";
                          $v .= (($val & 256)==256)?" EPS_LineVoltR_Loss":"";
                          $v .= (($val & 512)==512)?" EPS_LineVoltS_Loss":"";
                          $v .= (($val & 1024)==1024)?" EPS_LineVoltT_Loss":"";
                          $val .= " ${v}";',                               
                 poll => 1,           
			},
    'i1004' => { reading => 'SystemFault3',
				 name => 'sysFault3', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" BatTerminalReversed":"";
                          $v .= (($val & 2)==2)?" BMS-Battery-Open":"";
                          $v .= (($val & 4)==4)?" BatteryVoltageLow":"";
                          $val .= " ${v}";',                            
                 poll => 1,           
			},
    'i1005' => { reading => 'SystemFault4',
				 name => 'sysFault4', 
                 expr => 'my $v = "";
                          $v .= (($val & 32)==32)?" PV1_VoltLowWarn":"";
                          $v .= (($val & 64)==64)?" PV2_VoltLowWarn":"";
                          $val .= " ${v}";',                           
                 poll => 1,           
			},            
    'i1006' => { reading => 'SystemFault5',
				 name => 'sysFault5', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" NE-DetectFault":"";
                          $v .= (($val & 2)==2)?" PVISOFault":"";
                          $v .= (($val & 4)==4)?" reserved":"";
                          $v .= (($val & 8)==8)?" BusVoltHighFault_ISR":"";
                          $v .= (($val & 16)==16)?" BusSampleFault":"";
                          $v .= (($val & 32)==32)?" UHCTFault":"";
                          $v .= (($val & 64)==64)?" AComFault":"";
                          $v .= (($val & 128)==128)?" BComFault":"";
                          $v .= (($val & 512)==512)?" AuotTestFault":"";
                          $v .= (($val & 2048)==2048)?" NTCOpenFault":"";
                          $v .= (($val & 4096)==4096)?" reserved":"";
                          $v .= (($val & 8192)==8192)?" BBHeatsink_TempOver":"";
                          $v .= (($val & 16384)==16384)?" BBOCP_FaultISR":"";
                          $v .= (($val & 32768)==32768)?" INVHeatsink_Overtemp":"";
                          $val .= " ${v}";',                                
                 poll => 1,           
			},
    'i1007' => { reading => 'SystemFault6',
				 name => 'sysFault6', 
                 expr => 'my $v = "";
                          $v .= (($val & 1)==1)?" PV1_VoltHighFault":"";
                          $v .= (($val & 2)==2)?" PV2_VoltHighFault":"";
                          $v .= (($val & 4)==4)?" BTHeatsink_Overtemp":"";
                          $v .= (($val & 8)==8)?" INVHeatsink_Overtemp":"";
                          $v .= (($val & 256)==256)?" BoostDriver1Warn":"";
                          $v .= (($val & 512)==512)?" BoostDriver2Warn":"";
                          $v .= (($val & 1024)==1024)?" WARN104":"";
                          $v .= (($val & 2048)==2048)?" PV1_ShortFault":"";
                          $v .= (($val & 4096)==4096)?" PV2_ShortFault":"";
                          $v .= (($val & 8192)==8192)?" Meter-COM-loss":"";
                          $v .= (($val & 16384)==16384)?" PairingTimeOut":"";
                          $v .= (($val & 32768)==32768)?" CT-LN-Reversed":"";
                          $val .= " ${v}";',                               
                 poll => 1,           
			},                                                                                               
);

sub ModbusGrowattSPH_Initialize($)
{
    my ($modHash) = @_;
    LoadModule "Modbus";
    require "$attr{global}{modpath}/FHEM/DevIo.pm";

    $modHash->{parseInfo}  = \%ModbusGrowattSPHparseInfo; 
    $modHash->{deviceInfo} = \%ModbusGrowattSPHdeviceInfo; 

    ModbusLD_Initialize($modHash);  
    
    $modHash->{AttrList} = $modHash->{AttrList} . " " . 
        $modHash->{ObjAttrList} . " " . 
        $modHash->{DevAttrList};  

}